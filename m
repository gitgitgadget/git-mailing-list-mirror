From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Improve git-peek-remote
Date: Tue, 4 Jul 2006 13:01:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607041258310.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0607041222110.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jul 04 22:01:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxr59-0002ct-47
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 22:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWGDUBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWGDUBM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 16:01:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932368AbWGDUBK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 16:01:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k64K16nW031408
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 4 Jul 2006 13:01:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k64K16ER013140;
	Tue, 4 Jul 2006 13:01:06 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607041222110.12404@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23312>



On Tue, 4 Jul 2006, Linus Torvalds wrote:
> 
> This makes git-peek-remote able to basically do everything that 
> git-ls-remote does (but obviously just for the native protocol, so no 
> http[s]: or rsync: support).

Btw, if it wasn't clear - it's not actually a git-ls-remote replacement 
yet, even for native protocols. It doesn't actually do the remote URL 
thing, so you can't do simple things like

	git peek-remote origin

for example. 

Things like "git fetch", that do their own remote parsing anyway, don't 
actually care, but I thought I'd mention it anyway, just so nobody gets 
surprised.

		Linus
