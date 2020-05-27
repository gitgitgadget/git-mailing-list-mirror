Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D551C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724BB20C09
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q5zbpOEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgE0ROi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:14:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56085 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgE0ROi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:14:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF1FD4DCC7;
        Wed, 27 May 2020 13:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=85mpdY5m0uBd
        VClikuN3OIbrjzw=; b=Q5zbpOEkQ7qbuJ6ktluiGVGb7ETwpMmQybdujnbV99zA
        U0UcNOvwEa9YxH6kUairuX3W3trts6f6zsQB+kVxLWOXUCJSzOeHu0+NhpueXZu1
        S8CiI7qFEevS4UOp211RkF3PD78SuA4SMkjSTVIrZLnG8Bcy7JY6U4kTHPOjTuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JvySRx
        z4ojbMwxnoUEPOZ1enQpntarvpHdZwt1c7IwJplTnY5050yHvyEERlZe/7wDLr8U
        wclVEsrkRyO0WXw9tKwHeYsMaaO8DUJLG6WnIh6V8MEFCEJ9EjT0dAa61oL7+K1B
        wrJ+rII9O2lfbzuHIT+mb+uc4ixCOgLntNvEU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C68134DCC6;
        Wed, 27 May 2020 13:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4491F4DCC5;
        Wed, 27 May 2020 13:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH] reftable: technical documentation link fixes
References: <20200525210232.87550-1-carenas@gmail.com>
        <20200527022142.GB172669@google.com>
Date:   Wed, 27 May 2020 10:14:35 -0700
In-Reply-To: <20200527022142.GB172669@google.com> (Jonathan Nieder's message
        of "Tue, 26 May 2020 19:21:42 -0700")
Message-ID: <xmqqwo4xl2pw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8A5CB3D2-A03D-11EA-A995-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
>> Subject: reftable: technical documentation link fixes
>
> For next time, try to make the subject line summarize what specific
> improvement the patch makes.  For example:
>
> 	reftable doc: use link: and urlencode to avoid dead links
>
>> Showing as broken links in the html version (when using asciidoc 8.6.1=
0)
>> because some of the characters in the url need encoding.
>>
>> Change them to use a explicit "link" and URL encode the problematic
>> charecters (ex: +, =3D, @).  While at it, change the base URL to use
>> lore.kernel.org as has been suggested since 56e6c16394 (Merge branch
>> 'dl/lore-is-the-archive', 2019-12-06)
>>
>> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>> ---
>>  Documentation/technical/reftable.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Will queue at the tip of hn/reftable for now, but post 2.27-final,
we should tentatively eject hn/refs-cleanup out of 'next' and squash
this fix in to the step that originally introduced the problem (and
of course, new version of hn/reftable need to be based on the updated
hn/refs-cleanup topic when it happens).

Thanks, both. =20
