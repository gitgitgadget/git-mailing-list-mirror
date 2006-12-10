X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 17:08:57 -0500
Message-ID: <457C8579.5080407@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612102011.52589.jnareb@gmail.com> <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org> <200612102127.05894.jnareb@gmail.com> <Pine.LNX.4.64.0612101228590.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:09:16 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612101228590.12500@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33938>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWr3-0008KD-TI for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756821AbWLJWJC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbWLJWJC
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:09:02 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41269 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1756821AbWLJWJA
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:09:00 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GtWqw-0002us-Km; Sun, 10 Dec 2006 22:08:59 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 10 Dec 2006, Jakub Narebski wrote:
>> Well, the idea (perhaps stupid idea: I don't know how caching engines
>> / reverse proxy works) was that there would be caching engine / reverse
>> proxy in the front (Squid for example) would cache results and serve it
>> to rampaging hordes.
> 
> Sure, if the proxies actually do the rigth thing (which they may or may 
> not do)

squid seems to work well as an HTTP accelerator (reverse proxy). 
Apache's mem|disk cache stuff fails miserably.

Unfortunately squid development seems to have slowed in recent years.

	Jeff


