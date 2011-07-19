From: govinda <govinda.webdnatalk@gmail.com>
Subject: Re: newbie - missing file from untracked list
Date: Tue, 19 Jul 2011 10:07:22 -0700 (PDT)
Message-ID: <1311095242970-6599506.post@n2.nabble.com>
References: <1311040156386-6597192.post@n2.nabble.com> <4E24F275.3030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 19:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDlY-0005zr-S0
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab1GSRHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:07:24 -0400
Received: from sam.nabble.com ([216.139.236.26]:33135 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab1GSRHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:07:23 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <govinda.webdnatalk@gmail.com>)
	id 1QjDlS-0005Kk-Vx
	for git@vger.kernel.org; Tue, 19 Jul 2011 10:07:22 -0700
In-Reply-To: <4E24F275.3030906@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177463>

> You can see files aready in HEAD: 
> 
>   $ git ls-tree HEAD 
> 
> or files in stage. 
> 
>   $ git ls-files -s 

Thanks for these ^^^  Jiang Xin!

It is not easy for me to understand all the various contexts which show
files (and those contexts' names, and the commands to see into them) in git,
yet.. but now thanks to you I know better where to look (and reread) in
various docs.

>> I would sort that untracked file listing for ease of reading.. but I do
>> not 
>> know how (if it is even possible)... is there an option for 'git status
>> -?' 
>> that causes the list to sort alphabetically?  At the moment is seems to
>> try 
>> to sort ..but breaks the lists into a couple/few separate clumps of 
>> otherwise alphabetized file names. (That makes no sense to me.) 

> $ git status -s | grep "^?" | sort 

Apparently, I do not know how to use this that you gave me ^^^  .

So far, nothing I tried for generating a 'git status' listing would make the
(more-than-one, and separate) alphabetical clumps of file names sort into
just ONE homogenous alphabetical list.

for example:

[Govindas-iMac-2:SS_site_root] Govind% git status -s sort
[Govindas-iMac-2:SS_site_root] Govind% git status -s
A  VL_ShowMan.html
?? CSS/
?? Empire_06_10_Calls.html
?? GovTest-VL_ShowMan_e-card.html
?? Intranet_IE/CSI_Admin.html
?? Intranet_IE/DealerUpdate_Approve.html
[snip]
?? Intranet_IE/repupdate_edit_linestep3_action_update.inc
?? LunchReport-Trigger_email2attendees2review.html
[snip]
?? LunchReport_CommentToolTip.js
?? ManuUpdate/
?? RepGroup_Update_Trigger.html
?? SAS_DesignFirm_Dealer_Referral.html
[snip]
?? WelcometoNewVL.html
?? _SS_Govinda_only.php
?? _archived copies/
?? aboutVL/
?? booklist.html-mydraft
?? buyinggroup.html
?? buyinggroup.html-2011-02-16
?? categories/
[snip]
?? joinus.html
?? mainline_finishes.html-2011-04-29
?? mainline_finishes.html-2011-06-08
?? mainline_finishes.html-2011-06-17
[snip]
?? upload_CORRECT.html
[snip]


see, why is there what seems to be 2 consecutive alphabetical lists of file
names? 
The first one spans the files:
?? CSS/
.
.
.
?? WelcometoNewVL.html


...while the second list spans the files:
?? _SS_Govinda_only.php
.
.
.
?? upload_CORRECT.html


My knowledge CL is limited, so I apologize in case you have already answered
me and I just do not yet see it.
Can you show me an example for a git status *sorted* command I could copy
and paste into CL directly.. that would thus show me how to apply what you
told me... so I can sort the file names into ONE homogenous alphabetical
list?

Thanks for your time
-Govinda

--
View this message in context: http://git.661346.n2.nabble.com/newbie-missing-file-from-untracked-list-tp6597192p6599506.html
Sent from the git mailing list archive at Nabble.com.
