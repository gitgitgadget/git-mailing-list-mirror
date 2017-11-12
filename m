Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76326201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 21:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbdKLVOM (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 16:14:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:54688 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbdKLVOL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 16:14:11 -0500
Received: from [192.168.178.43] ([92.76.226.11]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lta9E-1fEab33NVU-010s6J; Sun, 12
 Nov 2017 22:13:17 +0100
Subject: Re: "git bisect" takes exactly one bad commit and one or more good?
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1711110612290.5087@localhost.localdomain>
 <CAP8UFD1=idL51XDzE_RKc_7z9NghTd7GHoZ-T61y0rQ8ZYXomw@mail.gmail.com>
 <xmqq8tfcevev.fsf@gitster.mtv.corp.google.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <4cc5519b-f384-f9e7-3261-f36e1943a776@gmx.net>
Date:   Sun, 12 Nov 2017 22:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tfcevev.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:AEtSBzgNSqAXS5bvDDgTjR0g1JtgtI2sj47QvJZqv6Pg79eqUqX
 R08Kxyeymi68Tqewb39bPfhIt0GzvKpuG1QkVHBC+yig8P4YnDPIZ5lto8411/VzszBVNk6
 wH1gVDwCojkKitCWZLpfn/904uS2GtVYjfRfUenOfk15kX53ZGN1NNR2Zxc3MV5GDYA869h
 Eyz1ITyzJUqk1t8jgwdtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7wDrnMerdc8=:lhTP+TTzhxDOSBfWXYXGxZ
 x00PWCbGvosd6kB7KUo48Up+86mZybkxNP6j+JWzvq4DCkHHRc00KpJwBNvQizgd3Cq94tong
 cWlF6CUAqBQ/3meXUyIi9OwGQ9Rh17jfJNmvTWCxOYvrcGLSiwStps5p5EiO2unVSvMbCkEeM
 IYjDldARRFhDPKIMU9qYvh7VPdzs0oFt+tKR36bPLjNZiHPq9pLYGiIDUGT3UzQznuFvyA6z5
 gimOGz4yA8SZRZa/sPxGOcP1cR4hq+jRA1Ari4aEIlMsuSlKJCXt1V0uST8hsDRNaRNnGUdq5
 JAaY6hcaLvpQGAmzzT9xUcWUIPcp1VcmJeTLtuCbsn8VyYOl3KzG/aOoTYU6bTtLHvxt/FYAM
 kggVytoUqCoBzUI0jXZuWrIn8TOUpZSPHFmTuxHJcvDqB0O1HQkSFaj8qMZMYvoCUpOV73l1M
 buGQvuFh9Lf9kiCV/OS7O1I6i4DjQZ3kEIM3IBaRI7VgOWQDXD4w/A+houSYdFvrErhXCSh32
 K8mpaXymlOsRnD2BeQP1OYnzJZt4XlJs2podOvhCn5qkD22K8qtzpS4vGy90xBY8mhi1yrbH/
 8PZtdYc+KvOAYWQRQxvvqsZ+qOuHzJ/Wb/ifwJ7PbWUhTFvWvYOlM/aT42CZjjm0xj13iWf06
 yzL/wucOvC47Dfr3SKmxnb0nnLfRA7cBVTUdJXewmfBi8PW4DRInvKghMKOLVyoN4mc9xGFE3
 MEeahZWnlwo/4yXD+LQYaZYI6lqVTGXiOlXBOPm15Lc7LTIGuFH9SxbZKmkDsN3IbxGpH7GGC
 yqjERFBrhK8L9kgU+sIkl61DA9xV4q6CFni2FtaKVPAD+teP10=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2017 03:34 PM, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>>> "You use it by first telling it a "bad" commit that is known to
>>> contain the bug, and a "good" commit that is known to be before the
>>> bug was introduced."
>>
>> Yeah, 'and at least a "good" commit' would be better.
> 
> Make it "at least one" instead, perhaps?
> 
> I somehow thought that you technically could force bisection with 0
> good commit, even though no sane person would do so.

Thanks for pointing that out but I disagree with the part after "even
though" :)

Imagine you add a test case that was totally uncovered before and now
reveals a bug. You want to find the introduction of the bug, so you can
either check out the first commit you think where that bug did not
exist, then you find out that its also a bad commit, so you check out
another commit... essentially you are manually doing a "bisect" but less
efficient. So it would be better to let "git bisect" do its job without
knowing a good commit in advance. Sounds perfectly sane to me.

The probably insane thing is that there are currently performance issues
with git bisect. So you *are* probably faster by guessing. But that is
what my patch series [1] was about (and that I postponed in favor of
other conflicting work on bisect).

1.
https://public-inbox.org/git/1460294354-7031-1-git-send-email-s-beyer@gmx.net/

Cheers
Stephan
