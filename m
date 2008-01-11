From: Johannes Sixt <j.sixt@viscovery.net>
Subject: gitk dev branch: F5 problem again
Date: Fri, 11 Jan 2008 14:17:29 +0100
Message-ID: <47876C69.8070604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 14:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDJlp-0002J6-0t
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 14:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260AbYAKNRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 08:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758159AbYAKNRd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 08:17:33 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60074 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757488AbYAKNRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 08:17:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JDJlJ-00032N-3R; Fri, 11 Jan 2008 14:17:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0EC5F54D; Fri, 11 Jan 2008 14:17:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70158>

I'm using gitk's dev branch (476ca63d Index [fnvr]highlights by id...) on
Windows.

Start gitk like this:

   gitk somefile.c

while on a branch whose tip touches somefile.c.

Now:

   git commit --amend

Then press F5 in gitk. I get these error reports after which gitk is
unresponsive:

can't read "children(1,)": no such element in array
can't read "children(1,)": no such element in array
    while executing
"lindex $children($curview,$id) 0"
    (procedure "ordertoken" line 15)
    invoked from within
"ordertoken $id"
    (procedure "idcol" line 2)
    invoked from within
"idcol $idlist $id"
    (procedure "layoutrows" line 51)
    invoked from within
"layoutrows $rl1 $r"
    (procedure "drawcommits" line 36)
    invoked from within
"drawcommits $row $endrow"
    (procedure "drawvisible" line 51)
    invoked from within
"drawvisible"
    (procedure "scrollcanv" line 3)
    invoked from within
"scrollcanv .tf.histframe.csb 0.00852273 0.146591"


... same as above ...
"drawvisible"
    (procedure "scrollcanv" line 3)
    invoked from within
"scrollcanv .tf.histframe.csb 0.0170455 0.155114"


... same as above ...
"drawvisible"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)


-- Hannes
