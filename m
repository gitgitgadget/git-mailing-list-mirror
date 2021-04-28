Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6776C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12066008E
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD1Ekb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:40:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60934 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1Ek1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 00:40:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 340901282BE;
        Wed, 28 Apr 2021 00:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AVUEnCobIlDzfQt1oN/IM3yiSxJI1A4zoPYmQE
        oskik=; b=gg63vcbEkdgT1JVz0VSTiP4vBL+4mpeIb1pbMQczLIMuVCovaP/FRn
        LE1RqMG5T3mUOkle2BnaTrjxzUlE+LSHBIsv0JFPy25gHr0nvu7JoDWseyp/l7rA
        EjdSRM6ehOYl4qewbG29Ssxy2oj9RmjQfhKNoGPt3FnfxUMhK52uo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C9B51282BC;
        Wed, 28 Apr 2021 00:39:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D2AC1282B9;
        Wed, 28 Apr 2021 00:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v5] add git-p4.fallbackEncoding config variable, to
 prevent git-p4 from crashing on non UTF-8 changeset descriptions
References: <20210424081447.uxabqbxc54k6yxrg@tb-raspi4>
        <20210427053916.1977-1-tzadik.vanderhoof@gmail.com>
Date:   Wed, 28 Apr 2021 13:39:38 +0900
In-Reply-To: <20210427053916.1977-1-tzadik.vanderhoof@gmail.com> (Tzadik
        Vanderhoof's message of "Mon, 26 Apr 2021 22:39:16 -0700")
Message-ID: <xmqqr1ivauph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEBC533E-A7DB-11EB-B5FF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> writes:

>  t/t9835-git-p4-config-fallback-encoding.sh | 87 ++++++++++++++++++++++
>  3 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100755 t/t9835-git-p4-config-fallback-encoding.sh

9835 is already taken (see 'seen').
