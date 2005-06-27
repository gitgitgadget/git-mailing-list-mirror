From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-local-pull
Date: Mon, 27 Jun 2005 11:46:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506271145410.19755@ppc970.osdl.org>
References: <20050626.200555.39157645.davem@davemloft.net>
 <Pine.LNX.4.58.0506262213220.19755@ppc970.osdl.org> <42BF8F2D.1070808@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 20:39:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmyVG-0004vC-Az
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 20:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVF0SpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVF0SpY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 14:45:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261555AbVF0Soi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 14:44:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5RIiBjA003023
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Jun 2005 11:44:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5RIi5qS013710;
	Mon, 27 Jun 2005 11:44:08 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BF8F2D.1070808@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 27 Jun 2005, Jeff Garzik wrote:
> 
> FWIW, I notice that git-diff-tree uses >100MB of RAM, on a large 
> git-pull-script run.  It's generating the diffstat output, AFAICS.

Ahh, yes, I should make the diffstat be conditional, not everybody wants 
it, and it's often the most expensive part of the pull..

		Linus
