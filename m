Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A1C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiA0TDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:03:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60902 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiA0TDC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:03:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AC991068AA;
        Thu, 27 Jan 2022 14:03:01 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=3f42MWS2Jzk2ipe0ppG86UQXz
        2aQiL1RI16jO/4Y9nc=; b=txjS7EatzMBH6h+OTlOWVlF18AHklo+ZFANvEHXUl
        8mbYp8UJobfG8pB4w/aZTgxR1mo+uIhtbEGCpxcqJpkmyhbf13X2wRlnF2WzOhOo
        XzNhEMK98V4uvaVEZyGqAgclGrB+AAkGjhQ4QwIitQwQ+LLMVZHAewbBb3irKJxs
        +A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90C861068A8;
        Thu, 27 Jan 2022 14:03:01 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84ACE1068A7;
        Thu, 27 Jan 2022 14:03:00 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/3] contributor doc update around log messages
Date:   Thu, 27 Jan 2022 11:02:56 -0800
Message-Id: <20220127190259.2470753-1-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-177-g7d269f5170
In-Reply-To: <20220126234205.2923388-1-gitster@pobox.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: BF2FB5A4-7FA3-11EC-8324-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already explain _how_ to write log messages, but did not tell
readers why we care.  Add a few paragraphs to SubmittingPatches
and CodingGuidelines to do so.

Junio C Hamano (3):
  SubmittingPatches: write problem statement in the log in the present
    tense
  CodingGuidelines: hint why we value clearly written log messages
  SubmittingPatches: explain why we care about log messages

 Documentation/CodingGuidelines  |  7 +++++++
 Documentation/SubmittingPatches | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

Range-diff against v2:
-:  ---------- > 1:  b86a706bfd SubmittingPatches: write problem statemen=
t in the log in the present tense
1:  35e39deb7d ! 2:  a65df87939 CodingGuidelines: hint why we value clear=
ly written log messages
    @@ Documentation/CodingGuidelines: code.  For Git in general, a few r=
ough rules are
         go and fix it up."
         Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
     =20
    -+ - Log messages to explain your changes are as much important as th=
e
    ++ - Log messages to explain your changes are as important as the
     +   changes themselves.  Clearly written code and in-code comments
     +   explain how the code works and what is assumed from the surround=
ing
     +   context.  The log messages explain what the changes wanted to
2:  fb54bcfcda < -:  ---------- SubmittingPatches: explain why we care ab=
out log messages
-:  ---------- > 3:  77d918fb98 SubmittingPatches: explain why we care ab=
out log messages
--=20
2.35.0-177-g7d269f5170

