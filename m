Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B7C1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeJWFFC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:05:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:60959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeJWFFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:05:02 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx4dh-1fZKq747GT-016cP7; Mon, 22
 Oct 2018 22:44:47 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx4dh-1fZKq747GT-016cP7; Mon, 22
 Oct 2018 22:44:47 +0200
Date:   Mon, 22 Oct 2018 22:44:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/3] reset: don't compute unstaged changes after reset
 when --quiet
In-Reply-To: <20181022131828.21348-2-peartben@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810222244150.4546@tvgsbejvaqbjf.bet>
References: <20181017164021.15204-1-peartben@gmail.com> <20181022131828.21348-1-peartben@gmail.com> <20181022131828.21348-2-peartben@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MMpcKb1M17vOVYV8MUbdXkPfKqp1qdaA28svcf6OuB1dqhvbIGi
 BDldOg3G/VCumuTt/EeyzMg5Bnwo2MHeEL0LV7MDDkUBnqD/pYDa/b6Lc7EB0FthJnJ+hNT
 im1awEUpiiVA11PR3NAMkJZwos1mxziS4Hj3j9+Z9wNS9XflZaCjo+b5pRYM4vtRL2kUwAq
 wtFWzi29kzGb4IEcT2Eyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:inBEpeaeTH8=:Frc2qU4Xc1BXCv+d/8pVpd
 kj4tmBZnsTSKnxtHphpL2fE+uWe7jNfYC2UqLx07meA2ix3zsBs5g+3mkI/bku3QamG/snlfF
 VmWqgxa2QDX78rAHt8WMtavU2h8gODx58gttfTBTQP1hBy1VLgdKzwDef61QfCFlqsTA/NY1P
 9rgjWh84N653dNZ/9rGr+16Ete80MgLCdoN19WXpFKNdub4SY5fkNFCpLgCmkKtMu3ULtn3nM
 4EKTJKW+h68uK4uV9/b1mbt2tjZ2ld+EFWpiFxJrYkkiCxYUrZbQhULCLbdye4KtrZjF++jAq
 vm+ybcPUURaq/8SHtgyphC54RrPeFfIVT5JTyYqU7OyuLBHj58X8hxNhDiiJcblTVWcxKZt1t
 HUjXtT1tFC21V/JJUtSKXSE7iX6v/cOyeIz5xrI937FEAvaAIP2dAjgxq7komS8kFGEyXkfBN
 5eQmCVhfE0HpFJMl6AiOyJaWKr3FrZA9GnDM0Nlec+N8F8lU2ScHjE7MReFb3pbICBQMKhZeY
 xgEowkzR+aB2W9ycdD5Sz8Og9XJ7vN47dNveogOYuowbHpIRiZlYMzmGffytzS7nycmZdYZv7
 uRALIRImV3MmS6BnRWZ1XyrHAeTT6qvbXJUZ4CPsgC+uq7BSrPoTMyvJgsqvHoThJaS34xILN
 dhuA89cG2WfbuYTnMsfBjcG1gJBxlHClqfySVPfmbCSTRLIUvaS7SDasAdfTarJkyGk+xeM79
 rzN1zeeR4U6hu0GYrDD/s/ltfp4UqFCIHvSMawzrL5Cf2DLJY1MzOEkTznVrZsPaoODH/lDSG
 H1s8k3c7XfTGAyVrGhu0rbxzc7NcAoCLwbiWZcy4wk6UvqKir8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Mon, 22 Oct 2018, Ben Peart wrote:

> From: Ben Peart <benpeart@microsoft.com>
> 
> When git reset is run with the --quiet flag, don't bother finding any
> additional unstaged changes as they won't be output anyway.  This speeds up
> the git reset command by avoiding having to lstat() every file looking for
> changes that aren't going to be reported anyway.
> 
> The savings can be significant.  In a repo with 200K files "git reset"
> drops from 7.16 seconds to 0.32 seconds for a savings of 96%.

That's very nice!

Those numbers, just out of curiosity, are they on Windows? Or on Linux?

Ciao,
Dscho
