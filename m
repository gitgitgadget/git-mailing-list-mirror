Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17621F453
	for <e@80x24.org>; Fri,  1 Feb 2019 07:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfBAHWX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 02:22:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:35861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfBAHWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 02:22:23 -0500
Received: from [10.10.1.35] ([195.130.156.138]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyVpm-1hBlIB2LNW-015rfT; Fri, 01
 Feb 2019 08:22:21 +0100
Date:   Fri, 1 Feb 2019 08:22:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Comparing rebase --am with --interactive via p3400
In-Reply-To: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1902010819470.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oanN/93RFc1QhTNfk2mpnw+BjNDOC9SzrhXdPGJCel7I1Hvn4Tw
 jtscAPb73UOyTbnBhy3vAE0Fr3qRsxoIUtrdfTFbR2eWUQbRr8EydUQO4IAUAtuNP/9n8SG
 5asoLEPAcaqfpTJvpvjy/kLDXcEKaAeIHwlwF9UQnHynLRi5JkRnmwuawP7jSMjvVFgUX4b
 Ncb6ffh8/zkE9lHa3x/CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OvUJHynEu+Q=:7aPmXGJvLsWBIAP5GJOIQk
 oYXobU/uN710XsXV7GBHN7M55fIyS+0qkxGCfXxWxwTJxcudRIQP4DxxGnpVYYW4Y4pea6jrR
 Q4freQKbs1mvyciBiRzjBRWQ/utP/Z+VgWGpvn1MALaHeSBlpmurBT+g2KQ755GDgtXUk3cSP
 HUITSH8Dqn3nVMXpRxk5/qbxtdqx5Rz+w9M8t7Az20ZvGXXMpP5wZOXnGwp5bvGwxup7bWh1i
 +o8Z0DGuixg2wQ3/vh3gNFtxDxKIIDGfiXHB0XL4hRYm3YvT4lQy6WtE1JW19rufHadZAbSL1
 CUwtyVDl/NHNCsIkbluFdDXWqv3i+2Vg2awKg6mOCORrrzg2VtxApoBOXBJaDmuJzCVqhQKLW
 SLgerv5e3Dg6qTdqDU56FLxSxdEwd4HCXkfzHO/V4ZaSc5fP9OJg3KTGw3ixN4VE80/C/vZXS
 iQzWasfeiDf0/z6htqf717be3z4zlGXdj8RAs+w/Fwm8PY3TYCGWgzWCgTxmFXg0sZAPFkvW3
 a18+kwXcU/yFTxuqI4mSZCNfFqJyMZR5eIfpKPDpRXWy8gGZaCCCc73zlwcSPqBpp90Ag/teG
 62ZrZgUChwp71xHik0/sF0kM47vx3VYNyxoG85WAy3E+E/ei9tRLvi+kfCbK5RBM5kM+D6mrx
 zIw4VLThg3Czvw+osViIrSGze7XqrPu11NLx9H5YA126Rzqr/HZO3NKc41Cu85W2d4dn5KkkF
 93VAYsyWg9yZKIXf0cEFfSFn349zuuCpmfNRd+qxpaMl9wFOhEUDfpmwpSqSCL6tnNb7doms+
 apUZn2k/T9if2CUfJ8yVRPRHGCjrfz8j/d/RfS/REWC1v4TR/3pmxkREX+eKYdHnvROmAeU99
 duZiUrojPjse94R4aK+T2agZgDUhs6Goea9xeLSGBizNXtiZDSK7Y3PpVaka9HchNMt+PMiU4
 XK+VtkCfMQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 1 Feb 2019, Johannes Schindelin wrote:

> as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. with the
> --am backend) and then with --keep-empty to force the interactive backend
> to be used. Here are the best of 10, on my relatively powerful Windows 10
> laptop, with current `master`.
> 
> With regular rebase --am:
> 
> 3400.2: rebase on top of a lot of unrelated changes             5.32(0.06+0.15)
> 3400.4: rebase a lot of unrelated changes without split-index   33.08(0.04+0.18)
> 3400.6: rebase a lot of unrelated changes with split-index      30.29(0.03+0.18)
> 
> with --keep-empty to force the interactive backend:
> 
> 3400.2: rebase on top of a lot of unrelated changes             3.92(0.03+0.18)
> 3400.4: rebase a lot of unrelated changes without split-index   33.92(0.03+0.22)
> 3400.6: rebase a lot of unrelated changes with split-index      38.82(0.03+0.16)
> 
> I then changed it to -m to test the current scripted version, trying to
> let it run overnight, but my laptop eventually went to sleep and the tests
> were not even done. I'll let them continue and report back.

It finally finished:

3400.2: rebase on top of a lot of unrelated changes             7.37(0.09+0.19) 
3400.4: rebase a lot of unrelated changes without split-index 393.96(0.04+0.15)
3400.6: rebase a lot of unrelated changes with split-index    404.65(0.01+0.24)

So there is a seemingly significant cost to using the split-index that is
just very unfortunate. In any case, just switching from the scripted
--merge backend to the built-in interactive backend results in a >10x
faster execution. So I *definitely* want that scripted `--merge` backend
to go away. Thank you for doing this.

Ciao,
Dscho
