From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: error: wrong index file size in /usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.idx
Date: Tue, 26 Jun 2007 22:03:28 +0200
Message-ID: <001401c7b82d$106f30b0$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 22:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3HG9-0002j4-U5
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 22:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073AbXFZUDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758058AbXFZUDc
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 16:03:32 -0400
Received: from csmtp.b-one.net ([195.47.247.21]:52972 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940AbXFZUDb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 16:03:31 -0400
Received: from Jocke (84-217-10-122.tn.glocalnet.net [84.217.10.122])
	by csmtp1.b-one.net (Postfix) with ESMTP id 3C8B019124874
	for <git@vger.kernel.org>; Tue, 26 Jun 2007 22:03:29 +0200 (CEST)
X-Mailer: Microsoft Office Outlook 11
thread-index: Ace4LRAeLhY4CSVgSaqBrXVtQ8yjdg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50972>

Did this and got a small error that I don't think should be there:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6

cd linux-2.6
git gc
cd ..

git clone --reference linux-2.6 ssh://git.infradead.org/~/public_git/jffs2_mtd_patches
Initialized empty Git repository in /usr/local/src/jffs2_mtd_patches/.git/
The authenticity of host 'git.infradead.org (18.85.46.34)' can't be established.
RSA key fingerprint is 45:df:f2:54:81:cf:42:05:1d:59:bb:dd:60:b5:0e:81.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'git.infradead.org' (RSA) to the list of known hosts.
remote: Generating pack...
remote: Done counting 0 objects.
Indexing 0 objects...
remote: Total 0 (delta 0), reused 0 (delta 0)
error: wrong index file size in /usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.idx
Checking 21649 files out...
 100% (21649/21649) done

git --version
git version 1.5.2.2

the ~ in above ssh: is jocke
