Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7D21FAE4
	for <e@80x24.org>; Wed, 31 Jan 2018 13:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeAaNIU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 08:08:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:64815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeAaNIT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 08:08:19 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.195.59]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MQu9K-1eKLJg491i-00UHcT; Wed, 31 Jan 2018 14:08:07 +0100
Date:   Wed, 31 Jan 2018 14:08:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 00/10] rebase -i: offer to recreate merge commits
In-Reply-To: <CAGZ79kYVa1HFG=tP6gJjH_epC_kwNSwjWmQ2gQ+JWzSksY6fSA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801311407190.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de> <CAGZ79kYVa1HFG=tP6gJjH_epC_kwNSwjWmQ2gQ+JWzSksY6fSA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TUu52poFEW2QAwlwZMvkW5YnMZ2IOuMaqUERDnCBpVhq6XPju36
 aXnSP5CUZYUbaw4jHP3Rh4Bd+I/iongAZ+CM2yAf9dUccAKowFBUU0we4ypIF+mqnNO88Cv
 aHdDT0BKWZEcYAM03QwsRSspDkp8cXgkI4YjNXoTZTWyUZlc2TJfXXJOxi4jOcX9zI4BNJq
 o/scigNZY2XVzJm9RQLSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BygxBXLyGxc=:yKKlgBaoHfvb5tSprRsR/n
 fJQ2NlcciwQ5LluAXACOdFaYdW7XGfex8AL+/rXZawVNeNM8Pl6CchaW6WkS8xdoRe3KNGx62
 Hfavlz110nYSK3kFOgNQuB1aVAYQIDI9GsFZJi9AyDBxf5e/4ZZzmGl+6qLKg+9l4HZyRK0ae
 6TsTbXr1A22fPnlOjGNDWB1Hu9Bf/YeAO5Pxux7C5hAWlzQdelkfpV3dCB8Rs1Dl0Tr/t2Td1
 kH9Fbcb0+peLXx3XjjZvVroibwwpvJLI4EA5VmXS4YZZLK0CI8FNIioj0tbAgH//kgbMyeqvN
 sFyECYeUWOlM/d57tBKo9dcHlO4ubxujCt4aqYsv2bMDTfNsxfizlnR/BrGdxAjcFfGfHq6km
 TmBzayKFKtkH+KBgzqdZEgKV1cuL0rn7qlvhA8H1YrCVNwh8+qaxB9xFXg+WC/UbtcxV6sn/J
 1NIkArHdYV5tCAP68igY5FqAK9weWo/MrGHq0nMDAPivJOMF10FHdbJ/OBnoTU7NC0D5+5ve1
 8uwsUi+v5c0g82Z6EHr54KXtlySiJ2aQjysRgKqTpR325e4jraV3+9/njsv+aLGbS3H9uXiQe
 aI1KK4jDPB1yYAIPnvJ1XiyHzuGzbvatN6TFd4N+qFWhh2x+pzf4btc/mhRhmqlfQiFN4FBQf
 NFT7hd1JWJMKpGdkJ+aoj3upMEvxbr6l+XN5KVyP/ivJGRvdDz+PRjjJOY17E7esM1ifAbF4P
 wAoz9ZvBRwe0ZmFUzJ5+qtUiR8Db0cJJZPXCgQk+V5NxF6m6qDCmxRclnj7tVbOIsLXnr5xgv
 H4UnVZz1M+sorHJtVS1FaGR9OqkdUU1iZWVVVhPH9HvlRt+OPZjju4Z5srgNUAN12BnFQYZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 30 Jan 2018, Stefan Beller wrote:

> > - got rid of the universally-hated `bud` command
> 
> Sorry if you got the impression for that. Maybe I was imprecise.

You were not the most vocal voice. Anyway, `bud` is gone now.

> > Stefan Beller (1):
> >   git-rebase--interactive: clarify arguments
> 
> No need to honor me with authorship, as I just wrote
> that patch in a quick hurry to express the idea.

You wrote it.

> The interdiff looks good to me, I'll review the patches now.

Thanks,
Dscho
