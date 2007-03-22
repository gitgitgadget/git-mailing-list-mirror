From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: emacs and git...
Date: Thu, 22 Mar 2007 08:57:18 -0700
Message-ID: <86lkhpmftt.fsf@blue.stonehenge.com>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 16:57:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUPfG-0006qM-M4
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 16:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460AbXCVP5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 11:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933663AbXCVP5T
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 11:57:19 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:6430 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933460AbXCVP5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 11:57:18 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9581C1DE638; Thu, 22 Mar 2007 08:57:18 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.2.19; tzolkin = 9 Cauac; haab = 12 Cumku
In-Reply-To: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com> (Francis Moreau's message of "Thu, 22 Mar 2007 15:53:26 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42860>

>>>>> "Francis" == Francis Moreau <francis.moro@gmail.com> writes:

Francis> Hi,
Francis> I guess it's a dumb...

Francis> I know that some of you work within emacs. I tried to use git iniside
Francis> a emacs shell (M-x shell) and had a weid behaviour:

Francis> $ git diff
Francis> WARNING: terminal is not fully functional
Francis> -  (press RETURN)
Francis> diff --git a/.lde/bin/cmd-version b/.lde/bin/cmd-version.[m
Francis> index a6ce3f8..687112d 100755.[m
Francis> --- a/.lde/bin/cmd-version.[m
Francis> +++ b/.lde/bin/cmd-version.[m
Francis> @@ -54,7 +54,7 @@ gdb_version () {.[m
Francis> [snip]

Francis> I'm not using diff color option.

Francis> Can anybody shed some light ?

I use M-x shell on a regular basis, and have learned to add the following
three items to my .emacs wherever I'm at:

  (setenv "PAGER" "/bin/cat")
  (setenv "EDITOR" "/opt/emacs/bin/emacsclient") ; `which emacsclient`
  (server-start)

Unless you do the first line, programs that like to push things through "less"
or "more" do some pretty nasty things.  And those last two are nice, because
you can use "git-commit" directly in the shell window, and it'll pop up an
emacs buffer.  Read up on emacs-server mode or you won't know how to get out
of it though. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
