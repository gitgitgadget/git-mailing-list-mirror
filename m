Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF6C6FA82
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 06:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIPGXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 02:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIPGXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 02:23:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EA3A2216
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 23:23:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E976A1BD19E;
        Fri, 16 Sep 2022 02:23:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=yt5QcHjAxAR3vdR+ujM7hXwAI
        AJG4F0o+B5F3lE9DLk=; b=aBQpwx7TNhTKqHTrXc4xFNzXqglLu4+YQXSKvaxSn
        GEg7Jivo3W+xIdN1bmmb62YaEfCB3wbgIjAsf74EQJvR4s4ENpmZ5YN5B+CBoaMd
        yRnMYoNj6TQAnZJM7QZLjHXKov0H1zpqEg6MdULQ8DvbikMdLuDe1KWOszHJAV4a
        QQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E27321BD19D;
        Fri, 16 Sep 2022 02:23:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 669261BD19C;
        Fri, 16 Sep 2022 02:23:29 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] api docs: link to html version of api-trace2
Date:   Fri, 16 Sep 2022 02:23:03 -0400
Message-Id: <20220916062303.3736166-2-tmz@pobox.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220916062303.3736166-1-tmz@pobox.com>
References: <20220916062303.3736166-1-tmz@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 153C7F8C-3588-11ED-9B94-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f6d25d7878 (api docs: document that BUG() emits a trace2 error event,
2021-04-13), a link to the plain text version of api-trace2 was added in
`technical/api-error-handling.txt`.

All of our other `link:`s point to the html versions.  Do the same here.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
This is minor, but I noticed it while working on the previous patch.  The
effect can be see at [1] where we link to [2].

Somewhat related, it also appears that the link to the API docs in the "F=
urther
documentation" section on git-scm.com is broken entirely[3].  I didn't tr=
y to
chase down why that might be, but perhaps someone who knows the site buil=
d
process can fix it up.

[1] https://mirrors.edge.kernel.org/pub/software/scm/git/docs/technical/a=
pi-error-handling.html
[2] https://mirrors.edge.kernel.org/pub/software/scm/git/docs/technical/a=
pi-trace2.txt
[3] https://git-scm.com/docs/git#_further_documentation

 Documentation/technical/api-error-handling.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentati=
on/technical/api-error-handling.txt
index 70bf1d3e52..665c4960b4 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -46,7 +46,7 @@ parse-options.c.
   returns -1 after reporting the situation to the caller.
=20
 These reports will be logged via the trace2 facility. See the "error"
-event in link:api-trace2.txt[trace2 API].
+event in link:api-trace2.html[trace2 API].
=20
 Customizable error handlers
 ---------------------------
