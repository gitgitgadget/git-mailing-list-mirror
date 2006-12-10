X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 07:41:04 -0500
Message-ID: <457C0060.3050605@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612091437.01183.jnareb@gmail.com> <46a038f90612092007w4637637aya1a01ec18ff16f6f@mail.gmail.com> <200612101109.34267.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 12:41:18 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612101109.34267.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33885>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtNzV-0003UJ-5B for gcvg-git@gmane.org; Sun, 10 Dec
 2006 13:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759126AbWLJMlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 07:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbWLJMlJ
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 07:41:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37792 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759126AbWLJMlI
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 07:41:08 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GtNzN-0000O5-Hx; Sun, 10 Dec 2006 12:41:06 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> P.S. Any hints to how to do this with CGI Perl module?

It's impossible, Apache doesn't supply e-tag info to CGI programs.  (it 
does supply HTTP_CACHE_CONTROL though apparently)

You could probably do it via mod_perl.

	Jeff

