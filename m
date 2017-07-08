Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC46202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 15:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbdGHPPi (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 11:15:38 -0400
Received: from mout.web.de ([212.227.15.4]:65018 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbdGHPPi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 11:15:38 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfqC4-1dHfip1bJk-00N8jF; Sat, 08
 Jul 2017 17:15:31 +0200
Subject: Re: [PATCH] urlmatch: use hex2chr() in append_normalized_escapes()
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <eb5e7bb5-d0a9-c8df-e89c-a2bd2430e8b6@web.de>
 <A1589486-3E84-494C-9B8D-3FB1724B3145@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <46294b4f-5e6d-bbf3-8b93-9d23df5ce07b@web.de>
Date:   Sat, 8 Jul 2017 17:15:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <A1589486-3E84-494C-9B8D-3FB1724B3145@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Q61bnNNi7q3G3RaRu/gfkGrZUS+vGjwAp1nWRIW404QlkNudTZ9
 pXBdkSwKYpyYIhyPtv7J2504m/LSbbDhQnoCzWGPXoIHYxjwLLaJMz3C2SVoNqfB9Ii9gOr
 kGg+W4p5h4eQeFsae20OfXvPoYpf9JprAsrX6+RXtm/bwY5Q4VFP5hU9G2y7ccr1CwGyjSj
 CIdDmXnxjjguRErp9lHjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K2zgEbp9JIg=:8C9qT6m1G+AhMWSVh6if/a
 mZqezB1zbgJkvBWfZdXIUZ3UUfexMqayFUcLFnRfYLxXvZZVFfg2FBRhj+byC7Vc7nuOH2WSE
 GhC6lSSjXGz3CFmi2mDGH8cfNN78JDEHrnSTGp8QdUxSCMqUDl3N6YX9bH5y1qVAuG+xNx3SP
 kSZE/IT6kOuxJjzczNqh9Ttl4mJO8Mo1edDvgsF3SskUItpTp2BX99G2Wj7KkvRO/avExw2a/
 bqHn0+dm4iw6ixidj0Kck1phE8Gcpt0kctcW6j1axm/vqRdQiZs8QjcFGsBLKIN0xhe8FitvL
 aiT9ZkoX33zWdG3pwnfu06SZpRgpMltgdDAUZ1kMsLujQ7VbggtWtnHjpolAUTyRNzxcitXMH
 I0wv//aGY8NrXYnLCJWJMHrO4yasBgX+a19YkZVLmQULa+PQ1dukHY7wxLonzvLTuYhx/sHcz
 zNYvHszHu48qBasTQ8yetB8VQzFytXXeKNSQppI0/OzacxkgPHOcaLStqaoENWE3BbkPx7Osh
 mn+qsGowe9ovas2VTtf7CajjKFyeCJye8A71Z2/acibGuYCxUGaCWGMedLfWS5HnPjRNQRah6
 OGnaeK6Opm3lYgINiihy1EStNRFSreTYDJ40Wg+W/MX9wSgGtUVPoDngHQoEPW2TsuH8byedI
 9s0blICaSLVU2WZJ+izodaekLPRuFemBWOfNiq68AGLn+E6Kx+vAfG0iCqOs6JwMYFjKjTHr4
 rnfJD1SkTU3Abdd5tlmHF1w3JZjCr2MThQodHQ6slf/16hVKxsTdqyI/cMxv0TrZOruBO1690
 C8EWFx+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.2017 um 16:28 schrieb Kyle J. McKay:
> On Jul 8, 2017, at 01:59, René Scharfe wrote:
> 
>> Simplify the code by using hex2chr() to convert and check for invalid
>> characters at the same time instead of doing that sequentially with
>> one table lookup for each.
> 
> I think that comment may be a bit misleading as the changes are just
> switching from one set of inlines to another.  Essentially the same
> sequential check takes place in the hex2chr inlined function which is
> being used to replace the "one table lookup for each".  An optimizing
> compiler will likely eliminate any difference between the before and
> after patch versions.  Nothing immediately comes to mind as an alternate
> comment though, so I'm not proposing any changes to the comment.

Right, the table lookups for isxdigit and hexval are not duplicated when
compiling with -O2.

René
