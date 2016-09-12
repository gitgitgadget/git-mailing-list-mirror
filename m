Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2234207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 16:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbcILQET (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 12:04:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56996 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751099AbcILQES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 12:04:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EFC43D77C;
        Mon, 12 Sep 2016 12:04:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=klt9RcAmht80EKEyqb3wAs89KXg=; b=Eh9K8A
        h1x0a1bsieNzCNaX2plsIdflRzC3ZQjCYWZ9M06P/KVcGjhDkjSR+uyYeneMjy+w
        W09GASSf1xA9KkKB0C4eKLbI26DvKY2DH0N6obI64JPXzFk0QUeO5DIZbaWbDSAT
        DnDcG45ZX2xVkUtfYVNpjrELabaD2ti48aidM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cH+DIGwkt1IjRJeF6MSRIWEihwR3lBvG
        6DdLzSE7CJbGerAn/4gkuDSQFUnMvzNNCvXPJ+GcrvoG+HRzi2Y4k2QN8orOLM4Y
        c1taZAvVqExgRzPn1xzv09v7SKNad7QP9KDd58Zu5Pt6h8ynjYXUaGX1yjBed1Ci
        dAkHS/8bpmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 369A93D77B;
        Mon, 12 Sep 2016 12:04:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB14E3D77A;
        Mon, 12 Sep 2016 12:04:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v2 07/14] i18n: merge-recursive: mark error messages for translation
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
        <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
        <1473679802-31381-7-git-send-email-vascomalmeida@sapo.pt>
Date:   Mon, 12 Sep 2016 09:04:14 -0700
In-Reply-To: <1473679802-31381-7-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Mon, 12 Sep 2016 11:29:55 +0000")
Message-ID: <xmqqinu13y0x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E64DEFC-7902-11E6-9FF0-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Lowercase first word of such error messages following the usual style.

"Change X to lowercase" is fine, but "Lowercase" is not a verb.

Reword it to "Downcase the first word...", perhaps (not limited to
this step).
