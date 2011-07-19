From: govinda <govinda.webdnatalk@gmail.com>
Subject: newbie - missing file from untracked list
Date: Mon, 18 Jul 2011 18:49:16 -0700 (PDT)
Message-ID: <1311040156386-6597192.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 03:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QizR5-0005BR-BC
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 03:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab1GSBtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 21:49:18 -0400
Received: from sam.nabble.com ([216.139.236.26]:47919 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab1GSBtR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 21:49:17 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <govinda.webdnatalk@gmail.com>)
	id 1QizQy-0005HV-Ch
	for git@vger.kernel.org; Mon, 18 Jul 2011 18:49:16 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177433>

Hi everyone.

I just started with git.. am new to VCS/SCM (been doing it
painstakingly/manually for years), am new to the CL, am a decent old-school
coder, but on occasion a little slow in unix topics, and other more
modern/current coding circles.

I am embarrassed to ask, because I am guessing it is going to be
obvious/silly, once I see it.. but meanwhile:

Isn't the list of untracked files that git shows me when I do, e.g.:
Govind% git status

..supposed to include all actual files in the directory?  A couple times,
like now.. I am wanting to add a file to the staging area.. and for some odd
(odd to me now) reason, the file is as if not there.  When I do:
Govind% ls

..then I see the file *is* there.. as I also know it is from my Mac OS 10.6
finder window.

So why does git not mention it when I do 'status'?  

Git seems happy for me to 'add' the file, but then refuses to show it to me
in the 'status' listing.
The file in question is in the pwd, and is named 'mainline_finishes.html'.

Here, please see my issue:

[Govindas-iMac-2:SS_site_root] Govind% pwd
/Users/Govind/Documents/webmastering/websites-devel./SS_site_root
[Govindas-iMac-2:SS_site_root] Govind% ls
[snip]
VL_ShowMan.html-2011-05-10_late			mainline_finishes.html
VL_ShowMan.html-2011-05-11			mainline_finishes.html-2011-04-29
VL_ShowMan.html-2011-05-12			mainline_finishes.html-2011-06-08
VL_ShowMan.html-2011-05-17			mainline_finishes.html-2011-06-17
VL_ShowMan.html-2011-05-19			manu_autoupdate00.html
VL_ShowMan.html-2011-06-02			news
[snip]

[Govindas-iMac-2:SS_site_root] Govind% git add mainline_finishes.html
[Govindas-iMac-2:SS_site_root] Govind% git status
# On branch Gov_SS_2011-07-16
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   VL_ShowMan.html
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
[snip]
#	Intranet_IE/CSI_Admin.html
#	Intranet_IE/DealerUpdate_Approve.html
[snip]
#	LunchReport_CommentToolTip.js
#	ManuUpdate/
#	RepGroup_Update_Trigger.html
[snip]
#	joinus.html
#	mainline_finishes.html-2011-04-29
#	mainline_finishes.html-2011-06-08
#	mainline_finishes.html-2011-06-17
#	manu_autoupdate00.html
#	myspecsimple/
#	news/
[snip]
 

^^^ *where* is 'mainline_finishes.html'?!

I would sort that untracked file listing for ease of reading.. but I do not
know how (if it is even possible)... is there an option for 'git status -?'
that causes the list to sort alphabetically?  At the moment is seems to try
to sort ..but breaks the lists into a couple/few separate clumps of
otherwise alphabetized file names. (That makes no sense to me.)

Thanks for any feedback.  

Also please feel free to scold me or train me on any point where I need it..
like list protocol, language used, CL tips, etc.  anything.  I mean to play
nice.. and am only appreciative.

-Govinda

--
View this message in context: http://git.661346.n2.nabble.com/newbie-missing-file-from-untracked-list-tp6597192p6597192.html
Sent from the git mailing list archive at Nabble.com.
