Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D128C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4F20872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pp6YzIwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgKYXmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:42:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61855 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKYXmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:42:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D84EFD333;
        Wed, 25 Nov 2020 18:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CsYt7JWzROhJZ3WBLl7Gvm3vfcM=; b=pp6YzI
        wYLiZB7vtNyDaFhXCqxEA8D7RiFIg6lMS4vmC24sr6q2NNYmsiZHX/abZ4xNBvvU
        chl7XZwGLxzMoeKMtSaF8NYJLSFlXrjLItgAy9K7oE8F0CHH9iWBwfKtahvlVnC4
        55TvpDAoowG0ET6yc/GtNy9WahUPkmv3QLSR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ErCJhbjzve2qZq8mRP6ShfwIRsDhFnsX
        JahJj34oTDpeORj7oS5slWue4bwXj51dl61fUHCvod5Itws4Qj/HvM6OeKIujGhs
        vcTEB8RFMwVxEqHz7ZQn+976+q9UkJwpGRwIhIQBpsqL7xvoEgkv8pgd3Uyk0Sqi
        l0tBkeuW72A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85E7DFD332;
        Wed, 25 Nov 2020 18:42:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1620FD32D;
        Wed, 25 Nov 2020 18:42:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Subject: Re: [PATCH v3 0/3] refspec: make @ a synonym of HEAD
References: <20201125233443.63130-1-felipe.contreras@gmail.com>
Date:   Wed, 25 Nov 2020 15:42:40 -0800
In-Reply-To: <20201125233443.63130-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Wed, 25 Nov 2020 17:34:40 -0600")
Message-ID: <xmqqtutdatqn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8D40B44-2F77-11EB-8659-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Basically $subject.

Will replace what was on 'seen'.

Dscho, heads-up as this series will add more references of 'master'
in the test suite.

Thanks.
