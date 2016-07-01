Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E742018A
	for <e@80x24.org>; Fri,  1 Jul 2016 23:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbcGAXr7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 19:47:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752457AbcGAXr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 19:47:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 328032A636;
	Fri,  1 Jul 2016 19:47:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=TVyO12
	VMl2hM5J3s337NCWr0R5qw1EPeG90+oL1x1WSAhzMSSDIZJ8vhWVlmz74GB1VE6a
	waFWGBFuJtevm4t8ytUW1fzDDUvU6Zbq+6zKTJ3/8qFVqF+WlkD1rppDYmuEM29f
	gFQ6lgAuX2hQxsaYsyIaKb56WSz5q9Yhxtg7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RvgtydhiedtFROG0VzjWEl1egzChC/P+
	tXoZuPkqHoyk8Silr8fWymxHyUjNptyHdzEIgoe1rvtQHqy24tFANw+OZ0BLeMPz
	6zcXjHvQkJjwYNzcy3NrLhFIhs9HKlbA6P9SuHAogHhum9JKcSJ4JfONhHkGRi8J
	igF/I6xvG9o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ADFA2A635;
	Fri,  1 Jul 2016 19:47:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF0332A634;
	Fri,  1 Jul 2016 19:47:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] t5541: become resilient to GETTEXT_POISON
References: <1467304470-27781-1-git-send-email-vascomalmeida@sapo.pt>
	<1467305358-12440-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Fri, 01 Jul 2016 16:47:20 -0700
In-Reply-To: <1467305358-12440-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Thu, 30 Jun 2016 16:49:18 +0000")
Message-ID: <xmqqr3bcvs3b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27FC96DC-3FE6-11E6-B812-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks, will queue.
