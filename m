From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/1] bugfix for git-checkout-cache --prefix=/symlink/export_dir/
 -a
Date: Mon, 23 May 2005 12:09:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231208460.2307@ppc970.osdl.org>
References: <E1Da8d0-0002GR-4m@ash.dgreaves.com> <Pine.LNX.4.58.0505231145190.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:07:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaIFb-0002ye-57
	for gcvg-git@gmane.org; Mon, 23 May 2005 21:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVEWTHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVEWTHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 15:07:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:59544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261939AbVEWTHV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 15:07:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NJ7GjA009470
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 12:07:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NJ7FNt013756;
	Mon, 23 May 2005 12:07:15 -0700
To: David Greaves <david@dgreaves.com>
In-Reply-To: <Pine.LNX.4.58.0505231145190.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Linus Torvalds wrote:
> > otherwise fails.
> 
> Hmm.. Does this alternative work for you instead?
> 
> [ Totally untested, please check for sanity first!! ]

Btw, I'm not going to apply this, and expect that David or somebody else 
can validate it and send it back to me as "tested".

		Linus
