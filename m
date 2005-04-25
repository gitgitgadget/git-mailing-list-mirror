From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 10:23:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
 <426D21FE.3040401@tiscali.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7Kk-0007iT-I1
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVDYR2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDYRZa
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:25:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:61634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262673AbVDYRVq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 13:21:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PHLfs4011322
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 10:21:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PHLear024768;
	Mon, 25 Apr 2005 10:21:40 -0700
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: <426D21FE.3040401@tiscali.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
>
> "register" and "auto" variables aren't relicts of the 60's,  they're a 
> part of the ISO-C 99 standard, I'm following, "man".

They _are_ relicts of the 60's. It's just that the C standard hasn't ever 
had the reason to remove them.

> And if you think "register" variables are outdated, please remove the 
> CONFIG_REGPARM option from the Kernel source.

That does something totally different. And doesn't use "register" at all.

Pass the toke, you've been hogging the drugs for way too long.

		Linus
