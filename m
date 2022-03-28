Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC58C433FE
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbiC1UJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbiC1UIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:08:13 -0400
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962F5F26D
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:06:27 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4KS3cH2TzPz5tl9;
        Mon, 28 Mar 2022 22:06:23 +0200 (CEST)
Message-ID: <507e1a83-d266-e832-8f62-e2402c97faa9@kdbg.org>
Date:   Mon, 28 Mar 2022 22:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
 <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
 <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
 <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
 <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
 <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.03.22 um 14:16 schrieb Ævar Arnfjörð Bjarmason:
> On Mon, Mar 28 2022, Johannes Sixt wrote:
>> What is wrong with
>> the status quo?
> 
> The larger context for why I was looking at this again is that I'm
> trying to slowly get us to the point where we can remove the
> i18n-in-shellscript entirtely.

Why? Again: what is wrong with the status quo?

> Just like having that "USE_PIC" comment in configure.ac isn't much of a
> big deal, but it makes sense to clean up unused code, just as we're
> adding new code.

There is a difference between "clean up unused code" and "change
observable behavior".

-- Hannes
