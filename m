Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC7C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 18:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjEPSjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 14:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjEPSjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 14:39:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726A10F9
        for <git@vger.kernel.org>; Tue, 16 May 2023 11:39:46 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6D7C1FF433;
        Tue, 16 May 2023 14:39:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P/Oq5yoNqmdP
        vz4NjxN4hI4yW42+5mDdxk5DHq1AGJM=; b=BVJXytA2D0W4dM9CXUbeouB+cLqZ
        1bS8Y7kQOO7U8wQ8WcyI8jRl+QFB/VzTcnrHv2YW3Rj4AzHXhUsZEBsXettZ4vSS
        DruoLHccecYdDSsqlRQrTaV57utxooBFumJkz+pHOJnUM6OaEU6awpaIO0a3m0CD
        iH/szUC2qHBDOD8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF3E51FF432;
        Tue, 16 May 2023 14:39:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F32D1FF431;
        Tue, 16 May 2023 14:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 0/3] tag: keep the message file in case ref
 transaction fails
References: <cover.1684067644.git.code@khaugsbakk.name>
        <cover.1684258780.git.code@khaugsbakk.name>
Date:   Tue, 16 May 2023 11:39:42 -0700
In-Reply-To: <cover.1684258780.git.code@khaugsbakk.name> (Kristoffer
        Haugsbakk's message of "Tue, 16 May 2023 19:55:43 +0200")
Message-ID: <xmqq7ct8unm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 06103BB6-F419-11ED-8A1A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> =C2=A7 Introduction (v3)
>
> The first part of this material is the same as v1 and v2; skip to =E2=80=
=9CBased
> on=E2=80=9D and onwards for the new things.
>
> Cheers.

Thanks, will queue.  Let's merge it down to 'next' soonish.
