Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5438120984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757731AbcIMWBN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:01:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53889 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755281AbcIMWBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:01:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C4693DC44;
        Tue, 13 Sep 2016 18:01:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pHR6T/ZlVJ5Q
        17tepccOCbwJnGo=; b=yBEp9wxA5SrtKXtnjf5kUzxl0u++oFnNd0A/TzDiwkKP
        1IKBmLozcxmNDRWd3NZpOY/TV6XCuiJ0MW7VlNRwWlIej93tEn1jaNOnUULcIf4U
        MKyNRmvsszItXGF9j64ruDbeWIlyvQm+RiwWJpn31lukNfd1ialiVkrviRTW9/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KvW6Zy
        kL8k1vwHEq2lsoXEZ78TQZ7GWAGABab90HtdPPRryCT8HUmjx6d1TD4w7ftXO9Qi
        3NoJpPLf0BU2Lv/QV7e2uGa+qFEVD6axx5AeSVmxBQi4yMXeXu/+XsGV118tEWCV
        aKAlduWNGyIsTYTy09FG1tPdnmLbHNc495GvE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C69E3DC43;
        Tue, 13 Sep 2016 18:01:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D17D33DC42;
        Tue, 13 Sep 2016 18:01:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 09/14] i18n: notes: mark error messages for translation
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
        <83f72924-9a9d-dc1c-109f-341f0cd7ac96@free.fr>
        <1473784505.7329.18.camel@sapo.pt> <2523910.zLOPm9a3mF@cayenne>
Date:   Tue, 13 Sep 2016 15:01:07 -0700
In-Reply-To: <2523910.zLOPm9a3mF@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Tue, 13 Sep 2016 22:23:07 +0200")
Message-ID: <xmqqfup3v4rg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9413210A-79FD-11E6-B0EA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> Yes, these verbs are git notes subcommands....
>
> Having one sentence per action is cumbersome, but avoiding sentence leg=
o is=20
> mandatory for proper i18n. How about  just adding quotes around the sub=
command=20
> and warn translators ?=20

I think that is a sensible way to go.  I do not think it adds value
to "translate" the action names that needs to be typed verbatim in
the message.

