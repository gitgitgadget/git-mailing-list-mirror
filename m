From: Matti Linnanvuori <matti.linnanvuori@portalify.com>
Subject: fatal: index-pack failed
Date: Fri, 30 Sep 2011 11:11:02 +0300
Message-ID: <50B87B00-064C-4FCC-B1E8-94A9EB027468@portalify.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 10:11:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9YBt-0006X4-8E
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 10:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757763Ab1I3ILV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 04:11:21 -0400
Received: from helsinki.portalify.com ([217.30.185.41]:11183 "EHLO
	helsinki.portalify.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758130Ab1I3ILE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 04:11:04 -0400
Received: from [127.0.0.1] (putki.portalify.com [10.192.0.11])
	by helsinki.portalify.com (Postfix) with ESMTP id B603D1B9068B
	for <git@vger.kernel.org>; Fri, 30 Sep 2011 11:11:02 +0300 (EEST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182469>

Jenkins got an error:

Error performing command: git fetch -t ssh://iac-builder@sorsa.portalify.com/p/git/.git+refs/heads/*:refs/
Command "git fetch -t ssh://iac-builder@sorsa.portalify.com/p/git/.git+refs/heads/*:refs/remotes/origin/*" returned status code 128: error: refs/remotes/origin/HEAD does not point to a valid object!
error: refs/remotes/origin/master does not point to a valid object!
error: refs/tags/jenkins-iac-orm-snapshot-889 does not point to a valid object!
error: refs/remotes/origin/HEAD does not point to a valid object!
error: refs/remotes/origin/master does not point to a valid object!
error: refs/tags/jenkins-iac-orm-snapshot-889 does not point to a valid object!
error: Could not read 49f273234b582edb44bbdbda29193719e5054cb7
error: refs/remotes/origin/HEAD does not point to a valid object!
error: refs/remotes/origin/master does not point to a valid object!
error: missing object referenced by 'refs/tags/iac-1.4.13'
error: refs/tags/jenkins-iac-orm-snapshot-889 does not point to a valid object!
error: Could not read 49f273234b582edb44bbdbda29193719e5054cb7
fatal: pack has 26 unresolved deltas
fatal: index-pack failed

git fsck --full
error: refs/remotes/origin/HEAD does not point to a valid object!
error: refs/remotes/origin/master does not point to a valid object!
error: refs/tags/jenkins-iac-orm-snapshot-889 does not point to a valid object!
broken link from  commit 5d4e8989e0b84546cd85fc5e1da12f68e4d38972
              to    tree 54e146b9fca023bbde2b311629d82601fa1e89a0
broken link from  commit 5d4e8989e0b84546cd85fc5e1da12f68e4d38972
              to  commit 49f273234b582edb44bbdbda29193719e5054cb7
dangling tree ec3b83770e89242fccda40b5194dd450122e49ed
dangling tree dd51bc467f3f36c89b8064e550298f91d15bf28d
dangling blob 1756f72adc8a8292e6fadeb306823f1d26feeb7b
dangling tree 5e58d68ae6f5d5f554fbeb80f14c49bbf097a44c
dangling blob 0f67ad10d3ad05b33b4689f3859cf2455bc0c292
dangling tree 72818c927d476f0d56846d82062afe2648f9b554
dangling blob 07969328481717f171624066c43948b8d69b4933
dangling tree c49ef6d9a7a248c726327fb9e00bffa365f84dcb
dangling tree 66b64e2a6ba858d357baa65887e8e117b368e771
dangling blob 18c48a80fde2c5e1c9e696c055852af723eec01c
dangling blob 4dcf4f005cc2e57f0f2720a937fa53740504ebf8
dangling tree add32288c58a090c3746f7286bfaefd5f5fb24a4
missing tree 54e146b9fca023bbde2b311629d82601fa1e89a0
missing commit 49f273234b582edb44bbdbda29193719e5054cb7

git --version
git version 1.7.2.5

Debian GNU/Linux 6.0

Matti Linnanvuori
