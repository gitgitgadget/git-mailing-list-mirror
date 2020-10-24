Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31853C4363A
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 11:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9B724248
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 11:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759392AbgJXLA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 07:00:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759323AbgJXLA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 07:00:57 -0400
Received: from [192.168.178.45] ([95.90.245.244]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1My6xz-1kCQOW3yjX-00zZW7 for <git@vger.kernel.org>; Sat, 24 Oct 2020 13:00:56
 +0200
From:   Thomas Wolff <towo@towo.net>
Subject: FR: git diff ignore option
To:     git@vger.kernel.org
X-Tagtoolbar-Keys: D20201024130054931
Message-ID: <394e7906-e26b-8375-6d6b-d235f15d0c2e@towo.net>
Date:   Sat, 24 Oct 2020 13:00:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oEVkRHGIXAQH2CFBzvUDCf3eihHpecxolIYwU5NgbPqKPkFqLks
 IqR6iYu9RX5yHf141EX0x0nJ27drsnpRaWDG2aqjL6CHuGWe1c2XopJyzdSukj/RVMYbY9A
 bWs/ZvQrL41aSbqkf+EGSZcbzF73Gi2FMxN0FuroFJUS5FIQqcuuovdQ3Pq/iTTg8EKTFfQ
 hSq3s1+VmJqjRg/8Gcg7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+qeesG4pG9I=:RsmrODZbo1tEDVoMkvkfBw
 2G7Nk3qXcYasjZQkJ//6RGFunqClNdri/0g+2sCJiMrUQAFbZRwJ6NeqW6FuDmPCVolD0t43N
 Vs52aVeOGxsQALZcQFEtcRbaaPBVosHCbfu1m22ZBM65OQFC4V9FKWyRqjILhf/5mQEIYoPH5
 Cq5Wif3HptkA++TptHDnoTFCOHXViKmMWb52nKVjMu4lDqIPIKQFPW9805QZkFQ5qQM79r9IF
 N4+6ahZbxp6cX7gZowRXB5wE3hkD5LTAKvEz4FSBz61N3BiGm7E8Kp59dQ2w68e8/cg2oIZek
 yOY5iIFKKQtRbggRadtdapiuVJu8Ube0aiwmop8O22aOgWxoHux/0QpPDOsBgRplf7xz88KK7
 G0zEwtKSeK4YNyqxzmrEN/64rWhNgHpIvy4db6gn5/0cdY59TorHtn02tac+1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git diff is missing an ignore option, like `diff -I`, which would be 
especially useful for translation files (.po) to check changed contents 
and not updated line numbers:

#: sourcefile.c:/123/
msgid "id"
msgstr "*changed text*"

"changed text" is important to be checked, "123" is distracting

Kind regards
Thomas
