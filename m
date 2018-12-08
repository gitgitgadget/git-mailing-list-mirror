Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AD020A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 00:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLHA0L (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 19:26:11 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:49366
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbeLHA0L (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Dec 2018 19:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1544228769;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=nZ+1QJF60dVX9JNYxxx532HZsUmU1e3G+GqjoPvIOzs=;
        b=GhhlhzaVythMuZJUzi4hX6RpgpdziYKb5rs38x/hJFptpmY7S79b/Z41EcoVpQag
        ifacNJ9fkj2HPvjSxq6lMTrFkU4EskKn4GpNn4SNgRTtbVRLCZvSvqkBeLtYITduQ8v
        yE0/CrsgoGqISTvY4hGeTsmVIoKVVmzUd88arfHk=
From:   Frank Dana <ferdnyc@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201678b350faa-868bbac4-9242-427a-9d3b-fc6f00a95270-000000@eu-west-1.amazonses.com>
Subject: [PATCH] docs/gitweb.conf: config variable typo
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 8 Dec 2018 00:26:09 +0000
X-SES-Outgoing: 2018.12.08-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the feature 'snapshot' claimed
"This feature can be configured on a per-repository basis via
repository's `gitweb.blame` configuration variable"

Fixed to specify `gitweb.snapshot` as the variable name.
---
 Documentation/gitweb.conf.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index c0a326e3883c3..40c9563ef67af 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -684,7 +684,7 @@ compressed tar archive) and "zip"; please consult gitweb sources for
 a definitive list.  By default only "tgz" is offered.
 +
 This feature can be configured on a per-repository basis via
-repository's `gitweb.blame` configuration variable, which contains
+repository's `gitweb.snapshot` configuration variable, which contains
 a comma separated list of formats or "none" to disable snapshots.
 Unknown values are ignored.
 

--
https://github.com/git/git/pull/562
