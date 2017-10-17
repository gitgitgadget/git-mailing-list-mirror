Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721091FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936560AbdJQPj1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 11:39:27 -0400
Received: from mout.web.de ([212.227.15.4]:51533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbdJQPjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 11:39:23 -0400
Received: from [192.168.178.36] ([91.20.51.19]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9oaG-1dxrBM1BjU-00B2b5; Tue, 17
 Oct 2017 17:39:16 +0200
Subject: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
Date:   Tue, 17 Oct 2017 17:39:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IQHcjBxUI6mhmuqEjSCYZn/GTiuUeTdllisoU0oQduquuQtyHe9
 bKxl98VqRn1KP1vKSX5F0cE4JwaDF7t2EVQ+hrj26bN6chOOzBCNrV10E08Ftl0mBTt3cYr
 Dzx9oDz73P9tgxnuhc1UxQ4HTI+uNgfyLkxGTSlZ03/Sv+NPrAZoI+D/gYn5gPtVFK0aRqQ
 M0M4rf3FaARl8UR2Z0qpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Co85/uccJU=:zl7xASIF7Dw8114DvKqklq
 Occ02GLIyncNZ8h3K3aNydiQM1cdT30n+ALq9t51j3TRx9QOIpnJxIRxn6xq43yTPPBalbnCk
 wLf+2DaiGZ3uC5f1FsuEjWwzvz9XPUpiYfg7vEgb/OByOGCEL1OFAnk34Vsb8QJjgy3CaF4sR
 f0vrvyLF9xMGA4f6H3qDCt7pRNGOj/rSMumb7nMuOS5BTmQY3LMrEGQpxJSws9GAUvU3aWikq
 eNKeVQPpEqkw3eWAW5v1lUSPoVT28TWa3UNZKV2equRU+Cmh/p3ff6KfMpnBKlZRT3eSh0xTd
 zgV5qDIwUqOBEF56NjPGb30fOwUPuqf83me8CbQsVFkbzmVOJ7mVcTUEr8jerk6tNtyaYW2vW
 kQRqxQzsQAQPT8u/aN0hCk8VDSlWiKe6+HoN6XOtw1NylfPRK1JY48eXygeou3exr51ZukKNt
 s2tK3IGsfeoXZbT3XEpAa6pdnCjhXBwE1EODR8IPxTomrIuRoRQ4yNBLgUpLL+ug61cCwX21M
 o7XeZQ/q+NpP1PH3KBWPyBQZAByDbzvXhKLfcg9NFeWonrWZG/0cxgAJtMGd5x0dcyfLFy/hh
 PVVeA5wkxEQ3VvWxHwW3qTdo7IKYcFKhee+urTnIPXNBXe30U065ngqSJv3y2ur0n5wcDNuBZ
 +L/fBq5TNtWRlw8e2MIGlr0J58wUEpdjfxY8ssIkYpArb1l78fAoBYIIBKJeXln+7Oh4fYY1C
 +oNZR8WDF7FI5WoFWQ++WkmZNPR4VFCvYX4jLoj2yIi4AK+ds225OWShsKnlzN4+Bhi4T+LPA
 oLcNcvGlBuHtMeJ6GiHRXXSNGdw4abw3Ivw7eSiyU8n62PVf74=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop advertising -h as the short equivalent of --heads, because it's
used for showing a short help text for almost all other git commands.
Since the ba5f28bf79 (ls-remote: use parse-options api) it has only
been working when used together with other parameters anyway.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
That would be step on the way towards more consistent command line
switches, in the same vein as d69155119 (t0012: test "-h" with
builtins).

 Documentation/git-ls-remote.txt | 1 -
 builtin/ls-remote.c             | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f8..898836a111 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -21,7 +21,6 @@ commit IDs.
 
 OPTIONS
 -------
--h::
 --heads::
 -t::
 --tags::
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c4be98ab9e..840deedbef 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -56,7 +56,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
+		{ OPTION_BIT, 'h', NULL, &flags, NULL, N_("limit to heads"),
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, REF_HEADS },
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-- 
2.14.2
