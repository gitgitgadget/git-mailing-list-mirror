Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164CE202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 18:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760762AbdKPSuo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 13:50:44 -0500
Received: from mout.web.de ([212.227.17.11]:56940 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbdKPSum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 13:50:42 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8zOD-1eKeQa1qgv-00CPq8; Thu, 16
 Nov 2017 19:50:37 +0100
Subject: [PATCH] apply: update line lengths for --inaccurate-eof
To:     mqudsi@neosmart.net, git@vger.kernel.org
References: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <acc527e8-f617-6230-9872-0b23ac24f8e5@web.de>
Date:   Thu, 16 Nov 2017 19:50:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Syn9iNoccrRVMZcOgEBE8AKLhZDCgdDwIaRZKIA9LT0CpmS8miu
 ADPN/x93pFRxHrT1YPwtl9BuEu1vSi/paFavQNw1QS7ofY5qV7AjkDtNjM9blCl+6v0MmmV
 exnPx8S4ng5yCcHAyLAIVm77tsRw6es8qbQZ123bb7PhlQ7eqXqTvqDWwwbQG3uTt8Yih4d
 /l9HmF29Xfj/+1OvdP/DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J0BYibtdFOg=:RkSqCdQilz5wqASjx2IaQu
 glFmVd16J+TjY8V8D+SylpNXZSHkxz0JHsAwVLIUZR2vjyLRdCawwRmUjNl56YB2CzcgcP3gY
 wmWH/2hVYwPSY6CJE4ZeUdrAwg+MoYJkxY4PMNgaP6rOc84R3Hoj+KVtN9gvP2CrH63KD3aKr
 c1XlGwcki2+M2pUwrPuvyyTuXkmNYiRRyDbgJr+hjN+ks16td+6WdEYX2QkXk8/s0cg/Q7kkA
 krQbj0aQOHocd5cKnsFMXqjOcigvypDcIVd2d6v5X6SRDjyCwdoLqK0wQK7Dm4uRzlWtG98TV
 PdnwXALMjo7j0iWEXKdUpmx3+VzigDruQx+x6HmqtWupj0nYLYIuppa2WWqeqh6iOVRLErbxb
 6yErqtUlA1ijbbvpatoZu67n2Zo07q+8tkNyf59I4ut+NczTUEuMDzO2MzgI/sA6929c6On51
 332cZRNbxCdxjkf7AVgpHYE6bUZW2qfoxWKMXfET0PgrLA6Iw0bP3VtqRudheYrMidgvpKnCy
 INia7wEYq8lB6joBu+ybwKu+KJ8aFRGC3zNsDKyqfTLGQO9yaiZ48sb97grHX3Fwrk9C1GMGb
 002qUE6g11ervc1Y3ri+XZgV9xM+9Cz94GIhz2XcA2Flwufh7gjffSBA7kma5HTwq/KvDxl4/
 PtpypMt5bpd1EMXzwpLgmyuY92qzXtzKXqvzhlsSTOIs7VUxsMZvY2IFfIyOCuj9zkThghO6A
 +oC2oBbFpnty4IMm5JC8N4ydTRWhPX3dWInOWiyvvI+jPo3tbNeauCk3SIdUsN/k321DEJM9Z
 G+hccEuxgXzKfCTruBssB5Yc4f5buwcjubcTNRAisB2LZmsovY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some diff implementations don't report missing newlines at the end of
files.  Applying such a patch can cause a newline character to be
added inadvertently.  The option --inaccurate-eof of git apply can be
used to remove trailing newlines if needed.

apply_one_fragment() cuts it off from the buffers for preimage and
postimage.  Before it does, it builds an array with the lengths of each
line for both.  Make sure to update the length of the last line in
these line info structures as well to keep them consistent with their
respective buffer.

Without this fix the added test fails; git apply dies and reports:

   fatal: BUG: caller miscounted postlen: asked 1, orig = 1, used = 2

That sanity check is only called if whitespace changes are ignored.

Reported-by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c                            |  2 ++
 t/t4107-apply-ignore-whitespace.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/apply.c b/apply.c
index b8087bd29c..321a9fa68d 100644
--- a/apply.c
+++ b/apply.c
@@ -2953,6 +2953,8 @@ static int apply_one_fragment(struct apply_state *state,
 	    newlines.len > 0 && newlines.buf[newlines.len - 1] == '\n') {
 		old--;
 		strbuf_setlen(&newlines, newlines.len - 1);
+		preimage.line_allocated[preimage.nr - 1].len--;
+		postimage.line_allocated[postimage.nr - 1].len--;
 	}
 
 	leading = frag->leading;
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
index 9e29b5262d..ac72eeaf27 100755
--- a/t/t4107-apply-ignore-whitespace.sh
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -178,4 +178,18 @@ test_expect_success 'patch5 fails (--no-ignore-whitespace)' '
 	test_must_fail git apply --no-ignore-whitespace patch5.patch
 '
 
+test_expect_success 'apply --ignore-space-change --inaccurate-eof' '
+	echo 1 >file &&
+	git apply --ignore-space-change --inaccurate-eof <<-\EOF &&
+	diff --git a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1 +1 @@
+	-1
+	+2
+	EOF
+	printf 2 >expect &&
+	test_cmp expect file
+'
+
 test_done
-- 
2.15.0
