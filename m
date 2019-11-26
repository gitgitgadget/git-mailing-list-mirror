Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862A2C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38705207FD
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FuWmFp7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKZBg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:36:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61052 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfKZBg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:36:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5797F3BDEA;
        Mon, 25 Nov 2019 20:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Go22KXBhkvlRCPkc6Aple63l//s=; b=FuWmFp
        7VSWVjmSny5wk7zWOqMOCEkczcMJ6KhS+rtzgRrU4u+3HxK1CvbEhQNY+lMybbRi
        HRAK0FrvV6q/7F/AiwPF7kCYPLAbNdUHvFIyciQ5/Vjv0C78xtoY5EkAQeGAs5/P
        F0i5q3h3KzxvUmPEggh/mpz6unmIzSyy5wQmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o7xVJu54EleMnxOc1ft240GoOdcqwrOu
        xRsk1ELPmw+tGn1dU2CI7UwB/F3jEtKsn2uAY1m/rnn/3KOEaFWWsx4TgquaI/8u
        0AnlLxlWGQC52HfguHvEaX879eoa+O8/LpD6Mc44ukvO15oDlBKRANB2anKal8VU
        07rT8MolwhI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F4943BDE9;
        Mon, 25 Nov 2019 20:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B60E23BDE8;
        Mon, 25 Nov 2019 20:36:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: Timing this week
References: <CALnO6CDvGjVo=s2QDwXU_hEoYQqGgPXu=fqroN5Rv2iaxvwXqg@mail.gmail.com>
        <20191126002326.GB14157@google.com>
Date:   Tue, 26 Nov 2019 10:36:24 +0900
In-Reply-To: <20191126002326.GB14157@google.com> (Jonathan Nieder's message of
        "Mon, 25 Nov 2019 16:23:26 -0800")
Message-ID: <xmqqh82rwh9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28FE2106-0FED-11EA-912A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> One of the nice things about email is that people can respond at their
> convenience.  So fire away. :)

Nicely said.

Thanks (I will be offline for a few days, though).


