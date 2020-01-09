Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6CDC33C9E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 02:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C26206F0
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 02:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NJ0rJVsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgAICGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 21:06:50 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:64371 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgAICGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 21:06:50 -0500
Date:   Thu, 09 Jan 2020 02:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1578535608; bh=9RTi+/TwcpyfR+zJu2L2zptihqqYnpQ+t9lSHP5a5jU=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=NJ0rJVsqx9B73Xu2zGaIvUla2AIf/rmulbso2mbgGQCm1R25q/LLUgpysyXkFv54w
         3zYl8J/X2j4WR5HqYhp10geJMHm7CsrfVgi4HmZwK6Qxv8Fxxq7itYnhnTnEXXvIoa
         5g3Z7wpWaZ7pwUOqc5RKMPyWzxa5l6EipZcDxlaLD2SpgBU/bauPXBz0LYxv/rYpck
         Ny0oIGVznHwJjkjgjc/HH1g6SQWCG9/uVUwH/GxGJXI4AH6oKTqmyg0VgraiotDMFT
         vVTAX74eMcmPRtKLNFEVMkAwMhiU/2NVi6G0cCDMsnLl9NsTurYuuM0A/ugsVN3h7y
         LP4hvcTw37kQA==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Tymek Majewski <tmaj@pm.me>
Reply-To: Tymek Majewski <tmaj@pm.me>
Subject: How log log a feaure request
Message-ID: <l0W9VY7TaoqT51RecilbNNTaX35RiCNlJtZKcz04cyKexuG06-bZMlwfor5kCvnIHRRWE7s8TSJLwvA-w4-1poMV_gle8iOzd3-wzFVDUh0=@pm.me>
Feedback-ID: cDgLEjRlB9iev_kPU1dIij15-W8uLl_dnplGiO_s8chZSuXPY1p2lWmI9dJdw90cgur8s4da-X7nNf2ScREvxQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello gurus!

I looked at https://git-scm.com/community but I failed to find a place to s=
end feature requests to.

Q: How to submit a feature request (rather than a bug)?

----

What is the feature request?

Change git checkout's
"Your branch is up to date with 'origin/branch_name_here'"
(and similar messages)
to
"Your branch is up to date with the *local* branch 'origin/branch_name_here=
'"

Reasoning:

I believe that if the git checkout message
"Your branch is up to date with 'origin/branch_name_here'"
was
"Your branch is up to date with the *local* branch 'origin/branch_name_here=
'"
it would make it clearer to new users what is happening.


Cheers
Tymek
