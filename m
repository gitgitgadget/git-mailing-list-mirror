Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09297205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755557AbdABP0X (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:57267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753185AbdABP0W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:22 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfVYB-1c8Jzn0oln-00P6IF; Mon, 02
 Jan 2017 16:26:16 +0100
Date:   Mon, 2 Jan 2017 16:26:14 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 02/38] sequencer: move "else" keyword onto the same line
 as preceding brace
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <65e0dac0115713b6ae955acdbc5b7655aeb18e7c.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j8dw4xbQ3GNNpYY53AQzoy0TSrql6hM5l3is05pv7hT9M6E/C1i
 RMQW5hzBz3CkhpaNwaWHVE+qvp/3B1YCMf4cKOCXgYnpEjbqIM3FMulBfJGiALunJINwKvp
 OgkdCfoeVh4tkt+JqpI38ATTNVOEQFi8UyZ4ByCF9TnDQRnKNiyVOEejzwHcS+FZyNmVNTR
 uAXEp4nZvJaf0hIWZcoDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X806E/ZGivY=:noasWbXoijomg0Q988Mtgh
 ioLVsdxRGl34SwPClj0iG6HS2C2gMCuuyDAO1vfLomHuOcBBr/UfpSkteFdK/haPsEIQLVN9t
 x6vVC3JTwizEjrbhdFPVgxwK2vLIk3Al+y0pSjVeKdK5JPcBuN/xZpU7+ayS9ri7f1Tvy4lXK
 f1nv8SHHW+j51mHSxnltCqZVQzmgZdGZtbBT6+R2n5gEJrF5EYnVkSjdmyHu0je4W4LGT1yKm
 pJo8n6BSw27Q2WuBSk6yKU0keiwu+Q9x5tno7Wc0a8Y3pp2daUFgMCSSWZ3UePL6wJPq1ty7w
 /euRfIctBBvnpwqbPRuotHJadl80XFWhpgNFJprqK1NbeT+fEY0PPRHoy6sMQLW6OePfxV9YR
 5rEd5FCmTUiBRd1UcNF7ujpsxCMAIOhD2no9kG8vfFRrbtGD9RFrjfrjEsk0VffKehm4LY9rH
 qPaFtyX5efECM73AhdvHpKQmcPYAGBA3Oggsm9kkjs17whL8VbJwBipNKI1uso6GViwhIUJb7
 YWJqmEZKvdDBslfYBUD6LFHrIM5q4vfH/A77gaOIMjtNozs88wvV0nfPTHTO3yfpSQ0ND8+tu
 6waFLNzxGf9+QCZO8Ckbk14mOq3DmeEGRXqdIpcDmkonQAeP+aQMb6xJgh21ppYYR5uGlGJyo
 z3srAPuNW+YfpAzeBcGw8gZg5vIoWg9OM+pr1E37B3U6+W4rEDx/oJuknenZAbzdwRykfK84G
 vXKr40KfN4rhEWtT1Z2eFBI3hqyElTgljnoZCbY4RZ6mytnx2ITurl72tL9OV1/Pj4Qjeys+8
 xaXfDRr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is the current coding style of the Git project to write

	if (...) {
		...
	} else {
		...
	}

instead of putting the closing brace and the "else" keyword on separate
lines.

Pointed out by Junio Hamano.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 23793db08b..3eededcb98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1070,8 +1070,7 @@ static int create_seq_dir(void)
 		error(_("a cherry-pick or revert is already in progress"));
 		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
 		return -1;
-	}
-	else if (mkdir(git_path_seq_dir(), 0777) < 0)
+	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
 	return 0;
-- 
2.11.0.rc3.windows.1


