Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D14207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 05:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041152AbdDVFfK (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 01:35:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54912 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1040838AbdDVFfJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 01:35:09 -0400
X-AuditID: 1207440c-9d9ff70000001412-b5-58faeb89e0dc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D0.5F.05138.98BEAF85; Sat, 22 Apr 2017 01:35:08 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M5Z0cG030757
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 01:35:03 -0400
Subject: Re: [PATCH v3 08/12] refs: remove dead for_each_*_submodule()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-9-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1f3c633b-fc05-36f9-ff9f-8327e2e90b73@alum.mit.edu>
Date:   Sat, 22 Apr 2017 07:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-9-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1O15/SvC4MQzFouuK91MFg29V5gt
        +pd3sVl0T3nLaDHzqrXF5s3tLA5sHjtn3WX3+PAxzmPBplKPi5eUPfYv3cbm8XmTXABbFJdN
        SmpOZllqkb5dAlfGhz3cBbuYKiZuvszcwPiHsYuRk0NCwERi4uJtTF2MXBxCAjuYJFofTWEB
        SQgJXGCSuLolFMQWFnCT2PWvkxXEFhFIk1g8+T0zRE2ixM9V+8GamQV2MUqceX4HLMEmoCux
        qKeZCcTmFbCXOL5hOnsXIwcHi4CqxJVJESBhUYEQiTkLHzBClAhKnJz5hAWkhFPATOL2REWQ
        MLOAusSfeZeYIWx5ieats5knMPLPQtIxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+bl
        pRbpGurlZpbopaaUbmKEhDTPDsZv62QOMQpwMCrx8K5g+RUhxJpYVlyZe4hRkoNJSZQ35PfP
        CCG+pPyUyozE4oz4otKc1OJDjBIczEoivJ+fAZXzpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeW
        pGanphakFsFkZTg4lCR4s18BNQoWpaanVqRl5pQgpJk4OEGG8wANv/cSZHhxQWJucWY6RP4U
        oy7HnHtf3zMJseTl56VKifPGgRQJgBRllObBzYGloleM4kBvCfMGgazjAaYxuEmvgJYwAS05
        6/cDZElJIkJKqoFxYsnqZ3PEjlywFP9X4nO6ec913UAjy6W1DzRvCfmEBjjPe5L6KC6BWeSQ
        cVbOwo3FU99e0+Z3jrnd/KZvBb/bFqYtWnPedmS01UzQruv825V5815YsyqPVcBM7qk+c5bu
        cH0R9dZZTqdaVuupx2T+n68VG3fX1b14fvbqn8ysPX/3mnh4nf2hxFKckWioxVxUnAgACIXQ
        2SADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 01:01 PM, Nguyễn Thái Ngọc Duy wrote:
> These are used in revision.c. After the last patch they are replaced
> with the refs_ version. Delete them (except for_each_remote_ref_submodule
> which is still used by submodule.c)

❤❤❤❤❤❤

I love the way this is going.

Michael

