Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E87AC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C360D20719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gbWwgPFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEUsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:48:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54326 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEUsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 15:48:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5011F9987;
        Thu,  5 Nov 2020 15:48:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HWiOYAwotCtY5AzhxNFcgoT1968=; b=gbWwgP
        FAOqjsNao69yoPgkysIXhxCUjBu+volCq+7Xj6gaaRDzh4qENjd9GIDeFcFV3jLR
        qYRfTB5w8XIaKgVstZ+Ym1g4Ss8vsrnMO+++CmZypScUshQLKSfAXDcYijBWcK6p
        oifceSGmz+Ly3+B/vStKBj+SabCSskBdahwlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=db3VQwToyvqaEYdjgEQaFApmHZHsCua5
        zKRMb6W53ZswBxXVthIUkZrnqLfGamYnhGdNXp0+uasc4qOe+hNDVaF/ynz2WAjx
        5aD261+Xdp7cFM48no9tdCWSP/rwrms1sUHTyeZnE+pAlHIDa7AYKTaxnS61B37K
        50GWtHR3ziI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CDF03F9986;
        Thu,  5 Nov 2020 15:48:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12185F9985;
        Thu,  5 Nov 2020 15:48:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marlon Rac Cambasis <marlonrc08@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fixing two trivial typos in Documentation/
References: <20201105091136.GA28535@marlonpc-debian>
        <xmqq4km3k03i.fsf@gitster.c.googlers.com>
Date:   Thu, 05 Nov 2020 12:48:14 -0800
In-Reply-To: <xmqq4km3k03i.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 05 Nov 2020 12:41:37 -0800")
Message-ID: <xmqqr1p7il81.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A78E5EE-1FA8-11EB-8C91-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Marlon Rac Cambasis <marlonrc08@gmail.com> writes:
>
>> Changed "speficied" to "specified" in config.txt and "occured" to
>> "occurred" in githooks.txt. This should help any readers of these
>> files.
>
> Thanks.  Will apply.

I was too fast to respond.

   $ git grep -e speficied -e occured

gives more hits than these two.  We should cover all of them.

--- >8 ------ >8 --- cut here --- >8 ------ >8 ---
From: Marlon Rac Cambasis <marlonrc08@gmail.com>
Subject: [PATCH] doc: fixing two trivial typos in Documentation/

Fix misspelled "specified" and "occurred" in documentation and
comments.

Signed-off-by: Marlon Rac Cambasis <marlonrc08@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt   | 2 +-
 Documentation/git-p4.txt   | 2 +-
 Documentation/githooks.txt | 2 +-
 git-p4.py                  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf706b950e..a3cdeaaa14 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -265,7 +265,7 @@ color::
 The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
 `blue`, `magenta`, `cyan` and `white`.  The first color given is the
 foreground; the second is the background.  All the basic colors except
-`normal` have a bright variant that can be speficied by prefixing the
+`normal` have a bright variant that can be specified by prefixing the
 color with `bright`, like `brightred`.
 +
 Colors may also be given as numbers between 0 and 255; these use ANSI
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index dab9609013..ec233ac0c1 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -417,7 +417,7 @@ p4-post-changelist
 ~~~~~~~~~~~~~~~~~~
 
 The `p4-post-changelist` hook is invoked after the submit has
-successfully occured in P4. It takes no parameters and is meant
+successfully occurred in P4. It takes no parameters and is meant
 primarily for notification and cannot affect the outcome of the
 git p4 submit action.
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 6e461ace6e..2bcf9b539f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -655,7 +655,7 @@ p4-post-changelist
 This hook is invoked by `git-p4 submit`.
 
 The `p4-post-changelist` hook is invoked after the submit has
-successfully occured in P4. It takes no parameters and is meant
+successfully occurred in P4. It takes no parameters and is meant
 primarily for notification and cannot affect the outcome of the
 git p4 submit action.
 
diff --git a/git-p4.py b/git-p4.py
index 4433ca53de..8af92a5a96 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1668,7 +1668,7 @@ def __init__(self):
     Submit after inspect the message file.
 
     The `p4-post-changelist` hook is invoked after the submit has successfully
-    occured in P4. It takes no parameters and is meant primarily for notification
+    occurred in P4. It takes no parameters and is meant primarily for notification
     and cannot affect the outcome of the git p4 submit action.
     """
 
-- 
2.29.2-302-gaa7bd0ae1c

