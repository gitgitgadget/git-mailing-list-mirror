From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-verify-pack command.
Date: Wed, 29 Jun 2005 09:15:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506290911590.14331@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org> <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506282314320.1667@localhost.localdomain>
 <Pine.LNX.4.63.0506290111250.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506282243180.19755@ppc970.osdl.org>
 <Pine.LNX.4.58.0506282252001.14331@ppc970.osdl.org> <7v4qbhfxad.fsf_-_@assigned-by-dhcp.cox.net>
 <7vvf3xcwyo.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 18:14:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnfC8-0006aI-MU
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 18:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVF2QS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVF2QPU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 12:15:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVF2QNt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 12:13:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5TGDhjA031915
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Jun 2005 09:13:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5TGDged015597;
	Wed, 29 Jun 2005 09:13:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf3xcwyo.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 29 Jun 2005, Junio C Hamano wrote:
> 
> *** Linus, what would be the practical/recommended/sane limit
> *** for mmap regions we would want to use?  Currently I start
> *** throwing away mapped packs when the total size of mapped
> *** packs exceeds 64MB.

Hey, anybody who ever used BK had better have had 1GB of memory for any 
real development. So 64MB is peanuts, but it sounds like a good guess.

> *** Oh, again, Linus, what is your preferred way to get a
> *** cover-letter material (like this) for a single patch?

I don't want cover-letters for single patches, or necessarily even for
short series (1-3 entries). The cover letter is more interesting for large
series, or even with small series if the early patches don't make much
sense on their own: then the cover-letter ends up being a useful place to
explain what the _sequence_ does, and why patch #2 that seems to be
totally useless and removes a feature is actually good ("we'll
re-implement it better in #5 after we've cleaned the code up").

So generally commentaries after the three dashes is good, if the 
commentary is "local", ie related not to a series. Only with non-local 
explanations does a separate [0/N] thing make sense to me.

		Linus
