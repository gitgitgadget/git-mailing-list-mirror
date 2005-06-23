From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git testsuite failures
Date: Wed, 22 Jun 2005 17:59:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221757440.11175@ppc970.osdl.org>
References: <20050622.121835.78708158.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 02:51:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlFvx-00085W-3B
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 02:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVFWA5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 20:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVFWA5S
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 20:57:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261935AbVFWA5P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 20:57:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N0vCjA008179
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 17:57:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N0vBIB016728;
	Wed, 22 Jun 2005 17:57:11 -0700
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050622.121835.78708158.davem@davemloft.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, David S. Miller wrote:
> 
> There are test cases failing in the testsuite over the
> past few days, is this expected?

Fixed now. It was the parent ordering cleanup that broke an assumption
about parents being in reverse order in the rev-list "epoch" code. I
checked in the fix from Jon,

		Linus
