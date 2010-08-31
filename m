From: Matt McCormick <mbmccormick@gmail.com>
Subject: Re: Gitweb: 500 - Open git-rev-list failed
Date: Tue, 31 Aug 2010 08:30:52 -0400
Message-ID: <AANLkTinJnw-CigSTSnP32PAYf=Awp3mmv33DtDxrNqd4@mail.gmail.com>
References: <AANLkTinjFNMH+ocDuxx=tkj_pe70RZMkfxBLW4wcLzPF@mail.gmail.com> <AANLkTimnz103yX_8YZO4RbmOqdvA-sET78EL5g5LrK+a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 14:31:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqPzr-0004zN-Eq
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 14:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308Ab0HaMbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 08:31:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55611 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743Ab0HaMbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 08:31:23 -0400
Received: by vws3 with SMTP id 3so5261960vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 05:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=6A0Dd0ZUtVLa+tVyTT8f4gS393Y0NglGjBGJufwNCwE=;
        b=HzlzJRAVRNoyjC9OxJ6f6+K0RVzPRjo3v6cNZJRlbPXVtsOUjRPHJWL7ZRCOAq7JxE
         vf64wgTCnrZhbITfF65o0+wmvuwYgIcNlnk9VQzI8M/o6NfDommXbpHHERuMFO71VHZm
         iPgrGtXHTTPrGmWPVmhJ1YVjg2QEnu00A12C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=Oa7GdwXB//2XhFD3Huy5wWoK7YG/c6aARlHKan3FZXYj4pIqzqS/T16yuOe6lVjquy
         2e5N5GIXnSFcsD+IRDz/r8HWjZFTAEEPWs4B6s9O7GvNHSl2S4/UY93c0s2oV5K0nA4s
         ryWtqUUSY0QduGALZWEJE7Qkr0GsSGDTQaTSY=
Received: by 10.220.157.139 with SMTP id b11mr3524210vcx.180.1283257882440;
 Tue, 31 Aug 2010 05:31:22 -0700 (PDT)
Received: by 10.220.163.9 with HTTP; Tue, 31 Aug 2010 05:30:52 -0700 (PDT)
In-Reply-To: <AANLkTimnz103yX_8YZO4RbmOqdvA-sET78EL5g5LrK+a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154896>

Another interesting item to point out is that when I visit
http://code.mbmccormick.com/ to access gitweb, when I click on the
"txt" button I get the list of git repositories, you can try that out
here:

http://code.mbmccormick.com/?a=project_index

However, the main page of gitweb still shows that I don't have any
projects because of the "500 - Open git-rev-list failed" error.

Any ideas?

--
Matt McCormick



On Mon, Aug 30, 2010 at 11:33 PM, Matt McCormick <mbmccormick@gmail.com> wrote:
> Hello,
>
> I just recently installed git and gitosis on my server. I am able to
> pull, push, etc. to my repositories that I have setup using gitosis
> without any problem. However, when I try to access gitweb, my list of
> projects is empty. My configuration files for gitosis all have "gitweb
> = yes" specified and my configuration files for gitweb are properly
> set for the right project root, etc.
>
> When I manually enter the URL for my project, like the one below, I
> receive "500 - Open git-rev-list failed". You can visit the URL below
> for a demonstration.
>
> http://code.mbmccormick.com/?p=mccormicktechnologies.com.git
>
> Any help that you have is appreciated. Thanks!
>
> --
> Matt McCormick
>
