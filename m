Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A0C433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 23:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiAZXmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:42:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53552 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiAZXmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 18:42:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6A1116C66A;
        Wed, 26 Jan 2022 18:42:10 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=iAzT7Va5ggcxPKV25KFM5y5Jv
        jz8h+SPLFBxoJblCBw=; b=fat5x53Qob16kg9hQaVsO3t32BMmMmWGFp55DusO6
        nbzEYPrOBnNB1XXm7X88pS2hAAiJ1iz7amjBtPK3LZbkd1Z/gqpU7d2mO6PDDONl
        BLCr3URfoLAMtc2OZPu0I4YzPXSEnVb3k3yrvAuSEjl4Y8NnbcH+IksI4J76bZkz
        q0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE31116C669;
        Wed, 26 Jan 2022 18:42:10 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17BC216C667;
        Wed, 26 Jan 2022 18:42:07 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/3] contributor doc update around log messages
Date:   Wed, 26 Jan 2022 15:42:02 -0800
Message-Id: <20220126234205.2923388-1-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-168-gb86c5231e1
In-Reply-To: <xmqqilua89z5.fsf@gitster.g>
References: <xmqqilua89z5.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 927E7416-7F01-11EC-A721-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is an updated "our 'present' is before the patch is applied in
the log messages" patch, together with a couple of changes to
explain _why_ we care about your log messages.

Hopefully by knowing whom they are trying to help with their log
messages, our contributors will be able to write a more useful
proposed log messages when they send their patches to the list.

Junio C Hamano (3):
  SubmittingPatches: write problem statement in the log in the present
    tense
  CodingGuidelines: hint why we value clearly written log messages
  SubmittingPatches: explain why we care about log messages

 Documentation/CodingGuidelines  |  7 +++++++
 Documentation/SubmittingPatches | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

--=20
2.35.0-155-g0eb5153edc

