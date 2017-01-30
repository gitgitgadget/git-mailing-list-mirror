Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4110A1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 16:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbdA3Qsx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:48:53 -0500
Received: from mout.web.de ([212.227.15.4]:59433 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750860AbdA3QsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:48:24 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LseoD-1cMzo649KD-012JRW; Mon, 30
 Jan 2017 17:48:16 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301637570.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9bcae427-d654-a671-4368-030150168102@web.de>
Date:   Mon, 30 Jan 2017 17:48:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701301637570.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:lSous+Vhzf8MlQU5Zyka9nuIbW1OdBch9i7OCRCGzmelhXsbO+G
 oFKE5e3L2sDtBvuSYN1AJ2r39N4xiZazDjCKD3Kz4NKtu+BeUD/LGBXxhW/HoXYsINz+1Qy
 GqTpqpL/inqwTkWZC+T/9vIRJElEPqhOcrCruaNcXkn4jE7KpNLRMFWgvk5oJsRNnAirkvu
 LeRoL1ox3odUBg1t32/hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w4qTq87A6aw=:msZmZE6T9gL4ofzFsNrm0M
 ILMZKrDCrs0I8vjDQ5/tET/XPzoNy9Ai/JSm3nB4Vu9UqCm757mIvUCgZmPJxB6oScHsKdjjd
 BJN12IshAmr93ARgceVls+AThnu6wz9BabkgcZFH2RXcP6hKEyCqgTI/15X3fnlmRG56rDntu
 DoMwwcVT1OhhwFPsYu5Eja8n1Vt1CqXPVH7vsPuovdpHGxD05kCWhsyWl5+Lzf/BgUCJIVgJS
 E9zMNCikAitaUtJtFtTjzX79+gGR9qTfWdNt8t54w/oioXKGdMCj/HLWqJxKlwjC2qnRzCVtA
 XwtxYJ717zCisG7+7Dp+8gWI15qwWclYK6/sTlNMhF8SZpBcqXJhSJyqnVzlGq94z0eedJClQ
 rq8RjIyo82Jz2R4LBgeFlSspA1Bz+F/gM1zSDb739FAAzrZaqcV8GRb7zDAUoP5I0vADFCP4V
 XULgcbIes7lskfWSvKkbgfcN74ZczW75tSC0+JJ4V/MObCxywIPlWJwQO7Qwclzr4+V4D2JWU
 +9wYWR+/n8dSMjsbUjDlq450mHzJ5UaHZWIoPNapwPRXmNnxD32rJmZDX+p4z088llEdqi5ib
 UyesNJoDWo7EJgrApAG5AmVtKeZ9NE2xAJB/zVIk/KIf2NdlTL3bOW/86I622UZ4JCiyF3h5L
 7gL2drAQAtJjyxflosqXYD3JplPFGIY8CQc3Uza+UNVZqiHKoAfrAu5++ypapGKm+M1KNEI1N
 4sPjslll8IGBbsIliiTYEspOJ8nAOJ3IoJX3FQPNPdc1CL+L4vfRq+FlKTb53N+SUddJSSGMV
 0d8Pfqz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 16:39 schrieb Johannes Schindelin:
> Hi René,
>
> On Sat, 28 Jan 2017, René Scharfe wrote:
>
>> Add a macro for exchanging the values of variables.  It allows users to
>> avoid repetition and takes care of the temporary variable for them.  It
>> also makes sure that the storage sizes of its two parameters are the
>> same.  Its memcpy(1) calls are optimized away by current compilers.
>
> How certain are we that "current compilers" optimize that away? And about
> which "current compilers" are we talking? GCC? GCC 6? Clang? Clang 3?
> Clang 3.8.*? Visual C 2005+?

GCC 4.4.7 and clang 3.2 on x86-64 compile the macro to the same object 
code as a manual swap ; see https://godbolt.org/g/F4b9M9.  Both were 
released 2012.  That website doesn't offer Visual C(++), but since you 
added the original macro in e5a94313c0 ("Teach git-apply about '-R'", 
2006) I guess we have that part covered. ;)

René
