X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_SORBS_HTTP,
	RCVD_IN_SORBS_SOCKS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Joshua N Pritikin <jpritikin@pobox.com>
Newsgroups: gmane.comp.version-control.git
Subject: Re: [PATCH] Document git-runstatus
Date: Mon, 20 Nov 2006 12:45:29 +0530
Message-ID: <20061120071529.GF3315@always.joy.eth.net>
References: <455F1595.9020009@lsrfire.ath.cx> <20061118092644.a9f15669.seanlkml@sympatico.ca> <20061118143511.GM7201@pasky.or.cz> <455F210B.8000107@lsrfire.ath.cx> <BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE> <455F4F06.3090902@gmail.com> <BAYC1-PASMTP06DE3E6CFF9E49C2BF16C7AEEF0@CEZ.ICE> <455F60EA.2080009@gmail.com> <20061118150431.81076072.seanlkml@sympatico.ca> <20061119181307.GY7201@pasky.or.cz>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: sea.gmane.org 1164006961 25272 80.91.229.2 (20 Nov 2006 07:16:01 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Mon, 20 Nov 2006 07:16:01 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Original-X-From: git-owner@vger.kernel.org Mon Nov 20 08:15:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gm3Nf-0004uU-23
	for gcvg-git@gmane.org; Mon, 20 Nov 2006 08:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933987AbWKTHPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Nov 2006 02:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933989AbWKTHPl
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 02:15:41 -0500
Received: from rune.pobox.com ([208.210.124.79]:41684 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S933987AbWKTHPk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 02:15:40 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8AD7193E3E;
	Mon, 20 Nov 2006 02:16:01 -0500 (EST)
Received: from emit.nirmalvihar.info (unknown [59.95.9.244])
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 120D993E23;
	Mon, 20 Nov 2006 02:15:58 -0500 (EST)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Mon, 20 Nov 2006 12:45:29 +0530
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20061119181307.GY7201@pasky.or.cz>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
Original-Sender: git-owner@vger.kernel.org
Precedence: bulk
Old-X-Mailing-List: git@vger.kernel.org
Xref: news.gmane.org gmane.comp.version-control.git:31883
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31883>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 19, 2006 at 07:13:08PM +0100, Petr Baudis wrote:
> BTW, I've finally found a fine example of situation parallel to Git:
> TeX!  There are the core TeX commands (plumbing) and plain TeX (basic
> porcelain) on top of that as well as a bunch of other macro sets (other
> porcelains). Now I need to dig out The TeXbook from wherever I've put it
> to see how did Knuth deal with it, documentation-wise.

Gahh! Please don't use TeX as an example. As far as I know, TeX doesn't 
offer lexical scope. Hence, action-at-a-distance is commonplace which 
makes program execution extremely difficult for mere mortals to 
predict. I am constantly amazed at popularity of TeX, in spite of its 
grave deficiencies. Perhaps there isn't a good alternative yet.

