From: "Zorba" <cr@altmore.co.uk>
Subject: is there an easier way to do this ?
Date: Tue, 30 Dec 2008 03:37:50 -0000
Message-ID: <gjc52u$ehc$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 04:39:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHVSG-0005bw-PX
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 04:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYL3DiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 22:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYL3DiT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 22:38:19 -0500
Received: from main.gmane.org ([80.91.229.2]:59413 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbYL3DiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 22:38:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHVQs-00019q-Ue
	for git@vger.kernel.org; Tue, 30 Dec 2008 03:38:15 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 03:38:14 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 03:38:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.1 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.1 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104148>

ok, now I'm in this for real, archiving versions of our website project (5k 
files approx)

so here is the workflow:

- copy version 1 files into GIT dir

- open git bash

$ git init

$ git add .

$ git commit -m "version1"

all vanilla ? cool
next job = store version 2, so delete version 1 files from GIT dir, copy in 
version 2
version2 has different files from 1 - which ones? Out of 5k files could be 
1% = 50 new ones, and same amount removed. Why should I care, with such a 
powerful friend as git around, n'est pas?
THIS TIME we are going to be CLEVER and use "-a" flag on commit to pick up 
any files that have been REMOVED (or "deleted" in git-speak)

$ git commit -a -m "version2"

BUT this does not pick up any new ones that have been added,

and when we run

$ git status > ../git_status.txt

these are referred to as "untracked files"
only problem there are 50 ish
is there not another flag on git commit to treat any untracked file as a new 
file ?
(would save me typing or creating a list out of these untracked ones and 
feeding them into git add)

I know, I realise now I should have looked up git-commit in the manual - in 
case its not there, pls enlighten me !
