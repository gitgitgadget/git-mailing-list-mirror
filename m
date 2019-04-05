Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB7720248
	for <e@80x24.org>; Fri,  5 Apr 2019 22:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDEWvb (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 18:51:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60982 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfDEWv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 18:51:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EEC3578DD;
        Fri,  5 Apr 2019 18:51:29 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=lzUZR/cTIV3N8esgk+PQWeFTh
        ak=; b=idwWnywMRVMEmdxbai3CB+ZpzNaq/f0c+wAwTLiqJdx4GKkqE//SUDpvz
        +o0a+Vszg62wm8k1tvfPoNlUP+2Giinb2yuFdmIADW/kTbLOq2pGd0oxMxIFxGRk
        W2JG874Z7ZJNgid/a/vhkuUV58IJSffsL3UoscXWIhfgwGDOcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=kdaa1K9yMQxM8PMumiK
        5csBAwyaQRMJYicjMZ6yaKfBma/SW0DDL6P8PBCvUtAn8Cf4F99gtnPyVrZaT89F
        EoD4rGdl2RUbndCHwD+KOEOFexIS8AMYHQOi9aQvbUBZ4xcQavuBRqPbO1Zjug2F
        3N5BFq/3b9WS/xXEg+DY1gp0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58B91578DC;
        Fri,  5 Apr 2019 18:51:29 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C99E4578D4;
        Fri,  5 Apr 2019 18:51:24 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] Documentation/git-svn: improve asciidoctor compatibility
Date:   Fri,  5 Apr 2019 18:51:15 -0400
Message-Id: <20190405225115.3882-3-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
References: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 57D81C12-57F5-11E9-8799-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second paragraph in the CONFIGURATION section intends to emphasize
the word 'must' with bold type.  Adjust the formatting slightly to
provide similar results between asciidoc and asciidoctor.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I debated changing 'must' from bold to italic in this hunk.
There are two other emphasized uses of 'must' in git-svn.txt.
One is bold and one is italic.  So I left this one bold and
simply adjusted the "'" quotes to "`" around the "*" and ":"
characters.  This is the more minimal fix to keep the output
rendered the same in asciidoc and asciidoctor.

 Documentation/git-svn.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b99029520d..81aaef8e4e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1100,10 +1100,10 @@ listed below are allowed:
 	tags =3D tags/*/project-a:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
=20
-Keep in mind that the '\*' (asterisk) wildcard of the local ref
-(right of the ':') *must* be the farthest right path component;
+Keep in mind that the `*` (asterisk) wildcard of the local ref
+(right of the `:`) *must* be the farthest right path component;
 however the remote wildcard may be anywhere as long as it's an
-independent path component (surrounded by '/' or EOL).   This
+independent path component (surrounded by `/` or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using 'git config'.
=20
