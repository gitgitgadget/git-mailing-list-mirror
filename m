Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C0F20323
	for <e@80x24.org>; Wed, 22 Mar 2017 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdCVUIK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 16:08:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63992 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751027AbdCVUII (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 16:08:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 535707BAA1;
        Wed, 22 Mar 2017 16:08:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=3PdP
        s3rULopso8nHKS/fheh4y2A=; b=HFZCyEekJiYOXfwqsIUNuVQFGPowBYWh1HF1
        vGtaWMpNenl7rr0bdPZAlUT2DL1tdWBuE2kmu6oufN+h5EbBhsnyUoVqpERnxRAa
        eFB1f+0+uPbNSaHmTfSejzT/1jVKdUlvXRa3sTU9n87WSBnozgOaGJeGF3rNQ924
        xy99KUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        Gvxxm9xCcsRUvIdry6G9gmFWGGPHI0sFBdGgUcub4Cl9Q578JzGERsa0lOmgPyHy
        lOlEFr7tHf75PfjLOgkd8YScerBvcdZ2c7dm9XbcJ9X2Oomci4+Uyk5CovEE1Ov+
        tF3Ji64wl3NAqNS3OXz8LToUgBapDMdQkcL3ArUFcPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C6187BAA0;
        Wed, 22 Mar 2017 16:08:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B16FD7BA9F;
        Wed, 22 Mar 2017 16:08:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jan Palus <jan.palus@gmail.com>
Subject: [PATCH 0/3] fix "here-doc" syntax errors
Date:   Wed, 22 Mar 2017 13:08:02 -0700
Message-Id: <20170322200805.23837-1-gitster@pobox.com>
X-Mailer: git-send-email 2.12.1-430-gafd6726309
In-Reply-To: <20170322173528.ho43ulndlozq35tu@kalarepa>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
X-Pobox-Relay-ID: 43762E1C-0F3B-11E7-B894-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because I'd prefer to be able to queue fixes on individual topics
that introduced the breakages, I splitted the fixes in your two
messages into three patches.

Please respond to the list, saying it is OK to add your "sign-off"
(see Documentation/SubmittingPatches) to these patches.

Thanks.

Jan Palus (3):
  t5615: fix a here-doc syntax error
  t7406: fix here-doc syntax errors
  t7004, t7030: fix here-doc syntax errors

 t/t5615-alternate-env.sh    | 1 +
 t/t7004-tag.sh              | 8 ++++----
 t/t7030-verify-tag.sh       | 8 ++++----
 t/t7406-submodule-update.sh | 4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.12.1-430-gafd6726309

