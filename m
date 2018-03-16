Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C6D1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 12:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbeCPMgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 08:36:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:54235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeCPMgV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 08:36:21 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFLhE-1etT5Z3l2K-00EP7v; Fri, 16
 Mar 2018 13:36:17 +0100
Date:   Fri, 16 Mar 2018 13:36:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] rebase: support --signoff with implicit rebase
In-Reply-To: <c9978ac6-ded3-592e-aa49-53172aad75bf@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803161335400.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180314111127.14217-1-phillip.wood@talktalk.net> <nycvar.QRO.7.76.6.1803151112390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c9978ac6-ded3-592e-aa49-53172aad75bf@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aUymR1wX2+bIXIqLjpHqXGt5iyKbxfr6PidS6ysEte2iDLb0ntq
 lk9rd7QM7rzGCsrq+rpqdCWX8aW3VHVOEwVZzXacLKQzRCTuwy9rmpV63eADkLUfOi/3uxh
 BH5FKJEAybNH9sqdxg8rw+lSgFvZHYcF/hQ/IB3cvfHU5A16Akgh08tFqEgQsd2F/8G2maG
 P3UsXfR7WoyZg1IJTCJNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KFw55TdtIj8=:YSgFkw4a/LWJJLEvywp3Ra
 eRWAADIAtsIZfBJO2uSj+dBo2m8PLOTxNGXdeTFFv0mUCpB79lXzWyS1+CBHVgiNCt4uVOtUS
 cn+eZ0+UNGwE1Los2mrTP2PMloYICd0fqjewqXkugaJJhAsrCMUmlvnn1HoA4LhmDbMS7ktZ6
 uvHluVIKa/Aljr04+gJdK2GbfN2rlpMELjhRUEnuqB5suKJVQzg85R3VCstGHGIFoAtOoowvB
 2GbvBbKzLgOtDo8fBpdhq4TnIcue1jijQLBQnZrjxzsICF2Q6UEs5NftBnpMvuJSyJxt4GisG
 Fia0pHLlEmQ+GUbYnssF2ttboLbccxS4mnLndhbN8S+Pw5/iL1FgsAyHK0Rj3szZnYszYD1Th
 p/8u422OTyY6EBJZfXt26eCWAvbm282n2AfOXJ69OuOxWwtlTr87LNBVi1MI/6aPdvb9H2HK2
 TDzENA2itNCvZ/x2URCnlqie+T3F3zBPQBZ4XRh6I2Ui891X37KWMpj77Poz0p8MKJOggsTaW
 /9ulN3IiVXWnKHNIzEN7wdgNdl80AT+qHJwjhtnMoaygmNFSRd2Up5wSMcBfKo4SWe68iZcfm
 lM02vZaguSnKRgMOLYBFgURxBRKjjU+vb3RWTpN4IQJeBdQhbUePRWuEPFv3//1hGA3wSUHII
 +kYL2uCeOcgNR/s1sTkeWR22SiQ4lyHGt1uHQSaq2KNV1PqKMUwppipvBHjvLcLigW5gb0hQV
 AWrk+OVTvZoQEFNbsszq2yiQ4Ua4W/olN7t6sn5Nr/mmE0cxjPda3Pc2WyQpNcQe/X2t2bVJ/
 NIVBHnvs/Z0oRpZBaYjUCNkH3PoYx/eK3yE+VayDiVP8ZikI0A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 15 Mar 2018, Phillip Wood wrote:

> On 15/03/18 10:18, Johannes Schindelin wrote:
>
> > As I mentioned in my reply to Junio's comment, it'd be awesome if
> > --interactive --signoff was supported (and likewise --merge
> > --signoff), but it feels like an undue feature request to be dumped on
> > you, so I'm fine with the patch series simply erroring out on those
> > combinations.
> 
> I'll have a look, if it's not too much work I'll do that, it would be
> nice to have --signoff better supported.

Thank you so much!
Dscho
