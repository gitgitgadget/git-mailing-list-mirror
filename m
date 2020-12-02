Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB1C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C6D22203
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgLBLsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:48:01 -0500
Received: from mout.web.de ([212.227.17.11]:39269 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgLBLsA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 06:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606909562;
        bh=3lM5sVFT2Fry+1x5lbAx+ldqjfpC1/tGssMjv/JiIB8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X6elvXfBCcal0yeUTOI/JQ8A8ORwuo6IqQUKGIxhaVeCndMbxvIsfcOa0xzSXbrxI
         ByyzBTs/7XaEgyRuAV4kWLqragJnHEqiAzrdNxgahXjd9EQKOxHjgFfoIiN5yX129M
         mzjMAzLNnnIUMNsmSJr55V0SznQIbhyeRVX4b3GM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1kDouz1X4Z-00flSq; Wed, 02
 Dec 2020 12:46:02 +0100
Subject: [PATCH] gitignore: remove entry for git serve
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-3-felipe.contreras@gmail.com>
 <xmqqczztqszv.fsf@gitster.c.googlers.com>
 <X8b7UMcsfaD0OFv4@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4e30fa82-fe24-1783-6f9a-13e1dd6f4ca9@web.de>
Date:   Wed, 2 Dec 2020 12:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8b7UMcsfaD0OFv4@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VALdzQwXntNHivW0oHZQfHT8pn0jcHWb7N8nUqYPFuxswnPdWT5
 R9SyKAGmNX2QrsDPG31RiZwp5KKm2CROWnM9czXujhDNZk/CCLCAKUKNT0/GZ1rhUoshVb3
 3l4Xdv9g2foYy+UcD3cXRee7SSrV1TKESpJOzAbgEbE/LBVnbLdsyb7KA8/hO4wsCx8wstP
 TTbGKr3q2EfIK5oXF1TGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eULktw3dINs=:iLsXtkhct0i3UtwdGXEv/r
 +DjoCEa6DdYXPsqRK8y/yGRK3k1IQhgdG2Z4J1rego/xCQRr059OxzLKatXobFC3k9e1Cy6aG
 Up3bGpBw5gGK/9kgrVuz00SCe65l3/VY27C36XvFKibJtRfpY69OM5/R0AVJs+wqLoBvn2uc1
 xk8+QT1p3gMr6wqW+1ehCk3O7cgsklhwIgCmuapIM7De2DdCR49H5TcrzcVbG41yN5BE1lj+s
 IRics1Y1PGri5ZveqpoZq/ZdH9LD0JqRHu55VZMbcNZrg9cwalsPaEfc91swvwgJ681YiQ8KZ
 SGQuz827FXeZyPqIx+rZ3zmyTVjBM9QiptxgklprqFcae7e2lPIKgpwSygp++RCxgBJpFRmFW
 4/phER+rvv8oiZhmksn4sogvrYcAgTT39A2zqwjgVbneDaFszL3FcZSSAj9BfZQRXkmIQduZb
 lTCUf1+ABDyBLXVEKVTYLyE0Vx23JENP/rgv66XC8RdocW4VtgDqrULBr+XOxPJr2425F0/oJ
 hr0dFsy/OZcry7/c9oD/RByYFsDRFtHZwa8AMz0l2a92r8+KY9IFD/uqy6l3RG2QyRTb1XMdN
 4jXE+KNfxaS7VjcfiuK0NoVi64VLbSQzwZA7KWwlWGabUkHTdrMogIT+tQNgOmcK/1JJAG9Ej
 /8bxEE5aKW8IchePY+c/PDxpgw6CMD/uUO8ixa8Qg0ApKaLdMpxQ9LyjXMmdDp/sgTXmyOu3D
 n7KhTbQswMwktXRHNWuaHwGLY5OejR2086QR5X3atnyOrwZIJTw77fbotiG9yGfzJ++WWuPs/
 DTRBBqGvC64dIgZyNMVLM1GO7IrhyqyTdXnLMyka6NH1apZva+4ddPADH+dkShae1sTJJtWcv
 BFvaC+ZhvqPJ7CFuc11A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b7ce24d095 (Turn `git serve` into a test helper, 2019-04-18) demoted git
serve from a builtin command to a test helper.  As a result the
git-serve binary is no longer built and thus doesn't have to be ignored
anymore.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index f85d02c854..28c079f227 100644
=2D-- a/.gitignore
+++ b/.gitignore
@@ -148,7 +148,6 @@
 /git-rm
 /git-send-email
 /git-send-pack
-/git-serve
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
=2D-
2.29.2
