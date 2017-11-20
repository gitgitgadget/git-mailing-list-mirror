Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC39B202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdKTWHo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:07:44 -0500
Received: from mout.web.de ([212.227.15.4]:56267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdKTWHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:07:43 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWAtV-1eemtj2niT-00XNN0; Mon, 20
 Nov 2017 23:07:34 +0100
Subject: Re: [PATCH 6/6] grep: show non-empty lines before functions with -W
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
 <9c3462e3-2d1d-05bc-9f7d-4bc93d32e7ff@web.de>
 <CAGZ79kZxiEPE4LPEo-eb4Ta4bYXVr9xQM0dFeiJk9XXKU4AR+w@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <55af5442-c22a-342e-edbd-02a776228345@web.de>
Date:   Mon, 20 Nov 2017 23:07:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZxiEPE4LPEo-eb4Ta4bYXVr9xQM0dFeiJk9XXKU4AR+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:FLimaAVrACURYUVJXcypVB3bl4mUbVkn6/FWbM09odU5hpjCrkP
 t68cHVEgsgDTngA0FI7KEfHsf9ySqNpGntbaMH5ahbHwlnQI/jCqepGn63qjONRDBtdcmxt
 oA1zvLUQuPgyze3MXBBN0lLsbVuTKoWQDCbZX/RL9dHhdNDJUvg3II/f1yBghIfKOQZSs5c
 ye84/HUFfTPi6euatfRLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:puHy9eP3oXk=:I0vnB5qC/4dBDVIR3KqCnz
 COdVPexdnX0sYpEy5EDhb6yZPtfgVfA/ZcPMvBL81BLT5MvmmotbP3D7kZzo9P1+8UZJjdA8r
 sBYAAaERa7FHtK4nRj52CzOBQ0ub3URbDoEQVUFQhDxm30IR2M9Ql2piTAYZtjK10//thzfDd
 3zUIQQEbr8r0Lsh0nlXk8BF0SCWO3OpQGsTlm1rO+YU5Ywdkn1MR0O9K/U82wN44BfZbaSAmr
 dO+07HiU733/vAcx3FnMb3llXcsZk6fcZngiDZCDhcN03WTJAD4uuvu6FJdxLb2iIt7OL1CQy
 qo+lX2k09XRN/sAJeQlLM5m2nczueUye3mVNbKw03K0EHcDSTrMrIfPE1xbZ4kvqQGGjNcXy4
 vRJq0JEQfMKl0z6ELy6dtSCcJih3Jmh6hii00tlve+bxNplfs5n7PVyF04nAqqEnzi8hPTyij
 w886wV1sEAj/IYajzwR58S7FvGfyjYmjoKJWnNRaKHmmFOxYHYvOH0VxLTFOFkPSyclci4pvI
 YeTKwZA5peLhFvmCPkHn1xC82EF3tRmcVSr6UI1mi8jH/H+iXY7bQqucNJhQ/GIozwO+soFd6
 EE3bFiWDkvPPi8eD1nScTBgRMGzRiA6+Q/WGba36uz3uZu7JUuC4Rc+ZGly/PfGhyv3cV80rG
 /Le1s+hSxL3BCjYSbVRz4KdAswWr4Dz7Jqh+Ol9juemsFrzOq4Vxnzwf2pvlHV11oY97JQds0
 RHuP/qeqBblfUamtejWFuqFJuVgZa4ZodeCgEYJQxg6hjK+iHs7pAm4gZY6XHxrT98q0USWlO
 Bqir9fBf6JasAiJ9uVlVh4DlxkjW6Ph6I9S2Ob3KOBO3+cFsRY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.11.2017 um 21:39 schrieb Stefan Beller:
> On Sat, Nov 18, 2017 at 10:08 AM, René Scharfe <l.s.r@web.de> wrote:
>> Non-empty lines before a function definition are most likely comments
>> for that function and thus relevant.  Include them in function context.
>>
>> Such a non-empty line might also belong to the preceding function if
>> there is no separating blank line.  Stop extending the context upwards
>> also at the next function line to make sure only one extra function body
>> is shown at most.
> 
> Can we add another heuristic, that checks for common function body ends, e.g.
> if the preceding line contains '}' but is not commented (the line doesn't
> contain '*/' '//', '#'), we have a strong hint that it is a function, not an
> additional comment.

C comments containing "}" as part of the text would only be shown
partially, e.g:

	/*
	 * Not shown because of the curly closing brace in ${PATH}.
	 * Shown.
	 */

Two examples in git's repo are in refs.h and sha1-lookup.c.

Before diving deeper: Is it worth it?  Does the heuristic in this series
produce excessive context often?  Enough to be annoying?

Thanks,
René
