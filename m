Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43E6202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbdCOQHk (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 12:07:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51257 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751972AbdCOQHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 12:07:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B3E37BE5F;
        Wed, 15 Mar 2017 12:07:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nXQ/uOV6MzH7
        gkGcyNTxwC8bX9o=; b=I6SFE9ntsMi1kfr0ILKZdoe+8nBgi7Zx/PoGNWgL6W5T
        yh2m56RKKvYBwLA8q0UugbtygRm4HUjVj0RyEA4ITifF/zP37DCBZzuEEF1bJAFB
        SrfYNk0nnOCSZ/gFsfWi2ia4csxpNuWWhHhLw9k+7zapcRcqo2EaoN4biS28nJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fDPZdF
        6zTajjPScniHbq5o/2/rUFE3dTQWhG7Auvs7UrX2cQhA6gp7C71bGrM/MB/5SVmk
        Np1vSwy9D6gc66Vq8KVw2jQVd1WBXxpiLv/2x/RJoaRHHTbooek90VTFk4/8M+7D
        sEwyFkDw6OTKPLqVuxvtVJG2OFVeK9FyrpqMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 648737BE5E;
        Wed, 15 Mar 2017 12:07:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C270F7BE5D;
        Wed, 15 Mar 2017 12:07:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170312200248.3610-2-jn.avila@free.fr>
        <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
        <0ae83f7f-e178-31b3-87ea-324e3f00d469@free.fr>
Date:   Wed, 15 Mar 2017 09:07:17 -0700
In-Reply-To: <0ae83f7f-e178-31b3-87ea-324e3f00d469@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Wed, 15 Mar 2017 08:58:51 +0100")
Message-ID: <xmqqr31yfrre.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76EEF028-0999-11E7-92A2-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Le 13/03/2017 =C3=A0 01:01, Junio C Hamano a =C3=A9crit :
>> +#. type: Plain text
>>> +#: git-add.txt:15
>>> +#, no-wrap
>>> +msgid ""
>>> +"'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--inter=
active | -i] [--patch | -p]\n"
>>> +"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update |=
 -u]]\n"
>>> +"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-=
missing]\n"
>>> +"\t  [--chmod=3D(+|-)x] [--] [<pathspec>...]\n"
>>> +msgstr ""
>>> +"'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | =
-p]\n"
>>> +"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update |=
 -u]]\n"
>>> +"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-=
missing]\n"
>>> +"\t  [--] [<chemin>...]\n"
>> This shows that even after adding just _one_ new option to the
>> ...  A mere single
>> rephrasing of a word in a large paragraph would have to result in
>> the entire paragraph to be translated again?
>
> I'm not sure to clearly understand your point: if there is the
> introduction of a new option, there is a need to update the translation
> for sure.

You probably are used to po4a well enough to accept "the smallest
unit of translation is paragraph" as a natural given, and it may be
an acceptable way to work for those who actually do the translation.

Because I am not used to po4a and I don't do translation, "why I
have to update the above translation of the whole paragraph, in
response to a patch to rename just a single option", e.g.

	-	[--edit | -e] [--no-]all | --[no-]ignore-removal | [--update | -u]]
	+	[--edit | -e] [--no-]all | --[no-]ignore-removal | [--modify | -m]]

was a natural reaction for me.  In any case, I won't be doing the
translations, and those who work with po4a are happy with the tool,
that is fine by me.

