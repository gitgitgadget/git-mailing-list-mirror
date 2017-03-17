Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4DB20951
	for <e@80x24.org>; Fri, 17 Mar 2017 15:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdCQPNe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 11:13:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47217 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751087AbdCQPNa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Mar 2017 11:13:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2ED682045A;
        Fri, 17 Mar 2017 11:12:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Mar 2017 11:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=l5Kgr+/9gcv6p7cX0T
        VMvUWGQcs=; b=iFMuPPKt2Qm1cm1HLctw+7qWOSkTFpYZQ5TKPsytMPf63zXtut
        d3mg/zerk3pm7arcsovveXWP8y7r0/pJlTlGkXgBS4oTWVta8b7sNAsygjYT4uN3
        vSK5UwwOObLNqI/Zbyw2+GiWwQABmvVBeWFHhEcXNLQvuNNZwI5OxaGsxu7zOqTp
        xWF1ca4Od2Bavlxkk1f2qgwWcw5+aFJ+UUqewR35kdKdFm2CYdzUDXIRRRVIW2yH
        TCynS0jy0g9v2z3NmI7dwZMT3FthzSHIqPsyA2jVC8AgH5bJTpLWAx2CMXqaqppN
        SB4Hq6klti/zj4rhAVWHRTBDq54na0JdHPmw==
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=l5Kgr+/9gcv6p7cX0TVMvUWGQcs=; b=h/51kfJM9+X4oxIY9Tt/wDJ3
        pYItzsEQOAkNyqdF1DRr8E9bTlVTWwhXK9lQaW3MXQ8C6HecdE94joHm5OLiUwJ8
        3qXkjka4UB9OSglX070ELbywvoclLaFp53vYVTLP6Ya/t2hz8ColbBaCP9L33R8x
        KDqxtYjzkhDVix1Tk9pKbw7+D74CRWg49HJEtYj74Su7qnzDFph1i4IEPHxKRNm8
        J/kJLRnnD9A0sfbWvY8DIBRzuB2GZWHismm4iWKItwQuTEF44r1zl+RkDrdQCJLu
        2TUCRmMq3lI57HFliF8VMmfXwUemiYhYgm+HlJOYYjzLyVMiBnvS1d6Ta3jilg==
X-ME-Sender: <xms:5fzLWD2Z7PZbdhUKIpII_HiyvrwNdPUSnmthUcId6vLwvbkM0ykmEw>
X-Sasl-enc: V5zvDbSwLkTxcMUAWtyhbSQVgVcBUHuZUVVg+kGYgZFx 1489763556
Received: from localhost (dslb-178-011-152-175.178.011.pools.vodafone-ip.de [178.11.152.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id A84FF240A5;
        Fri, 17 Mar 2017 11:12:36 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 2/2] l10n: de: translate describe debug terms
Date:   Fri, 17 Mar 2017 16:12:33 +0100
Message-Id: <faa3afab66e0cd2f3851c41415ce08aa3c53f42b.1489763302.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.484.g92f9ab2bc1
MIME-Version: 1.0
In-Reply-To: <105f48ad2ae1aa9c88ce6088e6b304294bec0835.1489763302.git.git@drmicha.warpmail.net>
References: <105f48ad2ae1aa9c88ce6088e6b304294bec0835.1489763302.git.git@drmicha.warpmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Junio: this is just a l10n-followup to the previous code patch ;)

 po/de.po | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index e9c86f5488..913db393dc 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7530,7 +7530,19 @@ msgstr "git describe [<Optionen>] [<Commit-Angabe>...]"
 msgid "git describe [<options>] --dirty"
 msgstr "git describe [<Optionen>] --dirty"
 
-#: builtin/describe.c:217
+#: builtin/describe.c:52
+msgid "head"
+msgstr "Branch"
+
+#: builtin/describe.c:52
+msgid "lightweight"
+msgstr "nicht-annotiert"
+
+#: builtin/describe.c:52
+msgid "annotated"
+msgstr "annotiert"
+
+#: builtin/describe.c:249
 #, c-format
 msgid "annotated tag %s not available"
 msgstr "annotiertes Tag %s ist nicht verfügbar"
-- 
2.12.0.484.g92f9ab2bc1

