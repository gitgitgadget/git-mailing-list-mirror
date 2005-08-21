From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Make "git-ls-files" work in subdirectories
Date: Sun, 21 Aug 2005 16:45:44 -0700
Message-ID: <20050821234544.GA19869@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0508211210500.3317@g5.osdl.org> <20050821224622.GB26241@taniwha.stupidest.org> <Pine.LNX.4.58.0508211613340.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 01:46:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6zVm-0002N3-Ek
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 01:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVHUXpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 19:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVHUXpt
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 19:45:49 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:34489 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1751160AbVHUXps (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 19:45:48 -0400
Received: from pimout1-ext.prodigy.net (pimout1-int.prodigy.net [207.115.5.65])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j7LNjr5x020264
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 19:45:55 -0400
X-ORBL: [63.205.185.3]
Received: from stupidest.org (adsl-63-205-185-3.dsl.snfc21.pacbell.net [63.205.185.3])
	by pimout1-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j7LNjihf091398;
	Sun, 21 Aug 2005 19:45:44 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 34059528F22; Sun, 21 Aug 2005 16:45:44 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508211613340.3317@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2005 at 04:17:52PM -0700, Linus Torvalds wrote:

> getopt() is too limited, and getopt_long() is very glibc-specific
> and thus inherently evil. And the complexity of doing autoconf or
> similar is worse than just doing it by hand.

what about libpopt?
