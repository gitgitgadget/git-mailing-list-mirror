Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DA521841
	for <e@80x24.org>; Wed,  2 May 2018 07:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEBHl4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 03:41:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:35711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeEBHlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 03:41:53 -0400
Received: from MININT-HARFK7P.southpacific.corp.microsoft.com
 ([37.201.195.116]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MLfLH-1fE3F81XdL-000qsF; Wed, 02 May 2018 09:41:41 +0200
Date:   Wed, 2 May 2018 09:41:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t1406: prepare for the refs code to fail with
 BUG()
In-Reply-To: <xmqqvac6wwrw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805020930340.73@tvgsbejvaqbjf.bet>
References: <cover.1525040253.git.johannes.schindelin@gmx.de> <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de> <CACsJy8A7K6-W=H_08JcJgtziz3aQ4B1WgOcsoMSMuSvEQDW8=A@mail.gmail.com>
 <xmqqvac6wwrw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W/YV/3eGYAqTL6jqiHyTLwD+pJXrOykm5GR2dZRdlyX6cW3C5Ar
 mwYNGbly4ibnay2Iuk2onvS8pmFQbrGFgmwiBt3uLLuoJBypVOlvCF6Td5QogkwlPMN0jct
 EHFjd3rN/6/GHFQpu1CQt5nLYQ9aB3fqgYd9E5yh1cSJ2zD2hYJmG/HaWXAESgcHK+7zkLD
 9v4RG5af+rFRdmLdxUeCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c202Vfk3ED8=:8HErixxZQF41F7ywq82qZK
 /so9q05qt1dkFGyOv3DKTivK9sj2k2/ANm8c1g04Q8waJ6k2vpyg+Evn6jxC9Q7RiNHxjyOmD
 6d8gTffm1BwYKhodb8or9KECBRcVcTl8saL9Y0EiiGN4ihwwCEXBtXF01JmiTpEtOnAYCDNPv
 06JGlHWsskV6J1LsfmyTMWueYhhs9uqOI+FHtus8b9wcMmtlEgmdyFAMrxMe4nOa6np049Y1J
 +9QDwl+tPhIcX9pxafhmwPlmSrGRiWuYY+spnquBgvMkT48S4uUFuBbw+7S0/HOZDRrwNlRsa
 m0Mop2HvfRjnBqMWkpzMXAGXrEWNxsJh95A1tWanAYwO+I8e1l4QNCQze/9bFD3TgCOJ2/wTa
 Lbg8sfgSQbDxjlcso2KsbZh6WiBJws0gXVV5j7SinLepf1IecgtmrszVIB4s88Rrt+hNKo5gx
 2BpRoVajLcFIcPwahNL7xXu7+Aw2Uy1jeM65x84LZ0bznxmSurOWP4NKc7e9hJnyutQyEZRaj
 cncAVcf0/29Rm/p+Oy550rppafKOzLq+6oQ1wWWZjP8QzC3wsV2atryqh2yETINuJ74tMC9Hr
 61Rx93Y8ygT7nVt9pmxFtISDCf08/eXVLi9wSttp4Trwg+4Pd+sE0c4gdMCSKzEQo2v+2Uphl
 mekgQSf8zJ0VNWYDG4K/iI+qT1EucDykDWL/4bxITtyzpmDzfOHMbE6Oda2pvDOCLLvZnek5V
 142ZZgnZVMNz9gadweb6LV8ofjKzcMhB5YOQL9JkuLLxhNYXbp4VVi3IPUJnd1HE31kdt8WkS
 E0lNzQZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 2 May 2018, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Mon, Apr 30, 2018 at 12:17 AM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> >> t1406 specifically verifies that certain code paths fail with a BUG: ...
> >> message.
> >>
> >> In the upcoming commit, we will convert that message to be generated via
> >> BUG() instead of die("BUG: ..."), which implies SIGABRT instead of a
> >> regular exit code.
> >
> > On the other hand, SIGABRT on linux creates core dumps. And on some
> > setup (like mine) core dumps may be redirected to some central place
> > via /proc/sys/kernel/core_pattern. I think systemd does it too but I
> > didn't check.
> >
> > This moving to SIGABRT when we know it _will_ happen when running the
> > test suite will accumulate core dumps over time and not cleaned up by
> > the test suite. Maybe keeping die("BUG: here is a good compromise.
> 
> I do not think it is.  At regular runtime, we _do_ want Git to dump
> core if it triggers BUG() condition, whose point is to mark
> conditions that should never happen.

Indeed.

> As discussed in this thread, tests that use t/helper/ executables
> that try to trickle BUG() codepath to ensure that these "should
> never happen" conditions are caught do need to deal with it.  If
> dumping core is undesirable, tweaking BUG() implementation so that
> it becomes die("BUG: ...") *ONLY* when the caller knows what it is
> doing (e.g. running t/helper/ commands) is probably a good idea.
> Perhaps GIT_TEST_OPTS can gain one feature "--bug-no-abort" and set
> an environment variable so that implementation of BUG() can notice,
> or something.

I think we can do even better than that. t/helper/*.c could set a global
variable that no other code is supposed to set, to trigger an alternative
to SIGABRT. Something like

-- snip --
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 87066ced62a..5176f9f20ae 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -47,7 +47,9 @@ static struct test_cmd cmds[] = {
 int cmd_main(int argc, const char **argv)
 {
 	int i;
+	extern int BUG_exit_code;
 
+	BUG_exit_code = 99;
 	if (argc < 2)
 		die("I need a test name!");
 
diff --git a/usage.c b/usage.c
index cdd534c9dfc..9c84dccfa97 100644
--- a/usage.c
+++ b/usage.c
@@ -210,6 +210,9 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
 
+/* Only set this, ever, from t/helper/, when verifying that bugs are
caught. */
+int BUG_exit_code;
+
 static NORETURN void BUG_vfl(const char *file, int line, const char *fmt,
va_list params)
 {
 	char prefix[256];
@@ -221,6 +224,8 @@ static NORETURN void BUG_vfl(const char *file, int
line, const char *fmt, va_lis
 		snprintf(prefix, sizeof(prefix), "BUG: ");
 
 	vreportf(prefix, fmt, params);
+	if (BUG_exit_code)
+		exit(BUG_exit_code);
 	abort();
 }
 
-- snap --

I'll try to find some time to play with this.

Ciao,
Dscho
> 
> When we are testing normal parts of Git outside t/helper/, we never
> want to hit BUG().  Aborting and dumping core when that happens is
> an desirable outcome.  From that point of view, the idea in 1/6 of
> this patch series to annotate test_must_fail and say "we know this
> one is going to hit BUG()" is a sound one.  The implementation in
> 1/6 to treat SIGABRT as an acceptable failure needs to be replaced
> to instead use the above mechanism you would use to tell BUG() not
> to abort but die with message to arrange that to happen before
> running the git command (most likely something from t/helper/) under
> test_must_fail ok=sigabrt; and then those who regularly break their
> Git being tested (read: us devs) and hit BUG() could instead set the
> environment variable (i.e. internal implementation detail) manually
> in their environment to turn these BUG()s into die("BUG:...)s while
> testing their early mistakes if they do not want core (of course,
> you could just do "ulimit -c", and that may be simpler solution of
> your "testing Git contaminates central core depot" issue).
> 
> 
> 
> 
> 
> 
> 
