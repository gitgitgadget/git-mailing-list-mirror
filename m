Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EBC433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 04:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhLZEJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 23:09:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50443 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhLZEJn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 23:09:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B51B717BBF2;
        Sat, 25 Dec 2021 23:09:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Cpe1TVAqp+71RoW1ybdNyE29NSc7brNb02NYhfjwlxQ=; b=HEBK
        6mJVc7CnWnK53jQXUPBlLuC1fvhnEC/wB9tiMfXf3tchX4opxq2cGseM3ED79meq
        /nWSgg6ew6b2IU5PYbBysznuoHeLGFxHVcir6oQSB0i20bET4Rd+MK+CvSkU2i5b
        nt3zIH2OiOki9wIOhPT+GytkCHRDo4siHCkjlbY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F9DE17BBF1;
        Sat, 25 Dec 2021 23:09:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F015117BBF0;
        Sat, 25 Dec 2021 23:09:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 24/29] t/perf/p7519: speed up test on Windows
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <1c2eccacff64edc0aba1d60a120f71cb94532e8b.1634826309.git.gitgitgadget@gmail.com>
Date:   Sat, 25 Dec 2021 20:09:37 -0800
Message-ID: <xmqqv8zc2eim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4F23BE6-6601-11EC-B4A7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ditto.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] fixup! t/perf/p7519: speed up test on Windows

Fix style violation of a shell-function definition introduced by
this step, and correct existing ones while at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/p7519-fsmonitor.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index e70252ed65..9e08fc169a 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -73,7 +73,7 @@ then
 	fi
 fi
 
-trace_start() {
+trace_start () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		name="$1"
@@ -92,14 +92,14 @@ trace_start() {
 	fi
 }
 
-trace_stop() {
+trace_stop () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		unset GIT_TRACE2_PERF
 	fi
 }
 
-touch_files() {
+touch_files () {
 	n=$1
 	d="$n"_files
 
@@ -142,7 +142,7 @@ test_expect_success "one time repo setup" '
 	fi
 '
 
-setup_for_fsmonitor() {
+setup_for_fsmonitor () {
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$USE_FSMONITOR_DAEMON"
 	then
@@ -188,7 +188,7 @@ test_perf_w_drop_caches () {
 	test_perf "$@"
 }
 
-test_fsmonitor_suite() {
+test_fsmonitor_suite () {
 	if test -n "$USE_FSMONITOR_DAEMON"
 	then
 		DESC="builtin fsmonitor--daemon"
-- 
2.34.1-568-g69e9fd72b5

