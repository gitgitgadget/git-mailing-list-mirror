Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A1E1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbfHVQG7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:06:59 -0400
Received: from mout.web.de ([217.72.192.78]:40315 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733034AbfHVQG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566490017;
        bh=qk3c9zorqzRazmTO0KvJcKDlObGB4kyFdrCcTofLX58=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=s+IdqFNNANI4daPW5oVHYB9lJp6v6T4bQGiugaYWZ0iXOIxQZSNmF5jpJxCfPfZJ9
         kR5MAFTY7MK3oUaBPuqpBUeuff/vGDRMs785Jhp8uK4bZIXe/waAAhcAwM0CzKzIA/
         J22hwffVMr/JJtwynxC7IZeITa4x2HlWhuT58iK0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4IAh-1iI5Tu2tOd-00rnvx; Thu, 22
 Aug 2019 18:06:57 +0200
Subject: Re: [BUG] You can't have single quote in your username
To:     =?UTF-8?Q?Giuseppe_Crin=c3=b2?= <giuscri@gmail.com>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fb5c0bb2-a5af-ef11-dada-a6e96fa7bdab@web.de>
Date:   Thu, 22 Aug 2019 18:06:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G2HCtl/jql0CkLFOj3EbPYgNd/SmUN70LLaHs34ZNlsN3nhNqZj
 yZkN4onF9CqQbB7jFT5I+KsSyVWxkiJtanix9RDkpHw85N8SuVnRqxXM06J/ubEtyZwBeUi
 AoslNfYKOGDKB/ZIBXkRA/0gBQcecP43yVfH91mIjKswNJy8fPYGW3BBlgBrxrgXN7e5+CR
 UoYhKT7Ux30dTQBGBQoXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NMh5mef71+I=:IwL9WpEixAgq9OCVY9GWAV
 98/0mfHPTk6RfS/SFDMJ1wmvGcOJlwvI5MtEBJ2ZHcgkTLP2uLS1HrOVm2AX3x7rwqpBmcHEu
 C52K9cYLiYj8UcQpjC71kQTBcVM/tHUrjpZx50a/AwWZmvk2lip7IJocqxG4+s9t0/iewrQx7
 po9CznKlHOufQe9ra6rBo56V0PcDVnff8SmqPENAlIEpCu1vSV+s1WssbYusrUe1MocqfS886
 aBD8bkwuAtjmIuNpI+nKnot4m+vWLjIAHiyAdQFIC64oyrPO1XKl1VqcNFFsI6ekX7R8e3Ths
 1OwmVi/rX6wJEXzC+TIMb8I7sIrfZcbnthumDZqz7BJLfEL+4Weo4jtHYjQGRHsVJdT/p/+zJ
 5qkzTQP7Menn+bL/u5TrqpcQs/UPSyjahdY8hZadNROFSXig+etKuMaaMctgNndh6b821guDS
 GzTxFPcF3Esgb1bLNSjROEh/l8jPh7IXXK5LHFLdGcbfktckSjIIdIeTN4Cx/rf19Ksq/rTlV
 0zSduciIjOdHb50TyGJfhGp9wyvJc3W94gkzKDF9Zdz6SUp2jHIFKo2yYL17TMo9QRI6OHh16
 03tzuP17QxXM0gD3Qv/C5npRxBFfIFvljsmm9exiuH66j500BgHd9G25/8mVTXtN5s0opMnCC
 V4cxs0UjItg/nEfDJMvmgbUF9eqLCZeIFPACFYcpHWSTuFD7ofEK4hg83yWRp5cXz31cUFPsp
 Xl3S+H7QMeKgS2/eO/MeTSVUaYlc6iidEb2jIz2C9rSgFnvn/6DofVNjT00dFVSZixKss14zS
 +Iu9gFNONqTAlF22zrH3b86NY9NVQbZ3yIMeY2qa9h+C7gIlnHdJgzoxiML7T7vfdZ5C20tgT
 jFkYAjMs43gVi6lel7BG5hM5YBsrqA9Y+MwQ2xCPwNlcuC9OxWNCmWAXV8qkQe5gCBraJQmO/
 UYlexQ5tg9I6usVi6raUyhwaaeyZB7h04p0PS2QlrpxuDP/aN/mAkwM4k3qOolUz9OAmnU9ur
 1ZOpz1TURUNPRyCFaMfp/ReAAUquS72I5SdGfDCb7OVlmIM2NMT/tVsUV6SXPHGdJiCpY+jBc
 wivk+85dsB4laYJK2PJvHX6NgYKZe+MryTh7+QzHIIeUBSJvgoy4wMb3/3WbwLXtpPPyWQjR/
 S7QqU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.08.19 um 14:32 schrieb Giuseppe Crin=C3=B2:
>         name =3D Les Actualite\\'

You can name yourself anything you like, of course, and I don't actually
speak French, but wouldn't it rather be "L'actualit=C3=A9"?

I just reply as a fellow accent-bearer, feel free to ignore me..

Ren=C3=A9
