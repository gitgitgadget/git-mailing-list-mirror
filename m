Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D9CC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215FA64F59
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhCDXYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:24:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61318 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhCDXYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 18:24:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBBBE118AFF;
        Thu,  4 Mar 2021 18:24:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tKcgoeXlleIBhoQHs4/cDvlZIPc=; b=ezzVev
        VY4hyE3K+Kk77jBthOKouJVK0hSZzZpAL+NI7iFQfQU1R2s3DV1U0ALODrcOY5mT
        GEMlFwIXU4GKQP1i1dg6kfpzGSSpW0GJn526PTqFZ3PvUaZLoMxly2pqZ2n9etT+
        HpWw2qOyeO1xaW4baMi/oFV0PljuACSBvytPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SiNicwMWKSopraJWm+VdTqqWySHcdMML
        nRaSpD19QOiFnumwet6Xfxnrxq3/0tKMAUzx62N0Hu8wCUZgYSsNbmCk5/O61Pwo
        hmAzl4EwvYBl7SqTdP32decOOjQ4wrVyn8g062D1q3XX5kNXuPfVzWgEeBY3SAfY
        6k2er4WIvaA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4CCA118AFE;
        Thu,  4 Mar 2021 18:24:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 09871118AF5;
        Thu,  4 Mar 2021 18:24:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git pull unclear manual
References: <874khsqq0o.fsf@osv.gnss.ru>
        <xmqqv9a7emx6.fsf@gitster.c.googlers.com> <87blbzm901.fsf@osv.gnss.ru>
Date:   Thu, 04 Mar 2021 15:24:30 -0800
In-Reply-To: <87blbzm901.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        04 Mar 2021 14:52:14 +0300")
Message-ID: <xmqqy2f2biz5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6236DA8-7D40-11EB-9019-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Do you think the manual needs some improvement still?

My reading is already tainted by using Git for a long time, so I
won't be the best person to judge what's missing in the manual.

> I mean, I'd then expect something like this as the SYNOPSIS:
>
> "git-pull - Fetch from and integrate with another or current repository"
> ...
>   git-fetch - Download objects and refs from *another repository*

Just replacing "another repository" with "a repository", the latter
of which includes the current one, would be sufficient, perhaps?

