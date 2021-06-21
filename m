Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662EC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34B16102A
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFUTpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:45:22 -0400
Received: from hekla.abc.se ([158.174.61.227]:33153 "EHLO hekla.abc.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFUTpV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 15:45:21 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 15:45:21 EDT
Received: from perkele.intern.softwolves.pp.se (cm-84.209.28.28.getinternet.no [84.209.28.28])
        by hekla.abc.se (OpenSMTPD) with ESMTPSA id a69808c0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Jun 2021 21:36:26 +0200 (CEST)
Date:   Mon, 21 Jun 2021 20:36:25 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: [L10N] l10n: fixed tripple-letter typos
In-Reply-To: <20210621020740.25577-1-worldhello.net@gmail.com>
Message-ID: <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
References: <20210621020740.25577-1-worldhello.net@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin:

> Andrei found that the word "shallow" has an extra letter "l" in
> "po/zh_CN.po". There are similar typos in other l10n files.

Andrei also pointed out another typo in the Swedish translation, where 
a configuration option had been copied incorrectly. Could you please 
amend your patch to contain both these changes?


From: Peter Krefting <peter@softwolves.pp.se>
Date: Mon, 21 Jun 2021 20:31:28 +0100
Subject: [PATCH] l10n: sv.po: Update Swedish translation

Fix mistakes reported by Andrei Rybak <rybak.a.v@gmail.com>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
  po/sv.po | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index 4a9f2f3aca..954efd23bf 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8,7 +8,7 @@ msgstr ""
  "Project-Id-Version: git 2.32.0\n"
  "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
  "POT-Creation-Date: 2021-05-17 16:02+0800\n"
-"PO-Revision-Date: 2021-05-20 13:31+0100\n"
+"PO-Revision-Date: 2021-06-21 20:31+0100\n"
  "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
  "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
  "Language: sv\n"
@@ -2734,7 +2734,7 @@ msgstr "Felaktigt %s: \"%s\""
  #: config.c:2512
  #, c-format
  msgid "splitIndex.maxPercentChange value '%d' should be between 0 and 100"
-msgstr "värdet \"%d\" för splitIndex.maxPercentage borde vara mellan 0 och 100"
+msgstr "värdet \"%d\" för splitIndex.maxPercentChange borde vara mellan 0 och 100"

  #: config.c:2558
  #, c-format
@@ -17352,7 +17352,7 @@ msgstr "kopiera Message-ID till slutet av incheckningsmeddelandet"

  #: builtin/mailinfo.c:64
  msgid "re-code metadata to i18n.commitEncoding"
-msgstr "koda om metadata till i18n.commmitEncoding"
+msgstr "koda om metadata till i18n.commitEncoding"

  #: builtin/mailinfo.c:67
  msgid "disable charset re-coding of metadata"
-- 
2.29.2

