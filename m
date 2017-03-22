Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E9620323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965568AbdCVS2s (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:28:48 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34882 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965446AbdCVS2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:28:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id u132so44511337wmg.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BBBPZGt/FYcRtjKqgg4fs5iPhH/Zt0yBZShUUrkRzSg=;
        b=iwiL2f3RikT+XEVNHzFv3CeCYz7PqqxLaYIizuJEG2/ljHa3/5Ni0Av2e1fnda2cL5
         Yl5oqOAI+oG0VVn3ntiioCjdD4p1BmdS7IXkGUoCdIyYs3n5AZLmE1xdbc/HQg4TavDA
         kx1w5rrvk9OdOmfLO15mqemafI8wlVnVREvuO98ykKUdYx7t0xhVYr8AjBTBefE4I62f
         YvaTuBPuK4hgasbAJ/cRwsT/hAKWYM310ZS0+GNmETEOyc1c55m17QlYIktUENHpo4GL
         f/3kkr64heyJvidLW5GxMZ7VsDCDTcAiNeMksy5b9CieloSVpVf8Wpem/+NNs/QKfmAg
         da+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BBBPZGt/FYcRtjKqgg4fs5iPhH/Zt0yBZShUUrkRzSg=;
        b=r6Sz2nivzRaFjvqeLOD1ti/F1O0ZIjxcocO9Uko0WBRpqNBCxT1vDgVVhKgHmsDGIL
         nxDfUUyErgpTZPyQ+cgy8eDigfqLeLpaI9yyC2dlU5K+0ZrAGJImkL+fOQCrITFzyDQ6
         18YDAy/EuQNF5W09P4AnFBnsSLUtik/ksHwL8HTsc8zQw93L5famW0tMzf/90i2ki1xF
         gH/k976EjikSZeYssKpaVurWEhgh6EZMsZrktkdTlzhZrACx+/GVoHJj+KL1GIbEsUTg
         8Zc16zLbkFhIsZyI5D4Mzcbmzkpo67u2fpaOVEcBgeuIlT7koKJ+IadijpKv1xy7TS4U
         GOSw==
X-Gm-Message-State: AFeK/H1i/FlgfhrpgN6k4R7i3FKnCD+e3fMMuYUIivJY7BwUAa3SsV0DSBQQNlVMT9F23A==
X-Received: by 10.25.216.220 with SMTP id r89mr3226749lfi.153.1490207324175;
        Wed, 22 Mar 2017 11:28:44 -0700 (PDT)
Received: from localhost (afed200.neoplus.adsl.tpnet.pl. [95.49.107.200])
        by smtp.gmail.com with ESMTPSA id t23sm108641ljd.30.2017.03.22.11.28.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 11:28:42 -0700 (PDT)
Date:   Wed, 22 Mar 2017 19:28:41 +0100
From:   Jan Palus <jan.palus@gmail.com>
To:     git@vger.kernel.org
Subject: Re: EOF test fixes (t7030/t7406)
Message-ID: <20170322182841.wkavsj6hj67jzud7@kalarepa>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v67j7sxleza24td2"
Content-Disposition: inline
In-Reply-To: <20170322173528.ho43ulndlozq35tu@kalarepa>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v67j7sxleza24td2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

It appears more tests are affected:

$ grep -r '^[[:space:]]*EOF &&' .   
./t7406-submodule-update.sh:	EOF &&
./t7030-verify-tag.sh:	EOF &&
./t7030-verify-tag.sh:	EOF &&
./t7004-tag.sh:	EOF &&
./t7004-tag.sh:	EOF &&

attaching patch for t7406 and t7030 which both fail even after fix is
applied.

--v67j7sxleza24td2
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="git-EOF-t7030-t7406.patch"

diff -ur git-2.12.1.orig/t/t7030-verify-tag.sh git-2.12.1/t/t7030-verify-tag.sh
--- git-2.12.1.orig/t/t7030-verify-tag.sh	2017-03-22 19:20:49.614759549 +0100
+++ git-2.12.1/t/t7030-verify-tag.sh	2017-03-22 19:26:27.608511234 +0100
@@ -126,17 +126,17 @@
 '
 
 test_expect_success 'verifying tag with --format' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : fourth-signed
-	EOF &&
+	EOF
 	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : 7th forged-signed
-	EOF &&
+	EOF
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_cmp expect actual-forged
 '
diff -ur git-2.12.1.orig/t/t7406-submodule-update.sh git-2.12.1/t/t7406-submodule-update.sh
--- git-2.12.1.orig/t/t7406-submodule-update.sh	2017-03-22 19:20:49.614759549 +0100
+++ git-2.12.1/t/t7406-submodule-update.sh	2017-03-22 19:25:34.105528379 +0100
@@ -442,9 +442,9 @@
 '
 
 test_expect_success 'submodule update - command run for initial population of submodule' '
-	cat <<-\ EOF >expect
+	cat >expect <<-\EOF &&
 	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
-	EOF &&
+	EOF
 	rm -rf super/submodule &&
 	test_must_fail git -C super submodule update >../actual &&
 	test_cmp expect actual &&

--v67j7sxleza24td2--
