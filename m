Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A861F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 02:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbdFJCKz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 22:10:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32809 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdFJCKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 22:10:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id w12so205171pfk.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=KRtPZuia1pg53bbqmN3ZjTekNbIApaenmU0Y3qbz+SE=;
        b=i35o7tJVTzwlbpmHHYsxhzsuzs5yzGh527SPtpzIxvdDv2wQ7jmJwqvvXva8vJ05aa
         23P4O3v/vZsaoDu0jUYvh/wOOLMOLbSztVrwVW/YjPTM2WhVUIc4Ig2hGTmHXqqmP4Dw
         BSqP7/zAS9cvaD/NKo12IJ44aNQ6UqFf9AjVXvf+QptEq66bTLy4+PGv7qjIdyrbu4T2
         /FpyDmJdZoedQ9WMb54qaWFZ5oidJnK1bmu6Z/FOh/r9LuhVGo/6HZLBA8/vIqkHoILV
         jBOH6uIis5d51O115wRxGuPGldJqsqYzSu146FChl0KkX3zthwe0DSqrbXcdMFSOJMkO
         hPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=KRtPZuia1pg53bbqmN3ZjTekNbIApaenmU0Y3qbz+SE=;
        b=Zd1yjxseRLD6y4LMe/sv0mYj7CEdlFDbm0XyvAt1QhLRvTzXVb5+yGYTlGnJTGF7S5
         mqBZrgyj+7oqpnHSUL46/7eD/Wt22FQPCsUWGU4U4XleuqevZPR8RAZ998/14m0G1/qB
         J77WYf2eVEpQsbTi6OTCCsE3RAwWaoHagOy58nha11gI+1+VICMXxdWnhfPbCXXiTO3w
         VUzwt741sIiyjUYQ5yO1W0YN4s4fiIl1zgHsNcVSKO2GiVFF9aYZKPZ0P4RGzSVxXhpg
         lHAx2M3Th/E7skawKYpZheDR7DtdmA6QnBE8EuQXbF3rsiIRDpK0kW9GDqsi+47ss03V
         QLqQ==
X-Gm-Message-State: AODbwcBaM3I5KRgsQoJA36uyh6XyEXnOBckg/TNWZPJWOJQin5QpQAHP
        TnqGVmAOtpja3wLxxEA457X9
X-Received: by 10.84.211.7 with SMTP id b7mr14553170pli.124.1497060654415;
        Fri, 09 Jun 2017 19:10:54 -0700 (PDT)
Received: from unique-pc ([2405:205:800f:e175:79da:a1fa:c50e:c98d])
        by smtp.googlemail.com with ESMTPSA id i17sm4725311pgn.60.2017.06.09.19.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Jun 2017 19:10:54 -0700 (PDT)
Message-ID: <1497060629.5324.0.camel@gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Date:   Sat, 10 Jun 2017 07:40:29 +0530
In-Reply-To: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The status message shown for a parent-less branch wasn't so
descriptive and was a little confusing.

The message has been changed to be more descriptive to users in
such a way that it clearly shows the state of the branch / repository.

This allows the users to be reminded that they are about to make
their initial commit which the previous message didn't seem to do
communicate well.

A few alternatives were,

* No commit yet
* Your current branch does not have any commits
* Current branch waiting for initial commit

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Corrected a little typo in the commit message


 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 037548496..7bfdde46d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1576,7 +1576,7 @@ static void wt_longstatus_print(struct wt_status
*s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s",
"");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s),
_("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
_("Waiting for initial commit"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s",
"");
 	}
 
@@ -1746,7 +1746,7 @@ static void wt_shortstatus_print_tracking(struct
wt_status *s)
 #define LABEL(string) (s->no_gettext ? (string) : _(string))
 
 	if (s->is_initial)
-		color_fprintf(s->fp, header_color, LABEL(N_("Initial
commit on ")));
+		color_fprintf(s->fp, header_color, LABEL(N_("Waiting
for initial commit on ")));
 
 	if (!strcmp(s->branch, "HEAD")) {
 		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s),
"%s",
-- 
2.11.0
