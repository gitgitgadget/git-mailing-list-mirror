Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22CA31F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 08:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJBIDO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 04:03:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:41275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfJBIDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 04:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570003386;
        bh=XX5Tcgng0urtsDwxgHet9WwMY5QKvsI5N5ifGz8eW8o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KbSRjhm2Yj+/Eu8Wnz94UbqkcAQFzgebbh/rcuRdr7yRUj1fVboBYeFwOryJFmBMv
         5mn/ZZHOFdBnFlL63WRMhCoNflWqAmHn1ObU4hGKhNIEYkxZORvLTLEbsP9tmSlMB0
         GKNkkvy6XbJsBmda4SBMBw48Gm6nEd3p0ohi3ya0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1hpcV63lb7-00iRHV; Wed, 02
 Oct 2019 10:03:06 +0200
Date:   Wed, 2 Oct 2019 10:02:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Garima Singh <garimasigit@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] commit-graph: emit trace2 cmd_mode for each
 sub-command
In-Reply-To: <da9a7ce5-736c-9d85-d655-cb19172063f8@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.1910021001400.46@tvgsbejvaqbjf.bet>
References: <pull.323.git.gitgitgadget@gmail.com> <6d1e51c3-64a4-0075-5c9c-3302c5d07c50@gmail.com> <da9a7ce5-736c-9d85-d655-cb19172063f8@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-727874285-1570003388=:46"
X-Provags-ID: V03:K1:LVGYltQvKgaC8f4CZkOTbr/GzsTH+gsoQLwgPGTfrlAmCiIRIDP
 nnRSMV4XfWPYsDmI5oZ5vm2dzz9stz0B2r+h0EXsgB/afKstRcy2qV3RjUkwTHiJNLnfkVw
 tdq/DBc3GU+ZtdcapXdshBC0HguMGPvmTbHQ2pvXd9S7C8OTEnUHhlkXQbCzsYDBr/mHIgj
 ieH11hOTwOSOac8tXLprg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u35/yJe8K9M=:/xV1RL8Y9S1VVByz9oUUlp
 5iTU0L2OkgdkkcFDQxCL32PJjNU/YR2li8Ls9JY6ad2EH1uNgB7IAxrwbeKj3nN+KnA36j2jZ
 TurF9yTEYW+lzgBdXlNfIz52gszR7eSiNd7KN/KJxGRB8SwXt+pVMQVT1L2HP9sg1RaPs9TaT
 /sFH7FMr4qSjr8jNu/nDMJi6m19AkFpGHhvI2oPas/WHIcv+dA1dwJaWtHF4OrDJ1w/HyfoJB
 a++lB4beeU4DIB6HYKewsZNEEl2Z9vMNLHO/oU+88xVSYFBK9CkOTLXjYT5BFdRh6r+EbIKyi
 E62ESUzXx0Nh1sXAgIAhIvKD9i//4ysM73YB+ITYT3aPpeMjoloWUVPqY8hP+kMWynlSneLLl
 a1SERXoF3jnvS85OT494wMXivCK499DXfb7OGMIDZNYeS7zK/ersuX7QAaNMUeLnL7oCZTISK
 NWEmz18LqAgBpwzud9mB8bbmLm0/SwA9w+oxTYMO7XbZKuQCl9Vpxw1SvlIINEDaP5ns5qc30
 brGrqHRWqWf3jYHygCEywtsucPaz+1L/HwuKYb1yz2GXig/DBvzl4lHJcQ9Dh0UPqawURrpVX
 nECFn28uH65HCc1KPcB+Xin8446WrZzIbqryLrDz+iBMrGVZdFN4yBrJywVn0WZWQTM6eYqrt
 1kyNqVDxvnLReYyfLsP6CdQ1rURC1ZuP34OxsIfyzVp2y535WvjnTg6USmSNgTdgMSErgZeE2
 mxoR7wm0YZ7Dt0/GToFgZEmOByu+I+NALcD4GteDIAkUW8G7pyvs0c2+T/716EamFdErhtyYy
 yjjbmbHYWJjo9xUTHlTIlixGVSX9gaU//GVq8SLPv+09WTSUBPfZ/rcz3mkXNBPcjuQHSPJFk
 kkOs1IAwsaX4ajB2Pd4fUD4Ji/WaJfVu8knmviap2U4SRVNVXf+TFFaBcdhOtQCPcPOBKKp/b
 dmp0KQjZ4GeJZ7XxBkbK4+YoDJL8B6ldNcC5gl4pMHGnDUrbtWoHYkZDnbwrLEvwkcjTmizAT
 R7F+/mTFJJysh1WMJXbD0CwkuYc53ie2IYNnZc6ozv7L2yOYOgztpyImrbpiHvr/oJ8yjdOJn
 vZGe5PD4005cXINHERaQydH+uz70RW+t/gj3/q9qAUCwDDojigxLHNwcXUmgaV7xE5H7FEC75
 5sR1HD7OE8IcK6Y5V7qd4DvGtCMZnbSdexiFyIdpeu8Uu5+mgrwc/vj8aGQfz7IOjLjmVaw26
 EkeefCkKQ0fXrLFSwnb0xB1GURNnAQlNothNlBPjMoTMqPHNjL2C7hke8aLY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-727874285-1570003388=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 11 Sep 2019, Jeff Hostetler wrote:

> On 9/10/2019 9:54 AM, Garima Singh wrote:
> > Ping :) Any thoughts on this?
> >
> > On 8/27/2019 12:56 PM, Garima Singh via GitGitGadget wrote:
> > > Emit trace2_cmd_mode() messages for each commit-graph sub-command.
> > >
> > > The commit graph commands were in flux when trace2 was making it's w=
ay to
> > > git. Now that we have enough sub-commands in commit-graph, we can la=
bel
> > > the
> > > various modes within them. Distinguishing between read, write and ve=
rify
> > > is
> > > a great start.
> > >
> > > Signed-off-by: Garima Singh garima.singh@microsoft.com
> > > [garima.singh@microsoft.com]
> > >
> > > CC: jeffhost@microsoft.com, stolee@gmail.com, garimasigit@gmail.com,
> > > avarab@gmail.com
> > >
> > > Garima Singh (1):
> > > =C2=A0=C2=A0 commit-graph: emit trace2 cmd_mode for each sub-command
> > >
> > > =C2=A0 builtin/commit-graph.c | 6 ++++++
> > > =C2=A0 1 file changed, 6 insertions(+)
> > >
> > >
> > > base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
> > > Published-As:
> > > https://github.com/gitgitgadget/git/releases/tag/pr-323%2Fgarimasi51=
4%2FcoreGit-commit-graph-trace2-v1
> > >
> > > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> > > pr-323/garimasi514/coreGit-commit-graph-trace2-v1
> > > Pull-Request: https://github.com/gitgitgadget/git/pull/323
> > >
>
> Looks good to me.  Thanks!

This was not yet picked up into `pu`, correct? Or did I miss anything?

Ciao,
Dscho

>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>
>

--8323328-727874285-1570003388=:46--
