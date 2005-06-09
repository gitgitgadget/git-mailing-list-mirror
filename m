From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 8 Jun 2005 21:11:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506082110510.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <42A7B28A.9010508@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 06:07:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgEJO-0004oG-Oo
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 06:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVFIEKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 00:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVFIEKQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 00:10:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:13505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262257AbVFIEJt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 00:09:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5949ajA024544
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 21:09:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5949ZCp014086;
	Wed, 8 Jun 2005 21:09:36 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42A7B28A.9010508@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Jeff Garzik wrote:
> 
> If this merge-gracefully stuff is all checked into git.git, I can 
> definitely give it some real-world testing.

Yup, all there. Not a _ton_ of testing exactly, but I did actually test
both the content conflict case and the "new directory" case. At least 
once.

		Linus
