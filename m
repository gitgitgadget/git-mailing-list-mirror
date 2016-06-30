Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB5320FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 06:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbcF3GQ3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 02:16:29 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:11649 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbcF3GQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2016 02:16:28 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 66de5858
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Thu, 30 Jun 2016 08:16:25 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:	Junio C Hamano <gitster@pobox.com>,
	"Nicolas Pitre" <nico@fluxnic.net>
From:	Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <xmqq8txo54pb.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
 <xmqq60st853d.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr>
 <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr>
 <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606282047360.24439@knanqh.ubzr>
 <xmqq8txo54pb.fsf@gitster.mtv.corp.google.com>
Message-ID: <146726738438.11587.1114281440699318943@s-8d3a3869.on.site.uni-stuttgart.de>
User-Agent: alot/0.3.7
Subject: Re: [PATCH v4] Refactor recv_sideband()
Date:	Thu, 30 Jun 2016 08:16:24 +0200
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 29 Jun 2016 at 18:40:16, Junio C Hamano wrote:
> Lukas, can you see what is in 'pu' after I push out today's
> integration result in several hours and tell us if you like the
> result of the SQUASH??? change?

Looks good to me. Thank you both for working on this. Note that you
should amend the last paragraph of the original commit message when you
squash Nicos patch into mine.

Oh, and one more detail: I wonder why we still use fwrite(), now that we
know we can use xwrite() which guarantees atomicity. Is there a reason
for that?

Regards,
Lukas
