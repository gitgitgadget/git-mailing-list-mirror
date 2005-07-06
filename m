From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Short-circuit git-clone-pack while cloning locally.
Date: Wed, 6 Jul 2005 09:13:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507060911510.3570@g5.osdl.org>
References: <20050704.125744.59481768.davem@davemloft.net>
 <Pine.LNX.4.58.0507041327580.3570@g5.osdl.org> <Pine.LNX.4.58.0507051721450.3570@g5.osdl.org>
 <7v8y0kxsfq.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 18:14:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqCWz-00009B-Ax
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVGFQNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVGFQNb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:13:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVGFQNW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 12:13:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j66GDDjA006493
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Jul 2005 09:13:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j66GDC3i006989;
	Wed, 6 Jul 2005 09:13:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y0kxsfq.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 6 Jul 2005, Junio C Hamano wrote:
> 
> By invitation.
> 
> ------------
> When we are cloning a repository on a local filesystem [...]

Hmm.. Did you test the ssh case?

> +case "$local_use,$is_local" in
> +default,f)
> +	;;

It would seem that you don't do anything at all for the non-local case.

		Linus
