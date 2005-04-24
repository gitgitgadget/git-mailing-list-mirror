From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sat, 23 Apr 2005 21:55:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232153500.15879@ppc970.osdl.org>
References: <1114280570.5068.5.camel@mulgrave>  <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
  <1114292680.4799.4.camel@mulgrave>  <20050423230238.GD13222@pasky.ji.cz> 
 <1114298490.5264.10.camel@mulgrave>  <Pine.LNX.4.58.0504231759010.2344@ppc970.osdl.org>
 <1114317771.4980.7.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 06:48:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZ2v-0007I6-3d
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVDXEx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 00:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVDXEx3
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 00:53:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:18340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262252AbVDXEx0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 00:53:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O4rNs4002939
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 21:53:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O4rMLx029307;
	Sat, 23 Apr 2005 21:53:22 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1114317771.4980.7.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, James Bottomley wrote:
> 
> OK ... this is done by reapplying to the top of your git tree and then
> doing a show-diff.  I've checked that it actually applies without
> rejections to a pristine git tree.

Well, I actually ended up editing the line numbers manually and already 
pushed out the previous one, so you might want to double-check that my 
current tree matches yours.

		Linus
