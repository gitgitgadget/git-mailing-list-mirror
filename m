Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3722D20441
	for <e@80x24.org>; Mon, 16 Jan 2017 12:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdAPMwx (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 07:52:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:57315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdAPMww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 07:52:52 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJXEd-1cRjzn3ysV-0033VY; Mon, 16
 Jan 2017 13:52:41 +0100
Date:   Mon, 16 Jan 2017 13:52:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
In-Reply-To: <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
Message-ID: <alpine.DEB.2.20.1701161251100.3469@virtualbox>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com> <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TygdWrDoSpQipoi+LIUtLqT1V+DE95FD8Mid79/1NFlAlGGpGN+
 dGFgp6IDtJZfJihMX3y36q8GTAIwIxML3WWnLdcC2dMfuHasrbp5YSI+1zazxszS5RX/W0l
 2e30o1ctSuyzDYu8N3trWFLYjxRaAFRej+gjGieM4GtCUdfcBAnZD9gkd5cErwuWKpbWNi6
 6cBqaelQ66M7mmIfr/t7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uuutcux5N+w=:jnbewcBh5vlYJdKbfVksBX
 V01dXXlcQ9KUj0FacCjnJ1zT/COsbNYTvORXLimvm8x9SbO8J4oFlf0srZH+Jv1GqccVk3MJp
 Nv9lUY749PQ58HtBvj4Zv3BtN6vumEhaHM9ou5MqU7DiHTa6+KE0gURHMKzd5Nun0UTtl/uSR
 pTl+bOXfRDYbmizpw1X0d1mdeZC2FDoznOZgStiXGzH3w7tz0be8Wgouw49xd0pgY7+h/Aywq
 0xGb9fdCGIDyNei887m2SNSqPevGOZCdRn5c6LBeEyylM01bbv9AbOImJjwM6XymtkgEOnxFT
 Rjd7WK0224fd8bTGga4wkejYt+swqMl5xjuQLCE/F+2MBsB6zfNVUp0mb3Fys2qlv+BEjtVuR
 keIjm6+jAu/ZnSObGHcDJHdbDF11zySsr4SRHyYseeXIYRVmEZdKZCJH8xdWGYl1hXbXfR926
 2dllclEI4MAY/B3nzElBmGn+o3DTv9nRu7QHOAh2JeKa3RdRhmeU+f+C6BKYZgZuyI5PMM+Rs
 cHCe7yv5kvqIy853xE1GTP/7+EuX59Uux1nBHvQluWMr4qEdF1eDI4YqWpemNLKFcBAE+cIS9
 qOH5qs9moBvcy+Z8+NKHJ9/YdDo5mpbt/vDnDafB4YFT/61BXT7oOdoN2Et8LtXpvnc0HwtqB
 UhxIx2aYP+VNvJaEjEvJGvRPkIXPaVo0VR6BjNcTzpetJQelLMF/TzPVTpyNskuzmeF+dZwPy
 3tljk/62elXkaXBPU4c5brEBVH4s3pJZB8GWoYZtqAyiv3utjIM8jyIkg0DA3FdMLwqtCi2v2
 EJB7Wgj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 16 Jan 2017, Johannes Sixt wrote:

> Am 16.01.2017 um 02:51 schrieb Junio C Hamano:
> > * jk/vreport-sanitize (2017-01-11) 2 commits
> >  - vreport: sanitize ASCII control chars
> >  - Revert "vreportf: avoid intermediate buffer"
> >
> >  An error message with an ASCII control character like '\r' in it
> >  can alter the message to hide its early part, which is problematic
> >  when a remote side gives such an error message that the local side
> >  will relay with a "remote: " prefix.
> >
> >  Will merge to 'next'.
> 
> Please be not too hasty with advancing this topic to master. I could imagine
> that there is some unwanted fallout on systems where the end-of-line marker
> CRLF is common. Though, I haven't tested the topic myself, yet, nor do I
> expect regressions in *my* typical workflow.

Thank you for being so attentive.

This topic branch would indeed have caused problems. Worse: it would have
caused problems that are not covered by our test suite, as Git for
Windows' own utilities do not generate CR/LF line endings. So this
regression would have bit our users. Nasty.

Something like this is necessary, at least:

-- snipsnap --
Subject: [PATCH] fixup! vreport: sanitize ASCII control chars

The original patch is incorrect, as it turns carriage returns into
question marks.

However, carriage returns should be left alone when preceding a line feed,
and simply turned into line feeds otherwise.

To make the end result more readable, the logic is inverted so that the
common case (no substitution) is handled first.

While at it, let's lose the unnecessary curly braces.

We also add a regression test that verifies that carriage returns are
handled properly. And as we expect CR/LF to be handled properly also on
platforms other than Windows, this test case is not guarded by the MINGW
prerequisite.

Spotted by Hannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0000-basic.sh | 8 ++++++++
 usage.c          | 9 ++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 60811a3a7c..d494cb7c05 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1063,4 +1063,12 @@ test_expect_success 'very long name in the index handled sanely' '
 	test $len = 4098
 '
 
+# This test verifies that the error reporting functions handle CR correctly.
+# --abbrev-ref is simply used out of convenience, as it reports an error including
+# a user-specified argument.
+test_expect_success 'error messages treat CR/LF correctly' '
+	test_must_fail git rev-parse --abbrev-ref "$(printf "CR/LF\\r\\n")" 2>err &&
+	grep "^fatal: .*CR/LF$" err
+'
+
 test_done
diff --git a/usage.c b/usage.c
index 50a6ccee44..71bc7c0329 100644
--- a/usage.c
+++ b/usage.c
@@ -15,10 +15,13 @@ void vreportf(const char *prefix, const char *err, va_list params)
 	char *p;
 
 	vsnprintf(msg, sizeof(msg), err, params);
-	for (p = msg; *p; p++) {
-		if (iscntrl(*p) && *p != '\t' && *p != '\n')
+	for (p = msg; *p; p++)
+		if (!iscntrl(*p) || *p == '\t' || *p == '\n')
+			continue;
+		else if (*p != '\r')
 			*p = '?';
-	}
+		else if (p[1] != '\n')
+			*p = '\n';
 	fprintf(fh, "%s%s\n", prefix, msg);
 }
 
-- 
2.11.0.windows.3

