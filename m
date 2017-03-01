Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E6E2027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbdCAW6x (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:58:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54893 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753041AbdCAW6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:58:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1777778C65;
        Wed,  1 Mar 2017 17:42:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F25XZd42PseUxQuJj70XlHJ4BPQ=; b=lVruLm
        Rn4WudIiEz/DQDmbW7cIvRFi349mS29woUg+ZLBsFQdO3z5R4wEWCBTv73iJZ2T5
        hiAXZZ6qbn+400RRk1kILJJhFXSOigOQBa934EfvviDASIbJMi4VNpYjVKXsMwuX
        uxYi98U8gpD5/hpJd+N+iLi1n+zGLYu/uZFZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b+eMNDL4wMtdQpJoa9XpQ+8l7w0Hiphu
        AFD6X7BYxKCswMeBqkMAQbekHg1oKs7niYk8VLSNx40aqUN8OY8zkT+77r1ZJ9Pd
        1a4DnTAn8yc8FL0coURQ1vGJ67Nfu9Jx5ZctoeG4oyGs9bSBm8knuxWjsGrLUY01
        xvFEier55Vw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1009078C64;
        Wed,  1 Mar 2017 17:42:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 713D178C62;
        Wed,  1 Mar 2017 17:42:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 0/2] Minor changes to skip gitweb tests without Time::HiRes
References: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
        <20170301211540.4382-1-avarab@gmail.com>
Date:   Wed, 01 Mar 2017 14:42:02 -0800
In-Reply-To: <20170301211540.4382-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 1 Mar 2017 21:15:38 +0000")
Message-ID: <xmqqy3woei11.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A4FECD0-FED0-11E6-A406-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, will replace what has been on 'pu'.

Note that I'd dropped a double-SP from the latter one while queuing.
