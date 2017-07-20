Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1605320387
	for <e@80x24.org>; Thu, 20 Jul 2017 09:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935685AbdGTJUf (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 05:20:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:56483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933731AbdGTJUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 05:20:31 -0400
Received: from [192.168.0.2] ([86.56.108.44]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRXVc-1d9pSO3JkG-00SiXE; Thu, 20
 Jul 2017 11:20:28 +0200
Subject: =?UTF-8?Q?Re:_--interactive_mode:_readline_support_=e2=8c=a8?=
 =?UTF-8?B?4qyG?=
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net>
 <CAN0heSoJVf4A=92GPwFGUL0uoqWK3eY89+uCTirVzSYHHhfwwg@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Marcel Partap <mpartap@gmx.net>
Openpgp: id=2E9589E4B9A4460B66AD9B8D65C6B04A8A39FBDA;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=mpartap@gmx.net
Message-ID: <59370040-020f-a5b0-fbd1-677e46d382b3@gmx.net>
Date:   Thu, 20 Jul 2017 11:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSoJVf4A=92GPwFGUL0uoqWK3eY89+uCTirVzSYHHhfwwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ln8qp1Y9hF9AynTcAh4RbnMKWP1zdXMW67O3Q7wyzFb7KwJvHF2
 qTIG7kBPN8culPIcJiViml4v0LfPOdbiErM/MORo6DF9Wb5quRpFRWxKiijQJs4YbGH8Nt1
 syVk5083PYura+AzEAmAKNnh4rANq3jQY1vBxCg96enmWzLNNsDLyexvaXi2szZEfQa/HqE
 F0SWBr9LEuIXjHFyEfElw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:puJKXckmygM=:xLpyv4QLH8E3rAMd8K1fpW
 62o7yrknF+wt8sM1EkMUM62gU7EUZ2/r9ghrVOaROQtgpuPsMiW9TFie3yvaAG7PseTlAc7//
 VZlezaSrrvlQZLOV06TqWTEyPmGp7yQhnEHfNb15D+Dvl+omAj2vTt6szOf/s0H0/mbc7HPdp
 t2NrF0qBM3Hnlf8E6fJc8rU5d6CvKan7EqwEKhNb75jk3os30P1qMBvjS27nRfGUrXPy3vYJT
 jHX3hPc4KXYjsQl2K7NB0RLQ2DXwA3Y/70GgFwqX2wSv/erpHBXxknZ5E9i50WvczNxST2JEz
 ENVepUxMISgEoa8nw3VsfCe2DnnK3FUIlnzoFd58BjhVnw7D5Bi+pNUXoBgCEK7/yN0UWFclt
 K1P6H8vudkDEf7SKVLJkRX5seJY3oQN5nnH3t04Cwm5XAfSOtK/utaOz9WoHlEiPC/Vf9qQey
 gqs43PizIwsUShFMzkDimBddtsjMnlv8J8oaKwgW7xw7xAsTqqNySu9C8/EEZU+HHDL5YfFzA
 anAuUvoOWRW8xcc+jbC5Kd1+MzRy3JQSm8JefMcZ8x4vZv8nxlGIvhdRKQT31/SgZFKQfqfV7
 H5CA5wX71x/YOWZm6kR8035jguWOE90kmtU+Y3kcBsLyR2pHgEB4KcbVr00mAntOuA0AFhysq
 kA5WvCXAow3ZvBN02TOOgtoJxCJp9jQq4pCR0fX62aa0nYs+xdSZrig1rYyQrjRhSwugQx6cJ
 8fDbBNKJmLaoJQpsJhpAvOOn6Pg3OvhPztdcA54pkUeOl6QePNVbzm7l0VNzFMSqfWEPN3t10
 1lIsxGiZk1ZML2ObeJyRtzcJj5Bon5x0CY00HccvN7yjsjs3os=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok very good point Martin ; )
I nefariously hid one obvious use case as trailing emoji™ in the subject, but a better way to make a point is to properly explain.
So the readline library powers the advanced line editing capabilities behind f.e. the bash or the ipython shell. Besides navigating with the cursor keys, it provides a history function accessible by the up cursor key ⌨⬆ .
At the moment, git interactive mode seems (?) not to make use of it, so there's no line editing at all. A typo at the beginning of a line must be corrected by reverse deleting up to it, then retyping the rest unchanged. With readline, the home/end keys for jumping to beginning or end work, as do the left/right keys in a familiar way.
The history function comes in handy when f.e. repeatedly using `git clean -i` and feeding the "filter by pattern" command a string like "*.patch". Like, that's the use case that prompted me to write to this list. : )

#Best Regards/Marcel
