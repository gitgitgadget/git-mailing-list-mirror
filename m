Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3103F20899
	for <e@80x24.org>; Sat, 12 Aug 2017 05:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdHLFpZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 01:45:25 -0400
Received: from mout.web.de ([212.227.15.14]:54974 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbdHLFpY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 01:45:24 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEqOg-1dqsoo3dRi-00G3ph; Sat, 12
 Aug 2017 07:45:16 +0200
Date:   Sat, 12 Aug 2017 07:45:16 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     tboegi@web.de
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: core.autocrlf=true causes `git apply` to fail on patch generated
 with `git diff-index HEAD --patch`
Message-ID: <20170812053944.GA21232@tor.lan>
References: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
 <287407ac-b0d0-ef24-4950-0982a2db9bed@web.de>
 <CA+dzEB=3OMw_YM4K_a8dyDG_FwGavU382stXrEOkbYoyM4DSZQ@mail.gmail.com>
 <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
 <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:5S0QkYFiXiIYlgCEWwbajKZHow4XgtSLoq2b/9LbVVaJbPToR55
 oKql8X6/Vw+MDNRKzUNmAY5fUtQuyWGyLiWf1scelSlWYXqFvifM3Zta0T9HbrPhJaebR7I
 Jeg+sQJG2g/5cKVb41i0+jm2ORyzaD/eboTzpr2QKV9AeSzQDpAc6rBlXU6Y1Evu9w537Gn
 5i7AarNciLbKacFN/O9MA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gBZY/5yv6aE=:1IU3eLGA4mOHoilxy9BvBu
 55a0whZVH/LASZQi6V2/V9GqyKDVbxgJoOIwCz2qAFr21MXnRD4ZhuqLlmWEzA9xB8wR3wTD3
 QfvsLCLhQNsbs0eT/hJmXrY8hyR/SvDDPqWJCkeE4j5MbVudRpNFhDbjaH64cHxQqte0uxcTl
 vHSPFG6tsxzluyiEk+gX24MaiUz/XDf8wRHfQgwgCkZP9/JWWEAwKZIH7A1HV2kNmRKQ1esrY
 4ojl9JZ6LnRDh0xfjnLw1wHZa2loczZjo7IpfKJiwCzo1Rp+DZqgpUsdN5OAGTfekbHX6CNQh
 hUnt5vqDkyC2mf/7q7+d21t7X/s/9aD7zcelGBmbTN+r6zP5+SfZYVvngqM/yWjD4idApfYAG
 1MnX0ZYcqYJFRXOpf9xmLUbfSWg/xwjJcORDa3CsQYzIw6XpTmjF+m7aQMF3BDiVK0BJKlOl4
 4MP5Eq3WHzUpF2BP4n/fQW6EHLsAMpKwuzzlRXF8ZaUwY7xd5Ym3RwsVmveZJl9qmotDBDGoP
 tHe0gJ22Ay6E/a4RXAPl34PEJBXyWYURRfgBRgc7rQrxeE7LKh2oE/yiAhrRLYg9oi/oBKL23
 K11tKLakX9en5zendKjGOilM1DZLKPSEUdJguYejC7EIpzewj0wQ1qSxEUZVYs90yoj/UgzNV
 5qodrrfO7DRUaQ+ZWbahvKsX0CG//ilFbaz/SQ0NPxednecI7YuHE7uj8ioqZdPGX4oQc4b8j
 6p4zAdBA8IEhFWD/3pbSloaWcK/mzpFMzSU7mepmuNtnuwIuUGfL97Epp8ZdcliBUIFggCPoZ
 pX+uidejINLXWmrQTjjzcV0cGHT3zD5hbXR/XERUuFV2zNCvWINLRunnsMOPiegidCNq2p4Z/
 3O9r2hPPkigrN0gpfLgrANQlYQCw9c1kaBbZCikXA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test from mutt
