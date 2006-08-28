From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 14:23:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281421120.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg .de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost>
 <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org> <m34pvwfwl5.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608281317070.27779@g5.osdl.org> <m3r6z0ef95.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 23:24:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHoaA-0003fo-8d
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 23:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWH1VXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWH1VXh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 17:23:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751527AbWH1VX2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 17:23:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SLN9nW002170
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 14:23:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SLN8Dc015256;
	Mon, 28 Aug 2006 14:23:08 -0700
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m3r6z0ef95.fsf@defiant.localdomain>
X-Spam-Status: No, hits=-0.435 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26182>



On Mon, 28 Aug 2006, Krzysztof Halasa wrote:
> 
> Well, conflicting files will most probably have the same size,
> like with MD5 cases :-)

That's only true for the much easier injection case where you generate 
_both_ files together.

>From an external git hash-attack standpoint, that's not a very useful 
case. It's much more useful if you can make a new file that has a hash 
that matches a given old file, and in that case, the filelengths are 
likely not the same.

			Linus
