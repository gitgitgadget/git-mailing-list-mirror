Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42BA1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393236AbfAPNgc (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35927 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393232AbfAPNga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so5440170edb.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dxzqfZAxZ+TPwgPiHydUMW7hZp+IB66oCyS61ZHth2s=;
        b=IM0PGUEdnIwVLe+o4XXZ77beaNnETk3dyYsNXPDvX0zMXaP95yUgJzfFNg5vO+yA9o
         VhofXi7T8/mi8SjFOtB8ZxHOiBWn629ATpR0Y8e4hRR+HI7Ao1MqpJIyFs9hDw6X03cz
         k0RyCK3LBAz8bJggpqbgPbG00WMwyfZsq3Fluv+EOEPFpM2HP8pwDeUwTHE4MOmY1uzq
         bsbfVB5LVOJuO/y93RO73RTRFCqqZNQY2qi+V3a3wsT/nIlnhnS9D7BpP/VtOeHsEx7y
         UHejTE6wY68q4i8jfalw/pSEDQTbLdOWV9SyJeUSyrKBX0nVT2kKxMA08OyZPp1cHEG8
         Fhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dxzqfZAxZ+TPwgPiHydUMW7hZp+IB66oCyS61ZHth2s=;
        b=Ayaz9MQMIPOcnH0bvzl61J9RbbNbBGUdVvTQGoaU/sDC1B+af0G12EBj/wV5VdJEfR
         Be3p7T1W55DL6InDHgPA1GUjeZ0qp2OE5ZwNAAFXrlw06jDMIysJARw/GraNXFaTlIov
         tG2O08I/k85vGRWjDn0q+/h/ppcpXXz4U2WeH+MPL940kZwbT1afitgCdFNyYLEdFFbE
         2ehm5ctsF/7NTIRySX1eW7gGJk3F9XKsOEDWsGnr41EqiIPnm0nUpry9rXBHdA/lDhrA
         vQzuSn+ckNarAm+rJ74w2/kI3ve0Fw1z1385Nd4Q1ys6V6N1uje3em8iWyO8FWGqzsS+
         A9CA==
X-Gm-Message-State: AJcUuke0RoM7//SntxbOkAJtCrWYkdmWfVNmvjXAit3Sl7teRcgTFYPe
        VGzd8KrSqVuQC+i7QNU3hjwju6rf
X-Google-Smtp-Source: ALg8bN4gjoq+U2XgSTNpYP+28F+USu8K7tEFRjgwKQmfcYED9YIccmT69aT2pc0tpdacorONfLfGkA==
X-Received: by 2002:a17:906:304b:: with SMTP id d11-v6mr6702743ejd.4.1547645787771;
        Wed, 16 Jan 2019 05:36:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q50sm5581240edd.66.2019.01.16.05.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:27 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:27 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:06 GMT
Message-Id: <713910e1dc634e3c09b374759a3bd282946eca96.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 18/21] t0061: fix with --with-dashes and RUNTIME_PREFIX
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When building Git with RUNTIME_PREFIX and starting a test helper from
t/helper/, it fails to detect the system prefix correctly.

This is the reason that the warning

	RUNTIME_PREFIX requested, but prefix computation failed. [...]

to be printed.

In t0061, we did not expect that to happen, and it actually did not
happen in the normal case, because bin-wrappers/test-tool specifically
sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool wants
to know about the runtime prefix).

However, with --with-dashes, bin-wrappers/test-tool is no longer called,
but t/helper/test-tool is called directly.

So let's just ignore the RUNTIME_PREFIX warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0061-run-command.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 99a614bc7c..5a2d087bf0 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -166,7 +166,8 @@ test_trace () {
 	expect="$1"
 	shift
 	GIT_TRACE=1 test-tool run-command "$@" run-command true 2>&1 >/dev/null | \
-		sed -e 's/.* run_command: //' -e '/trace: .*/d' >actual &&
+		sed -e 's/.* run_command: //' -e '/trace: .*/d' \
+			-e '/RUNTIME_PREFIX requested/d' >actual &&
 	echo "$expect true" >expect &&
 	test_cmp expect actual
 }
-- 
gitgitgadget

