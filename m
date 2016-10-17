Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F681F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 21:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934991AbcJQVLv (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 17:11:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62627 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752197AbcJQVLu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 17:11:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9570D45569;
        Mon, 17 Oct 2016 17:11:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PBHSaXsO2F+O
        EeP4yu4T/vpgAA0=; b=RlvMHVO5KZpR+X/gGjTCCGp1OE6KwJCUzonj0ooBQrW/
        xQj3OnZQre91AUfCIkzyVvGm78DgeuXddh/M3ZIpFajEf9Ck0fWbk0Y04jklPxsl
        6sfDUHrIxKZbO8HyecJLqi9R+wEYx3c9oszhg9iG1sirWyMS2PRgGiK7IFzGpfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ja6uO5
        2KLAm5EGXwFMCnjPSBXYKoRMSHYg3Vvf3l9iVfu6DVFOSqn0+uDk+r5slMAEHbgc
        u/7t53pDTj3byYKPT4w4AnBELhOdDiVLJQpfZoBEyIbn9P7XKidibotJs1AGBbE+
        8FFMDpUxMGqmbNkw4q6H+Aa3WTrLIEbO08DJ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D7DA45568;
        Mon, 17 Oct 2016 17:11:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0991945567;
        Mon, 17 Oct 2016 17:11:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cocci: avoid self-references in object_id transformations
References: <a5ed26c0-7fea-259c-74c1-0cd870a35290@web.de>
        <20161015134503.u3aznujploqee2le@vauxhall.crustytoothpaste.net>
        <xmqqlgxmvof2.fsf@gitster.mtv.corp.google.com>
        <014ef44e-9dd8-40b3-a3ec-b483f938ee02@web.de>
Date:   Mon, 17 Oct 2016 14:11:45 -0700
In-Reply-To: <014ef44e-9dd8-40b3-a3ec-b483f938ee02@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 17 Oct 2016 22:04:43 +0200")
Message-ID: <xmqqeg3eu1da.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 50B3E3CE-94AE-11E6-A152-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I get these instead with 6513eabcbcbcfa684d4bb2d57f61c662b870b5ca on
> Debian testing with its "spatch version 1.0.4 with Python support and
> with PCRE support", which look legit:

They do look good.  So I'd stop worrying about it and see how
painful to update my copy of spatch would be.

Thanks.
