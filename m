Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C71C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2A24655
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fWt3UKMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAUSmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:42:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55024 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:42:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7C24A22D5;
        Tue, 21 Jan 2020 13:42:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n6b/2WrbTB9silOjRrDz7yiDxvw=; b=fWt3UK
        Mj3tSKpljbBv9iwdzOvb7TXzy/2rcAYsVwyNUzb9IToqGy+xdRNEKQux++ywu9Um
        Kq0AAOqW4K+Y2u1qtbOJvSvR/OXNm4YexCeCNVK/iK6qhucA5ZaY3MPqlNV0Bj8i
        0Pvq1hSAlzKFGgMZh3zE4R/DLtXfcbWsVufEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EOH9pOyCy9KFI7mqSfZjvwiShCTk6J0p
        fa6yruUFASp0h6kfUBh3SL8ZZ7Kkb7YC9m88oWKyeBks/26Ddb7KeIcx+KZAvQDd
        7fRO/cVTmduiaJ8xy+Raxc6jzz1kND6wdlfmLnIEC8TYbC7mwgaeuNvYOk8CThHM
        q8stOdY3cPY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A08B1A22D4;
        Tue, 21 Jan 2020 13:42:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C84F8A22D2;
        Tue, 21 Jan 2020 13:42:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>, git@vger.kernel.org
Subject: Re: [PATCH] docs: use "currently" for the present time
References: <20200120212156.4109999-1-sandals@crustytoothpaste.net>
        <alpine.LFD.2.21.2001201633240.8488@localhost.localdomain>
        <20200120215326.GE6570@camp.crustytoothpaste.net>
Date:   Tue, 21 Jan 2020 10:42:36 -0800
In-Reply-To: <20200120215326.GE6570@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 20 Jan 2020 21:53:26 +0000")
Message-ID: <xmqqo8uwabxf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC895388-3C7D-11EA-9D91-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> As I mentioned, this is very minor and I can't imagine a native English
> speaker being confused by it, nor can I imagine a speaker of most
> European languages finding it confusing.  It just stood out to me since
> I know Spanish and French and I thought, "Oh, someone was thinking in
> another language here."
>
> I've actually been sitting on this patch for a while because I thought
> it might be too minor to send, but I finally decided to do it as I was
> sending some other doc patches.

Thanks.  The use in the sslVersion seems to have come from 01861cb7
("http: add support for specifying the SSL version", 2015-08-14) and
the other one seems to have just copied it at d73019fe ("http: add
support selecting http version", 2018-11-08).

Will queue.
