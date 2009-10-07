From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Code reuse
Date: Wed, 7 Oct 2009 18:00:09 +0530
Message-ID: <2e24e5b90910070530p757b3651ne0f7e4a6e8bc8825@mail.gmail.com>
References: <ac07bcaf0910061218x148374d0u66b36fae1466ea98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Philip Herron <herron.philip@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 14:33:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvVhW-0003hf-Hj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 14:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbZJGMas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 08:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZJGMar
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 08:30:47 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:59519 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbZJGMar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 08:30:47 -0400
Received: by iwn8 with SMTP id 8so2795597iwn.33
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=hoirgKSOLOuDfwhkecRJGgEahmU4PdreZSlJlCcVcHo=;
        b=GXFX/DjjH8xpyRPt5TJAjsWu1l31QcVJoQQ/i1qM5jUIXjd1oOqcsiTe92dYXhiZdv
         yWtX23KGw0AvlOZ0/asiiaD3+Bpdhp5GOu5faHGU2R76t2JF3TRqc0SPa8jaBLrV1xsW
         vDKF0A7rG9qQZuRuu1ejoDvXDQT3NsTyK1GRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eIjCNZfB/6sGTKGTDx4dg6oJ4nNxbEGH8JkUqCJyLvGRBA50+liCPi0PoCDZuOBB+x
         OlGmWQ1HZgJEehhucA+am6wbq8lNDx50EAuo/TW+cpRrrWttYUXov3wjITt41176Yrb0
         8f52hvZqGc1q3U0caw3KlfUw38P9QPDRKzDLY=
Received: by 10.231.9.33 with SMTP id j33mr5404349ibj.37.1254918609610; Wed, 
	07 Oct 2009 05:30:09 -0700 (PDT)
In-Reply-To: <ac07bcaf0910061218x148374d0u66b36fae1466ea98@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129645>

On Wed, Oct 7, 2009 at 12:48 AM, Philip Herron
<herron.philip@googlemail.com> wrote:

> I am not sure if this is the right place to ask this question, but
> I've been working on a personal project a programming language
> interpreter for some time now, but i took 2 code snippets from
> git-core namely:

[snip]

> I've changed it a good bit (probably doesn't resemble much of what it
> was) to fit in with the way my stuff works but is there anything i
> need to like put in my source code to say hey this is based of
> git-core, so far is just a comment to say 'based of git-core hash.c'.
> Its an open source (GPL) program but i haven't released or made much
> noise about it yet because i want to work on it more myself.

In general, the GPL's main requirement is that whoever gets the binary
should also get the code (I'm over simplifying but that's basically
it).  It actually doesn't say much about giving credit, except (from
<HEAD:COPYING>):

"If the software is modified by someone else and passed on, we want
its recipients to know that what they have is not the original, so
that any problems introduced by others will not reflect on the
original authors' reputations"

and

"a) You must cause the modified files to carry prominent notices
stating that you changed the files and the date of any change."

That's basically it...

It would seem to me that, if you changed them significantly, and going
by the above logic, you don't need to do *anything* regarding
attribution.
