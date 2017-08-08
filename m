Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F9620899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbdHHREi (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:04:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55397 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752092AbdHHREh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:04:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2F3B9A882;
        Tue,  8 Aug 2017 13:04:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=d8Fq8+C3fBnN
        MJYbdfxkzfBLU3M=; b=uGStBZGGiHzoqhjccpTe2SLUwCuhIV4Mhze/3mTbP+X+
        H1hjgdhvOsy5CPWwGI0LQgG7Rup0ec2JCY03NrnEKnWUg2cH0wtU2cp2LeQq3FYN
        6yEnMPmbuykZoHldoKwtT4KHRuvB1fhzIYkuRXfmqBVGoI0FbEVmDHLTOYzE1hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=T25fXC
        LFZF+WiS3aH46p4gmvRfIgDqQ9RnJsTEcUDv7W4OdbERrKhEf0ecrAdPpxIkN8Oq
        1VifAtfC5hgX3PocChQ1oo/zaW07KMPtDKLGbrYpAmil8dG++xn7TxO3bcOHfQvv
        EzgW52a+zQ8EP6ZFwUJYkbyREVKX+N3vJyEVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAED59A881;
        Tue,  8 Aug 2017 13:04:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BAB79A880;
        Tue,  8 Aug 2017 13:04:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/6] clean up parsing of maybe_bool
References: <cover.1502128418.git.martin.agren@gmail.com>
        <CAGZ79kaEA7DRm4inO=XPCVvA3mJioV_yckAVEUbCo5DEwoxbUQ@mail.gmail.com>
        <xmqq1sonozdx.fsf@gitster.mtv.corp.google.com>
        <CAN0heSqbi-2VzhXtFO--v2+kMKuUbt4Z3QgtjW6WLEFP+VeoTg@mail.gmail.com>
Date:   Tue, 08 Aug 2017 10:04:34 -0700
In-Reply-To: <CAN0heSqbi-2VzhXtFO--v2+kMKuUbt4Z3QgtjW6WLEFP+VeoTg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 8 Aug 2017 06:02:06
 +0200")
Message-ID: <xmqqbmnqc7od.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8164FB8-7C5B-11E7-A0B7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Thanks, both of you. I could wait a couple of days to see if there are
> other things to address, then send a v2 with a more aggressive patch 5?

Sounds like a plan.  If there aren't anything else, I personally do
not mind using what is already on the list without v2, though.  That
would be less work/churn for me ;-)

Thanks.
