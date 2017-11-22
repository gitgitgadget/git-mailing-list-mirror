Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BDB2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdKVFHm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:07:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63570 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750959AbdKVFHl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:07:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35631B2277;
        Wed, 22 Nov 2017 00:07:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=If4P+vzQNhzz
        W+B7yt1mTCsZmU0=; b=eRnxp1jWDkCIsorAL9hz+Z8g1lBTNlL6WWOPU6uLDduZ
        n+W8HBwlLnWSbiFVvaOvdE4+MoHk3GnphcdE9NUmnzzp7YH1C35TQ0aVjzHa0m6d
        wDcA7fE2kw492qaE7pO8T4xISooHK4OP4ZYyf/l9/WOfE6W2OjeKicQb7pP8tKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vywV17
        khUs/OZt0aLUdmxjST2Qtw22AhABGbw3rI2BcaIvX7zxzyHdAhAtf1v4YuibODrP
        nC9pslknhrIVRtHCsDsFbiCUoF3mb6ar8Ysu0uoS8fCiImSlx1Oa/PaT1Zr6ryZb
        ZV16QTHp0iMEoFyrQjniYQBtuV7Du0gagH9Eo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CF58B2276;
        Wed, 22 Nov 2017 00:07:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9697EB2275;
        Wed, 22 Nov 2017 00:07:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: allow overriding timestamps of generated asciidoc
References: <20171121232935.GM3429@aiede.mtv.corp.google.com>
        <20171121233432.GN3429@aiede.mtv.corp.google.com>
        <20171122005433.kwv4bin6y65xuxm5@genre.crustytoothpaste.net>
        <20171122011531.GQ3429@aiede.mtv.corp.google.com>
        <alpine.DEB.2.10.1711212317440.27951@mass-toolpike.mit.edu>
Date:   Wed, 22 Nov 2017 14:07:39 +0900
In-Reply-To: <alpine.DEB.2.10.1711212317440.27951@mass-toolpike.mit.edu>
        (Anders Kaseorg's message of "Tue, 21 Nov 2017 23:30:27 -0500 (EST)")
Message-ID: <xmqq7euivr38.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1098E688-CF43-11E7-9908-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> That should make this Git patch unnecessary.  (You=E2=80=99re of course=
 still=20
> welcome to take it if you think build reproducibility with old AsciiDoc=
=20
> versions is worthwhile.)

Thanks. =20

I've queued these three only so that I won't lose track, but will
not hastily merge them down (yet) until I hear from people.

