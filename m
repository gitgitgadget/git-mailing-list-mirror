From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 17:12:03 -0700
Message-ID: <87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org> <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 02:16:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaN5U-0006aw-J3
	for gcvg-git@gmane.org; Tue, 24 May 2005 02:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVEXAQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 20:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEXAMw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 20:12:52 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:944 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261198AbVEXAMK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 20:12:10 -0400
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j4O0CEKh013669
	for <git@vger.kernel.org>; Mon, 23 May 2005 20:12:14 -0400
X-ORBL: [63.205.187.115]
Received: from taniwha.stupidest.org (adsl-63-205-187-115.dsl.snfc21.pacbell.net [63.205.187.115])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4O0C4HW212522;
	Mon, 23 May 2005 20:12:04 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 7351B528F22; Mon, 23 May 2005 17:12:03 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> +  (1) a colon.
> +  (2) mode for "src"; 000000 if creation or unmerged.
> +  (3) a space.
> +  (4) mode for "dst"; 000000 if deletion or unmerged.
> +  (5) a space.
> +  (6) sha1 for "src"; 0{40} if creation or unmerged.
> +  (7) a space.
> +  (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
> +  (9) status, followed by similarlity index number only for C and R.
> + (10) a tab or a NUL when '-z' option is used.
> + (11) path for "src"

What if the path has embedded tabs or spacs?  I skimmed over the patch
but didn't see anything to deal with this (I didn't apply it and check
the result though it might have been outside the patch).
