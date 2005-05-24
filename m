From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 18:33:38 -0700
Message-ID: <211e617258d9d993810f3c88bace255e.IBX@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org> <Pine.LNX.4.62.0505231827430.4200@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:33:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaOHN-0005j5-1k
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEXBdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXBdw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:33:52 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:27882 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261204AbVEXBdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 21:33:49 -0400
Received: from taniwha.stupidest.org (adsl-63-205-187-115.dsl.snfc21.pacbell.net [63.205.187.115])
	by pimout4-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4O1XcPA126364;
	Mon, 23 May 2005 21:33:38 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 2A730528F22; Mon, 23 May 2005 18:33:38 -0700 (PDT)
To: David Lang <david.lang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505231827430.4200@qynat.qvtvafvgr.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 23, 2005 at 06:29:07PM -0700, David Lang wrote:

> hmm, personally I would have expected it to do shell escapeing of
> the name

diff doesn't do this, so i'm not sure it's useful:

cw@taniwha:/tmp$ echo "we have ones here" > "file one"
cw@taniwha:/tmp$ echo "we have two here" > "file two"
cw@taniwha:/tmp$ diff -u file*
--- file one    2005-05-23 18:32:44.334535901 -0700
+++ file two    2005-05-23 18:32:49.047851694 -0700
@@ -1 +1 @@
-we have ones here
+we have two here
