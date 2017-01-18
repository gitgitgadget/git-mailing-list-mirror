Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F8D20756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdARAC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:02:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53112 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751142AbdARAC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:02:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6950D618B2;
        Tue, 17 Jan 2017 19:02:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mpS1ittKv7gbX0ibuqVLa3rb7ek=; b=AWsCkc
        OaAkdGRp3Ntf7bm+q8fwZ1Aic76aJTqle82SOnzyxppUjYbvnmffam05Ueh0h8jb
        sRio/2r1dlFsN4TSKN4Jlx8t+OvVN9sXAgu6+5RVfgzfai2cA7j0NF4XWaognr1s
        Zpl2DcblKdqxoJfQVe1gs/nEAyZAdRDXcfxtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FQdgmIe+2FA2oGx383mjpQs48i4V5sF7
        BBpLgY1Xe39EkD3v7Gk6VF9pF/sWY0DX3jKh/MrhnXUW0kSbDGZRvc3c3WOSUn51
        YwRJ9ZgesxzrNtxPVPcJkgq1GkivgjTHd+yqYAvAEK0/32639oNoNwEM1GDxz8rp
        IXgG8VSggS4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60D92618B1;
        Tue, 17 Jan 2017 19:02:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7A8C618A8;
        Tue, 17 Jan 2017 19:02:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
References: <20170117233723.23897-1-santiago@nyu.edu>
        <20170117233723.23897-5-santiago@nyu.edu>
Date:   Tue, 17 Jan 2017 16:02:24 -0800
In-Reply-To: <20170117233723.23897-5-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Tue, 17 Jan 2017 18:37:21 -0500")
Message-ID: <xmqq4m0xck1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64DB65BA-DD11-11E6-AD4E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> +	if (gpg_verify_tag(sha1, name, flags))
> +		return -1;
> +
> +    if (fmt_pretty)
> +		pretty_print_ref(name, sha1, fmt_pretty);

That's a funny indentation.  I'll fix it up locally while queuing.

> +
> +	return 0;
>  }

