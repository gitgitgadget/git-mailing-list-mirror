Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299FAC33CB1
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 14:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD96206D5
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 14:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="q750Hvab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgANOsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:48:09 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:40042 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgANOsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 09:48:09 -0500
Date:   Tue, 14 Jan 2020 14:48:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579013287;
        bh=ctcuwlXVGm7s6pKnBA6pKWkuE2g9xLXkOlXsb7kJzSA=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=q750HvabxR9wbHWbU3/DkeOWoME1ddX4thvRwnz+h4Y9ByaI5Bp8E+BLr7Q4ZH29F
         brI83Ep6JxEgiHmetLlrZKKIhLtP4ApAlN7lMfIL9FPzTfcj8OWWeeV5Na3Z3+a1pZ
         idevwNa/tlTuQKrTi3sBHM+/1DFL3hdFxtlGUR5E=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   1234dev <1234dev@protonmail.com>
Reply-To: 1234dev <1234dev@protonmail.com>
Subject: Can Git repos be hacked or otherwise manipulated?
Message-ID: <fOv65WlolaWZ638trkwZ6nnWIaRu14wx8bYkLdqzidlHPvhYpg1f6TSa_Z7w7iFEsXSLkMzQ6EYTwo3ggF3oXrDh5U4LM_i2Rzx0BkMh7zI=@protonmail.com>
Feedback-ID: jm_lYfXrrNlRjeoYk2ubMr1Ofg3d6jxZVz74GfYfMumLfq3Q9_Z5n8vqkvDBYWSlKkQ9TIGL2Vvi-4DSzBFTyQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Let's say you're working with a team of elite hackers, passing a tarball of=
 a Git repo back and forth as you complete your mission. Now let's say one =
of them has malicious intent. What are the possibilities that he or she can=
, for instance, hide changes made to a script or binary that does something=
 malicious if executed? Or perhaps maybe there are other such scenarios one=
 should be made aware of?

Thanks and have a nice day!

--Jonathan

Sent with ProtonMail Secure Email.
