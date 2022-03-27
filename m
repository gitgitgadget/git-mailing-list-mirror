Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDC1C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 21:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiC0VjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 17:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0VjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 17:39:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B99338A5
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 14:37:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F4571259F9;
        Sun, 27 Mar 2022 17:37:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8iQBakJpKPfw55uYj6JtLbiHNfYoS/UgrgMseP
        4oI6g=; b=IY47Yz9CWFA0+Q8CtMjrkO9fMVcGXp7pc4PIBsWH/fRzz/eOYP0NpV
        z8psfd5AHJKWl/oK/P0hQOArlWNaElzqky6Ja9uT9BeQAkY3kyxByNKxHrd3UI46
        uVfqN76OZymHP/P/aOfKpWvBjQMsdZcRXDAZJ1TfNst1Zz0K46AWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 333CC1259F8;
        Sun, 27 Mar 2022 17:37:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ADA41259F7;
        Sun, 27 Mar 2022 17:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v6 2/3] vimdiff: integrate layout tests in the unit
 tests framework ('t' folder)
References: <20220327112307.151044-1-greenfoo@u92.eu>
        <20220327112307.151044-3-greenfoo@u92.eu>
Date:   Sun, 27 Mar 2022 14:37:18 -0700
In-Reply-To: <20220327112307.151044-3-greenfoo@u92.eu> (Fernando Ramos's
        message of "Sun, 27 Mar 2022 13:23:06 +0200")
Message-ID: <xmqqr16n5b75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1467C64C-AE16-11EC-8C85-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> Create a new test case file for the different available merge tools.
> Right now it only tests the 'mergetool.vimdiff.layout' option. Other
> merge tools might be interested in adding their own tests here too.
>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---

.git/rebase-apply/patch:21: trailing whitespace.
	. $GIT_BUILD_DIR/mergetools/vimdiff && 
.git/rebase-apply/patch:26: new blank line at EOF.
+
