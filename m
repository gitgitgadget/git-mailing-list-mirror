Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1C2C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA0B20661
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+e72SIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgA3SYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:24:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59057 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgA3SYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 13:24:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 621D1498D7;
        Thu, 30 Jan 2020 13:24:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d/7j4OfYxuQaFQB9unzgH6ZTSL0=; b=G+e72S
        IJ43OiT0sfcZbjFSvrGdysioy3hABnwJVfOm8vHH2vdLYgeNaA07eeW5rQq2tZiR
        xHcjXONvFf5cvnSQpR0Xrt3wgkM9B49fdAq5q4g8lcAPWqr0GWDAApQtZR9fXjg1
        gk9i84FzHm6cOzUqh2d2kg0TILDmMVCgp6uZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=scEm4cdtGtEjGFKxOlfTBz1LwZLtfnia
        RGnknPM9Maw1I7DDCvE97OQYC+SkZ1hgTO7NEFGeakGDmlkQ8vUlMRLI+VO0yCWU
        pNZloYJCLZV/CYqOkqt+B8z/xuh9bm+w/s5RNYGPtO2ZrwXVD2DyksrY7boZgMEG
        9SA2OGL5Q7g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A712498D6;
        Thu, 30 Jan 2020 13:24:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0D3B498D5;
        Thu, 30 Jan 2020 13:24:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH] .mailmap: map Yi-Jyun Pan's email
References: <20200114024938.GA17003@generichostname>
        <21b8a0d08764c31de12ef7661667eb1117d41ac4.1578972215.git.liu.denton@gmail.com>
Date:   Thu, 30 Jan 2020 10:24:29 -0800
In-Reply-To: <21b8a0d08764c31de12ef7661667eb1117d41ac4.1578972215.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 13 Jan 2020 22:23:58 -0500")
Message-ID: <xmqqv9osdcpu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1BD2E9A-438D-11EA-BFC4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In 13185fd241 (l10n: zh_TW.po: update translation for v2.25.0 round 1,
> 2019-12-31), the author mistakenly used their GitHub username for
> authorship information instead of their real name. However, a commit
> with their real name exists prior to this: 9917eca794 (l10n: zh_TW: add
> translation for v2.24.0, 2019-11-20).

Just fell thru the cracks.  Applied.  Thanks.
