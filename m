From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Sun, 27 Aug 2006 13:46:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 22:47:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHRXL-0003yF-3L
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 22:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWH0UrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWH0UrM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 16:47:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27080 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751151AbWH0UrM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 16:47:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7RKkxnW020846
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Aug 2006 13:46:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7RKkvlW005011;
	Sun, 27 Aug 2006 13:46:58 -0700
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m31wr1exbf.fsf@defiant.localdomain>
X-Spam-Status: No, hits=-0.433 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26112>



On Sun, 27 Aug 2006, Krzysztof Halasa wrote:
> 
> > Maybe sha-256 could be considered for the next major-rev of git?
> 
> Not sure, but _if_ we want it we should do it sooner rather than
> later.

Modifying git-convert-objects.c to rewrite the regular sha1 into a sha256 
should be fairly straightforward. It's never been used since the early 
days (and has limits like a maximum of a million objects etc that can need 
fixing), but it shouldn't be "fundamentally hard" per se.

		Linus
