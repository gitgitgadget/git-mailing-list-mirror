Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9150420A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbdAWSfj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:35:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61110 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751585AbdAWSfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:35:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 794456170F;
        Mon, 23 Jan 2017 13:35:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=of6ThK7NQjigXJHIF2Z8UKY5X6Y=; b=ET8Knl
        Mvc+vKXYqWlP/Jii/eDexjaat7HY3nH5uXV09kjIFKqWUV3xa5EF7tQIeMV/iu2v
        CoB95KlwAlMDr218no8bFsaOKpKOC0dRCZEt1fOrX+a5jcNXjOeXY3N6qp/r5nbA
        dYK2vPFzEt+Fngr5hq/UgiGTCP2GkR45kUN1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ktoWJ5GLTcz5wTmDCbBmSzj3zUQdkR6M
        radC5KaECu4//xemen5BAGVndcP3yYX6oOxycCUTiW751Bx5kphEg9h8ZAwC5087
        91dYex9T+GZmsac9W8WcXgWGZrMFUvF0k1kMuo1oz5Pl3QkQOr7a1PnpKdLLgPj5
        6G6718WKig8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EE466170E;
        Mon, 23 Jan 2017 13:35:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA3D46170B;
        Mon, 23 Jan 2017 13:35:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC] Case insensitive Git attributes
References: <CAHnyXxRx_iagZhki1rmVEpw+GZPWBRx7mNmahs3pruy57L3h-Q@mail.gmail.com>
Date:   Mon, 23 Jan 2017 10:35:29 -0800
In-Reply-To: <CAHnyXxRx_iagZhki1rmVEpw+GZPWBRx7mNmahs3pruy57L3h-Q@mail.gmail.com>
        (Dakota Hawkins's message of "Sun, 22 Jan 2017 14:25:58 -0500")
Message-ID: <xmqqvat5sjym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7EE8F24-E19A-11E6-9166-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dakota Hawkins <dakota@dakotahawkins.com> writes:

> Apologies for the delayed bump. I think because we're talking about
> affecting the behavior of .gitattributes that it would be better to
> have a distinct .gitattributes option, whether or not you also have a
> similar config option.

As I know I am on the To: line of the message I am responding to,
let me quicly let you know that I won't be responding to this thread
for a while as I don't recall what the discussion was about.  I will
after I'll dig and find out what the thread was about but it won't
happen immediately.  Sorry about that.
