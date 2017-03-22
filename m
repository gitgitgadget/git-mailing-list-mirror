Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA2720323
	for <e@80x24.org>; Wed, 22 Mar 2017 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932208AbdCVUjn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 16:39:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932205AbdCVUjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 16:39:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 995957F563;
        Wed, 22 Mar 2017 16:39:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UpGOfnWUqo9A7TTXzZsH51dGOjY=; b=PcA152
        f1yBXKx4pISPasloWwmtqpCaG/0YwI4QBfAE1XN3T0g+muzKSej07xsMUNbxxQBT
        rvj8bjdeQNUf1gI7FOC/5Pvx3Qp1cqwx1PtzTRuV61o1shWBdMpotgNyYCUTD/e1
        16g565M3lsvySCe/ArfUlbV8l87IzacFFbIk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jDtAWw9+TWEzjj/6IbYGiODxOL+wVoDy
        FsFuytEQPWGqfpC3bwVKVPXqHCAbVG7cfF25g0Gn9l6DyeD8wNjbt2qIi8WDa/Cp
        9CdjURh3pVtobXo0AmcDIUnQmAI1rM7/mnGxhzhHHMpm5AnxFkUaZviGHZO3IwWp
        pqqRyZVjAUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FCEF7F562;
        Wed, 22 Mar 2017 16:39:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E93C17F55F;
        Wed, 22 Mar 2017 16:39:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/6] thread lazy_init_name_hash
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
Date:   Wed, 22 Mar 2017 13:39:20 -0700
In-Reply-To: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Wed, 22 Mar 2017 17:14:19 +0000")
Message-ID: <xmqqa88djbbb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A12F893C-0F3F-11E7-ABA9-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just FYI before I start reading each patch carefully...

Subject: [PATCH 2/6] hashmap: allow memihash computation to be continued
ERROR: trailing whitespace
#28: FILE: hashmap.c:56:
+ */ $

total: 1 errors, 0 warnings, 30 lines checked
------------------------------------------------
Subject: [PATCH 4/6] name-hash: perf improvement for lazy_init_name_hash
ERROR: space required after that ',' (ctx:VxV)
#57: FILE: name-hash.c:38:
+	return find_dir_entry__hash(istate, name, namelen, memihash(name,namelen));
 	                                                                ^

ERROR: do not initialise statics to 0 or NULL
#105: FILE: name-hash.c:157:
+static int lazy_nr_dir_threads = 0;

total: 2 errors, 0 warnings, 516 lines checked
------------------------------------------------
Subject: [PATCH 5/6] name-hash: add test-lazy-init-name-hash
ERROR: do not initialise statics to 0 or NULL
#64: FILE: t/helper/test-lazy-init-name-hash.c:4:
+static int single = 0;

ERROR: do not initialise statics to 0 or NULL
#65: FILE: t/helper/test-lazy-init-name-hash.c:5:
+static int multi = 0;

ERROR: do not initialise statics to 0 or NULL
#67: FILE: t/helper/test-lazy-init-name-hash.c:7:
+static int dump = 0;

ERROR: do not initialise statics to 0 or NULL
#68: FILE: t/helper/test-lazy-init-name-hash.c:8:
+static int perf = 0;

ERROR: do not initialise statics to 0 or NULL
#69: FILE: t/helper/test-lazy-init-name-hash.c:9:
+static int analyze = 0;

ERROR: do not initialise statics to 0 or NULL
#70: FILE: t/helper/test-lazy-init-name-hash.c:10:
+static int analyze_step = 0;

ERROR: trailing whitespace
#215: FILE: t/helper/test-lazy-init-name-hash.c:155:
+^I^I^Ielse $

total: 7 errors, 0 warnings, 278 lines checked
------------------------------------------------
