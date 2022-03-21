Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C632C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 06:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245328AbiCUGuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbiCUGuK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 02:50:10 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B9F896D
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 23:48:45 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4KMQF64GRyz5tlD;
        Mon, 21 Mar 2022 07:48:42 +0100 (CET)
Message-ID: <e44b6ccf-21a2-72c6-4d40-dc0004895255@kdbg.org>
Date:   Mon, 21 Mar 2022 07:48:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/7] More i18n fixes
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.03.22 um 22:54 schrieb Jean-Noël Avila via GitGitGadget:
> This is another i18n PR (and hopefully the last for a while).
> 
> As usual, the intent is kept the same: curbing the number of strings to
> translate, remove constant, error prone parts out of the way, trying in some
> sense to "put a precedent" so that the template strings can be reused later.

I feel that many of the example conversions look like sentence lego
because there remains only one English word, e.g., "'%s' failed". The
converted code does not leave a hint for the translators what the %s
will be. Is it a command, a function name, somehting else? Even if the
hint was provided, different translations may be required depending on
the substituted entity. Did you investigate the existing translations
whether all of them can be converted to the new scheme?

> This series has also a RFC status: can "bad argument" messages be merged
> with unrecognized argument?

The cases that patch 7/7 transforms look like they need not keep
"unrecognized argument", but can be converted to "bad argument".

Disclaimer: neither am I a translator nor a user of a translated Git.

-- Hannes
