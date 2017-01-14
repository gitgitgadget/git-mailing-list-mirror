Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C6E20798
	for <e@80x24.org>; Sat, 14 Jan 2017 18:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdANSED (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 13:04:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:49662 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdANSEC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 13:04:02 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyF3F-1cYHba0gHl-015bxa; Sat, 14
 Jan 2017 18:57:15 +0100
Date:   Sat, 14 Jan 2017 18:57:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/38] sequencer: avoid unnecessary curly braces
In-Reply-To: <xmqqk2a0ktxr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701141856240.3469@virtualbox>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de> <bc1a6c21c9ab2f55882c363e802bfcf37e49d79f.1483370556.git.johannes.schindelin@gmx.de> <xmqqk2a0ktxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ekCLKxaoQnEz+H6ixYkvtsLd7VHzclD+icKCjAg3Rfkk+LNM22f
 j8IibluLZWNWvXXw0SdxtceleD8wXfTQXdtPqYCOoV4Bm3+1lUHJvjhT4FLPs5aTlkvlOmh
 mrpg66oamLuWm7MzmwyNlvAANsdR2VQY/NdX3vANSuaMy4bq8uBY/VXWFSzuvOiz6c9cLkK
 rEO0vk48s73HGfga8Yvzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0W1X8KeFEkk=:eHuvNoY0xTPI+Z71nko0yh
 IojfJZl1k7YEs19bi41JXv2sRQgFA6rQALKw+Nm7wrvZeFdqhdA8rYoWNmexuW9WyBecZ8tgT
 cSxRQNvLxHpkVP8XxuxsLot/p2IwSVAS2f05ZPQrhKvkBdl1oSjZMg/L26R4MC497UkLW9QW0
 3lyFRrCKW44ZcDrFCaASB6U6edOvu6NAteaF+TGMoyKfOvm3JmcqUBLrPJtILzJDsVuz02NWW
 u8vHSMuS1MKUWQ2vi4oboRC+Q3+kdwhRcWhExgOF2oUdPXQMkZzyk8nDefjnr0PNQG19p1DOb
 drZ2V+DL58Uk5HH8KY+LRBF1NcCfpMgOiMcOM+gplf1AfJW/cCCcmunk/obwHMfFmwxrQGMNc
 x6qPcdE5Skri9f3CORaYYUFZaInY5qDZs97TxCIDBcHbCJs2kG9O5X9CE51y5OFdxempZfGiY
 l8n+dhaQMWlscM9ZGG50arO6e/DvPBW3ozaS3iXncE6Ff0HasfWS5JOiBfm2O+NZ+/5ZlFSRz
 wjnNaMv2eQ6dceiKQHNG0k/pAfgBV/SP3xkrJ6i+Y5ieghn052X7M1Bh62jHtIR2G+gFWj+Ij
 rN8cyL2MIpUBVcThthmqww/zXzDbjP1msLQiDCZHqLOYRCOdoLyz7KvuAO4zU5vbZRnORYg9C
 ukNP7ByIMZ8EXoMndgt17fEQFVRxqPlE6egOoUumgtcy4/VaCfOEDOtjNzXGCV7U/Xp0BrbiQ
 zNpNgFMIqIIU0mh62XSZsI+KsA6Beg9s3ekz9tSjf58U8wUWuj/fT1WYglZeBfql2was11qL7
 pmv0F6j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 12 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  
> > -	if (!commit->parents) {
> > +	if (!commit->parents)
> >  		parent = NULL;
> > -	}
> >  	else if (commit->parents->next) {
> >  		/* Reverting or cherry-picking a merge commit */
> >  		int cnt;
> 
> The result becomes
> 
> 	if (...)
> 		single statement;
> 	else if (...) {
> 		multiple;
>                 statements;
>         }
> 
> which is not quite an improvement.  

Yet, this used to be the coding style of Git, and your statement comes
quite as a surprise to me.

Ciao,
Johannes
