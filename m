Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36881F597
	for <e@80x24.org>; Wed,  1 Aug 2018 00:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbeHACl4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 22:41:56 -0400
Received: from mout.web.de ([212.227.15.4]:57059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732863AbeHACl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 22:41:56 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKrC4-1fkfTY2oYC-0003TM; Wed, 01
 Aug 2018 02:58:52 +0200
Subject: Re: git merge -s subtree seems to be broken.
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     George Shammas <georgyo@gmail.com>, git@vger.kernel.org
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
 <20180731161559.GB16910@sigill.intra.peff.net>
 <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
 <20180731172304.GA16977@sigill.intra.peff.net>
 <20180731190459.GA3372@sigill.intra.peff.net>
 <xmqqeffj9ku3.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d60fc243-7271-bc49-b687-ade2b6e315ea@web.de>
Date:   Wed, 1 Aug 2018 02:58:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqeffj9ku3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Uso3GKlfOBrBEgmiieCMwNIwvjO1xgKsqvqtqWzYeLuxccGL0Z3
 fy6UPDsYMgErTe400ThHXPvvGCmwMJ6tqpUWJXzeobejeAufWJPZCrLs5I5aDZbEBwQ/ODh
 ICr2OCERXUpWeplLmpmr8v4qmBigzgQBk5LLkB2l9uAi0Q+nH3rApt0yo498Fij4FihisAv
 7Xwy1kI3MfobxZNt6CMDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fJmY5Cm2DYw=:NoNGMdzWa2pvF0JZ5tk0Vk
 3cBHTIoJmobpbkKsAMOZzxGaujU6DHK3pPDNNg37yAlGGtnqOloAf5eZOU5wy5PVNF9buuEQB
 1tJBnwB+rrfjPLrfRbTs250zVr4dwyMQ1YDLX3tylOZH6JY1LAcL+ohahV0YNUJJOONGt8OH6
 3DnkZsk2Vib2G9ih/Qd6S59KDBTsLeK843UemYdCkIZv3pM6S7CQV28YxvyH0K2KNV+gyO1SX
 51PRQxyjs9zhy23ORHFPB5YYO2XjY/JbORnujw9bpFFV+xucqH1sUGP6xuvcodWyplk3IYMQe
 JxnIB3ZgFweLnB8W/gbFlbTODAUlH+YYFrZrc6G1TAHB4H2fMdOJMJFQCpZneWRnSbxMCub6d
 lXrX2UJD+ciHGFrFt64H+p88paUgME/ahPAscXuEJ0TPkp5KCy6UrWOyfhjyktpyrc3fx480L
 3J0a5Kr5643+7uEguk8sJHUDNpKNmPQGcaR0dgz9U6hy3jYa2cSq8/PbfAhnL+lvOBDy8rhTP
 xONUkzbqNcHtPbh6qZrs+Zz7+47ham+Z2haYq0PO7cIE8ulHomSYzcLsPfaZ8PGtaQ+Qi9cDg
 lxxVyHMKEnBUhtu9kJt+tsMgcmjJ2eVx8l90S9JByv8CrRsuP9e4G+r9rz7ORJ1rLZd9PenZw
 TJSii5SyKUvnWbgdBkGFPdm/gOy8EmK0GZZ4HwlXuLrpicuXKi/u+olowXjKvzNNZy/523eQm
 yBBFI/bFDDk3D99HWhiw+0C8F4EsRp/l0ZXGQ44aAEfmAixgl6yYVQo7tTfNl4RljYppV6UZK
 gvMKj32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.07.2018 um 23:06 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Jul 31, 2018 at 01:23:04PM -0400, Jeff King wrote:
>> ...
>> So here it is fixed, and with a commit message. I'm not happy to omit a
>> regression test, but I actually couldn't come up with a minimal one that
>> tickled the problem, because we're playing around with heuristics.
How about something like this? (squashable)

---
 t/t6029-merge-subtree.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 3e692454a7..474a850de6 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -29,6 +29,34 @@ test_expect_success 'subtree available and works like recursive' '
 
 '
 
+test_expect_success 'setup branch sub' '
+	git checkout --orphan sub &&
+	git rm -rf . &&
+	test_commit foo
+'
+
+test_expect_success 'setup branch main' '
+	git checkout -b main master &&
+	git merge -s ours --no-commit --allow-unrelated-histories sub &&
+	git read-tree --prefix=dir/ -u sub &&
+	git commit -m "initial merge of sub into main" &&
+	test_path_is_file dir/foo.t &&
+	test_path_is_file hello
+'
+
+test_expect_success 'update branch sub' '
+	git checkout sub &&
+	test_commit bar
+'
+
+test_expect_success 'update branch main' '
+	git checkout main &&
+	git merge -s subtree sub -m "second merge of sub into main" &&
+	test_path_is_file dir/bar.t &&
+	test_path_is_file dir/foo.t &&
+	test_path_is_file hello
+'
+
 test_expect_success 'setup' '
 	mkdir git-gui &&
 	cd git-gui &&
-- 
2.18.0
