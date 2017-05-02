Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56DD9207D6
	for <e@80x24.org>; Tue,  2 May 2017 05:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdEBF3w (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 01:29:52 -0400
Received: from mout.web.de ([217.72.192.78]:61173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbdEBF3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 01:29:52 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lw0uH-1e8oWK2hI5-017o2W; Tue, 02
 May 2017 07:29:37 +0200
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
 <070a4b85-98e0-12a4-6c9c-557f3dfa733c@web.de>
 <20170428214934.tuqihgch6qeen3ni@sigill.intra.peff.net>
 <11699799-6bdf-484d-5a1c-8e8fa7981594@web.de>
 <20170430031154.qurrbdb3wqrdxd37@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57741b45-81b4-5940-3ffb-10c3b067cce3@web.de>
Date:   Tue, 2 May 2017 07:29:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20170430031154.qurrbdb3wqrdxd37@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3hvGzbdxK2Hpi0CwsFRnhgFmooiGlZgrchVyPlxWqjxR3M283Y4
 GOIE0FJYKjkH1L6bDeREwx/fsmK35sMzs2gv8mEmz+oXG7O9KkFdHRdqiDYtYaiaix0LGeO
 WzfeGBZdLFJ307nLMjmRbY/8mEz8VKk33P5wMJ5mrP1/Yowp4Llr2gh0O3jpUd4aBFKq4GU
 8WwKfu0Er8fF4TyweW9Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C+4UViKytTM=:MKMM6sKz26O0Hkh3fm/eJA
 fPTfczbcFTWqEULv5x542d2AQczxxG4S+a+ke/sPeFthpoipI5bdO54fZIx8917ZKG54UC1ns
 ysyczDkoDyK+vLY2spCdpUgG4RjJ28HYx1MHUJKToious8Ig2c2F4Qku/f/oUDPxrP6dkoun8
 yJ8oeUaGCI9nEi/mKSh3OW3uL+2gaaicfvqGUwcI1BOEN04CkzZcvdTP2E8whFNXH1i1M9RVY
 Lt2mseDYFoiKH94yAP9fZY3jC5OSwb6Yn5XlN2ZCdAm8ewEuC6cgB9RGnKwDnKfKvsYCQE/8N
 2mQAvdiAMrTbDszoxonzFlpYEwPgv5yATwbIoL9uHGDzkLDHJxzR3u1fW4rmPfH5Y/Aa/rjqZ
 L2h4CUHDBtjCLGEMwp0xaXOvxSRAWn4PjxiAKo3/zpb68DhCoxvzMWJsCn9yPKjLF1nTSwsak
 mdqZpwSkH5JEiKDbos6unzLKAqXz2cLAkGEig0lfCdnpJW+4ZPXGsJZG6QT/EtBa/jxwFsYTB
 9EGU5Sq3kBAmRzxhIC7o/oTBl7Un6qtRk2WujzmSTCuv28X2L/6mtLzmMVNS/BMIIpR25z9G7
 2NJG0o47QYQnfFxDpcGEGScp4CijtA2k8BT25l0AQzuHlS/jU02Q1ma3wv/1w1xQwUhqCduWc
 pv0eyh4QGttQvKrMiHs+m8fNTkSvOtLXMxc/ROYM5WGaxGLeY4qztg5THxcplZw0AlBbbEbZb
 HYfTj70utoBqW7viTBTByt+Y8DRc2fjMwYWqiDmAAKty6rOBthbcBuJIXLAGa3eIDTJDLJxOM
 x2R0E8U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.2017 um 05:11 schrieb Jeff King:
> On Sat, Apr 29, 2017 at 08:16:17PM +0200, René Scharfe wrote:
> 
>>> I dunno. I could go either way. Or we could leave it as-is, and let
>>> valgrind find the problem. That has zero run-time cost, but of course
>>> nobody bothers to run valgrind outside of the test suite, so the inputs
>>> are not usually very exotic.
>>
>> It would be  problematic on platforms where memcpy has to erase the
>> destination before writing new values (I don't know any example).
>>
>> We could use two temporary buffers.  The object code is the same with
>> GCC around 5 and Clang 3.2 or higher -- at least for prio-queue.c.
> 
> Hmm, yeah, that's an easy solution that covers the overlap case, too. If
> the generated code is the same, that seems like it might not be bad (I
> am a little sad how complex this simple swap operation is getting,
> though).

Patch below.

All is well if the compiler can (and is allowed to) see through the
memcpy calls, otherwise we get a performance hit and this change makes
that slow path slower.  FWIW, I didn't see any slowdown in our perf
tests, though.

It's not too late to switch to a macro that takes a type parameter, as
Dscho suggested earlier:

  #define swap_t(T, a, b) do {T t_ = (a); (a) = (b); (b) = t_;} while (0)

Much simpler and with full type check, but harder to use (needs correct
type parameter and its other parameters must not have side effects).

-- >8 --
Subject: [PATCH] avoid calling memcpy on overlapping objects in SWAP

Copy both objects into their own buffers before swapping to make sure we
don't call memcpy with overlapping memory ranges, as that's undefined.
Compilers that inline the memcpy calls optimize the extra operations
away.  That allows calls like SWAP(x, x) without ill effect and without
extra checks.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bd04564..a843f04 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -528,13 +528,15 @@ static inline int ends_with(const char *str, const char *suffix)
 }
 
 #define SWAP(a, b) do {						\
-	void *_swap_a_ptr = &(a);				\
-	void *_swap_b_ptr = &(b);				\
-	unsigned char _swap_buffer[sizeof(a)];			\
-	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
-	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
-	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
-	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
+	void *swap_a_ptr_ = &(a);				\
+	void *swap_b_ptr_ = &(b);				\
+	unsigned char swap_a_buffer_[sizeof(a)];		\
+	unsigned char swap_b_buffer_[sizeof(a) +		\
+		BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b))];	\
+	memcpy(swap_a_buffer_, swap_a_ptr_, sizeof(a));		\
+	memcpy(swap_b_buffer_, swap_b_ptr_, sizeof(a));		\
+	memcpy(swap_a_ptr_, swap_b_buffer_, sizeof(a));		\
+	memcpy(swap_b_ptr_, swap_a_buffer_, sizeof(a));		\
 } while (0)
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-- 
2.1.4
