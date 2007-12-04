From: Baurzhan Ismagulov <ibr@radix50.net>
Subject: Not a valid object name refs/heads/t20050127-arm during git-cvsimport
Date: Tue, 4 Dec 2007 18:18:33 +0100
Message-ID: <20071204171833.GD29315@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 18:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izbhf-0006hN-Uz
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 18:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbXLDRgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 12:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXLDRgn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 12:36:43 -0500
Received: from kz-easy.com ([85.214.25.173]:43708 "EHLO almaty.kz-easy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbXLDRgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 12:36:42 -0500
X-Greylist: delayed 1077 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2007 12:36:42 EST
Received: from alatau.radix50.net (dslb-088-064-016-236.pools.arcor-ip.net [88.64.16.236])
	(authenticated bits=0)
	by almaty.kz-easy.com (8.13.8/8.13.8/Debian-3) with ESMTP id lB4HIdfD025124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 4 Dec 2007 18:18:40 +0100
Received: from alatau.radix50.net (localhost [127.0.0.1])
	by alatau.radix50.net (8.13.8/8.13.8/Debian-3) with ESMTP id lB4HIX0p004146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 4 Dec 2007 18:18:33 +0100
Received: (from ibr@localhost)
	by alatau.radix50.net (8.13.8/8.13.8/Submit) id lB4HIXYc004145
	for git@vger.kernel.org; Tue, 4 Dec 2007 18:18:33 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Status: No, score=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL 
	autolearn=no version=3.1.7-deb
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	almaty.kz-easy.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67065>

Hello,

I want to import a CVS repo myrepo into git. I copied CVSHEAD and myrepo
dirs from the cvs server to /home/ibr/tmp and issued the following
command:

git-cvsimport -p x -k -o cvshead -d/home/ibr/tmp -C zzz myrepo/drv

It fails with the following messages:

Initialized empty Git repository in /home/ibr/tmp/zzz/.git/
fatal: Not a valid object name refs/heads/t20050127-arm
read-tree failed: 32768

t20050127-arm is a branch that exists not for all files under
myrepo/drv.

How can I import this repo?

I use git 1.5.3.6-1.1 from Debian unstable and cvsps 2.1-2 from Debian
stable on a Debian testing/unstable system.

Thanks in advance,
-- 
Baurzhan Ismagulov
http://www.kz-easy.com/
