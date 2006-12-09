X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 09 Dec 2006 04:27:51 -0500
Message-ID: <457A8197.5090503@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>  <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>  <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>  <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>  <45798FE2.9040502@zytor.com>  <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>  <457998C8.3050601@garzik.org>  <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org> <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com> <Pine.LNX.4.64.0612081648160.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 09:28:07 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612081648160.3516@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33809>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsyV1-0005f4-Ip for gcvg-git@gmane.org; Sat, 09 Dec
 2006 10:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936595AbWLIJ2A (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 04:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936642AbWLIJ2A
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 04:28:00 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:59338 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936595AbWLIJ17
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 04:27:59 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GsyUq-0002I9-4c; Sat, 09 Dec 2006 09:27:52 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> That said, I'm not personally convinced that there is much point to using 
> netfilter for transparent proxying. Why not just use separate ports for 
> squid and for apache?


That's what most people using squid in "http accelerator" mode do.  They 
put Apache on port 8080 or somesuch.

	Jeff

