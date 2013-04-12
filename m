Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 26606 invoked by uid 107); 12 Apr 2013 15:21:11 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Fri, 12 Apr 2013 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab3DLPTK (ORCPT <rfc822;peff@peff.net>);
	Fri, 12 Apr 2013 11:19:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:43045 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab3DLPTI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 11:19:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UQfkp-0007M8-BK
	for git@vger.kernel.org; Fri, 12 Apr 2013 17:19:07 +0200
Received: from ip68-227-87-145.sb.sd.cox.net ([68.227.87.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 17:19:07 +0200
Received: from richard_hubbe11 by ip68-227-87-145.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 17:19:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: segfault in git-remote-http
Date:	Fri, 12 Apr 2013 08:20:52 -0700
Organization: " "
Message-ID: <20130412082052.5afaa5cd88677eeb6da7daf0@lavabit.com>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
	<20130409084718.587e99aa7a935296867a84a1@lavabit.com>
	<20130409171623.GE21972@sigill.intra.peff.net>
	<alpine.DEB.2.00.1304091924210.20932@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-227-87-145.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: encrypt
X-Operating-System: Barebones_6.1
X-Gmane-NNTP-Posting-Host: 192.168.1.1
X-NNTP-Posting-Host: 192.168.1.1
Mail-Copies-To:	never
X-Archive: expiry=17
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 9 Apr 2013 19:25:53 +0200 (CEST)
Daniel Stenberg <daniel@haxx.se> wrote:

> On Tue, 9 Apr 2013, Jeff King wrote:
> 
> > git-remote-http does not touch the openssl code itself at all. We
> > only talk to curl, which handles all of the ssl (and may even be
> > built on gnutls). So if that is the problem, then I think it may be
> > a libcurl bug, not a git one.
> 
> ... and if/when you do make it a libcurl bug, please include more
> details that includes how to repeat the problem and what versions of
> libcurl and OpenSSL you're using.

I posted to web.curl.general few days ago....

