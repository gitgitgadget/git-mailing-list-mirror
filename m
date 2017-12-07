Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA8120954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbdLGPbg (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:31:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59714 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754005AbdLGPbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:31:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6041EC0395;
        Thu,  7 Dec 2017 10:31:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8345Lhid4BqL2eZf5qDns2x6Wpk=; b=BvotID
        1G+s7AQay/eOtziXpz4UFhiSiU1eDEgG+nFBgNompdtCS2br2RAynr53tEVgbz/+
        UZI2Wiwx03beLmidhX5YUdAkg7AXpI7DoA6ePW5R/lOL+lqqHusLWdK6bSpplk40
        WbApQGstC6keqtlOeqxgtbVZahkV6AygXp/K0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oVkroZvwzYQF8x88lGHUpQ9bsFcKH7hE
        gauEQi4kld1lqJbJ4HNrQP7Hd+d7dVCx3HSj+ZWGmusqYNm9p1m3Ed+Px6+cPUZA
        y7kFnICFuUFrC/Bw3Ylc87yFJRGlZR8zBWZc2VjmEJiMkVZpPQC/dUaMuZhT7vP0
        1cmSX+eqKrI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E19DC0394;
        Thu,  7 Dec 2017 10:31:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4D88C0393;
        Thu,  7 Dec 2017 10:31:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        "Michael Haggerty" <mhagger@alum.mit.edu>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify triangular workflow
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
        <xmqqwp24iah2.fsf@gitster.mtv.corp.google.com>
        <24f652b96fd940ee91e2741830382a72@BPMBX2013-01.univ-lyon1.fr>
        <q7h9y3meoghn.fsf@orange.lip.ens-lyon.fr>
Date:   Thu, 07 Dec 2017 07:31:33 -0800
In-Reply-To: <q7h9y3meoghn.fsf@orange.lip.ens-lyon.fr> (Matthieu Moy's message
        of "Thu, 07 Dec 2017 13:43:48 +0100")
Message-ID: <xmqqvahieeqy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5460D9C-DB63-11E7-9ECC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> Not a native speaker, but according to wikipedia
> (https://en.wikipedia.org/wiki/Singular_they) it's OK to write
> "maintainer [singular, but already neulral] may get merge conflicts when
> they [sinugular they] ..."

Yes.
