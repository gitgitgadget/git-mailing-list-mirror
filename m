Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328EDC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGTUyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTUyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 16:54:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF69509E3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 13:54:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E731E1A59E9;
        Wed, 20 Jul 2022 16:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=24+FLpKy/pl4O2wOKNxYbB8adYbZBZn/AK1z4L
        dsBeA=; b=AjMJvnwAiOxxDDa8kQaMQxn1bdpFPw95Kp9ZQaUaRTHICvvPqAu6Es
        eudAJpapH6mK7i2Mire91vI2rfUmG0w3aRCedCWS3no1REdlrPWNZlknF7+UfJSy
        lwHu53i5iSpIGcjygvrmCS05dPkeI3/W/y1XqRCSicEPk/MX/IWsk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DFCCA1A59E8;
        Wed, 20 Jul 2022 16:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7AF1B1A59E6;
        Wed, 20 Jul 2022 16:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>
Subject: Re: [PATCH v2 0/2] git-p4: fix two undefined variables
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
        <pull.1297.v2.git.git.1658343330.gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 13:54:40 -0700
In-Reply-To: <pull.1297.v2.git.git.1658343330.gitgitgadget@gmail.com> (Moritz
        Baumann via GitGitGadget's message of "Wed, 20 Jul 2022 18:55:28
        +0000")
Message-ID: <xmqq35ev33ov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DBDFD5C-086E-11ED-BE90-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Moritz Baumann (2):
>   git-p4: fix typo in P4Submit.applyCommit()
>   git-p4: fix error handling in P4Unshelve.renameBranch()
>
>  git-p4.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Perfect.  Thanks.
