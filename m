X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: directory is not in cache
Date: Mon, 13 Nov 2006 16:47:01 +0200
Message-ID: <20061113144701.GF29113@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 14:44:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31301>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjd2L-00082J-IY for gcvg-git@gmane.org; Mon, 13 Nov
 2006 15:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754772AbWKMOnq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 09:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbWKMOnq
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 09:43:46 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:9345 "EHLO
 dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1754772AbWKMOnp (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 09:43:45 -0500
Received: from mellanox.co.il ([194.90.237.34]) by dev.mellanox.co.il
 (8.13.1/8.13.1) with SMTP id kADEhexd014475 for <git@vger.kernel.org>; Mon,
 13 Nov 2006 16:43:41 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 13 Nov 2006
 16:47:01 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi!
I tried to check out a directory from a branch:
$ git-ls-tree --name-only demo_branch
drivers/infiniband/
drivers/infiniband/Kconfig
drivers/infiniband/Makefile
drivers/infiniband/core
drivers/infiniband/hw
drivers/infiniband/ulp
$ git checkout demo_branch
drivers/infiniband/
git-checkout-index: drivers/infiniband/ is not in the cache
$ git --version
git version 1.4.2.3.g128e

-- 
