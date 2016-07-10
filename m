Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F110A2018E
	for <e@80x24.org>; Sun, 10 Jul 2016 12:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413AbcGJMps (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 08:45:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47810 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933405AbcGJMpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 08:45:47 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rnSd44cPgz3hjKf;
	Sun, 10 Jul 2016 14:45:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rnSd44DvBzvkJg;
	Sun, 10 Jul 2016 14:45:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ugq3fJ4Shj8q; Sun, 10 Jul 2016 14:45:43 +0200 (CEST)
X-Auth-Info: IXwRdFcXqI3Rrkz6nj7xh7yftZT4TA9cLBkWhvdo7hdCnAcQhO8quTbpiA6ZlcFe
Received: from igel.home (ppp-88-217-3-50.dynamic.mnet-online.de [88.217.3.50])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 10 Jul 2016 14:45:43 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 76C392C25AA; Sun, 10 Jul 2016 14:45:43 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Peter <peter.mx@gmail.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Fwd: git rm
References: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
	<CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
	<87a8hubtw4.fsf@linux-m68k.org>
	<20160707033538.GA7595@sigill.intra.peff.net>
	<CAK8tuqiCMUjoS_xXKSJ4qiGK8ioAjfGsQ3_WO0OQj5-5-i7rOw@mail.gmail.com>
	<87bn254v7b.fsf@linux-m68k.org>
	<CAK8tuqj8_Xgp1f+SPArmMHQs_+u6gOMnt958GXXRnTp4MAuB3g@mail.gmail.com>
X-Yow:	ANN JILLIAN'S HAIR makes LONI ANDERSON'S HAIR look like
 RICARDO MONTALBAN'S HAIR!
Date:	Sun, 10 Jul 2016 14:45:43 +0200
In-Reply-To: <CAK8tuqj8_Xgp1f+SPArmMHQs_+u6gOMnt958GXXRnTp4MAuB3g@mail.gmail.com>
	(Peter's message of "Sun, 10 Jul 2016 14:23:54 +0200")
Message-ID: <874m7x4q6g.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Peter <peter.mx@gmail.com> writes:

> Ah, ok, I see now. But are there any other situations where the "-f"
> switch is not needed?

When the file is unmodified and matches the index.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
