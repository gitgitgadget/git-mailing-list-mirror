Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D0C20189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbcFVU1b (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:27:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:55269 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbcFVUZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:25:59 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M5LJv-1baE1718z1-00zXQO; Wed, 22 Jun 2016 22:25:54
 +0200
Date:	Wed, 22 Jun 2016 22:25:53 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] t/perf: fix regression in testing older versions of
 git
In-Reply-To: <20160622194013.GA1697@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1606222223530.10382@virtualbox>
References: <20160622193904.GA1509@sigill.intra.peff.net> <20160622194013.GA1697@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8p0wfMOGBcbIsitEJ3gYWS4SkuUQGM4pxMPKikE0Ub4mfPXioIq
 TL/3/LHX2w26hZPePGievWLNeV6jQkgdRoBu9NGreODEQ0TJ+/Ok+/81lhomQ27qWYt51fp
 6Qcgiab7oadV/Wf3AOhomRq63ENle7A2OzXoXxKTnri2VXubxPFR852cj+bucD/NqPjKKgx
 qcjYYMh5H7TamNao/lQHQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:yujl+tsbswQ=:g4Z0sri8GL5W1AxmsVW6NK
 bvpX9mQpF+tXwF+TrAdLm3J8X7UCkK+qhB68eUYxrqzhB6NyRCQZNUGoqNseeb2+xNQX5/6yz
 tcJSAN0UQX0Qt7j9xHxLyzkRII0LsG8LlUMi3Tt+m37z5E87zcwFedEZyCXH9LwL06zANQTAs
 WndPwxaSDYZzYyze0Sb5Tw8aA5dxR1+FZurgHkk7dGrzkIV6QFR6IS85n6E2Ao80DAJ0tczpq
 GM3Ua32y801/8fT5H9Zs2p7Zr7TFJrTF8kLaDido7J3s5GcxU9y5LHyqcVxGTXJRG2xK00ECN
 84EI3LkDaBqjv8ToSaC17ZbUHpZzkCXhr33VtrjZkz4RVpnaXhnSz/CP4uqmVrdq9uapBednK
 GW+vGOMUaCcgpuQO11bj+9osX4h82xCAExyQGuV+PmvxPRYTms00pfrTjMziiE/OSVUX/n/jP
 DKSJX+Ns49HKfW1gLmPp2qe4B5xX6rAskloDM6jdC1yW3xkEcGXAS8rF5QJvm2f8j0IIq62Tu
 c58GHqYVJ2SOZDsjkP2jGA1Z+B5apVqx4YSQVbXTu/7TWMOZ3lt93GCvc7bmyg0wKEXVzbQWb
 RH66x/3+xxHA84eEgewJXGnAoedq3v4l0ehmkVSbNoi5I0VPZ7E3QKyJtBzyoHb9muii8tcqG
 UaQdt5vA9qAzUtMvq6g82dgOiKVRrpJ4EPUUjBQ5hWE8TOz+BYrCbTi9NOlZtNRrc5qjIMV1V
 MYunG+SyiPJFFIY5lm+EU5tJ6du3Qr+vHvO+fhpq5Sczi2ErcqHi6168yVFt6QiF9K+nNyH0u
 x2j9n2b
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Wed, 22 Jun 2016, Jeff King wrote:

> diff --git a/t/perf/README b/t/perf/README
> index 8848c14..15986ca 100644
> --- a/t/perf/README
> +++ b/t/perf/README
> @@ -115,8 +115,16 @@ After that you will want to use some of the following:
>  
>  At least one of the first two is required!
>  
> -You can use test_expect_success as usual.  For actual performance
> -tests, use
> +You can use test_expect_success as usual. In both test_expect_success
> +and in test_perf, running "git" points to the version that is being
> +peft-tested. The $MODERN_GIT variable points to the git wrapper for the

s/peft/perf/

Or s/peft/peff/. :-)

The rest looks fine!
Dscho
