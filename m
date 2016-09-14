Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5261FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 22:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760345AbcINW5k (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 18:57:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51730 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754608AbcINW5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 18:57:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4ACC3E697;
        Wed, 14 Sep 2016 18:57:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=81LRf1B/bGDGJMB61kBHimJauDA=; b=uIG4qy
        ZQIB0rNtvg4t2c2jlirDyS3EB5icMyydOlvjyb5HozGhtzl6+NZYbuR5nDkP2v5C
        T3DNgF7CKszhVKttKcOn7lCmy3vkxPFZjWGWhz4S+g3+OJ+HL4yHuxv/LSBllMdJ
        d+zUltlZpeZm8m+FO4sXDXWnZKJxXcRVKDZjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CGNz0ft5o1pLgxMZxjOFW9BC9KKq9nei
        cJW5GQvBpij4s1SnFrOdJD4hauDstgwb/afUTzpqXB05MT+vh5OscfCvxm8qipHY
        w8TfJ3ukiTFh7Ww8U0k42hXe5sGv52pRxWSWxm5MR5svyxm48kTbOC2CzCJsNybI
        ztSUumrjc7U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC96C3E696;
        Wed, 14 Sep 2016 18:57:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 454463E694;
        Wed, 14 Sep 2016 18:57:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <20160908011200.qzvbdt4wjwiji4h5@x>
        <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
        <20160908185408.5qtfnztjbastlrtw@x>
        <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
        <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
        <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
        <20160909200721.xfkbud377ja4wkrt@x>
        <xmqqpoocajbb.fsf@gitster.mtv.corp.google.com>
        <20160909210040.zlsczhcotrxnu4e4@x>
        <xmqq7fakai5k.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 14 Sep 2016 15:57:36 -0700
In-Reply-To: <xmqq7fakai5k.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 09 Sep 2016 14:16:07 -0700")
Message-ID: <xmqqmvjaozrz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A21C772A-7ACE-11E6-98D2-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not mind doing it myself, but I am already in today's
> integration cycle (which will merge a handful of topics to
> 'master'), so I won't get around to it for some time.  If you are
> inclined to, please be my guest ;-)

I queued this on top for now; I think it can be just squashed into
your patch.  Please say "I agree" and I'll make it happen, or say
"that's wrong" followed by a replacement patch ;-).

Thanks.

 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index d69d5e6..cd9c4a4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1360,7 +1360,7 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 		return;
 
 	/* Show the base commit */
-	fprintf(file, "base-commit: %s\n", oid_to_hex(&bases->base_commit));
+	fprintf(file, "\nbase-commit: %s\n", oid_to_hex(&bases->base_commit));
 
 	/* Show the prerequisite patches */
 	for (i = bases->nr_patch_id - 1; i >= 0; i--)
-- 
2.10.0-458-g8cce42d

