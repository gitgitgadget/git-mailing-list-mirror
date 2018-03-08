Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBEF1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 17:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeCHRz4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 12:55:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61422 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeCHRzz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 12:55:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43B0CCFB4D;
        Thu,  8 Mar 2018 12:55:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ys3JbvaZ1Ory
        52M/jUcMq0Fw0tg=; b=JlFbN9E9cBb9iKGSnc7In5+fpYw3bSVyu4UkYbPYz53x
        Kz/jNpiaTu3leuG55Ax6Bt2u+jyzKvf2/P6a/0F252wzwCRijTw1xGnvlY40V12R
        /m7efwEEbl3PHkThgpP5eCQ9oEPWBQB9Cq3sV8kS2t/o1UGP42ZmET4OX5lEowE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AD41CFB4C;
        Thu,  8 Mar 2018 12:55:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type:content-transfer-encoding; s=mesmtp; bh=iYZrwtl3jJk2o5dk3j69I27ugohARMxQ675/cCaVIU0=; b=OaXJUcruRah9wyjd7gbWVnHscv+CElSE3bgUg719xwfdicNIGLoHKGPl0co4umQZKs3MD2u503FLmeyAZgNB/mCWzgOQXJb5MzjAs5eTHafDAKBbiGuVs0HwS6tFg1eOsPEaxoaQUuPfDlQX8iBrYfcMhchzCd4IfBKAbGM3jzI=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB678CFB4B;
        Thu,  8 Mar 2018 12:55:51 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git{,-blame}.el: remove old bitrotting Emacs code
References: <87muzlwhb0.fsf@winehq.org>
        <20180308094544.7286-1-avarab@gmail.com>
Date:   Thu, 08 Mar 2018 12:55:50 -0500
In-Reply-To: <20180308094544.7286-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 8 Mar 2018 09:45:44 +0000")
Message-ID: <87zi3i8na1.fsf@kyleam.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Pobox-Relay-ID: F0D06EEC-22F9-11E8-B069-67830C78B957-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

[...]

> These days these modes have very few if users, and users of git aren't

s/if// or s/if/if any/ ?

--=20
Kyle
