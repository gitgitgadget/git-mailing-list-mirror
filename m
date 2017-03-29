Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C8220958
	for <e@80x24.org>; Wed, 29 Mar 2017 17:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbdC2Rnv (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 13:43:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50997 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932191AbdC2Rnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 13:43:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28556810BF;
        Wed, 29 Mar 2017 13:43:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sCWHFQ5Uo86PZchrwtgXqdlHDrc=; b=mx5af+
        qI9V8lXusehS0ms3iHVgJuC4cJsYhuAoULa97b0UuffXIDfstrUS/gtTdQVdRrwE
        5UezdbnrfXt2dLLr2wfIDvYSnekR1pxxj6IC3heIp2yqhZk2xEEcFpIBZ/LPZ5Go
        dJEmakTumSM2uRel8XtiwFMA7CuVnoNQaook0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j/7WkuzeDlXQ3GbFvUrnbg2HlbI5/x6i
        5uy/zPGrXkHhW/YzFTbFTcDjR7rzst0qCRCRYZ0df86MWYAYD17gIr0o/SQKQKjg
        YqDaiOlpracUD/5SJOk4hRWAMYqXkWDbIT/LnnImThOf2xpZfAt9kb1sCMxfzLyH
        mhqRMddl7dc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21044810BE;
        Wed, 29 Mar 2017 13:43:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CFC8810BD;
        Wed, 29 Mar 2017 13:43:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 0/3] name-rev sanity
References: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
        <cover.1490798142.git.git@grubix.eu>
        <xmqq4lycatsu.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 29 Mar 2017 10:43:47 -0700
In-Reply-To: <xmqq4lycatsu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 29 Mar 2017 10:15:13 -0700")
Message-ID: <xmqqvaqs9dws.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 439E417E-14A7-11E7-A8CF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The first two applies cleanly to the same base as jc/name-rev that
> the first two of these patches are meant to replace, but the third
> one doesn't apply on top.  Are you depending on something newer?

Ah, of course, you are depending on your other topic ;-)
I'll wiggle these in.

Thanks.
