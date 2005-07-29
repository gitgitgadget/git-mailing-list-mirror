From: Timo Hirvonen <tihirvon@ee.oulu.fi>
Subject: Re: Makefile: COPTS vs CFLAGS
Date: Fri, 29 Jul 2005 17:03:27 +0300
Message-ID: <20050729170327.5f8f3d5a.tihirvon@ee.oulu.fi>
References: <20050729134011.GD21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jul 29 16:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyVSm-0006m5-Lg
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 16:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVG2ODf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 10:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVG2ODf
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 10:03:35 -0400
Received: from marski.suomi.net ([212.50.131.142]:6330 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S262596AbVG2ODe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 10:03:34 -0400
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IKE0090K71WHX00@marski.suomi.net> for git@vger.kernel.org;
 Fri, 29 Jul 2005 17:03:33 +0300 (EEST)
Received: from garlic.home.net (addr-213-216-219-24.suomi.net [213.216.219.24])
	by spam1.suomi.net (Postfix) with SMTP id F1FCB6A00; Fri,
 29 Jul 2005 17:03:27 +0300 (EEST)
In-reply-to: <20050729134011.GD21909@pasky.ji.cz>
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.8; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Not virus scanned: please contact OPOY for details
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.827,	required 5,
 autolearn=not spam, AWL 2.07, BAYES_00 -4.90)
X-MailScanner-From: tihirvon@ee.oulu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Jul 2005 15:40:11 +0200
Petr Baudis <pasky@suse.cz> wrote:

>   What I would propose:
> 
> 	-COPTS=-g -O2
> 	-CFLAGS=$(COPTS) -Wall
> 	+CFLAGS?=-g -O2
> 	+CFLAGS+=-Wall

Sounds good. I've never heard of anyone using COPTS variable before. And
"-g -O2" seems to be a good default value.

Using $DESTDIR instead of $dest would be nice too because DESTDIR is used
by Autotools.

-- 
http://onion.dynserv.net/~timo/
