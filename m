Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B18C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiHAVej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiHAVei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:34:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160002A403
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:34:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A706193A98;
        Mon,  1 Aug 2022 17:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mgW0LPUnPM1Ywsaj+ncxgVpCdh/LoAmNhHoebA
        o39ls=; b=b+w8tEzit1JaJwhKFEEXHnOIw0kVC13MTEFOp3uma/ITTydzHTBOKp
        jpjQ3VxmcUYJx3Kl8xlQYyz2rKUIMM7qY73o9JjnhpvI22P7pdnsyTGLmzIsUoOG
        jmy76ZIsFGpvnyhlVBJDHj1m7e9nuSMJhYkLD+4IR6pS7+lGx3mTc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83576193A97;
        Mon,  1 Aug 2022 17:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33143193A96;
        Mon,  1 Aug 2022 17:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/7] Generalize 'scalar diagnose' into 'git bugreport
 --diagnose'
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 14:34:32 -0700
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com> (Victoria Dye
        via GitGitGadget's message of "Mon, 01 Aug 2022 21:14:51 +0000")
Message-ID: <xmqqfsifodg7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBABAD18-11E1-11ED-93D1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As part of the preparation for moving Scalar out of 'contrib/' and into Git,
> this series moves the functionality of 'scalar diagnose' into a new option
> ('--diagnose') for 'git bugreport'. This change further aligns Scalar with
> the objective [1] of having it only contain functionality and settings that
> benefit large Git repositories, but not all repositories. The diagnostics
> reported by 'scalar diagnose' relevant for investigating issues in any Git
> repository, so generating them should be part of a "normal" Git builtin.

;-)
