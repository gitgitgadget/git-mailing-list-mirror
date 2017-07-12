Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD270202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdGLR64 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 13:58:56 -0400
Received: from mout.web.de ([217.72.192.78]:54334 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbdGLR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 13:58:55 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgZv-1duTrT1K9n-00kBKM; Wed, 12
 Jul 2017 19:58:40 +0200
Subject: Re: [PATCH] sha1_file: add slash once in
 for_each_file_in_obj_subdir()
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
 <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net>
 <xmqqy3rx8svk.fsf@gitster.mtv.corp.google.com>
 <20170710000638.p7foedomfmdakyww@sigill.intra.peff.net>
 <xmqq8tjx82kf.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0465f03f-3d60-15f5-6d67-80b46b6c8c5f@web.de>
Date:   Wed, 12 Jul 2017 19:58:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tjx82kf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:mPwSW//Km1d35x0LNnSn4+M8sCcoibmHIw1KnJMp87Qzlm9cPNo
 u/THpUQIOb4nx9QseNUf2uqk3rMHCMx11K+qB3RSXvYyUY9DjhBs09dvd4ejtPO/xSOEnvN
 ZHwWc8GV165cl9p5S1IcViXNDKH6OTiCWPY5s8RffLqM68eIr/FLMiC3h7mSFsALXkoxiQY
 iBtUK2RrChJ0XpVQkKpuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R8qazaG1uLc=:SgV1rK96GE7vQuHO2PbixE
 jzxVkCBYVKRLYNT9ZdXPIANZa5dxGJocQRQERMOOAObGBxiTcB/PiFavFRgrFZUbFKZAXe7sT
 nyg96/xnIQ4yi8poxnl8AzEX8zw4MHRp/euiU7raJvqsOzay4PLGIBAo02vSJ4VK7qa0SmD4O
 6BN8Sq/sm92LU+4rHB7WYirK26AjGD8I0iVrp2IKbQOoa8++YLd2O/zKxHrTe209cjK/9YPu4
 +ttwqrgrALaabJn5xabVekzm2Ay6Kzjaen1G3363HnYiHWbAuKbmv9r35qm/HKqfvLWsNozbT
 d4gJmAKk2tHS4svTtSPzZqOtvQwgIL5q+2YTjwhLnpn9n9HH1tbfsejrf1W+/US8dFfFG0V3W
 BD7icUB0UsGO0/za9DObq5CTkuUqVIdaBSI5W5BDZkbZTlaRoHhJQE0lkEODzfIbxi8S0Gi/t
 P9Se30G6/NrcCJVF68BhsY6/yraB9htFWZAu+pgv1giOL1qf+nKV5SJ3uWXoY3BwrcTJSTPzx
 uAJ316AAImjxE8HpKykIaGRwKvyyvyIj02HbKi4GO4YN8/3KJ4B7Mj7XXNKOxlgBaR3eBOOU0
 u597Y2PkkhNrenwCf3dKQMZDRpD753FpFaHgwjNnlB/kVfOuQFGS1mL7DUcY5DD0UuYJneEqr
 kYt/x+OjNxPDavs0Pg083mCYoQHVTeATQF9aUJYmsdpQxGbETG5Mc/6ckXtPYC42DK/34LziI
 E1vOlsJB+EbuTQcYOwTwpLBPaKIttuJSZpXFrNDAqeIl5JkGY2aAkNtFwBSBKsAab82BTBSig
 klzQv4l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.07.2017 um 04:10 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> ... And you could even drop origlen by
>> replacing it with "baselen - 3" at the end. But somehow doing the
>> computation on the fly actually seems more complicated to me (from the
>> perspective of a reader who is trying to make sure all is correct).
> 
> True enough.  I personally do not mind any of the three variants
> (including the original) and would rather not spend too much time
> micro-optimizing this codepath, lest the next clever person starts
> to turn the loop in for_each_loose_file_in_objdir() to a nested loop
> that runs 16 times each to avoid copying the same leading byte again
> and again ;-)

*evil grin*

Anyway, I agree that this patch is not worth spending much time on.  I
still think the result is cleaner (perhaps due to my strbuf_addf
allergy), though it's longer and perhaps adding a twelfth variable makes
the function too complicated.  The magic chomping variant is a clever
compromise -- but needs a comment to explain itself.  So if you are
indifferent please just drop it.

Thanks,
René
