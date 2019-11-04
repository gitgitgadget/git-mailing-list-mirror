Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B101F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKDMfi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:35:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21976 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfKDMfi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Nov 2019 07:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572870937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHGdaPTrV0JwkcK82ElZD6Z2S2lhBmKoscQu4ZV39dI=;
        b=aiUYfzhYhEYOcMebhbYv/SdzP9mJn/C2GVXR6YCyka+5JVt2QjRrcV0vZB/ZrGSdvZu7pD
        XXf/Ycvw1sc9S0dl4xCF+eamqTq5oUMy39bn7AYNecR0+bmmQaFLMqEm8MvOGMDvkYC8sU
        ztYYwQnpg3I5u8FkvvPYfalJeYTsD2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-cO5USGGmOgSc2Y2rIoSC2A-1; Mon, 04 Nov 2019 07:35:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A2F800C73;
        Mon,  4 Nov 2019 12:35:32 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD26E5DA7C;
        Mon,  4 Nov 2019 12:35:31 +0000 (UTC)
Subject: Re: [PATCH v4] pretty: add "%aL" etc. to show local-part of email
 addresses
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com
References: <20191029120914.14756-1-prarit@redhat.com>
 <b9516269-3c17-1e7d-27f8-83558b56d1bd@redhat.com>
 <xmqqpni8z37z.fsf@gitster-ct.c.googlers.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <2ad15a2d-63c7-51a5-fe1e-64e9b655adca@redhat.com>
Date:   Mon, 4 Nov 2019 07:35:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqpni8z37z.fsf@gitster-ct.c.googlers.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cO5USGGmOgSc2Y2rIoSC2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/3/19 11:15 PM, Junio C Hamano wrote:
> Prarit Bhargava <prarit@redhat.com> writes:
>=20
>> Just re-pinging to make sure this didn't get lost.
>=20
> I think it has been on 'next' for several days aleady.
>=20

My apologies Junio.  I didn't realize that.

Thanks :)

P.

