Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0D020437
	for <e@80x24.org>; Thu, 12 Oct 2017 09:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbdJLJRy (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 05:17:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36457 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdJLJRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 05:17:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id 131so3598449wmk.3
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2b3TAOdYY3vJ6AEIzirMpBsvNzAMLYNlLbkuQAuMDk=;
        b=QZ5zRw3xqiose6WJnzWivJBVPb+NPESM4WRX6EMeu/V8g0XJC6LTvfZlfg8PX1+M7y
         xMqdau+34v1PkjSWS+lAalsI87dAHSv5ZZWwtXTYPGgnbu3Ds9KkF76cJfBA+kdoZueN
         J+k9TbsTLcK+ksVzq7VUytisoRrifUz/tJ2L9Pxl1QM/bk8pwgE8SW5zpqFgXqhk0dCp
         Fo8txNWMt9XTN238ah/VdCv+galJpQzFQ59A/aScFBzkwvL5ePh9H/jJ8Cxjj2pFzgkS
         sIYDvM4zUGyDyXPRcZt9Tdg1oimYDrfYdJJfLzfDKCyrz3uqEfMA5gl7ZMRybuy7TSGI
         m6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2b3TAOdYY3vJ6AEIzirMpBsvNzAMLYNlLbkuQAuMDk=;
        b=WTzjJRh9AwkotxtSryfIku30ODDIX2dkmekOoQIBnc/zrmDRRphKrigdW3JwPfllok
         pdxM8GUL+Emnh+1F1v8oaLVwRI+Wc0KCCO5GfJ0luV44QLe4ERgtNAjO/GdntpWVLmFu
         PuFr4KhpHqhlYXkFtxv2ADNP+7SyxjjLe4V+1W52baHzfC6HayGqIpC3xXTVYgapaM9m
         DX0e0y7FpOYbyIspW5eoKr7jwkXvvAbwZP5rVN8oj0DnwEuOc5peft9igZCAQoJaOaXz
         1YMzTSHSBlPbyhMFxj8aVYDZETZFAUN4G+g3yFZLnu4vKCEtQ1r82dVswGRFwJx4nhxu
         3Q+w==
X-Gm-Message-State: AMCzsaUkC9hRxGe2utALunr9mlqKQaWSJ6rdlPe3OlMAoDZU5hrvmEsS
        oLRqNVV0pSQmVvDs2FZAz0l3wA==
X-Google-Smtp-Source: AOwi7QCEE8MS6S2u1ls9+j9tgHFkbS+kqLdC8GWlLTVnnrSw5xFWb6ajMazdVs2ROO76VJJ07ainGw==
X-Received: by 10.223.151.221 with SMTP id t29mr1367671wrb.34.1507799871799;
        Thu, 12 Oct 2017 02:17:51 -0700 (PDT)
Received: from Laptops-nathan.univ-lyon1.fr (wifi-ext-0151.univ-lyon1.fr. [134.214.214.152])
        by smtp.gmail.com with ESMTPSA id w126sm17014714wme.25.2017.10.12.02.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Oct 2017 02:17:51 -0700 (PDT)
From:   second.payre@gmail.com
To:     git@vger.kernel.org
Cc:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        MOY Matthieu <matthieu.moy@univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Nathan Payre <second.payre@gmail.com>
Subject: [PATCH v2] Documentation/git-config.txt: reword missleading sentence
Date:   Thu, 12 Oct 2017 11:17:27 +0200
Message-Id: <20171012091727.30759-1-second.payre@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <xmqqtvz7pewn.fsf@gitster.mtv.corp.google.com>
References: <xmqqtvz7pewn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>

Change the word "bla" to "section.variable", "bla" is a placeholder
for a variable name and it wasn't clear for everyone.
This change clarify it.

Change the appearance of 'git config section.variable {tilde}/' to
`git config section.variable {tilde}/` to harmonize it with
the rest of the file, this is a command line then the "`" are
necessary.

Replace "git-config" by "git config" because the command
is not "git-config".

See discussion at:
https://public-inbox.org/git/20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca/

Signed-off-by: MOY Matthieu <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Signed-off-by: Nathan Payre <second.payre@gmail.com>
Noticed-by: rpjday@crashcourse.ca
---
 Documentation/git-config.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 83f86b923..2ab9e4c56 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -174,11 +174,11 @@ See also <<FILES>>.
 	either --bool or --int, as described above.
 
 --path::
-	'git-config' will expand leading '{tilde}' to the value of
+	'git config' will expand leading '{tilde}' to the value of
 	'$HOME', and '{tilde}user' to the home directory for the
 	specified user.  This option has no effect when setting the
-	value (but you can use 'git config bla {tilde}/' from the
-	command line to let your shell do the expansion).
+	value (but you can use `git config section.variable {tilde}/`
+	from the command line to let your shell do the expansion).
 
 -z::
 --null::
-- 
2.14.2

