Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D420C1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeKNDLd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Nov 2018 22:11:33 -0500
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21337 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeKNDLc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 22:11:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542129152; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=AORKo/RJNc5RbK+UNVLXORibL3pK6SnJ/8jToqOZijO2DeFgYSY0Txf57Ax20oBi8WakkIgL/e9kxtZUzxbzAimR08Uqim74sC8iBw1ID0W0p0iyMj5l3GPsXuXXhTWLRgS2djHUaqPbfM/pyN4ZlytDD5VXwSA+9Ossr1yBXgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542129152; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=PfULn1701fnA4WLM6dHiVUd6Eo04RrRsfmq3UjdKLwE=; 
        b=IKuxX01Nad1MobtStcpXlHtHfoyrf87gZk3Tw3hnGcrCioAu0WZP9DNIBCdM7VOKvTpbjsv3vTHtgHvaLVvGI+FplrG2ymQ/azig0FU/jI7pgqAZjniL7oDGl9L+8dE00LVp+wdOB6qERKERdsCteUFEXZdzhaMw3dLjivHWWXg=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=carminezacc.com;
        spf=pass  smtp.mailfrom=carmine@carminezacc.com;
        dmarc=pass header.from=<carmine@carminezacc.com> header.from=<carmine@carminezacc.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1542129151973335.9193979435787; Tue, 13 Nov 2018 09:12:31 -0800 (PST)
Date:   Tue, 13 Nov 2018 18:12:31 +0100
From:   Carmine Zaccagnino <carmine@carminezacc.com>
To:     "git" <git@vger.kernel.org>
Cc:     "marcopaolone" <marcopaolone@gmail.com>
Message-ID: <1670e0f6fe4.e39bb5cf263071.2511867790961882485@carminezacc.com>
Subject: [PATCH] po/it.po: Remove space between the dashes and start of an
 option's name in the Italian translation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a really trivial change, but it is quite annoying to see this

diff --git a/po/it.po b/po/it.po
index 908021944..4d87faeee 100644
--- a/po/it.po
+++ b/po/it.po
@@ -566,7 +566,7 @@ msgstr "è già in corso un'operazione di cherry-pick o di revert"
 
 #: sequencer.c:740
 msgid "try \"git cherry-pick (--continue | --quit | --abort)\""
-msgstr "prova \"git cherry-pick (--continue | --quit | -- abort)\""
+msgstr "prova \"git cherry-pick (--continue | --quit | --abort)\""
 
 #: sequencer.c:744
 #, c-format


