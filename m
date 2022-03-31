Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAA8C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 20:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiCaU3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiCaU3G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 16:29:06 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D29B2414EB
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 13:27:16 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4KTvwv6Cm2z5tlB;
        Thu, 31 Mar 2022 22:27:11 +0200 (CEST)
Message-ID: <12c7c651-49d2-d38b-122a-3fb5c29e94df@kdbg.org>
Date:   Thu, 31 Mar 2022 22:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
 <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
 <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
 <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
 <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
 <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
 <45c963da-19a5-de51-34d4-5b29f461c9ec@gmail.com>
 <220331.86a6d6qqfe.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220331.86a6d6qqfe.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.03.22 um 13:15 schrieb Ævar Arnfjörð Bjarmason:
> I do have some WIP changes to tear down most of the *.sh and *.perl i18n
> infrastructure (the parts still in use would still have translations),
> and IIRC it's at least a 2k line negative diffstat, and enables us to do
> more interesting things in i18n (e.g. getting rid of the libintl
> dependency).

Why? Why? Why? Does the status quo have a problem somewhere? All this
sounds like a change for the sake of change.

> But I also don't think that such a series is probably not possible in
> the near term if we're going to insist that all shellscript output must
> byte-for-byte be the same (for boring reasons I won't go into, but it's
> mainly to do with sh-i18n--envsubst.c).

Such an insistence can easily be lifted if the change is justified
sufficiently. I haven't seen such a justification, yet.

-- Hannes
