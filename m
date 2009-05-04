From: "Mercier, Carl" <cmercier@websense.com>
Subject: bug in git-p4?
Date: Mon, 4 May 2009 12:20:33 -0700
Message-ID: <F98DA2FE6F6C464C860149518BD861CC3B3C13440A@SSDEXCH2.websense.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 04 21:20:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M13id-0005xz-JM
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbZEDTUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 15:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZEDTUn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 15:20:43 -0400
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:55295 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbZEDTUm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 15:20:42 -0400
Received: from ssdexch3.websense.com (static-204-15-64-77.websense.com [204.15.64.77] (may be forged))
	by rly13g.srv.mailcontrol.com (MailControl) with ESMTP id n44JKOq0019850
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 4 May 2009 20:20:37 +0100
Received: from SSDEXCH2.websense.com ([10.8.2.90]) by ssdexch3.websense.com
 ([10.8.2.52]) with mapi; Mon, 4 May 2009 12:20:34 -0700
Thread-Topic: bug in git-p4?
Thread-Index: AQHJzO1l8Ry+cPYv0UiK4vE7T4Tq1g==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Scanned-By: MailControl A_08_51_00 (www.mailcontrol.com) on 10.71.0.123
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118256>

Hello all,

I've been trying to use git-p4 without much success.  My setup is very simple:

- 1 existing Git repo (with data)
- 1 existing P4 depot (with an empty subdirectory)
- We commit and push to Git and our company requires all the code to be stored in P4 (in the p4 empty subdir).

Here's what I did:

cd /root/p4-repo/SecTech
git clone /home/git/repositories/web website
cd website
git-p4 sync //SecTech/website
git branch --track p4-master p4/master
git checkout p4-master
git merge master
git-p4 submit

CRASHES WITH:
Perforce checkout for depot path //SecTech/website/ located at /root/p4-repo/SecTech/website/
Syncronizing p4 checkout...
... - file(s) up-to-date.
Applying 32a1b2fe93f48c044d04ca37a276fe66afc988ce initial import

fatal: ambiguous argument '32a1b2fe93f48c044d04ca37a276fe66afc988ce^': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
Command failed: git diff-tree -r  "32a1b2fe93f48c044d04ca37a276fe66afc988ce^" "32a1b2fe93f48c044d04ca37a276fe66afc988ce"



Am I doing something wrong or is there a bug in git-p4?

I'm a bit confused right now.  Thanks!

Carl


 Protected by Websense Hosted Email Security -- www.websense.com 
