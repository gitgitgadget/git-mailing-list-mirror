Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DDE21F404
	for <e@80x24.org>; Wed, 28 Mar 2018 21:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeC1VOV (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 17:14:21 -0400
Received: from mout.web.de ([212.227.15.14]:38067 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752832AbeC1VOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 17:14:19 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmQS2-1eSmrA2n7S-00Zuvy; Wed, 28
 Mar 2018 23:14:10 +0200
Subject: Re: [PATCH] submodule: check for NULL return of
 get_submodule_ref_store()
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        jeremy@feusi.co, Prathamesh Chavan <pc44800@gmail.com>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
 <20180328183832.243036-1-sbeller@google.com>
 <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
 <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com>
 <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <38570708-e166-0004-878a-2d8442c12b65@web.de>
Date:   Wed, 28 Mar 2018 23:14:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zb2lT/IHBmkM3K5QAO8R8Y2FKp7qrIvt6iXdMSBM91L0uCMnyqW
 yVvIJaccud3aDJk2u4PjaNogFi4S0xFtVtVfcevFNvM5RxUXOL8kNOXsJO4eJgfIIdhOLlH
 9jU3jzMGOd6HMchVz+AAcuTIc6dVGNNb/5lQNEXpH7bJcVPPV6RqT+qybnwFLV5D+dAbnlF
 9isdqWlAXyoWc686Rptgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MGBe4yHtZA0=:xDw3A/Dx24LCO0gb9QOCnW
 3nWxZLhpJfXyJyOvetAaSxtlbyCMmA4MMRnlydKeKMguN6ZmwdA2eLKQsgvoJhC3h2DWJDcml
 JqNxBR9Mbc85y8hcvDPsaQhXczT4qi7pg08MOl3teK82pTFLTgyV9k9dxqWiL+YD2nbbn1PhJ
 Wqs8CIb5RH7hVz9fR8wbmHKdqbzR5psINoaHGLjI4i8NtUYOGGNpXxITWFYg/P3zZmOMCGwtl
 YHR5XnxQQ3zG+CifVSehIe0u4vhpLnA3uAPWsilosJDNVLPESanWwGkW5ddHaNO8Ty1+DmvvL
 niBdPoNDLJgdgqIgcDQKOHQFZeNsQz6JtXFccXqYFSMdcC/95/I/PBZ+rvTzzFVfOB3ZQ9SZA
 aobiOnsBxOK9aVLieX8wW1Vi4zzPL1fFjqo7Ayn4ECLzXXtqdRcju8GecS2HtZYxmtgOzG+sr
 gp1EOF56vSla7lY6CXEJcJynljNMBN84Ck3/GAJeVFB2I8OBlDmyrQr2R05srI05VmX44tzWm
 6hu3cT7qhQbosadlew6eF29ZNGcyEiSPGyMuny59Cit3HTjVspXpLu31VHC60pWY/LENQ/Sco
 aqJQwcv4+Aq7veIe1L/AYG7lu2wR/awG6VzPMwYgayg1qvB0ViTOHkAC+/clP8V6r+3s/qc/t
 uvhu6U3UuyBV9gaumN4Nhpo28okxHiZ+8NZ/ZPz1X7uIPRqp8xv6SsBRDbc4/pTjzmvoJyuIw
 3TnYpK2OiCpnAnrGCAXoeo9fT3KRnh0PZY2LA94MjrgFIX1jwY/WZ3dYf6h8mF20LZG4JcLRp
 vDlqhHvmlLX6tXhSM4MdWhJsObnZSegZ86pW6WIG1A9zkZKbXY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.03.2018 um 22:21 schrieb Eric Sunshine:
> On Wed, Mar 28, 2018 at 4:08 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Mar 28, 2018 at 11:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> +test_expect_success 'moving the submodule does not break the superproject' '
>>>> +       (
>>>> +               cd addtest2 &&
>>>> +
>>>> +               mv repo repo.bak &&
>>>> +               git submodule status >actual &&
>>>> +               grep -e "^-" -e repo actual &&
>>>> +
>>>> +               mv repo.bak repo
>>>
>>> Should this "move back" be encapsulated in a test_when_finished?
>>
>> I thought about that, but decided against it for some reason as I was debating
>> where to put the test_when_finished. I mostly saw those at the very beginning
>> of a test and wondered if it can be called from within a subshell.
>> (I'd not want to put it at the beginning but rather adjacent to the move.)
> 
> It looks like test_when_finished() shouldn't be used in a subshell.
> However, wouldn't the following be reasonable?
> 
>      mv addtest2/repo addtest2/repo.bak &&
>      test_when_finished "mv addtest2/repo.bak addtest2/repo" &&
>      (
>          cd addtest2 &&
>          git submodule status >actual &&
>          grep -e "^-" -e repo actual
>      )

I like this version, except for the grep call -- it accepts either lines
starting with a dash or containing "repo".  So if status would report
just "-" and nothing else then the test would pass. 

> Or, even simpler:
> 
>      mv addtest2/repo addtest2/repo.bak &&
>      test_when_finished "mv addtest2/repo.bak addtest2/repo" &&
>      git -C addtest2 submodule status >actual &&
>      grep -e "^-" -e repo actual
> 

This looks nicer here in the script, but doesn't test exactly what users
type most of the time, I suppose.

So how about this?

-- >8 --
Subject: [PATCH v3] submodule: check for NULL return of get_submodule_ref_store()

If we can't find a ref store for a submodule then assume the latter
is not initialized (or was removed).  Print a status line accordingly
instead of causing a segmentation fault by passing NULL as the first
parameter of refs_head_ref().

Reported-by: Jeremy Feusi <jeremy@feusi.co>
Reviewed-by: Stefan Beller <sbeller@google.com>
Initial-Test-By: Stefan Beller <sbeller@google.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/submodule--helper.c |  8 ++++++--
 t/t7400-submodule-basic.sh  | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6ba8587b6d..9a0fb5e784 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -654,9 +654,13 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
 		struct object_id oid;
+		struct ref_store *refs = get_submodule_ref_store(path);
 
-		if (refs_head_ref(get_submodule_ref_store(path),
-				  handle_submodule_head_ref, &oid))
+		if (!refs) {
+			print_status(flags, '-', path, ce_oid, displaypath);
+			goto cleanup;
+		}
+		if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
 			die(_("could not resolve HEAD ref inside the "
 			      "submodule '%s'"), path);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a39e69a3eb..ef1ea8d6b0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -821,6 +821,21 @@ test_expect_success 'moving the superproject does not break submodules' '
 	)
 '
 
+test_expect_success 'moving the submodule does not break the superproject' '
+	(
+		cd addtest2 &&
+		git submodule status
+	) >actual &&
+	sed -e "s/^ \([^ ]* repo\) .*/-\1/" <actual >expect &&
+	mv addtest2/repo addtest2/repo.bak &&
+	test_when_finished "mv addtest2/repo.bak addtest2/repo" &&
+	(
+		cd addtest2 &&
+		git submodule status
+	) >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'submodule add --name allows to replace a submodule with another at the same path' '
 	(
 		cd addtest2 &&
-- 
2.16.3
