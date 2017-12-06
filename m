Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DED2420C11
	for <e@80x24.org>; Wed,  6 Dec 2017 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbdLFQsV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 11:48:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65303 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751711AbdLFQsP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 11:48:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FC08C5FE5;
        Wed,  6 Dec 2017 11:48:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T69sghCATGJ/
        fdtqD3iJH8k0+RY=; b=wrSjUKmD6QRR6eVPYjikCceLzzYz6c/fO6wiVWQyDO8q
        ciFZchNMEiE7vsGl436i7d09DmEJkRTGv/DnFNQqLbz/Y4RV1/jH1KWm8QRQp4Nl
        //hAgEb45a4h4xOQb6lUMks6fkJKr7O5QYpvY/ABarVaGwtpvf86Ac0ypAAqDrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tGy8AI
        iOp3dDW5sqsU5SVMGi8eUUQbqNbb3HEZWGmzblnF2uwFbs/w72I51cYVJoDX8BMZ
        +jykYg4IWUi5+jH3N4cYDcfvNzoh0bNxjjWqUn+yCr6B8TZgf/DvN7dsvL0ffS6G
        zt0M5R4xtUxdkr1rEI5E0gCnt0A1YcVZ//wuo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98278C5FE4;
        Wed,  6 Dec 2017 11:48:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D734CC5FE3;
        Wed,  6 Dec 2017 11:48:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
        <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
        <0c2aa5cd-55d3-28ea-8577-b8b2839fd4c2@web.de>
Date:   Wed, 06 Dec 2017 08:48:12 -0800
In-Reply-To: <0c2aa5cd-55d3-28ea-8577-b8b2839fd4c2@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 6 Dec 2017 17:03:17
 +0100")
Message-ID: <xmqqlgifhkfn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4028A70E-DAA5-11E7-9809-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Looks like t0027-auto-crlf.sh is failing on Windows:
>> https://travis-ci.org/git/git/jobs/312135514
>>=20
>> Could that patch be related?
>>=20
>> - Lars
>>=20
> Chances are high, I will have a look.
> Thanks for noticing.

Thanks.
