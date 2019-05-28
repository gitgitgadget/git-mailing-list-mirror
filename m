Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2A31F609
	for <e@80x24.org>; Tue, 28 May 2019 16:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1QeY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:34:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65121 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfE1QeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:34:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D57B8148CA3;
        Tue, 28 May 2019 12:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xseKmuv9WRX7
        KWlL3Pq4uCvKFlw=; b=XKtA/Fb/EM2YElkylvlDa7CITf5k1xZmJN5Vr96jjuA6
        4Z71RawUhNnBgcE647lhxCTJZGdmqBHPLqF98zoGgYOJ2Fbx1bgEp1oyTrpeYl2k
        04Ec1s0pJY+Bu1fFsVNq9uzpoA27NDCYtb7Pa6JfH+0EK5lj9JY6yxpbQibZ94s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mV/WeR
        iqo6fYSniPEShu4Vexx9i7VlPOObI/1Wjaqq/SBYRBroWacERRi5MG62SO0b1nrN
        h00uN82rJDjvc7FfPsWNvOokbTij2Ykv83oAciRSaDH7GLSiLjU3rM8C2STucUv/
        zjSEceJZcXg7/O66CS/AK0wTmniWQzz4A3rHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD4EA148CA0;
        Tue, 28 May 2019 12:34:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FE27148C9F;
        Tue, 28 May 2019 12:34:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v3] userdiff: add built-in pattern for rust
References: <20190520170403.16672-1-marcandre.lureau@redhat.com>
        <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
        <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
Date:   Tue, 28 May 2019 09:34:20 -0700
In-Reply-To: <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
        (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 May 2019
 12:57:12 +0200")
Message-ID: <xmqqtvde4jxv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 721E83C8-8166-11E9-816F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Ok, I am adding:
> ...
> sure, I thought it was already covered.
> ...
> I think that would be fine, ok I am changing it

Thanks, both.

The previous round has already hit 'next' (which means that we won't
replacing the patch wholesale), so whatever you do, please make the
update relative to / on top of what is queued as d74e7860
("userdiff: add built-in pattern for rust", 2019-05-17).


