Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17E2C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 01:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiAQBeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 20:34:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60352 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiAQBeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 20:34:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EDFF173402;
        Sun, 16 Jan 2022 20:34:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=0ewMQizn3mhdO0UeRWpCzQau1fY3+G+reS3ailuZdXA=; b=EOFh
        QJUTf4FjDWvKxHNbUyW4u+rbRC9DhUBdHMkuuuvVXyVXc+08rngGk/TWVxQggR5X
        bdiL86Ays/KYZap46DraYb1UDoa/tSBqXOSsdsA3RwS/D0UCC0nFgFL/lvc2pfJF
        L6KPQvdtLA4aZmOB036CjzuFrGz86Ph5vdUC7og=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34A63173401;
        Sun, 16 Jan 2022 20:34:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1D77173400;
        Sun, 16 Jan 2022 20:34:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v3 00/21] git-p4: Various code tidy-ups
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Date:   Sun, 16 Jan 2022 17:34:12 -0800
Message-ID: <xmqqr197xi0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93B684F0-7735-11EC-AB29-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> This third version of the patch-set is rebased on top of the next
> branch.

After other p4 topics in 'next' graduate to 'master', you'd need to
rebase the series again to the updated 'master', but in the
meantime, people can comment on the current patches.

I'll take the series as "for discussion only" for now.

Thanks.

cf. Documantation/SubmittingPatches::[[base-branch]]

* In the exceptional case that a new feature depends on several topics
  not in `master`, start working on `next` or `seen` privately and send
  out patches for discussion. Before the final merge, you may have to
  wait until some of the dependent topics graduate to `master`, and
  rebase your work.

