From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 18:05:02 -0700
Message-ID: <893c1abb4647b2c536a14ab2cbcf2805.IBX@taniwha.stupidest.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org> <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net> <87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org> <7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net> <046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org> <7v64x91mfb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:12:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaNwr-0003rq-0E
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVEXBMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEXBHq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:07:46 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:10715 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261289AbVEXBFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 21:05:11 -0400
Received: from taniwha.stupidest.org (adsl-63-205-187-115.dsl.snfc21.pacbell.net [63.205.187.115])
	by pimout4-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4O152PA120714;
	Mon, 23 May 2005 21:05:02 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 084B4528F22; Mon, 23 May 2005 18:05:02 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 23, 2005 at 06:03:09PM -0700, Linus Torvalds wrote:

> For raw-diff yes, but since you'd normally end up using that name in
> the diff, it won't be safe any more.

I'm not really worried about a diff being spat out that can't be
cleanly parsed --- I was more worried about the application doing
BadThings(tm) and crashing or eating some of my repo or worse.
