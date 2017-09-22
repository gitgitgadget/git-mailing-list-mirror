Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E89202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbdIVBEP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 21:04:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54510 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751779AbdIVBEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 21:04:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 322DBA57DC;
        Thu, 21 Sep 2017 21:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bgaIrsw5XR8j
        khF57ICdJfg64Fk=; b=ax2fiVCXcYpRyG/7ujN/3tHAeKS1dc5ZdJmUZSZJqYow
        ODjIZEAiHt7nk4arDNTMCQckH8GD2Xy9D4IpElfnxSPOyj5udtDb8ocTf+3FmW1B
        Aishp1KluWhV/4+tYhdscqQJaJ19il7NbRC5EC+kZLRyFNHu4cTYaWaNknn/SIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=B2tUIv
        v1ABpikvM+vQ/FQl61+JodonjkadZ4TisgwpASj91gjmjl2ScplhlIsxw26S2GRO
        ZcscjZ61H+4WWn/jyeDp1GIOTEt2wo1ABGIuAYgqo1gXQDQv/u/WfPOSPjq3Hqem
        OxAQLpR2WglgwLndhYoB5fpEzRAp8lCUfXbjk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A685A57DB;
        Thu, 21 Sep 2017 21:04:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9064EA57D9;
        Thu, 21 Sep 2017 21:04:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com
Subject: Re: [PATCH v1 1/1] test-lint: echo -e (or -E) is not portable
References: <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
        <20170917054318.28560-1-tboegi@web.de>
        <20170919203714.GF75068@aiede.mtv.corp.google.com>
        <20170920134952.GA1898@tor.lan>
Date:   Fri, 22 Sep 2017 10:04:10 +0900
In-Reply-To: <20170920134952.GA1898@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6ge?=
 =?utf-8?Q?rshausen=22's?= message
        of "Wed, 20 Sep 2017 15:49:52 +0200")
Message-ID: <xmqqh8vvmtmd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F2568EBE-9F31-11E7-A1C5-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Junio, if you wouldn't mind to squash that in,=20
> another fix is needed as well(trailing '-' after '-E') :
>
> s/'-n', '-e' or '-E-'/'-n', '-e' or '-E'

Yup.  Thanks all.

