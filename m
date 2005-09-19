From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: nit: missing branch error message
Date: Mon, 19 Sep 2005 10:06:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191005040.9106@g5.osdl.org>
References: <432A67C3.2010205@pobox.com> <7vhdckfw40.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 19:11:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHP9C-0003h4-8u
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 19:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVISRJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVISRJj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 13:09:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932503AbVISRJj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 13:09:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JH6HBo021862
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 10:06:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JH6AIs002590;
	Mon, 19 Sep 2005 10:06:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdckfw40.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8891>



On Fri, 16 Sep 2005, Junio C Hamano wrote:

> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> >> [jgarzik@pretzel libata-dev]$ git checkout -f upstream
> >> fatal: Needed a single revision
> >
> > Better error message would be "hey dummy, branch doesn't exist"
> 
> Thanks.

Hell no.

I'm pissed.

	[torvalds@g5 linux]$ git checkout -b st-5481 0677b284b827fbac20961037982f2a6459a827a8
	hey dummy, branch '0677b284b827fbac20961037982f2a6459a827a8' doesn't exist.

This f*cking message needs to go! The old message may have been confused, 
but it was confused for a really good reason. The new message shows that 
you didn't understand what "git checkout" does.

		Linus
