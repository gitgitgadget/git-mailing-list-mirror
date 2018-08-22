Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20451F97E
	for <e@80x24.org>; Wed, 22 Aug 2018 21:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHWBLB (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:11:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:46405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeHWBLB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:11:01 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNuwp-1fmFGT0uDL-007VNk; Wed, 22
 Aug 2018 23:44:18 +0200
Date:   Wed, 22 Aug 2018 23:44:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #05; Mon, 20)
In-Reply-To: <xmqqo9dumh9z.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808222339490.73@tvgsbejvaqbjf.bet>
References: <xmqqsh38admf.fsf@gitster-ct.c.googlers.com> <xmqqo9dumh9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rg8Wb3vNQ73GXKegCvDyWTQH/xUcKkFd/L4u512AgZGzmK+RVx6
 8oPOmA+FtJS9Yk/xl2avXWjnshxOZpEfolpmikdQti5RH693aY+zLd3K8Z1jdEntH3mG/JK
 LbgbB27KtNM8s3jKtoekYM0A2mfp2loJvPiu+22f66XFiSfAVivIm2y53ZAIERaT8E7IVPX
 pM86apWuYyaXRKWAwVO0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5TDz8NQFd5I=:fi596lLyutT+QgZIH/EEPz
 LILyaeU3zU4rJFlA7U8avP+kNptqzdgA96cCHMvRDrx9yIoK5PlKjvmFewDoeHkVu6k6cOVvA
 jCVtarDaayW51Crvx+yzPAEcuYp2Idat7HmSGfdkazR4woqmQRW3HGR11UqKp2B8/CRMbs4G/
 QK1ErCAHiiLl4Ql4IG6eHa8KW9mIrQj/cblEfEDbFFFVxowlomFKuWKlAqJbw6kIONNFt5qrf
 hxVD1OHdEx1HkIXmcyOhzjsaii+2U6bmLI36mzNEjGNEZ+FNktAMeAe6lB+PZYYClROFfnGBv
 PWh/kTQJisqyZGROe0o/+o8xu2aPC4k3rd/REFaS5R8CCKvr0+7wonRUCLgfD6chCH1Ds3DZ1
 sdDgnbjOq8M7ZpGnN8Evei/up4h9SLqAbZwG8v1KrB2RFjBmcQHGQNyMXH7QjPgmc8Q3Seh6z
 L7k7kq0S9jl7kmWEn78uUMo9V+DNc6TD69yJn2M+Y9xz6xHP9VgzFKVslKw9pFxLdoS9LADHs
 YiJPQGxjHcaK8wsLntrVfp/WissB6ZLjcHJHi3cBkyjjxfLbm2BwfPZ89dgZ+8CF+7IhFwn9l
 2YaHoV1XtWhqjZ82YVm+Vn2E4vUJw92DFhETVGrRKZUbqRJZ4cr2iz5m/3WxFUUHjkPROygel
 2vO4pD5kUEw6hsejtBY7DmvbiqfO2O9UFg5xyGeY2cxNJdL7nVuNJFrQIsoeu97Oik7Xk3BSs
 RL6A9+7APFHDQtkptWm6uvNHvG3AcQN+ZRnby+tHmUrEKzU7u8nN3EegEX4/dASzzGXHw3u1g
 m3MUinz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Aug 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> 
> Mentors (and GSoC students),
> 
> Two topics your students have worked on conflict heavily at the
> philosophical level; "rebase in C" rewrite assumes that backend
> implementations are forever written in shell and can be invoked by
> dot-sourcing ". git-rebase--$backend", while violating that
> assumption is the whole point of "rebase-i in C" rewrite.  Trying to
> use them together would of course not work without a bit of "last
> mile" further glue.
> 
> I do not think neither topic is ready for the upcoming release, but
> can you help your students to come up with "the final step" to make
> the fruits of their effort work well together?

Pratik is unfortunately unable to spare time, as the university schedule
in Nepal does not really have such a thing as summer break. He made a
heroic effort to work on GSoC nevertheless, and I am quite proud of how
much he learned, and that he managed to finish the patches (with my help).

As I have a vested interest in a substantially faster `git rebase` on
Windows, I will take care of the `rebase-in-c*` patches.

FWIW I am a lot more bold about these builtins, and want to get them into
Git for Windows v2.19.0, either as full replacements, or like I did with
the difftool: by offering them as experimental options in the installer.

Maybe this will remain a dream, but maybe, just maybe, I will manage to do
this, with your help.

Ciao,
Dscho
