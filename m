Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26FC1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 15:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeADPok (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 10:44:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:61894 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752801AbeADPoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 10:44:39 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBFBB-1ef8Qy0LaP-00ABlo; Thu, 04
 Jan 2018 16:44:37 +0100
Date:   Thu, 4 Jan 2018 16:44:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Alexei Lozovsky <a.lozovsky@gmail.com>
cc:     Carl Baldwin <carl@ecbaldwin.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
In-Reply-To: <16725929-1BD2-44D3-8E71-E97C4A2C4034@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1801041643400.31@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <877etds220.fsf@evledraar.gmail.com> <20171223210141.GA24715@hpz.ecbaldwin.net> <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
 <16725929-1BD2-44D3-8E71-E97C4A2C4034@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vfkw86Kji/KJSUKUv7vHPELWYc2qoBUoAaarWO2Sv7JRYCRqN8K
 HIdaz0+ByvlcB5Y7ykEseyJfyjkhzTuVGAOTvU09DCPj0K9O9kQnIxLhoehGAA0JWgJTFnO
 2PfZLj8R3BK25HFsfTYk6b4kg8kusZTlnQBrD5Scm85C/NG8XrakORtyDBKlHoEZpXBB8ZM
 iJfBQi/IYVfSwFdJH5L/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u9ma54/CzPE=:ZwQjFaXKM0M8cZb72nYKLc
 QdxyI49Zzc1Lp27MxDVUbgN/SN6mLC0D4JnHD+jNlROeYEEvSOuQU6p+Rlyo95+HuxDanrjP/
 RzEelCnleYZLZvgHaTl+VZQbBOxTJJ1n0Yy0GouqVGT1javMrcPDp8lSbu/47FtrK56LD1JFL
 2qBHqxnqip/8sBYpXV+llbM0Vo0DMW8aB7jVBRVmWfV7bZB0Pu8VkG8ElRygP6Pc8dfuIXpr2
 zk0G99SprbQccCtdSUO6HwU1o7Sph3JQAexqyvlign27oK+eih/NBBVm2WJf5Nq3XqlgGc+Rx
 Z/kCiDQDE0W1lQAlacHO/QddJA/Vl4ausXX4gp+LgIqbhjZ2eudAjW3KlU9u6JG8vPL5ZE4Et
 TjMLXe7Goo/YO5vFOnZMtOWZr9wgo8FkjTt8o9DRBtbmcS2htUduu6msYcA79+KMgTZ/uhfh8
 sN0kZ6ffa49MJ/+rW/MLMCV5hq22+daFii1w7iesD2QXmpJUBT13MlcjIC85oOGQQJW8CriMW
 /9gV+9en1XN3V/ra8nyVQbj/H54Rm75osy8F+5Gifcry1+1aEt3T5LQIj3+bHKSkktPs3+0sW
 fRXFHSRLeUQ3Q6tmlqHzSXci0Dxi7dYscBPZ6uERpze7swfL3GjoIdnENuP7YV7vwoSvYjBg3
 CA7PNHZ9XaLl2n1o54uHdvDdmxeByH55cg2Fc8XMhBFIX7+nQFGvBJilVsKQ+ZmUl6PJcag8/
 4e7//RJPvz1XhB+O2QSjZs8BoL3xwXgLmvLDUAq8TKwbsmu3hDlFIwSXK8etMVbnGdbjSDbBD
 BQExrxShBlarpBZMaK15BPirzMbkkAlXeYC7RPLf4mHWPEIW/QNjaUtYPHpfiqilIc3iFjc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 24 Dec 2017, Alexei Lozovsky wrote:

> On Dec 24, 2017, at 01:01, Johannes Schindelin wrote:
> > 
> > Hi Carl,
> > 
> > On Sat, 23 Dec 2017, Carl Baldwin wrote:
> > 
> >> I imagine that a "git commit --amend" would also insert a "replaces"
> >> reference to the original commit but I failed to mention that in my
> >> original post.
> > 
> > And cherry-pick, too, of course.
> 
> Why would it?

Because that's the command you use if you perform an interactive rebase
"manually". Or if you need to split a topic branch into two.

Ciao,
Johannes
