Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D3120323
	for <e@80x24.org>; Wed, 15 Mar 2017 08:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdCOILZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 04:11:25 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:32376 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbdCOILX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 04:11:23 -0400
Received: from [192.168.1.112] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 2E6447803D7
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 09:11:20 +0100 (CET)
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170312200248.3610-2-jn.avila@free.fr>
 <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4EGfBAu0M0y4xboVAtWf5N07XY8s40npQ1hN3rbgqmSw@mail.gmail.com>
To:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <103dec84-b274-0a81-fa9b-bf29afd988d9@free.fr>
Date:   Wed, 15 Mar 2017 09:11:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX4EGfBAu0M0y4xboVAtWf5N07XY8s40npQ1hN3rbgqmSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 14/03/2017 à 22:00, Ævar Arnfjörð Bjarmason a écrit :
> On Mon, Mar 13, 2017 at 1:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jean-Noel Avila <jn.avila@free.fr> writes:
> Jean: Comments on the patch:
>
> - Firstly thanks for working on this. When I hacked up the initial po
> support in v1.7.8-rc2-1-g5e9637c629 I always meant to try out po4a,
> but never got around to it. It's much easier than I thought.

Well, that's only the simplest setup I could come up with :-). I'm
discovering the tool and it seems that can go quite hairy, depending on
where we want to go.

> - Consider submitting a more minimal patch that doesn't have the giant
> fr.po (or just some minor cut version) as the tip of the series, to
> make this easier to review

OK. Will split in po4a.conf + Makefile changes, then pot and po files.
The point is that as long as the po files are not translated at a
minimum level, po4a does not generate the target files. Right now, the
threshold is 80% of translated strings (no fuzzy).

> - The git-add.txt file is hardcoded in po4a.conf, won't this file need
> to be generated in some final version of this series?

If all the translation string are harvested automatically from the
source files, the resulting po file will be huge. For the moment, I
prefered to manually select the files and check that po4a behaves correctly.



