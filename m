Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E059208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 07:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdHQHHH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 03:07:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752018AbdHQHHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 03:07:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 753949F71A;
        Thu, 17 Aug 2017 03:07:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YtDwTYsx9Fq7
        33zt4mg7y219h+g=; b=ru0sbPEOc4S9aQGBOhhGOLgb/jskSC9XRrApI2TvGVXL
        Dyf7vIQCxbIuYyeV9jiUszLJmBYO6Ze4N9fVBahQxv6OsJ7cvpabp2xeQi0GSWhw
        FH2h1gDwnbJeLfPYBhAs2HDvzOnnF/RxE13qHpLUeeDvzDJ9qFqmMTY4G4Ivegc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IUeGjq
        Urq5yjN8LMMQMrcwd4Y2Znsb6hFSKUzQI1yURE+IrAeqqgZx5PpUHU1ClvT+Aiq/
        PJdjDA5E5BVG/AL1YOgtH4E6FIlUbVs/ZT8iGSwhkrOPWGgbr5siNn3NzY+2bcCT
        RKTBxDP41EpTrFK9L+5Np/tY7iMmLrTsmJirQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59C869F719;
        Thu, 17 Aug 2017 03:07:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A7A99F717;
        Thu, 17 Aug 2017 03:07:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH/FIXUP 6/2] apply: clarify read_old_data() is about no-index case
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
        <xmqqbmnfl5tm.fsf@gitster.mtv.corp.google.com>
        <20170817062450.GA28592@tor.lan>
Date:   Thu, 17 Aug 2017 00:06:59 -0700
In-Reply-To: <20170817062450.GA28592@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Thu, 17 Aug 2017 08:24:50 +0200")
Message-ID: <xmqqfucqisfg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA1DA96C-831A-11E7-9918-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I don't have time to look at this today or tomorrow,
> please give a hint if you are working further.

It is past my bedtime, and generally I prefer not to touch topics
that I know other people are willing to look into, especially when
I know those "other people" are well informed and capable.

Thanks.
