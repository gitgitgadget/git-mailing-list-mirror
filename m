Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B8E1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 16:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbdHSQcQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 12:32:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65198 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751327AbdHSQcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 12:32:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FA89B19B1;
        Sat, 19 Aug 2017 12:32:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7ecLiawqze8k
        phosEWpXgyPTZSw=; b=xdnA8PZhemTSO80W62AH9j40F+Dh4LWnEYzElPHKhC2p
        k0AQK/qTRe+EFQv2jD3QPB82Nbe0zWLNnh9npR8GdSMd4/ajZCKX0AqgwH82f8sV
        SyzjIxt/Z/XfMi5N0os7KFYpTUwnYKC8BL7CPwmzFiTMEsxN8QQGdnG7so6TuZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZHXAzU
        LdSFIs9kTRXehNGretWHZixuJQtOPcWWmGrcKWN698YsNi3wieuSKwpZoX5bFaJg
        nw1KCC5w9WyPqAnoYw0RaJ/1X5bCuZd6UhWx6DaTIsh4OKMjeDxntz68+5ZwAerx
        po3BV1hH5ImXo/giWh3hgXucmxQJJvS92CIJM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 290FBB19B0;
        Sat, 19 Aug 2017 12:32:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74504B191C;
        Sat, 19 Aug 2017 12:32:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #04; Fri, 18)
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
        <20170819112651.GA13262@tor.lan>
Date:   Sat, 19 Aug 2017 09:32:06 -0700
In-Reply-To: <20170819112651.GA13262@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Sat, 19 Aug 2017 13:26:51 +0200")
Message-ID: <xmqqfucna589.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F11C437C-84FB-11E7-8A34-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> * tb/apply-with-crlf (2017-08-17) 3 commits
>>  - SQUASH???
>>  - apply: file commited with CRLF should roundtrip diff and apply
>>  - convert: add SAFE_CRLF_KEEP_CRLF
>>  (this branch is tangled with jc/apply-with-crlf.)
>>=20
>>  Will merge to 'next' after squashing the fix in.
>> ...
>
> I will send V4 in a second (hopefully the last version)

Thanks.  Will replace.
