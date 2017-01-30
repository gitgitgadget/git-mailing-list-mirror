Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7862C1FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 22:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbdA3WKW (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:10:22 -0500
Received: from mout.web.de ([212.227.17.11]:63436 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753269AbdA3WKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 17:10:21 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKa2F-1cWP8H3FrD-001xwp; Mon, 30
 Jan 2017 23:09:38 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
Cc:     Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
Date:   Mon, 30 Jan 2017 23:09:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701302158110.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:T7GDAdhTEoK7uu8FkwymI1FB3sPpc2rGkyjWOFcgcXBVrpoANRv
 bJQJScKO5ncTgv6e+ShRjoNIGcuIL0aSYmUCvYvQjWWlh1tGplzfCUVe96Wqgom+ldQheSl
 tWiUyoZBww/gLQ9nxc1aH20ZI/wrSpXu1P3wNHP3t5qK0qTIKV/T6W7s82sF6BdeYK8HWSz
 0W0J+P7AiSXw+EfgrBLdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n6T6rE/gHRk=:VoXS9sNivFfXYVQQPqgzut
 eL9IAkXk37MvchAqW9mnsVrwlwWRJaUjPUV8mytGgAE/7Is28MxqrBWMSndMe4xGqogd1BTaY
 Yc9R+esRFMD/hl1XkcjpjlxK5X+OExwoHms3xM64X2iNDK4hggmiLanXzz+gHzjh5rIFeg0j/
 2kJBOkhPv9/GmTAEBJDVpOcaaeRcEo/oTs3QG1/ek+6DzMZqZHcOXJoMr6drlXdg6EagoS0wI
 tYTSMaZs1UNepwwshBtjeq+u+PgFcmBj+7bpng9adsdy6BzfkdcMS/ZgUof22o/OEH0NwPgwd
 z/tXYoSdjlUI3hQg6VrQ1x+rGJ6/LGDDhS0SMUdawwIpUbAg+UI+4dxDupX/ijBvR78H3K6Ai
 GmKxLzdqk4qWAHC2CROjnwuxDRDRDIGHE7rRg06XA4iTSnXhnUDEd0zHapQv+QhU3yYsLvurl
 rwxCmE9ocNXDGxalzM7cqwkXNxBPYzVNTe5EpoYPNXA9gIeDQZ1Md9Liswe516E3OFWubThzn
 UVhb+kCuoI5Kh3IPYo/+owcsfVYfNrMqkwG1wEM9AMZQN5pCmK8YhIW/UH9InoTBPvDZGNin/
 46kqU1jUyK9gVqlsbcoOejlefV8Bb/rzc1s1Mp34jY+g4NH3OncPotRyTBFEcDPAHzDIyxuNP
 wHhMt0nudEmiz02fKYyfdDjqTDUfw7aXZ7t8B4htj6/0irbmm+Taunv6bq+4Ivi3qByKTDuli
 Jvz+4/Z/y/UYwIrX9Rq6QWI5L9A57zfg4W6yAdoBF9LYsAt4z9K3cAwCD2rYdlwR0j04JRYQ9
 F6PaHB5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 22:03 schrieb Johannes Schindelin:
> It is curious, though, that an
> expression like "sizeof(a++)" would not be rejected.

Clang normally warns about something like this ("warning: expression 
with side effects has no effect in an unevaluated context 
[-Wunevaluated-expression]"), but not if the code is part of a macro.  I 
don't know if that's intended, but it sure is helpful in the case of SWAP.

> Further, what would SWAP(a++, b) do? Swap a and b, and *then* increment a?

That might be a valid expectation, but GCC says "error: lvalue required 
as unary '&' operand" and clang puts it "error: cannot take the address 
of an rvalue of type".

René
