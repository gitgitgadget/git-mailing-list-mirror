Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6768207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 23:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755130AbcI2Xko (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 19:40:44 -0400
Received: from mout.web.de ([212.227.15.3]:59802 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbcI2Xkm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 19:40:42 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LyDqv-1at60S2Le1-015d9X; Fri, 30 Sep 2016 01:40:25
 +0200
Subject: Re: [PATCH 1/3] add QSORT
To:     Junio C Hamano <gitster@pobox.com>
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
 <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
 <eeb2791e-c09b-b7bc-f8e8-336d4f3906b8@web.de>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <302c140e-bfb9-a54c-7ce0-14b266611584@web.de>
Date:   Fri, 30 Sep 2016 01:40:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <eeb2791e-c09b-b7bc-f8e8-336d4f3906b8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:74MeBBHRBbX0k7PPYE3ntIpW4TUMAUv6Cf27u8ipTSLRqzc1yPd
 /CCoPgqyLAgs6sRI/Jbv9W0XkC6Oc1uh14E+8fd/sU0WcLL6dGjlwwQI12mI26JabEnGUwc
 s5Wc2bcaMCKCl6KSVJcZ+KvTcs1kDnJyxzNJC8/IGKMsD1MJ5bae+9P85pAyFN8ZefiKWG/
 Y/php71Ek9mzuyO8oT8gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:04ONahPtH30=:iGxTDSQuUECeFY9wDVRmgW
 ftFf25d3tRBAXiquPeLwfvro5FkKEyugvteLOsljTwbWuXQTnnu0aRD+nmDhS1pWIGQne7hu5
 /PBjt+r3uX+hcOfh6Z9g/ecMXXteFGHsfnbRQD/xwbp72n1Anf3X57ttix7czN8sqZKiIQyCH
 SSUB7NuVkvyPoLJXZKSWybL+gkN03l9PDXeIEPLv/mDvVtrsVOstr0heoR91J+5+JlNgrY3TR
 el77VonXjR6TC47qAQbxjUhNUOJAsgJmvWykV+stpsnrzjbd9hLWlTDBBdRSj2htwCKGek003
 8V/aVVBAyKGaCyLb6T6l9/F1lCc0HBJZkIy151Obs7pJSfAB2/10e0C8tOAEhbtugzPq3QJ4N
 9uurhDgu8SOaxJPR4m6+iALi11gjxMjDWRz3VQ9K7I5oAEP7JM9gv8Ca+pj8A71YaViNAIpqA
 up2PP7735agDmdH3rCRsZt+8d1lUK4lwrWp8W9lApt4Cb8VVZeqaTnW/LjFm5pxw+YoU+MWq/
 gjanRahUv29/SIbjkEC1ykFBfDd1riQQnU76hlwKiNf2r4HohTceAcIKt5UImbe94pgb5Em9J
 gJ4+CAqNwGSGQPHJfQ5OYuHmDUNv8x5bcqvFlcUgoE0Ltak8i6pqAIDtizRunDqgv0uI6kuNn
 AyTWsrnkNNRBzp7V3GOTOuBnP6p4QTcYkhjY2nkEQ24ei+Qkm2+qtZgQ0FcX236MjSa3but7d
 VpeaXRdsjRJOel0oZrbU4dXL6yDtUylrben7ZqdipOH797LxJsUtSGO+iVwQFbK4L7qAbFsQW
 iqiPcq+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.2016 um 01:21 schrieb René Scharfe:
> Am 30.09.2016 um 00:36 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Add the macro QSORT, a convenient wrapper for qsort(3) that infers the
>>> size of the array elements and supports the convention of initializing
>>> empty arrays with a NULL pointer, which we use in some places.
>>>
>>> Calling qsort(3) directly with a NULL pointer is undefined -- even with
>>> an element count of zero -- and allows the compiler to optimize away any
>>> following NULL checks.  Using the macro avoids such surprises.
>>>
>>> Add a semantic patch as well to demonstrate the macro's usage and to
>>> automate the transformation of trivial cases.
>>>
>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>> ---
>>>  contrib/coccinelle/qsort.cocci | 19 +++++++++++++++++++
>>>  git-compat-util.h              |  8 ++++++++
>>>  2 files changed, 27 insertions(+)
>>>  create mode 100644 contrib/coccinelle/qsort.cocci
>>
>> The direct calls to qsort(3) that this series leaves behind are
>> interesting.
>>
>> 1. builtin/index-pack.c has this:
>>
>> 	if (1 < opts->anomaly_nr)
>> 		qsort(opts->anomaly, opts->anomaly_nr, sizeof(uint32_t), cmp_uint32);
>>
>> where opts->anomaly is coming from pack.h:
>>
>>     struct pack_idx_option {
>>             unsigned flags;
>>             ...
>>             int anomaly_alloc, anomaly_nr;
>>             uint32_t *anomaly;
>>     };
>>
>> I cannot quite see how the automated conversion misses it?  It's not
>> like base and nmemb are type-restricted in the rule (they are both
>> just "expression"s).
>>
>> 2. builtin/shortlog.c has this:
>>
>> 	qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
>> 	      log->summary ? compare_by_counter : compare_by_list);
>>
>> where log->list is coming from shortlog.h:
>>
>>     struct shortlog {
>>             struct string_list list;
>>     };
>>
>> and string-list.h says:
>>
>>     struct string_list {
>>             struct string_list_item *items;
>>             unsigned int nr, alloc;
>>             ...
>>     };
>>
>> which seems to be a good candidate for this rule:
>>
>>     type T;
>>     T *base;
>>     expression nmemb, compar;
>>     @@
>>     - qsort(base, nmemb, sizeof(T), compar);
>>     + QSORT(base, nmemb, compar);
>>
>> if we take "T == struct string_list_item".
> 
> Transformations for these two are generated if we pass --all-includes
> to spatch.  So let's do that.

And here's the result:

-- >8 --
Subject: [PATCH] use QSORT, part 2

Convert two more qsort(3) calls to QSORT to reduce code size and for
better safety and consistency.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Squashable.

 builtin/index-pack.c | 3 +--
 builtin/shortlog.c   | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7657d0a..0a27bab 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1531,8 +1531,7 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 		opts->anomaly[opts->anomaly_nr++] = ntohl(idx2[off * 2 + 1]);
 	}
 
-	if (1 < opts->anomaly_nr)
-		qsort(opts->anomaly, opts->anomaly_nr, sizeof(uint32_t), cmp_uint32);
+	QSORT(opts->anomaly, opts->anomaly_nr, cmp_uint32);
 }
 
 static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 25fa8a6..ba0e115 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -308,7 +308,7 @@ void shortlog_output(struct shortlog *log)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (log->sort_by_number)
-		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
+		QSORT(log->list.items, log->list.nr,
 		      log->summary ? compare_by_counter : compare_by_list);
 	for (i = 0; i < log->list.nr; i++) {
 		const struct string_list_item *item = &log->list.items[i];
-- 
2.10.0


