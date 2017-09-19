Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5530320281
	for <e@80x24.org>; Tue, 19 Sep 2017 03:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdISDSi (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 23:18:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50551 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750789AbdISDSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 23:18:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58F2BAA852;
        Mon, 18 Sep 2017 23:18:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uyVKLNk+JY7i
        cO69Aia+orSU6NY=; b=LHk3qc4L1YthsszHiDlTvzp4qVh9w2IfGbhgYeHmZ3Vc
        xD1OHLaPg6Zxjiq9iUNfxokvAArCBEOBr7vot5x4t0fhadbudJKuUDWgzn+PappH
        9CuBXQWT4Udh+/Cx7EReOG2Im6hvRvnU7+dZrmVH+FDOORxOWX20XU40WZpAF/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WtLvGM
        FYpUTf4Qgmwe8C/or4OqJANk1vYPAOohtBO4gZ8WTsQNymlkiacV8sokSVs6PeHK
        tYF8EIwWxmjJ0ilJl9YBBofj7nSTPyjS7v4pMhdCV5bYVzv148JjL6CRw3KRUAme
        oEPXk8VP+w+2ZMQVpCOcTRwmdTgu84/RaHN1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 522C9AA850;
        Mon, 18 Sep 2017 23:18:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE223AA84E;
        Mon, 18 Sep 2017 23:18:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: rev-parse: add --is-shallow-repository
References: <20170918170429.8328-1-oystwa@gmail.com>
        <20170919023349.GA175206@aiede.mtv.corp.google.com>
Date:   Tue, 19 Sep 2017 12:18:35 +0900
In-Reply-To: <20170919023349.GA175206@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 18 Sep 2017 19:33:49 -0700")
Message-ID: <xmqqlglbqstw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39BA7522-9CE9-11E7-80C3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  test_expect_success 'showing the superproject correctly' '
>
> With the two tweaks mentioned above,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I agree with the fixes to the test titles suggested, so I'll queue
the patch with the fixes squashed in.  Hearing "yeah, the titles
were copy-pasted without adjusting, thanks for fixing, Jonathan!"
sent by =C3=98ystein would be super nice.

Thanks, both.


