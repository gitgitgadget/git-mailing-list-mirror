Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3C61F453
	for <e@80x24.org>; Tue, 29 Jan 2019 09:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfA2Jy0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 04:54:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:33201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfA2Jy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 04:54:26 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDFB2-1gw7D42zgi-00GZP5; Tue, 29
 Jan 2019 10:54:18 +0100
Date:   Tue, 29 Jan 2019 10:54:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
In-Reply-To: <xmqqva288jts.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291049430.41@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com> <xmqqzhrr54h0.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901261916340.45@tvgsbejvaqbjf.bet>
 <xmqqlg35elgv.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901282352470.41@tvgsbejvaqbjf.bet> <xmqqva288jts.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bnzgLKtNIr8n6V/aeq9pd2ZPXxe1KKNBEX+thYj1JpglDhm6N5k
 f4N5su61XHOP+qvMrHCGvncuGiX6zfKFxM8bkejrVYYqxdjGMHXDcSXr0vmwy5xD63eVUdY
 XJ8cgkj1FVXHGsPb66fY/9wV/LEGVP8YTJ5FpfZYE1F4+naPpBa23UAlTP0BMe0Ewyvnzjy
 VWdThB7iHXhKF+oREVh5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nan3WDJbEzc=:3SGXWXspG1cg+hGJa6T3UY
 iyzJ4ybkNhPpZaQIzAn10rdn3xE0uuk3FudsCLIUzYFXq9RH3+DZOIDYemdf+8bmpYRwnGb72
 Yyomddj7wJ1OZjLZX1QtrVFOMNZ3OmOxJUv9073CIv3hm5TSN/5RsOrAGYSLoRf7kBvR4XPfB
 f/MIUmPUQGnUhr8+zJXXu1UvqDTyrQko3BvW76xuZzLleQvM/wUmcDwn9itKI9U2S67NkDLww
 G/d9M5kn30zc54/3f97txuYs2o4XAQq8o2s7ICTdOjhP/JXr60TbabXIv+YLxje0IkJ/9NQHa
 f5uqCzC67OCUbtg0BdNO42OVTIWGPNzeziTGi3tCI/nSst77wXVLJAhFn4t6DLq12th1Sa29o
 pLojCfKtVvqamvuMsH7ibqblM4Cfxnk99xpTj7Brtz/A/eHV7zidlXF1ejtuSTreC/sFGMvt4
 /j41F6ZrWYelF4BfTwA0mVfXTVcYOJdmv0Jjc2lfZwl8TSCogFMeMAxwBmVqiYuMCWJxqvt+B
 fV88Mzbly87P87Vn2iNkP61uxCjj938ZC/CdN/ZXpATERbZvJ6SFsQFB7C0CCWvalbSENCshJ
 ZA8nO/SUBJlbzMkSS0S0p5isZiz4yeIOqWFBwyHLAM979m9xEdkXO5HTEOPZcAKL1qweUuaqz
 NHEP7l0C8tWmPXrm4Vn0jPyB9hTCsr425aVqH7gLiejC4cwd5/cdIhNqukGsKoPiiQLQTuCmC
 azixsx1CCJMHgzPh0FUaELnFR03lbtoo7BnhntH0QWBiRD3sJwceVvzZV32cztvB6Ruv4ism6
 QVpbQpWCdWziFoA3g9+jR0Cbrj9arsAjxIXIVRCMfKLz1CGPI3omepQkCAq6jRu44w+jy/u6V
 nSgUh3UJ1lrwfZ2RznRXCJAVE+6R+RfJtl5TgS0wo9d4EYjwJotbRQpHUsfQ33YyOpOdDNzLT
 KeOxJMuQ9qQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The big difference is that gettext is needed to build Git and run its test
> > suite. While gnu-time is only needed if you want to run the perf tests,
> > which is not a part of the CI configuration we have, neither Travis nor
> > Azure Pipelines.
> >
> > So as long as we do not run the perf tests as part of the CI runs, that
> > optional dependency should *not* be included in *CI_TYPE* specific
> > sections of the code.
> 
> Ah, in that case, I do not think it makes much sense to even keep
> that comment.  As you said, ci/ is about running tests under CI
> platform, and the scripts are not designed to be run manually with
> tweaks, and none of our CI integration runs the perf thing, there is
> no point to even mention it.

Well, yes and no.

Yes, it does not make much sense to cater to interactive usage when we
target a CI system.

But yes, it *does* make sense to let users run those ci/ scripts in case
they want to investigate test failures. Take, for example, a Windows user
contributing patches that end up failing on Ubuntu with clang. Then they
can install Ubuntu from the Windows Store, run those scripts in ci/ to
painlessly get the necessary packages (without spending extra time to
research which ones, and how to install them on Ubuntu in the first
place), and they have a pretty good head start at debugging this
interactively.

Likewise, I take the comment about perf testing as a seedling for testing
performance in a controlled, repeatable and automated manner. As such, it
would probably make less sense to step on that seedling and crush it;
Instead, we will want to keep the comment there because it does no evil
and at the same time is kind of a placeholder for something beautiful to
come.

Ciao,
Dscho
