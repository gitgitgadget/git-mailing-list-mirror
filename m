Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6E320286
	for <e@80x24.org>; Fri, 15 Sep 2017 10:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdIOKBg (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 06:01:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOKBf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 06:01:35 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0M0MsD-1dZl5B3Vcr-00uXXE; Fri, 15 Sep 2017 12:01:28 +0200
Subject: Re: [PATCH 1/3] t6010: test actual test output
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1505394278.git.git@grubix.eu>
 <80f7dcfaa9162dc795f8c072effea44fa83ea196.1505394278.git.git@grubix.eu>
 <20170914143450.tmomqf2vs55tk3nz@sigill.intra.peff.net>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <089cdbf6-7556-6fba-21f2-6602c5ca8920@grubix.eu>
Date:   Fri, 15 Sep 2017 12:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170914143450.tmomqf2vs55tk3nz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iAsDeBRazDK4BIhP3jhFt//I1GFl8LfFMkegB70XqLvBOKZI5ew
 ewMWpGnB0Hv1FA1lwPNrPy+rdQP2GuS3C6kFZL11rSoKDUfnrzSmw+e5Zx8E/0AU0lo05MA
 NcVlWWWxus5pa9KwBhn8n1Bz5AnF9bBKYv/qoxRQIjALLHFVURpZLI/hf9F7TLzzja7ObrI
 kOaFbvqV3mqIkHe0fC3TQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q1+JC0L/c+M=:dXceBf26De3hqr9Nzxlt2E
 oBIH0r5vfJAyrEBAg3X5Rd1B3fI3S5rZ3rAuhsDWdk0903sRhnVWIM8Ckb4RsZdKbdgoluZNk
 EKxHJ9Lv8xLw79/5bTbI5ZjjGdLYL+M009cfUODTFFr9AYgYwMvqJJW1ALPUGb/ObBOE9QDPB
 s8dcHGsRE33N9xbe8QekmAO07qigQ24x0KTO2kTcqQRrKDlDHiAY4vqhzY3yoxd4IyEWtuT1d
 mgpS/9dBcuwoZmH7h1M4OWVJP/iVk+Ks5ZYWeKIhCRBfHXeAbhoTnoZVwjsW947a5MNdjXQVu
 30Fx7MSduk16Nqig3LwKA1JUeuX+QmyAK0RHlt+Jmy44DDoGN1zNP37qZxX7Ex4q53MS8FePn
 M4gZu6uqnacsxtQxcAUrdnr+HqElbMQCopDfJNCiHHO3rfxp45/qnSejUvYrvowgpd8R9izyb
 Vkk6F/hmJueqwaydG92MykS9+HKHG7qVCh9FRZfa29Qr5HuQGQiWsK4HGU7x/NX/wsoGesjE5
 38c4948pC7gLxoephov5yhWy5emn5fLypAScBUw0NhFmsP87Y/p1h3kUYGpoyZdZPA/wCqUvk
 +FXPFdBNU5FZbJCY8gF6/ER0WD2DN0D6z+sdVhxVww2rfDl6PaIvW7/FgchIPpfNVk8UF4oxQ
 NQupsIpug6bSHM3fujRm7ycsFYZurD9iXl8UcFeDo/l+bSJhvXXWCKmB45rA8pmzpE2EGp5Ps
 78hq4aeXVh491qnZwAmTey0CmyytEDNMnVXku7K0ghqsRomelxKCQNhvbNM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 14.09.2017 16:34:
> On Thu, Sep 14, 2017 at 03:15:18PM +0200, Michael J Gruber wrote:
> 
>> 4f21454b55 ("merge-base: handle --fork-point without reflog",
>> 2016-10-12) introduced a fix for merge-base --fork-point without reflog
>> and a test. While that test is fine, it did not update expected nor actual
>> output and tested that of the previous test instead.
> 
> Oops. The use of the existing "expect3" was intentional (the idea being
> that we are repeating the identical step from the previous test with the
> slight tweak of not having a reflog). But obviously failing to write to
> "actual" at all was a mistake.
> 
> That said, I'm OK with reiterating the expected output.

expect3 had a different content, too ;)

Michael
