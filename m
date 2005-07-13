From: Paolo =?utf-8?b?XCdCbGFpc29yYmxhZGVcJw==?= Giarrusso 
	<blaisorblade@yahoo.it>
Subject: Why fetching latest kernel sources is failing?
Date: Wed, 13 Jul 2005 17:22:22 +0000 (UTC)
Message-ID: <loom.20050713T182418-822@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 14 10:58:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DszX4-0008Ld-2n
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 10:57:26 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j6DNBISs042272
	for <gcvg-git@gmane.org>; Thu, 14 Jul 2005 01:11:19 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVGMReN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVGMRca
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 13:32:30 -0400
Received: from main.gmane.org ([80.91.229.2]:64475 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261922AbVGMRam (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 13:30:42 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Dsl3f-0003G8-5c
	for git@vger.kernel.org; Wed, 13 Jul 2005 19:30:07 +0200
Received: from 151.97.230.33 ([151.97.230.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 19:30:07 +0200
Received: from blaisorblade by 151.97.230.33 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 19:30:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 151.97.230.33 (Opera/8.0 (X11; Linux i686; U; IT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

gives me the following error:

progress: 2 objects, 921 bytes
error: File 2a7e338ec2fc6aac461a11fe8049799e65639166 (http://www.kernel.org/pub/
scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/
7e338ec2fc6aac461a11fe8049799e65639166) corrupt

Cannot obtain needed blob 2a7e338ec2fc6aac461a11fe8049799e65639166
while processing commit 0000000000000000000000000000000000000000.
error: cannot map sha1 file 2a7e338ec2fc6aac461a11fe8049799e65639166
cg-pull: objects pull failed
cg-init: pull failed

What's happening now? On the other local tree (I had already checked out a tree) 
I get other kind of problems, so I can't use it either.
