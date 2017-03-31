Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD4E1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbdCaNvl (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:51:41 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932854AbdCaNvk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:51:40 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue004
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M3wRS-1c2fYH3svq-00rXXG; Fri, 31
 Mar 2017 15:51:32 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v3 0/4] name-rev sanity
Date:   Fri, 31 Mar 2017 15:51:20 +0200
Message-Id: <cover.1490967948.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.739.gfc3eb97820
In-Reply-To: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:BD1TsEH79E8EywBRq7O4NRSenb6/zgdHGy8Pj4QTv4LF430fIfn
 Ovj4L7z1xa3uBAp/BPw5HKmC7vuxn4FHMmfejZIrzetasc7nvbtkqNdAsSQ0f+SvSvp63Ci
 JtICORLUcG0PdJaBG/0JtOZp70u0AsrqUkmWUV7Ovcc2hfB9bZYZzdwyiMjXf//PDZ1O6VF
 CQowf+oFLZyYUlYISRoKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EVZfOiBRk0g=:Z8SDVUOcN06o6h7XuX/gIx
 kRq7JunQVARBg7p75W77xOzO2RvJVK0DLFmo89ITS62InV/42xFEwg2CUyUrM8NmRe/GNG42P
 /4qC1ac8R0WKSMcrAd4ktggX0pC7wCLIKiZIB+cVciDzqu19Sb4FdEN256i4796+Vcjh43XUl
 +lOtL6chw4XS+rHZQBLN96Ysg00R82FyGDkWl8CnJQmRrREG4wVl1NaDiO4afUgqvhwzphYTo
 DWyGX1P28KhqL3LQ6ED2XzG3D1x839AYtoaLRlmjiuvKTaX2bmP/cu/2SLJh7LFMPZwiepeTt
 NbPEzF7r0bZxWdFa7V4dR2Q77NJ8gmuHaEBjTrUqb3sEYivLyK7YJBhLv7NLgpj1evkrtgfU1
 UpILuF6lEq5FUdpcfsgibdBgsZ7r13uN67AreNyoaTazuwWUDjJN9eSHa5AFv2yNwj8UuEgbU
 vBN6284QfALqCwvMpcqB+y1fxpSAJ1nbeAHz8aQ2vncn6u7g6lNAkc6dG8S8acDjzpd/sdQX4
 5IJRxdVWxqx6S++yTZRTYKFM6Cfen60Z7jiP2Itu4ZjPoTYD/xRzNKeSQPTu4PXWlLycT40X8
 C2EGziUhas/VugCFJUACpL3di5wDF7a31/01va1sPLQDg0WwncoeUAkRGIaRwmo0JkqaLrdvR
 dy5JsD33AN/4tLCgM89ov8p9cKMntW/5iWNgLEp5CqpAPC1UvtCfuIzx/EQcDR3Soh9g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 splits the old 3/3 into name-rev and describe related parts and
adds documentation.

No core dumps encountered so far ;)

Did I mention this is on top of mg/describe-debug-l10n (next)?

Junio C Hamano (2):
  name-rev: refactor logic to see if a new candidate is a better name
  name-rev: favor describing with tags and use committer date to
    tiebreak

Michael J Gruber (2):
  name-rev: provide debug output
  describe: pass --debug down to name-rev

 Documentation/git-name-rev.txt |   5 ++
 builtin/describe.c             |   2 +
 builtin/name-rev.c             | 117 +++++++++++++++++++++++++++++++++++------
 t/t4202-log.sh                 |   2 +-
 4 files changed, 108 insertions(+), 18 deletions(-)

-- 
2.12.2.739.gfc3eb97820

