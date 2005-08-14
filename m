From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC][PATCH] Rewriting revs in place in push target repository
Date: Sat, 13 Aug 2005 19:20:11 -0700
Message-ID: <20050814022011.GA19897@taniwha.stupidest.org>
References: <20050813214725.GM5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 04:21:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E486s-0002RW-1H
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 04:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVHNCUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 22:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVHNCUX
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 22:20:23 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:62897 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932425AbVHNCUW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 22:20:22 -0400
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j7E2KQfW014446
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 22:20:27 -0400
X-ORBL: [63.205.185.3]
Received: from stupidest.org (adsl-63-205-185-3.dsl.snfc21.pacbell.net [63.205.185.3])
	by pimout2-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j7E2KBgD159318;
	Sat, 13 Aug 2005 22:20:14 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 11182528F26; Sat, 13 Aug 2005 19:20:11 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050813214725.GM5608@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2005 at 11:47:25PM +0200, Petr Baudis wrote:

> 	I think it does not in real setups, since thanks to O_RDWR the
> 	file should be overwritten only when the write() happens.
> 	Can a 41-byte write() be non-atomic in any real conditions?

yes

if you journal metadata only you can see a file extended w/o having
the block flushed
