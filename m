Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285D32070F
	for <e@80x24.org>; Wed,  7 Sep 2016 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934626AbcIGIUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 04:20:42 -0400
Received: from forward19p.cmail.yandex.net ([77.88.31.22]:34796 "EHLO
        forward19p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934111AbcIGIUj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 04:20:39 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Sep 2016 04:20:39 EDT
Received: from mxback2j.mail.yandex.net (mxback2j.mail.yandex.net [5.45.198.16])
        by forward19p.cmail.yandex.net (Yandex) with ESMTP id 7E170217C3
        for <git@vger.kernel.org>; Wed,  7 Sep 2016 11:13:09 +0300 (MSK)
Received: from web8j.yandex.ru (web8j.yandex.ru [5.45.198.49])
        by mxback2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id c980T1TUEF-D9xS5RsO;
        Wed, 07 Sep 2016 11:13:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1473235989;
        bh=Y/NVdOZkmftNZCiMNbA7cu5P4sEYOx7/kPfgX/7xznw=;
        h=From:To:Subject:Message-Id:Date;
        b=n3rapGHrsFCO2/3c1odc2ts2+5MB+A6IvyXQEMsj22hwKD9r9a5V0dvyeKOL5yeJ3
         bCzcWyckvnfvK+PRb/6iLM0030EnIDpPEe9y6TZQuINDeZOM+gGsY97ekCOcxnugIn
         AmLCP8bewEi98qH67WQ1/Zr28UGNg1mN1XZ19uTc=
Authentication-Results: mxback2j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web8j.yandex.ru with HTTP;
        Wed, 07 Sep 2016 11:13:09 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: Why patch is not showed at log?
MIME-Version: 1.0
Message-Id: <46301473235989@web8j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 07 Sep 2016 11:13:09 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have patch:
diff --git a/t b/t
index ced22c4..992533b 100644
--- a/t
+++ b/t
@@ -1,2 +1,2 @@
 asdf
-asdf
\ No newline at end of file
+asdf

When I commit it I do not see it at log:

commit 1efee9908a734c40194ffc07e7793afd2e386fbc
Author: x
Date:   Wed Sep 7 11:09:04 2016 +0300

    asdf


commit 4f429665850cb929f73f1463bedd978dd8b68009
Author: x
Date:   Wed Sep 7 11:05:20 2016 +0300

    asdf

diff --git a/t b/t
new file mode 100644
index 0000000..ced22c4
--- /dev/null
+++ b/t
@@ -0,0 +1,2 @@
+asdf
+asdf
\ No newline at end of file

Why I do not see changes at log when 'new line' was added at the end of file?
