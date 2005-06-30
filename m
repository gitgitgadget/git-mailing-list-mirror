From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 16:56:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301655310.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301731220.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 01:47:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do8kh-000497-4U
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 01:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbVF3Xyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 19:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVF3Xyo
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 19:54:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263126AbVF3Xye (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 19:54:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UNsOjA006846
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 16:54:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UNsNt8009573;
	Thu, 30 Jun 2005 16:54:23 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506301731220.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, Daniel Barkalow wrote:
> 
> My expectation is that the puller will have a ref "remote-branch", and
> will therefore: (1) want to update it, and (2) know the last commit pulled
> from it. In this situation, we can skip figuring out the start (the two
> points I didn't quote), because we saved it from before.

This is _never_ how I do things, so I think that's a bad expectation. I 
have other peoples trees "just show up", since they are actually based on 
mine..

		Linus
