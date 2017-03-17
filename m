Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FE120951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdCQTfR (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:35:17 -0400
Received: from mout.web.de ([212.227.17.11]:49665 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbdCQTfP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:35:15 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4ZPc-1bzRvk3kPk-00yeQs; Fri, 17
 Mar 2017 20:35:08 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
 <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
 <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
 <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de> <ffntuqzgjgcfhebokbty@eduj>
 <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
Date:   Fri, 17 Mar 2017 20:34:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YGdVaRhTCOAVtHh/rJyAvpEavS7IhXVG8/yd5sgtx3WwAfrdjZ1
 TAFPTXBAKk4uyt/NFj/KVqZgx4e04/WVt/J0TMsR7dt/Kl1KFe24g/prwih4l3kWeRJeOjb
 UjMv2IDOrDg7NM76NM1WPYV4rTET6EpmflMopI73Ljf9nLDV02aE6Mkn1aAmU+l4riEbAVX
 GY5kIlDK7T1hFsxo+7IfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MtFF03XSVE4=:cRBL0CfM46o1HfBsOVnxQl
 b9MF5RvlNAtQ/W/pusQO0PdIVJmz3SOdmw5Fxgi8omkPXXIGW6RAJraxxgg/ks3wa9ycWFF7t
 aisdVPVMnE/VXZBS0Xpkysr18ZGWrzM6E03D6wZEq+4HypPycDqhvbneWAoQ/9batJ45LwmO1
 OwvATbVZBzIFygOD342DWB/B3gcTIZq/A1oQLFj0PC+ZRGWFHwvrGr/EnQKtP4HUvHz4YwCDD
 605FG75n+IY7A1bLpfOBrFKGQxv9a74889M74a0jhRBplh2v43wNuTiQdcUM7VeFOLTLRsaBb
 gEO9iww15EpBnQ6kry7UjqfU4LUB0ztiP5kwnySZMlfOsfXyVgJZci6XILzz1dU+7t7i3VIUy
 o3v5/EsopgIM9BVAtNSeC0soqPlo6dwy09jQkQJrnZ0N+9zC463yVQtJMat1YkJJehpNb6qix
 LwicAmNRExw6kbKfmzpPYntEqnLbLWLmvzbcjEkIQNNytKKroD4irfBO65iUrjVZgSKbPK0me
 lxk7s76UCN3ELc1JG31ZMFhftmCeCaHHMdtj9yKyLs4v7lx/y7v2VQkZMC5psXbUQ/6Iv0MBL
 f/U07xGz21/QRdW845dVviPceuMMytmCu9O7AR7EI4h8fPMn3sejo9gNGRwN3nUTXEnhYeFSQ
 56vw94h5NwICj0yMWN8w5bcVlo1bVbm/tEsDVqJd9lLyk+MNbQUnoM703jm+XkjfyMop+jf7K
 PPvSkSaURXQwkgJ/NKfTK1TAcW3PmIDmM8iBL/FUVv4cCyVXXymz+pGmXCzAODVSRYfL5fxKD
 oGhWW4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.03.2017 um 22:30 schrieb René Scharfe:
> Am 15.03.2017 um 10:44 schrieb Zenobiusz Kunegunda:
>> $ git bisect bad
>> 7333ed1788b4f2b162a35003044d77a716732a1f is the first bad commit
>> commit 7333ed1788b4f2b162a35003044d77a716732a1f
>> Author: René Scharfe <l.s.r@web.de>
>> Date:   Mon Jul 28 20:26:40 2014 +0200
>>
>>     setup: convert setup_git_directory_gently_1 et al. to strbuf
> 
> That's what I half-suspected, and I think by now I got an idea.  Here's
> a test program:

And here's a patch for letting strbuf_getcwd() use the same getcwd(3)
extension that pwd(1) uses.  It avoids the need to guess the path's
length and thus reduces the chance of stumbling over strange error
codes.  I wonder if it helps in your case.

René

---
 strbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index ace58e7367..4c02801edd 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -442,6 +442,14 @@ int strbuf_getcwd(struct strbuf *sb)
 {
 	size_t oldalloc = sb->alloc;
 	size_t guessed_len = 128;
+	char *cwd;
+
+	cwd = getcwd(NULL, 0);
+	if (cwd) {
+		size_t len = strlen(cwd);
+		strbuf_attach(sb, cwd, len, len + 1);
+		return 0;
+	}
 
 	for (;; guessed_len *= 2) {
 		strbuf_grow(sb, guessed_len);
-- 
2.12.0
