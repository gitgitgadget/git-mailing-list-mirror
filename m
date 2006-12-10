X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 12:30:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101228590.12500@woody.osdl.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <200612102011.52589.jnareb@gmail.com> <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>
 <200612102127.05894.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 20:31:49 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612102127.05894.jnareb@gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33924>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtVKs-0007n5-RW for gcvg-git@gmane.org; Sun, 10 Dec
 2006 21:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762488AbWLJUbi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 15:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762489AbWLJUbi
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 15:31:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59213 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762486AbWLJUbh
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 15:31:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAKUoID019729
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 12:30:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAKUnlX002340; Sun, 10 Dec
 2006 12:30:49 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Jakub Narebski wrote:
>
> Well, the idea (perhaps stupid idea: I don't know how caching engines
> / reverse proxy works) was that there would be caching engine / reverse
> proxy in the front (Squid for example) would cache results and serve it
> to rampaging hordes.

Sure, if the proxies actually do the rigth thing (which they may or may 
not do)

> What about the other idea, the one with raising expires to infinity for
> immutable pages like "commit" view for commit given by SHA-1? Even if
> the clients won't cache it, the proxies and caches between gitweb and
> client might cache it...

I agree, but as mentioned, I think the _real_ problem tends to be the 
pages that don't act that way (ie summary pages, both at the individual 
project level and the top "all projects" level).

