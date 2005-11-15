From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 0/3] C implementation of git, take two.
Date: Wed, 16 Nov 2005 00:40:20 +0100
Message-ID: <437A71E4.9030604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 00:41:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAPc-0006pE-Hv
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVKOXkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVKOXkW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:40:22 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:33732 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965079AbVKOXkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:40:21 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA000763C0 for git@vger.kernel.org; Wed, 16 Nov 2005 00:40:20 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAFNeKf24415
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 00:40:20 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11970>

The commit-messages says it all really, but in case anyone doesn't want 
to read near-identical code to find out what's different between take 
two and take one, I'll just list it briefly here.

* Renamed "git --lib" and $GIT_LIB to "git --exec-path" and 
$GIT_EXEC_PATH, respectively, as per Junio's decision.

* Implemented Linus' idea of prepending exec-path to $PATH.

* "git --help diff-index" brings up the git-diff-index(1) man-page 
(patch 3/3), as does "git --help git-diff-index".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
