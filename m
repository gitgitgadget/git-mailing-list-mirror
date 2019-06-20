Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D82E1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 04:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfFTEAj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 00:00:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61066 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTEAj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 00:00:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E236A168CD3;
        Thu, 20 Jun 2019 00:00:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=86XflHZpxyrb
        fF8RfnvPi7ipL+4=; b=myQYlV8BNUVYgFfoK/GhVGrH+mQcTnKL4KntuBI8YJO/
        jUa8JaCf3fcnWPfTQdqqEWbIC2eR4DVu7Tq8cAAjhey4oLM3pVcA/cGNAqm+zen1
        X4N+jkrkIGVD7PDOgFdtFXvcnibpCkh8MRqZANFnNWiBNcwS+/QVjCvSlCeXLQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YoRhaF
        0mO4Os1pMNkDlAs2q5Z7ibwUB85RJlOtEH0B5BNfhp48Uh+rRZxHSXM/iysDdPFB
        i4WsFkbJuc5EEIgIDW3ea55qzg8Rlw0G2iDQ6ggsij2hqNBv5G8yRpfGgB4TaSQY
        mblxWQkGmKphwSNqBcw5jn7qVgSy/PLfwbcqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9438168CD2;
        Thu, 20 Jun 2019 00:00:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B8A4168CD1;
        Thu, 20 Jun 2019 00:00:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
References: <20190619095858.30124-1-pclouds@gmail.com>
Date:   Wed, 19 Jun 2019 21:00:34 -0700
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 19 Jun 2019 16:58:50 +0700")
Message-ID: <xmqqk1dgq525.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4DA41D4-930F-11E9-9904-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is probably just my itch. Every time I have to do something with
> the index, I need to add a little bit code here, a little bit there to
> get a better "view" of the index.

;-) =20

JSON is not particularly my cup-of-tea but it is better than many
other things exactly for one reason (everybody and their dog have
heard of it), and certainly is much superiour than inventing our own
ad-hoc format. =20

Thanks for working on this (I do not expect I would see an immediate
need for this myself, though).


