Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00624C433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13252242A
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 10:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgL1Kkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:40:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58022 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgL1Kkk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 05:40:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A51E710EE0E;
        Mon, 28 Dec 2020 05:39:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=O
        apktK0nq/qDd948cxQb+oFpgng=; b=RekrTHIVE0kkC9ZALpt8pfj1faKKPqsao
        5Eq3lKoXNBwzEuxRKFI8qD5n/sm8QoaNFLkSv4vMc4ejivDMGAaugRDTmMYnvMX5
        SOAmIapxn9EDdGWnHjpVPNAy+RnRsR+gvezLIxWTsBSZ6uGGraVP5brbcOmKMxpq
        bOPqCpPFF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=GTG
        5Cn3msTQq6aoEJ67rZjan+tg+bpkkxK2aK/wVmrgLy/a6AVNlpeI2j7iDfjyu9QW
        d0vUjS9W/hDDsQteWsrZ0aQKPGsI7+X/0+6VZtk7T10C/zIp4P4+6+dgvwKrIIoh
        AR/jMWMj3eednXaOSkTW1cswXFG9E+Zzd7kLOvhk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ED4810EE0D;
        Mon, 28 Dec 2020 05:39:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E90EE10EE0C;
        Mon, 28 Dec 2020 05:39:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: tighten wording on "sign-off" procedure
Date:   Mon, 28 Dec 2020 02:39:54 -0800
Message-ID: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06994D48-48F9-11EB-A000-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The text says "if you can certify DCO then you add a Singed-off-by
trailer".  But it does not say anything about people who cannot
certify.  A natural reading may be that if you cannot certify, you
do not add the trailer, but it shouldn't hurt to be overly explicit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index d12094bac5..b091730771 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -307,35 +307,35 @@ wrote the patch or have the right to pass it on under the same license
 as ours, by "signing off" your patch.  Without sign-off, we cannot
 accept your patches.
 
-If you can certify the below D-C-O:
+If (and only if) you can certify the below D-C-O:
 
 [[dco]]
 .Developer's Certificate of Origin 1.1
 ____
 By making a contribution to this project, I certify that:

 a. The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

 b. The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

 c. The contribution was provided directly to me by some other
    person who certified (a), (b) or (c) and I have not modified
    it.

 d. I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.
 ____

 you add a "Signed-off-by" trailer to your commit, that looks like
 this:
