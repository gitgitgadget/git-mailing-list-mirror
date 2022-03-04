Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B658FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 02:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiCDCp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiCDCp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 21:45:29 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41CA17E34B
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 18:44:42 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC06D17017B;
        Thu,  3 Mar 2022 21:44:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5Q14fT2cBNwKYARbbDtholmgKrldIiK0kw5EmYHBlK8=; b=v9Xe
        6Ok64HqFiv3rXYgiF9rQc8NDHgk6uHzSLiqlPjhSGa54hJSw15fUrN1XkNM6aViI
        kkcHpCyXoLmIFkScsQKMlUGHOFBIsatajw16fA1GFwK4W+1EmP9w9L59ZdkXMfIq
        JEcu/ePoc2tTAGPCALfUOXIKog5feaKoMAa9Fpo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A498E17017A;
        Thu,  3 Mar 2022 21:44:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16484170179;
        Thu,  3 Mar 2022 21:44:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
        <20220303181517.70682-1-jaydeepjd.8914@gmail.com>
Date:   Thu, 03 Mar 2022 18:44:39 -0800
Message-ID: <xmqqee3i4eso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09DC28F8-9B65-11EC-B6DC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jaydeep P Das <jaydeepjd.8914@gmail.com> writes:

> Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.

"git format-patch --help" and look for "-v <n>", perhaps.  This is
the fourth iteration, so [PATCH v4], I guess?

