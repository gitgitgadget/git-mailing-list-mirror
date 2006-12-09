X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 16:49:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612081648160.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> 
 <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>  <457868AA.2030605@zytor.com>
 <20061207193012.GA84678@dspnet.fr.eu.org>  <4578722E.9030402@zytor.com>
 <4579611F.5010303@dawes.za.net>  <45798FE2.9040502@zytor.com> 
 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>  <457998C8.3050601@garzik.org>
  <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
 <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 00:50:28 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33781>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsqQ2-0005QL-5e for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761316AbWLIAuT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761327AbWLIAuT
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:50:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58340 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1761316AbWLIAuR
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 19:50:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB90nXID014026
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 8
 Dec 2006 16:49:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB90nV7B011557; Fri, 8 Dec
 2006 16:49:32 -0800
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org



On Fri, 8 Dec 2006, Michael K. Edwards wrote:
> 
> In Squid 2.6:
>    collapsed_forwarding on
>    refresh_stale_window <seconds>
> (apply the latter only to stanzas where you want "readahead" of
> about-to-expire cache entries)

Yeah, those look like the Right Thing (tm) to do.

That said, I'm not personally convinced that there is much point to using 
netfilter for transparent proxying. Why not just use separate ports for 
squid and for apache?

