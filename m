From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 17:31:02 -0700
Message-ID: <046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org> <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net> <87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org> <7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 02:30:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaNJ5-0007ca-W9
	for gcvg-git@gmane.org; Tue, 24 May 2005 02:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEXAbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 20:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVEXAbP
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 20:31:15 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:46553 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261221AbVEXAbG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 20:31:06 -0400
Received: from pimout1-ext.prodigy.net (pimout1-int.prodigy.net [207.115.5.65])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j4O0VBKh023551
	for <git@vger.kernel.org>; Mon, 23 May 2005 20:31:11 -0400
X-ORBL: [63.205.187.115]
Received: from taniwha.stupidest.org (adsl-63-205-187-115.dsl.snfc21.pacbell.net [63.205.187.115])
	by pimout1-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4O0V35S027524;
	Mon, 23 May 2005 20:31:03 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id A7607528F22; Mon, 23 May 2005 17:31:02 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 23, 2005 at 05:25:32PM -0700, Junio C Hamano wrote:

> Then you would use '-z'.  (10) becomes NUL which your path
> cannot have inside.  So do (12) and (14).

Sure, I guess I meant to what would happen when not using '-z'?  Will
something notice this early on barf and tell me to use '-z' or will
BadThings(tm) just come bite me at some (possibly) later stage?

