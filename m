Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61532C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA30220737
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KNOkXbG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgFITCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:02:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59512 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgFITCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:02:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 144566E1F0;
        Tue,  9 Jun 2020 15:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BpSUFXqom3V1jCMtLhtrnBN4bNQ=; b=KNOkXb
        G8+FeluDFrwKC4hVwKf4bMvIiq9Qn4RsKh7BH4H60IuW5vYoNQ1KOBIATipi9tRI
        wLZKEEnCVDerjiqXlpD+9xfVS7bYa4+PQzge4QiFbPT30LFRARtO1IhP0KS4MnOp
        IsJBm2Emnj1bcGisuE2HjBVbbaioAqpZdJvU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZyDibusHrmUxlkIlIFwBI+nInSppJD2b
        Eh4Mxn7yt8dBZnGVuQjCEgD1Wd7zlSwm2yzwMfD9fMBsS2K74jgx+LezA7Ot2jLX
        B+6Gq4BcGF6vemVotRb+cp+pTkoSm5aF0t5TlVQyjv9iApmRQXiULKr4Ie70Gogo
        v6xM2XaWeIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04A896E1EF;
        Tue,  9 Jun 2020 15:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 596866E1EE;
        Tue,  9 Jun 2020 15:02:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Simon Pieters <simon@bocoup.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Subject: Re: Rename offensive terminology (master)
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
        <20200505231641.GH6530@camp.crustytoothpaste.net>
        <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
        <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
        <448e4f49-d1f8-94df-4fc7-64cd024e668f@kdbg.org>
Date:   Tue, 09 Jun 2020 12:02:49 -0700
In-Reply-To: <448e4f49-d1f8-94df-4fc7-64cd024e668f@kdbg.org> (Johannes Sixt's
        message of "Tue, 9 Jun 2020 20:10:52 +0200")
Message-ID: <xmqq5zc0hxk6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0826E7E-AA83-11EA-AE6B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 09.06.20 um 18:02 schrieb Junio C Hamano:
>> so it might be the matter of teaching "git
>> init" (it uses 'master' by default) and "git clone" (it tries to use
>> the name of the branch the HEAD at origin points at,...
>
> Don't forget the special treatment of "master" in fmt-merge-msg.c that
> skips the " into 'foo'" part of  "Merge branch 'bar'".

Yup, that certainly needs to be taken into consideration in this
topic.  There may be more that we are forgetting.

