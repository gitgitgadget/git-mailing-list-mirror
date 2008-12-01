From: Johannes Sixt <j.sixt@viscovery.net>
Subject: gitk: git bisect view doesn't work
Date: Mon, 01 Dec 2008 15:43:37 +0100
Message-ID: <4933F819.1010701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7A1H-0002Nf-4H
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYLAOno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbYLAOno
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:43:44 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34863 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbYLAOnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:43:43 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L79zu-0000Mh-O6; Mon, 01 Dec 2008 15:43:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4876669F; Mon,  1 Dec 2008 15:43:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  gitk bails out like this if I do "git bisect view": $ git
	bisect start HEAD HEAD~2 Bisecting: 0 revisions left to test after this [9a61060c7e0d112d0742f5b845210ea8c41b6c6b]
	Added encoding $ git bisect view Error in startup script: can't read "notflag":
	no such variable while executing "expr {!$notflag}" ("--not" arm line 2)
	invoked from within "switch -glob -- $arg { "-d" - "--date-order" { set vdatemode($n)
	1 # remove from origargs in case we hit an unknown option set origarg..."
	(procedure "parseviewargs" line 21) invoked from within "parseviewargs $view
	$args" (procedure "start_rev_list" line 27) invoked from within "start_rev_list
	$curview" (procedure "getcommits" line 5) invoked from within "getcommits
	{}" (file "/usr/local/bin/gitk" line 10897) [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102047>

gitk bails out like this if I do "git bisect view":

$ git bisect start HEAD HEAD~2
Bisecting: 0 revisions left to test after this
[9a61060c7e0d112d0742f5b845210ea8c41b6c6b] Added encoding

$ git bisect view
Error in startup script: can't read "notflag": no such variable
    while executing
"expr {!$notflag}"
    ("--not" arm line 2)
    invoked from within
"switch -glob -- $arg {
            "-d" -
            "--date-order" {
                set vdatemode($n) 1
                # remove from origargs in case we hit an unknown option
                set origarg..."
    (procedure "parseviewargs" line 21)
    invoked from within
"parseviewargs $view $args"
    (procedure "start_rev_list" line 27)
    invoked from within
"start_rev_list $curview"
    (procedure "getcommits" line 5)
    invoked from within
"getcommits {}"
    (file "/usr/local/bin/gitk" line 10897)

$ git version
git version 1.6.1.rc1

-- Hannes
