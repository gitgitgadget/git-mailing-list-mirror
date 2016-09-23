Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45BF6207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 19:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbcIWT5a (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 15:57:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60806 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751710AbcIWT53 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 15:57:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45D6A3FE1A;
        Fri, 23 Sep 2016 15:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DK4yKjkiFGOM
        2wu6eFl4ALrnnkk=; b=MgmE0pM/XsklUsTvJ25GzUdp8TCTmpULUm8sXnR37cpR
        TjlBJagwNJwQoSePeS+MvaFQEDbMl3mgQZ/iNawb0Rr18vkU9HVqOnXNbvllSsip
        /L78hhurevK1lZqUVblkhbdAL+Rz9043o7GPDeZ9XMCZm2NlrorMIqQCmxCyOAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nOHD+l
        6ZLCE5zdNDu3lmwtO9kbsoFZHpI+HntGFFUlqqwWmRHvbiY9V7I9KXwsaAFU+hDO
        KV0BAz4aRKS28NXHR0OJF2I+9sbu+qwZ2kUA/ucZEfS5GGc/pxf04alDBfWwwBN7
        9UmEYM2P4IMoM+4UVPqmkrKBdEnaY/rqE7YhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BF2F3FE19;
        Fri, 23 Sep 2016 15:57:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5DBA3FE18;
        Fri, 23 Sep 2016 15:57:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] gitweb: remove unused function parameter
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
        <20160923090846.3086-1-ian@iankelling.org>
        <4a616b43-cd22-e2fe-6085-a65c48687560@gmail.com>
Date:   Fri, 23 Sep 2016 12:57:25 -0700
In-Reply-To: <4a616b43-cd22-e2fe-6085-a65c48687560@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 23 Sep 2016 21:44:56
 +0200")
Message-ID: <xmqqwpi2z8wq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F43EFF1E-81C7-11E6-BDE2-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> I think it would be better to be more descriptive, and say:
>
>   Subject: [PATCH v3 1/2] gitweb: remove unused parameter from guess_fi=
le_syntax()
> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

Thanks.
