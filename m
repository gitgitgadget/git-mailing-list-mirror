Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7AE202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 15:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965270AbdKGPMr (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 10:12:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65012 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933842AbdKGPMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 10:12:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30E9EAF7E0;
        Tue,  7 Nov 2017 10:12:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8umhWy5YDsNtYJgeVEZxyz4qrsM=; b=VoiHDK
        Qa4o9ilDV6UVXwPyzhS/9byeG9AHpBvrtnivBirXGQMoUlwXGv1DQbr1XvNYXeDe
        0d6JqXTRrPJoM8HjiTlFxcQkNA26aOv3oUsyXwHctTnnSIIqLOqsyZPaClgp2W4S
        7b1YzZhN8EoDZmD7KbwcBAVire/y5kiy6bjTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SGNuUl6pNIg0UTwo0Pd8zBbeoxNtORbl
        mgwG2Krk5+57YUcf9s1eqTm4kg5TPTJKFHsiTqER4gHpVUraEF+nncV55mVzZQrk
        qyJhoZz/5iPTvroQfC0KWk/AD1xDewOrqgL7X8FWMzdgO5ULh4zaBdjJ0jJ5ycmN
        8niSxBSSNQg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2947BAF7DF;
        Tue,  7 Nov 2017 10:12:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99BFBAF7DC;
        Tue,  7 Nov 2017 10:12:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: future of the mediawiki extension?
References: <87vaix731f.fsf@curie.anarc.at>
        <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr>
        <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com>
        <158227903.238854.1510040782947.JavaMail.zimbra@matthieu-moy.fr>
Date:   Wed, 08 Nov 2017 00:12:44 +0900
In-Reply-To: <158227903.238854.1510040782947.JavaMail.zimbra@matthieu-moy.fr>
        (Matthieu Moy's message of "Tue, 7 Nov 2017 08:46:22 +0100 (CET)")
Message-ID: <xmqqefpadswj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BE0A290-C3CE-11E7-B0E5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> I realize I didn't answer this point. The reason you didn't see any
> update recently is just that there haven't been any release and
> actually not much development for a while on git-multimail.

That is perfectly fine.

> I still have a list of "would be nice to have" features, but it seems
> users are essentially happy with git-multimail as it is (or at least,
> aren't unhappy enough to send patches or discuss interesting issues),
> I haven't received any bug report or pull-requests for a long time.
>
> But I still do maintain git-multimail and I will continue updating it
> in git.git.
