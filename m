Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9D7207EC
	for <e@80x24.org>; Sat,  1 Oct 2016 01:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbcJABdc (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 21:33:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63254 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752736AbcJABdb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 21:33:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 999AD4330C;
        Fri, 30 Sep 2016 21:33:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ntwfzny+79gf
        h5WLZ4REjx3pUGs=; b=lsoENvcgpMzXMnoeYs/gDSqCsBXsvDUZ4olZxBz85O+s
        yOeb7UFTis1EAvEyQ01+yqq2tOmKh7Y2JzK0giJu8BtEABIU8fSFpBWBJb7FFlt0
        AeVdxkgmYTM7mqzgGsEX0VmG9P1hnGKWPHAlYzGh26VrW4dVJYCjPmARU4wk8EM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eS3Nq7
        x/6NkyecAupzsVnrx6Gr4jCKVnEQ6mpBIg0Ug/4len1+e0hzgN7/p3uc9Vxg9ydW
        f2BN1tlSvuHdLtfoxjrRfeavruCuCFSQIF4pSI6GXQbBGq4p+LhC9bzpVWCv6Orw
        +4MBZoTPECH9u9yJcg16XBRCxL4aurEBRmi9E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91A5E4330A;
        Fri, 30 Sep 2016 21:33:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C5B043309;
        Fri, 30 Sep 2016 21:33:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v3 2/5] ref-filter: add function to print single ref_array_item
References: <20160930221806.3398-1-santiago@nyu.edu>
        <20160930221806.3398-3-santiago@nyu.edu>
        <0e3cc036-787b-d93b-dc87-47a0826ec919@gmail.com>
Date:   Fri, 30 Sep 2016 18:33:26 -0700
In-Reply-To: <0e3cc036-787b-d93b-dc87-47a0826ec919@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sat, 1 Oct 2016 01:12:23 +0200")
Message-ID: <xmqqeg4097kp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E3F8B4A-8777-11E6-9C4A-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> Expose a format_ref function to create, pretty print and free individu=
al
>> ref-items.
>
> It's now pretty_print_ref, not format_ref (old version in commit messag=
e).

Good eyes.  Will tweak locally.

Thanks.
