Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27621F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 13:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeKKW6J (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 17:58:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53975 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeKKW6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 17:58:09 -0500
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2018 17:58:07 EST
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2DBB397BC;
        Sun, 11 Nov 2018 07:59:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=psE+KLXCr9r5
        bx0qN+dYwOnxzLQ=; b=yJjKBP8cJ4ioZ9WO9hLmaVnQGZcWPigAvtIcE0BlEkIu
        cfn7jWf0HoldVyzM2iLzvantDizD8BFFL8wd6lcXnfbv3mV8pr82RHMeg6GHVyUI
        xc15sGWRLBPEMiswiBTGWGIaOSzZ2L6OpT3KGt3Y9Aow/eAhEI9d6X/iLN6pvS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xPhgy8
        A3ZwmnM8gIRJyIzYnAf2DQO8Rxzfn83TLONE4jNtghMsQHugn4H1TbHbbfPK6yaY
        cpSReU8nCe0VzHrTzce6CozYEWQ9vGPWqkBBJubUTXlRH8LzSZmvLNpLQ3vTyCKy
        K3221rOUPyZunnBp/mIWkiQesQpM6+pskxSbM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC1AA397BB;
        Sun, 11 Nov 2018 07:59:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CF45A397BA;
        Sun, 11 Nov 2018 07:59:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com>
Date:   Sun, 11 Nov 2018 21:59:52 +0900
In-Reply-To: <20181111095254.30473-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 11 Nov 2018 10:52:54 +0100")
Message-ID: <xmqqva534vnb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF596556-E5B1-11E8-AA9D-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Also while "precious" is a fun name, but it does not sound serious.
> Any suggestions? Perhaps "valuable"?

FWIW, I am reasonably sure that I was the first in Git circle who
used the term "precious" in discussions wrt .gitignore, i.e. "Git
has ignored but not precious category".  Since it was not my
invention but was a borrowed term from tla (aka GNU arch), I'd
suggest to keep using that term, unless there is a strong reason not
to follow longstanding precedent.
