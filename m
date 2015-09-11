From: Chris Packham <judge.packham@gmail.com>
Subject: Re: storing cover letter of a patch series?
Date: Fri, 11 Sep 2015 20:30:04 +1200
Message-ID: <CAFOYHZB3dKgi3rERHXuWynTjYQu+iPVdbWqmtoD+irYopfoRCg@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Simon Glass <sjg@chromium.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 10:30:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaJio-0008EN-2G
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 10:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbbIKIaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 04:30:07 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37241 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbIKIaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 04:30:05 -0400
Received: by igbni9 with SMTP id ni9so34161988igb.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 01:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=khIZxEv2unpncn4LtR8OmSdWBYjjqINuTEhUHQYOjsM=;
        b=XkJRlowCKMX2AuR4P5ogdBmJWAZAXKXyiw8nnMcfogEQ6/bP1IkEwi8FZUts3pjmYZ
         +IqVdTf/c7OPMTRmtq5bPaoF0ZV+2pEMbVR9DupedteLSc+vUH3nUEtaH9ra8fKb72YM
         fYWlc8uDiANFU/8O2QZPQOvXNObZjdeLrwtcfaJzt39U2LNJQFzvwDby4b7fIJmQiv/e
         YHbnZDyQS/nj1UQBqQzHmYeP/hTtqe/W3wBUcq98renQLeRfQ0YLqhXh8BSwzr2cTsyM
         J3UVYgPgGQt7k43TB81nU7uK4ZIUvbPEr04IhkUfZvTM2UtcxRgkpgqg4TU57NoGdY0l
         gWhA==
X-Received: by 10.50.143.42 with SMTP id sb10mr915270igb.49.1441960204131;
 Fri, 11 Sep 2015 01:30:04 -0700 (PDT)
Received: by 10.79.109.71 with HTTP; Fri, 11 Sep 2015 01:30:04 -0700 (PDT)
In-Reply-To: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277653>

On Fri, Sep 11, 2015 at 4:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hey,
>
> does anyone know of any tricks for storing a cover letter for a patch
> series inside of git somehow? I'd guess the only obvious way currently
> is to store it at the top of the series as an empty commit.. but this
> doesn't get emailed *as* the cover letter...
>
> Is there some other way? Would others be interested in such a feature?
>
> I get very annoyed when I've written a nice long patch cover letter in
> vim before an email and then realize I should fix something else up,
> or accidentally cancel it because I didn't use the write "To:" address
> or something..
>
> I really think it should be possible to store something somehow as a
> blob that could be looked up later. Even if this was a slightly more
> manual process that would be helpful to store the message inside git
> itself.
>
> In addition, this would help re-rolls since it would mean if I go back
> to a topic and re-roll it I can just update the message. If it were
> properly stored in my local history that would also mean I could see
> revisions on it.
>
> Any thoughts on how to do this?
>

A bit of a plug for patman[1] which the u-boot project uses (although
there's nothing u-boot specific about it). It lets you put the cover
letter and other meta information in the commit messages as you go
then will extract that information and generate a cover letter and
clean patches. As of fairly recently it's also installable as a
standalone application.

--
[1] - http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README
