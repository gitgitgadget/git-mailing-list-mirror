Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69562C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 05:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B892070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 05:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P6QEce4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfKVFoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:44:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62812 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKVFoc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 00:44:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E32698D30E;
        Fri, 22 Nov 2019 00:44:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RgziQiNZ3ACsCU0HmNkQqHTaSTE=; b=P6QEce
        4weykSSMumpgre6afK9OeW74cBQ/2uip9GsOgI+6EsrKeTIYrwOdccbsIjfqWsvY
        vFabZglVCtAraFLGce4BWgWY52MbegPfl7hWkHi13Kzk2C7bpUhXsnwWk4KV/ASx
        6SbrHr1rRg8OKSZ9W4XwJr24iy/mUwE9UF7Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jGJ50VlTC+JeKZRzwesAFUAFqaUCArJ/
        ZJtgtU00m7yMH/+Z5rPE1i7Y87YpVIWr5NY25QsA52BJUfvVkyW1Hv6oCqCjuXFj
        0XPrPJtq9c0UyB9V7pDos9vueOdZ9k1F7nPe/otdrUUbRMq4sKQkX2VRNsc+UJmP
        yxOVKQ4dTpg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB5268D30C;
        Fri, 22 Nov 2019 00:44:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 111438D308;
        Fri, 22 Nov 2019 00:44:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Christoph Berg <myon@debian.org>, git@vger.kernel.org
Subject: Re: git clone git clone some://url
References: <20191119141537.GD18924@msg.df7cb.de>
        <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
        <20191120180709.GA63368@generichostname>
Date:   Fri, 22 Nov 2019 14:44:24 +0900
In-Reply-To: <20191120180709.GA63368@generichostname> (Denton Liu's message of
        "Wed, 20 Nov 2019 10:07:09 -0800")
Message-ID: <xmqqy2w85utj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 254CB4C8-0CEB-11EA-BCED-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> Or
>> 
>>     $ git git clone some://usr
>>     $ git git git diff
>
> That's why I have `git config alias.git !git` set. It's saved me seconds
> of my life from having to retype these lines. ;)

;-)

Yes, it was the above hack of yours I had in mind when I sent my
reply.
