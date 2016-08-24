Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D4D1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755622AbcHXPp3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:45:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60910 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754045AbcHXPp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:45:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A76834A6A;
        Wed, 24 Aug 2016 11:44:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Zw8fW31odU5o9LJGTIhZ7a4mg8=; b=GMH6TD
        SMyMArqtCO0NQ3nQuo5BTBJ0/f/gkcbes86NhynhfolMq1TaACsRUaboXs8DweDL
        NGdiY/bCC5aQU6RnzsG4qejWRE8ldB7m1yECoa6Ke4NvE2VskB2Im2mJ9Nq1euqY
        0lO1nCBbakXDD3SD9xy/wkHCEzZd8IaT1ZDeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IuiJhYSea+J+7n+H+hE0wQAo+g+V35DX
        5yjtWmw3W3BPre8zCBFpUJW1PHODPvVkYxXQboX3J4gQJTvihkO2A0FkaWf6Xxe7
        MXtC5Jx/WVzlMfQ3SPj06LG0UrCKsYhEnqssihi/5n0eURQB55spV91jMleTbgQ6
        uwuHviL8P2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3278434A65;
        Wed, 24 Aug 2016 11:44:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDCE834A64;
        Wed, 24 Aug 2016 11:44:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] i18n: fix typos for translation
References: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
        <20160821145039.12121-1-jn.avila@free.fr>
        <xmqqk2f7xyfe.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Aug 2016 08:44:48 -0700
In-Reply-To: <xmqqk2f7xyfe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 23 Aug 2016 09:06:13 -0700")
Message-ID: <xmqqwpj6rx1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B197DCBC-6A11-11E6-BBFF-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here comes suggested replacement for 1/3 and 2/3.

Let's not correct "C" in "Cannot" at this stage and leave them to
the next cycle; there are too many of them.

-- >8 --
From: Jean-Noel Avila <jn.avila@free.fr>
Date: Sun, 21 Aug 2016 16:50:37 +0200
Subject: [PATCH 1/3] i18n: fix typos for translation

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 2e9c7d0..3804fa9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -702,7 +702,7 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	if (action != opts->action) {
 		if (action == REPLAY_REVERT)
 		      error((opts->action == REPLAY_REVERT)
-			    ? _("Cannot revert during a another revert.")
+			    ? _("Cannot revert during another revert.")
 			    : _("Cannot revert during a cherry-pick."));
 		else
 		      error((opts->action == REPLAY_REVERT)
-- 
2.10.0-rc1-130-gf5df0f2

