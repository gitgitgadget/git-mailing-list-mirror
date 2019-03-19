Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4858620248
	for <e@80x24.org>; Tue, 19 Mar 2019 06:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCSGya (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 02:54:30 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:32029 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGya (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 02:54:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44NkLW2B6vz5tlN;
        Tue, 19 Mar 2019 07:54:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5837D49CC;
        Tue, 19 Mar 2019 07:54:26 +0100 (CET)
Subject: Re: [PATCH 4/4] gc docs: downplay the usefulness of --aggressive
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Newsgroups: gmane.comp.version-control.git
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-5-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5cf21eee-a46f-2657-7bf3-e4963cf1c56b@kdbg.org>
Date:   Tue, 19 Mar 2019 07:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318161502.7979-5-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.03.19 um 17:15 schrieb Ævar Arnfjörð Bjarmason:
> +Using this option may optimize for disk space at the expense of
> +runtime performance. See the `--depth` and `--window` documentation in
> +linkgit:git-repack[1]. It is not recommended that this option be used
> +to improve performance for a given repository without running tailored
> +performance benchmarks on it. It may make things better, or worse. Not
> +using this at all is the right trade-off for most users and their
> +repositories.
> ++
> +The effects of this option are persistent to the extent that
> +`gc.autoPackLimit` and friends don't cause a consolidation of existing
> +pack(s) generated with this option.

The first paragraph talks about potential downsides. And I think that
the second paragraph attempts to tell me how I can back out if I'm hit
by those downsides. But I have not the slightest idea how to read this
sentence and know what I have to do.

-- Hannes
