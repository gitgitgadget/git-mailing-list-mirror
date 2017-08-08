Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE1920899
	for <e@80x24.org>; Tue,  8 Aug 2017 21:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdHHVpV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 17:45:21 -0400
Received: from mout.web.de ([212.227.15.3]:56750 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752464AbdHHVpV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 17:45:21 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUSOp-1e5MGR0I4Z-00RH9r; Tue, 08
 Aug 2017 23:45:12 +0200
Subject: Re: [PATCH] builtin/add: add a missing newline to an stderr message
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2821200b-0428-a5dd-9680-f291cee0ec47@web.de>
Date:   Tue, 8 Aug 2017 23:45:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:sNir932QsUzbupft2Lxo295olbvDDa0vfYRaWEKAxAZEepax5VL
 WLJBqgvawFpaIfI70JdU2W134V4nigvQR+RoOza2sM9A+hDJPaCeATCg66k1MPV+64ip1gX
 mUWeJA/tCGsqCIwFAtHwq3yOqLA6UUrJosu2h2MdRspoOzqw+IzYWM1bPJFwxWPmPQE74sZ
 O0y2hsTZrbWAaj+cRzKQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ptwLr0N8siU=:cYC6koxFNp4m1dvVnv5ut6
 AWkrUJZwRRh+PIe2WQLVfq2z7N/9AbfRj/u3fdlQdfIeuQ12PQ39PlMQlzu+uKs4W2fIjUJ83
 G6HUN4/IxaiI7Nbz4d0cwmjmkXld4CWT1I1ecALxGF1Mc14tX69RH7WnQMD3OsA50eq4RMDEw
 9ZtTEeTOQ3H3RAi+cE04ddSAhxR6woZt2WIeiiN2kDX1KPdFbXwMnvTpRwsP+Sb3rIzJp5D6u
 zveVWVKgxO/EZmnkdSqr+YFgQPiPNSl+riynCdtZSmDU1bjR/9xWf8iUYaLw5/8OZV4RnlgeR
 ++fWfKUEp3x720tg+hMWfKY7084dDny2Y6yquQ9NEDNxOXYYONbOEVdrqwHj3l/DltITR9LV2
 zC555c+nSeqBU5qb5osVD2TdI3vvCmzFPmZPl0WjHywTsgxo7tZT4s2NK5Bv7D5PM/hn3X9mC
 DHw/Bx4AVxX+ogtGueI/Z4bovhZwNyVQMfALYSLJJPWe1cqGoi6tCA+4RNLE4Aq/FFrKVPBo+
 iT5i78OCGNImpnAGy++VBWgHoBW/rD5F/qrFla2dOmOYcb5HprpFh2bjhBlfUMsrBsGVkGBUA
 cupGTlFc3NIkmb49G4JUyOz0tKAXCfpuMOotnfqn9rh5fqV+ZVSFbxlIRiPMA3Tm2QtndhYEO
 nTLoMEh9vPw3B3GFsEFCsirSV0ocADtVGQA2P6Pa3WuYXQ/ntAHSvfww/jhIJ9BEintmYwljn
 szQUL4gE76viHmxEWkYiPp25ZOnpuacmKX6T+5bX0MqqzDkWxLKtup9JUn3Ml+bLJUYRj38/u
 1BiLDky5BzQRTKP02Ix9oPgkNJzgG/y0UZ1CrWMYd8jHAIwgsQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.08.2017 um 23:36 schrieb Ramsay Jones:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Junio,
> 
> I noticed this while looking into the t3700 failure on cygwin tonight.
> Also, I couldn't decide whether or not to add the i18n '_()' brackets
> around the message. In the end I didn't, but will happily add them
> if you think I should.
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>   builtin/add.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index e888fb8c5..385b53ae7 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -43,7 +43,7 @@ static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
>   			continue;
>   
>   		if (chmod_cache_entry(ce, force_mode) < 0)
> -			fprintf(stderr, "cannot chmod '%s'", ce->name);
> +			fprintf(stderr, "cannot chmod '%s'\n", ce->name);
>   	}
>   }
>   

FYI: I brought this up yesterday in the original thread, along with a
few other observations:

  https://public-inbox.org/git/3c61d9f6-e0fd-22a4-68e0-89fd9ce9b944@web.de/

Not sure if the discussion can or should be revived after all this
time, though; just sending patches like yours might be the way to go.

René
