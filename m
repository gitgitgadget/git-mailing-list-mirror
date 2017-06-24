Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150B520401
	for <e@80x24.org>; Sat, 24 Jun 2017 13:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdFXNRs (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 09:17:48 -0400
Received: from mout.web.de ([212.227.17.12]:58453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdFXNRs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 09:17:48 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIN2h-1dLBVO3v15-004E2q; Sat, 24
 Jun 2017 15:17:22 +0200
Subject: Re: [PATCH v5 2/2] strbuf: change an always NULL/"" strbuf_addftime()
 param to bool
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170624121452.7952-1-avarab@gmail.com>
 <20170624121452.7952-2-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9f3720e5-b8be-978d-4f6c-8c082aef3680@web.de>
Date:   Sat, 24 Jun 2017 15:17:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170624121452.7952-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xqfZgR+/j8VVvTbdNrObYUvK5snTmu5o0v1qQd4X/nnq2I2akHh
 bMAJ11iXQ6LT0S3FGTzgKAM+Usaq2V2vH7RNFhtD/06+qFgwuR+bCAyShkQ+Q48FZoFD8az
 jzpdYg+RDZ2rgM3VG2Pq678rNR0zfveF8hBr1/zFMwBdSaiab8470xyAAxyUKvZVeoKxKE2
 RA2seHMyhAl4zdzSIJnJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xTLLULZ4ElI=:sm2pY2znmG3fNFKDcJPrtT
 NCDLfQMqyn1Oz5ZwoF9y/Au405eE9yf1EUIDo7QvskhTFvIDAGqVeASrzU3VltTowLkrYND8r
 TVPehNAD0+o6y/aOqKwJV1cLNW0bp1endMVgcv2bY4xlUleMhdstf/Hic2zZn5kMqrHrEtrCS
 2bnNkm0YojNBgsi8xEVdawYZ7KRfxkqeG3CHwx5p0lNiALS0Bm0p1KgdmCMnJKKiJ68ppVh00
 z35IN7sExHk1pTqJtBUyXAARjA2+BElF1sUYM2aOESs93tWmVH6ohqbLA/n1VgLi/dlbs418p
 /iw5btFHsr4dkBkp74gZALHjn14dywXQLkl69d/HQe3pi0VCglaTV2irqL7yoeOajToguO+QN
 1Y9pJutoZxnilnXw0REv+aapQh/pjBl2GAjPtbtdVp4igiJrMzgdua6TJXUxYPwB43K+UMw79
 tZ6F63hSFOU6aMYIWqyRf472V5Jf9zsMMT2qYiaRFI2BqV1ZAZ+gSvE0t/L13cmtKk6hwUboE
 7rvIDXbhu2Ic79MN64fTHKzOpUTwH1LdekiYEOOxtoRfYnKcmF6b5KqpV+G4uZ17NaI9yCjmu
 sd4WPoXB3/VLDPzNenR6OAuZZRZovJFaioquOWpryArbTvdAs1j+0Rxg4GG6MrWtYvBqt6IyW
 TGDc5E+o4XbTyCd1/o9xORZsQ5a+iNMdMEtgYFUpNtGEPYfeCH/Mmbbqamv1Sle5WmyxU41J/
 zsLaAL3XSpkfeztQijJtzZXGncOBfOcJZOhJxtucdUrW4ycV5qVQhFXe5ls1GeQKXowCvzlMx
 mFJSgM6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.06.2017 um 14:14 schrieb Ævar Arnfjörð Bjarmason:
> Change the code for deciding what's to be done about %Z to stop
> passing always either a NULL or "" char * to
> strbuf_addftime(). Instead pass a boolean int to indicate whether the
> strftime() %Z format should be suppressed by converting it to an empty
> string, which is what this code is actually doing.
> 
> This code grew organically between the changes in 9eafe86d58 ("Merge
> branch 'rs/strbuf-addftime-zZ'", 2017-06-22). The intent was to use
> this API in the future to pass a custom leave the door open to pass a
> custom timezone name to the function (see my [1] and related
> messages).

"leave the door open to pass a" seems redundant.

> But that's not what this code does now, and this strbuf_addstr() call
> always being redundant makes it hard to understand the current
> functionality. So simplify this internal API to match its use, we can
> always change it in the future if it gets a different use-case.

I don't understand the confusion, but of course I'm biased. And I don't
like binary parameters in general and would use named flags or two
function names in most cases.  But that aside I find the description
hard to follow (perhaps I should do something about my attention span).

Here's an attempt at a commit message that would have be easier to
understand for me:

   strbuf_addstr() allows callers to pass a time zone name for expanding
   %Z.  The only current caller either passes the empty string or NULL,
   in which case %Z is handed over verbatim to strftime(3).  Replace that
   string parameter with a flag controlling whether to remove %Z from the
   format specification.  This simplifies the code.

René
