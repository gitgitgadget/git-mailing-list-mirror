Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DF2C7619A
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 14:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjDBOiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 10:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjDBOiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 10:38:24 -0400
Received: from m13112.mail.163.com (m13112.mail.163.com [220.181.13.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1476F525C
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=OSgjQUSSVrjfsyoxbatPpRCwG0RYDF/neui1mM1Ly5E=; b=j
        /ZJK6JUCQA3Y9k76Vmy01RYlnx8O0WpbHgihzdtUHPuGqOT3xgUlq64Nyufh16d3
        DGGT33NKV2yJ+XA3l4N/WUra6hLXzmNLlpQSQIHngpeotTqoN9vqCR1IHnMvapfr
        82KJwmNuikEs3RGc6hR/YC9hAIMtsy30fm0lg7M0/A=
Received: from 18994118902$163.com ( [153.0.171.49] ) by
 ajax-webmail-wmsvr112 (Coremail) ; Sun, 2 Apr 2023 22:38:12 +0800 (CST)
X-Originating-IP: [153.0.171.49]
Date:   Sun, 2 Apr 2023 22:38:12 +0800 (CST)
From:   ZhangYI <18994118902@163.com>
To:     "Christian Couder" <christian.couder@gmail.com>,
        git@vger.kernel.org, hariom18599@gmail.com
Subject: Re:  [GSOC] [PROPOSAL v2] Draft of proposal for "Unify ref-filter
 formats with other pretty formats"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <CAP8UFD3Lns7pQQ-yNc5W8d2bfPBmJ0pcD52yCbkFOmymhWKw9Q@mail.gmail.com>
References: <100814d1.2603.18735b059bb.Coremail.18994118902@163.com>
 <CAP8UFD3Lns7pQQ-yNc5W8d2bfPBmJ0pcD52yCbkFOmymhWKw9Q@mail.gmail.com>
X-NTES-SC: AL_QuyTAvifuUoi5CKabekXn0oVgu88UcCzvPok34ZQOZk0pivh/A8/W0NjEWXk0sGvKQayjCS7dTFH8NRFV4xDfaUGm/3uzaIwSgkRcIvhLrt+
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3cea7bba.1e54.18742678107.Coremail.18994118902@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cMGowADX5pZUkylk0mECAA--.2345W
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiGAlF-lv2lgM6LwABsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvcsKgQ2hyaXN0aWFuIENvdWRlcidzwqBDb25zdHJ1Y3RpdmUgY29tbWVudHMuCkkn
dmUgbG9va2VkIHRocm91Z2ggT2xnYSBUZWxlemhuYXZhJ3MgZGV0YWlsZWQgYW5kIGhlbHBmdWwg
YmxvZ3MuIApJIGFsc28gdHJpZWQgdG8gdW5kZXJzdGFuZCBtb3JlIGFib3V0IHRoZSB3b3JrcyBv
ZiB0aGUgcHJvamVjdCB0b2RheS4KCkkgaGF2ZSBvbmUgcXVlc3Rpb25zIGhlcmU6CkkgdXNlZCBn
ZGIgdG8gdHJhY2sgdGhlIGZ1bmN0aW9uIGNhbGwgcmVsYXRlZCB0byByZWYtZmlsdGVyIG9mIHRo
ZSBjb21tYW5kCiJnaXQgbG9nIC0yIC0tcHJldHR5PSVoICIgYnkgc2V0dGluZyBicmVha3Mgb24g
YWxsIG5vLXN0YXRpYyBmdW5jdGlvbnMgaW4KcmVmLWZpbHRlci5jIGJ1dCBmb3VuZCBubyBzdG9w
LgpTaG91bGQgSSB1c2UgYW5vdGhlciBjb21tYW5kPwpPciBhcyBJIGtub3csIEdpdCB1c2UgZGlm
ZmVyZW50IGJyYW5jaCBmb3IgZGlmZmVyZW50IHB1cnBvc2UsIGxpa2UgdG9kbywgbmV4dC4KU2hv
dWxkIEkgdXNlIGFub3RoZXIgYnJhbmNoPwo=
