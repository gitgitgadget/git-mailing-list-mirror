Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91870207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 20:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755473AbcILUqw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 16:46:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57635 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751311AbcILUqv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 16:46:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 307BB3DA7F;
        Mon, 12 Sep 2016 16:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/47HyUOq+xGq
        W5J7w36YRVHGFLU=; b=ALcRQx8OeMZSgRnhEv7f666HHmSJzTY9BK21VA0qdaf1
        YMJip9I9CSSPp3iut3asLdthBSQAK0qEfB4IBA37xqyH5PFDdftHyRosDZROTR8t
        BvOGULTWeZcqTLVcl8Rz8n+hUAgN1q49bv54o02XmU2Ap/codoSEk770QrhTmlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=G+aF5r
        YaGz0+2EYrBcG2j8AhGAxMkSQI4XTnGBPqZmeDTJag+LauEgeZyePGVhnhp2n5Mq
        LHEm70+vmRyZK2aHav6AQnDfdTMEAaD870md2gyGxV+3XsC7MNXuQH0976CI0a+w
        k45UeaQfu/nKnyTOz3ssnDBayz7R8ZLMw4rGY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2909B3DA7E;
        Mon, 12 Sep 2016 16:46:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A719C3DA7C;
        Mon, 12 Sep 2016 16:46:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 12/14] i18n: show-branch: mark error messages for translation
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
        <ba3430ff-9643-eddb-31e7-c1e9a399d806@free.fr>
        <xmqqa8fd3vb5.fsf@gitster.mtv.corp.google.com>
        <17140652.xHVhzLXte8@cayenne>
Date:   Mon, 12 Sep 2016 13:46:47 -0700
In-Reply-To: <17140652.xHVhzLXte8@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Mon, 12 Sep 2016 19:19:55 +0200")
Message-ID: <xmqqlgywzw08.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07274B1E-792A-11E6-A3B7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> ..., and=20
> plural forms can be quite different depending on its value.

AHHhhh, of course you are right.
