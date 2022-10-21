Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88202C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJUR5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUR5M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:57:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD2263F2B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:57:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8E7715A96A;
        Fri, 21 Oct 2022 13:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6dNDFrQtSplY
        QuSzNRONexlxLjbiFN2IS8Tbnp4lqKY=; b=m4IAwaNAT7zzTf9YjDLnzbqQNwm8
        VjDzC0KEVmvk6UUqQExgyf4ckpVOFnTv0HhcpFqfbClASnf8iXS2Xkyt3ESVZ6LO
        20PREWcAOXE6g1ea1Ec1qAxQJeLrvn4Rehj8/hE4xWXW8Qw9scOKB4r7ccOLBXib
        o5ky85bvefNDmME=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B735415A969;
        Fri, 21 Oct 2022 13:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 450E515A968;
        Fri, 21 Oct 2022 13:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/build-docdep.perl: generate sorted output
References: <20221021102950.539148-1-szeder.dev@gmail.com>
Date:   Fri, 21 Oct 2022 10:57:05 -0700
In-Reply-To: <20221021102950.539148-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 21 Oct 2022 12:29:50 +0200")
Message-ID: <xmqqh6zxkqku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C859B0E2-5169-11ED-914F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> So let's make 'build-docdep.perl's output stable and ordered by
> sorting the keys of the hashes before iterating over them.

Makes sense.  Will queue.
