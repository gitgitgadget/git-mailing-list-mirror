Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2084BC433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 10:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiC0KtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 06:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiC0KtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 06:49:10 -0400
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B26C1AD9A
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 03:47:32 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4KRCFq20ddz5tl9;
        Sun, 27 Mar 2022 12:47:27 +0200 (CEST)
Message-ID: <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
Date:   Sun, 27 Mar 2022 12:47:26 +0200
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
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.03.22 um 18:14 schrieb Ævar Arnfjörð Bjarmason:
> Partially revert d323c6b6410 (i18n: git-sh-setup.sh: mark strings for
> translation, 2016-06-17).
> 
> These strings are no longer used in-tree, and we shouldn't be wasting
> translator time on them for the benefit of a hypothetical out-of-tree
> user of git-sh-setup.sh.

There is public documentation for these functions. Hence, you must
assume that they are used in scripts outside of Git. Castrating their
functionality like this patch does is unacceptable.

-- Hannes
