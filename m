Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E511F404
	for <e@80x24.org>; Fri, 13 Apr 2018 15:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750867AbeDMPWC (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 11:22:02 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:10191 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMPWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 11:22:01 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 70WSfYY8yLjjA70WTfUR7K; Fri, 13 Apr 2018 16:21:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523632919;
        bh=Fhnu3snVBm2DWfP9+lKM5ryW3Cmlu+OACXvhorb+Kb4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WYj57ZAtkXr3Glzh+ckR7HEypTH7D+NI+1zdB9+NAFsN4g743BbMQREktlJQuYmZu
         QCw+TC/FfNpu2y0fQIzb5LZJxNOe1Y/JOud4PjYKMKsaYL3a7XSDGVWRNtwVSZq+Yq
         l7ug+oizuZbov8cV7hiqA/5r8ezu1gFIH0uzeMwc=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8 a=q-13nYL-w6O4rlMW0iwA:9 a=QEXdDO2ut3YA:10
 a=u09W0hvIdLUA:10 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the
 man page
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de>
 <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
 <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
 <CAPig+cRfQgz2tCab2d9g-XznHORW0FJvDKS4fe85JkLPxm2HMQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <de682d44-a8e7-6fdd-f7bc-e06fea2685ab@talktalk.net>
Date:   Fri, 13 Apr 2018 16:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRfQgz2tCab2d9g-XznHORW0FJvDKS4fe85JkLPxm2HMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC28uO8VF2SEoiggrF/z2YqmY7dlD2tzo2jHOu2N8e05mD1sWv84R5+HQPXuYU1uuignsxC0opevaa+HRAKSuBCj8e9QhmrmiztePdEHsLCEHtiDuFcQ
 1Fn19x+XHgQmAT/qlwGhpnb8/bjjb34IsesO5hiV5tOTS5zoF+ORYoiz9oiYVPHVUdg0Fz5zPhyeF72Dtff2MKjSS9b1MvPs5RT+UT6lP94J2QAmNi0kgS3Q
 mlnNtdtdMLwSzMFDn18A0bwcoMZEOgpTWkTFBWW7Nq312O0TMf8V0kF4VqUD2D1lrBouPSTJpvp/RMXkU5OqXMFCUFU049wEBXUGCKlYcUMFlclyVGt8S1R9
 to8dwqghm/eJ8L2vhlY+eN+HbvPq/aaKJiq38qxNFoG+6+BZ+uM02UJbN1g9vzm1yWI9G3mtH2vAiDvqFCjN/VrF76DuU+7lMnnlP2hQYhjuaMgRFWqrYZIt
 U09MT2i/hODRRZy2Sp2Hpq5OZPmRWsErZtX21Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/18 20:10, Eric Sunshine wrote:
> On Wed, Apr 11, 2018 at 11:35 AM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
>> On 10/04/18 13:30, Johannes Schindelin wrote:
>>> +The `reset` command is essentially a `git reset --hard` to the specified
>>> +revision (typically a previously-labeled one).
>>
>> s/labeled/labelled/
> 
> American vs. British English spelling.

Ah, I'd forgotten that the American version only had one 'l'

Thanks

Phillip

> CodingGuidelines and SubmittingPatches talk about this. Junio
> summarizes the issue well in [1]. The TL;DR is to lean toward the
> American English spelling.
> 
> [1]: https://public-inbox.org/git/xmqq4m9gpebm.fsf@gitster.mtv.corp.google.com/
> 

