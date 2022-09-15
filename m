Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1E7ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIOSB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOSB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 14:01:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891813E93
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 11:01:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9E891B12E6;
        Thu, 15 Sep 2022 14:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pCHZ/nUuyo4EfGDUMATaIuh52kzPluCqwM84Qa
        Q9K8Q=; b=x87s/XJjApJn0V3WZNF0LUqm5UQakUkEuyBL1XJVWJJqcRzgKHCrMM
        DY+/A/1nXNrz+QGVTH4tnRYJ0N3u0AEELJ1MTtxZa8SuTegxIQyF0bqJsA1z8IPq
        yO9bODbvT/BO1rIA8KKCBw3zzs0nBtx0+jrXmBe3ns7pKpYCn3KRU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C38BD1B12E4;
        Thu, 15 Sep 2022 14:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 60C5A1B12DF;
        Thu, 15 Sep 2022 14:01:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Conners <business@elijahpepe.com>
Cc:     "git" <git@vger.kernel.org>, "hanwen" <hanwen@google.com>
Subject: Re: [PATCH v2] reftable: use a pointer for pq_entry param
References: <1833f3928cb.acf3c97d869879.7909589521159235166@elijahpepe.com>
Date:   Thu, 15 Sep 2022 11:01:50 -0700
In-Reply-To: <1833f3928cb.acf3c97d869879.7909589521159235166@elijahpepe.com>
        (Elijah Conners's message of "Wed, 14 Sep 2022 20:37:34 -0700")
Message-ID: <xmqq1qsco6sx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 799FFFFC-3520-11ED-993D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmph.  I do not know what went wrong.  Somebody between your "git
format-patch" and the mailing list archive ate tabs and spitted out
spaces, it seems.  I'll try to fix it up.

Thanks.

$ git am -s ./+ec
.git/rebase-apply/patch:13: indent with spaces.
                               .rec = rec,
.git/rebase-apply/patch:14: indent with spaces.
                               .index = i,
.git/rebase-apply/patch:15: indent with spaces.
                       };
.git/rebase-apply/patch:17: indent with spaces.
                       merged_iter_pqueue_add(&mi->pq, &e);
.git/rebase-apply/patch:18: indent with spaces.
               }
error: patch failed: reftable/merged.c:36
error: reftable/merged.c: patch does not apply
error: patch failed: reftable/pq.c:71
error: reftable/pq.c: patch does not apply
error: patch failed: reftable/pq_test.c:46
error: reftable/pq_test.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: reftable: use a pointer for pq_entry param
Patch failed at 0001 reftable: use a pointer for pq_entry param

