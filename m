From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ls-tree: handle trailing slashes in the pathspec properly.
Date: Tue, 31 May 2005 20:51:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505312048350.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
 <7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org>
 <7v8y1vvvaa.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505311636260.1876@ppc970.osdl.org>
 <7vy89uu9vc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 05:47:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdKBo-00089y-69
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 05:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFADtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 23:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVFADtV
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 23:49:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:51844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261236AbVFADtS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 23:49:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j513nDjA002264
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 20:49:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j513nDdg032093;
	Tue, 31 May 2005 20:49:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy89uu9vc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 31 May 2005, Junio C Hamano wrote:
> 
> BTW could you limit git-apply --stat output to 79 cols not 80?

Hmm, I thought I already did, but it turns out it could round up both 
add/del, causing my 79 to be 80.

I think I fixed it.

		Linus
