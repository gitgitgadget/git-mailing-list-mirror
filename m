Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D004C207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 17:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbcILRC7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 13:02:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60444 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753242AbcILRC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 13:02:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69CFC3A6B6;
        Mon, 12 Sep 2016 13:02:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FVRrhd1ePdM5
        27PojSveXLK8o8w=; b=k8xCa6YooCFOOspLu2Ek4rNxMAA+fGKrb59S9k4buTnr
        Iux/Xs/KuxERe0BK7IPLzHLCfPnZynb5hWtve4aewG2pQclU+UxZUJ5yj0+NkEkc
        myLhv8iz1A+CAfgR6M87hn8l8m38AbvrNLShrbi7G4jq1wDcyPKETlBBakkut6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GWFjnF
        sdUjMpPEzZpAYiG/J4twvZkc90HzysOgwxI3mD2advGLiAlWOgy7oHHH8cPEm9mc
        0PG5oO25JZzpOPYrXBFNa9yuDTp/Fse3TkxUk9CBpILnR3TKpOKsH2+zRJzJNk3z
        hKf8lcdnby2zsHPvKl3q4bToaf6g92PQVcbnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 611663A6B5;
        Mon, 12 Sep 2016 13:02:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D55583A6B4;
        Mon, 12 Sep 2016 13:02:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 12/14] i18n: show-branch: mark error messages for translation
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
        <1473679802-31381-12-git-send-email-vascomalmeida@sapo.pt>
        <ba3430ff-9643-eddb-31e7-c1e9a399d806@free.fr>
Date:   Mon, 12 Sep 2016 10:02:54 -0700
In-Reply-To: <ba3430ff-9643-eddb-31e7-c1e9a399d806@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Mon, 12 Sep 2016 14:12:25 +0200")
Message-ID: <xmqqa8fd3vb5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0937C5A-790A-11E6-82C7-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Le 12/09/2016 =C3=A0 13:30, Vasco Almeida a =C3=A9crit :
>>  		if (MAX_REVS < reflog)
>> -			die("Only %d entries can be shown at one time.",
>> +			die("only %d entries can be shown at one time.",
>>  			    MAX_REVS);
>
> Wouldn't you i18n this one too, with plural form?

I would think this one is OK in practice for the same reason as 7/14
