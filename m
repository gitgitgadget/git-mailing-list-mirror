From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 13:05:59 -0500
Message-ID: <CAJ8P3RAXp8i11-D9=0Af6VZk51Et-gMruTk6vGgVyz1mZPGtXA@mail.gmail.com>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
	<20111206215102.GA3654@centaur.lab.cmartin.tk>
	<CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
	<CAGK7Mr7z6hqoda=pr3syzC5mO1+ZExMeD7sReeyRaYL5OMhemw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 19:06:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYLse-0001r4-NI
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 19:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027Ab1LGSGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 13:06:02 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34889 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950Ab1LGSGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 13:06:01 -0500
Received: by wgbdr13 with SMTP id dr13so1726315wgb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Rl6eaIfc0b/97ZwPKjTK6aUO1MUv4Nufc01bngxsZkE=;
        b=iDhPpwLjJSoLWcjoEbqY8hJoj0iNoKptlJPd1J/GZVBWwQbtKmUkDBGDR33hAoLyQ2
         AAlgbH7mwgg2qPyXAt+LJDpfFwq0X9qjFD8JM+YqAGVU3P7YI5eEN2w/5BHxiQ6bIvNN
         mxgGx9h6b38XB6gZAtZtZbaFaHcVY5VacT/VQ=
Received: by 10.227.205.130 with SMTP id fq2mr19746543wbb.17.1323281159743;
 Wed, 07 Dec 2011 10:05:59 -0800 (PST)
Received: by 10.223.88.132 with HTTP; Wed, 7 Dec 2011 10:05:59 -0800 (PST)
In-Reply-To: <CAGK7Mr7z6hqoda=pr3syzC5mO1+ZExMeD7sReeyRaYL5OMhemw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186477>

On Wed, Dec 7, 2011 at 12:20 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> 11:35][admin@Hiram-Abiff-2:~/src]$ rm -rf framework/
>> [11:44][admin@Hiram-Abiff-2:~/src]$ git clone
> ...snip...
>> [11:51][admin@Hiram-Abiff-2:~/src]$ cd framework/
>> [11:51][admin@Hiram-Abiff-2:~/src/framework(master)]$ git diff
> ...snip...
>
> Can you paste the output of "git status" right after the "cd framework"?
>
> Looks like you have some external process that goes and touches your
> file after the git clone, or that git fails to check out the files
> after cloning but isn't able to work out it failed to checkout those
> files.
>
> Philippe

Sure.
--
[13:04][admin@Hiram-Abiff-2:~/src/framework(master)]$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   app/modules/Core/controllers/CloudSponge.php
#
no changes added to commit (use "git add" and/or "git commit -a")
[13:04][admin@Hiram-Abiff-2:~/src/framework(master)]$

I'll try rebooting the Mac to see if there's some rogue process afoot :)

-Chris



-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
