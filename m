Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13BE1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeG3QEJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:04:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:55751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbeG3QEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:04:08 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08eS-1fyfH13acW-00uKtH; Mon, 30
 Jul 2018 16:28:47 +0200
Date:   Mon, 30 Jul 2018 16:28:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] contrib: add a script to initialize VS Code
 configuration
In-Reply-To: <20180723165719.GA16420@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1807301626150.10478@tvgsbejvaqbjf.bet>
References: <pull.2.git.gitgitgadget@gmail.com> <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com> <20180723165719.GA16420@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CdDcgIHjNmhP4F354KVvszsWuPq0feheuH3KWflukf61OtJZuHQ
 xVcBnBwFJbF3m4+iZVeBvSZ+r4sfY3RU2vPjvDBm/ManHNYjI36RnpTuap1o3IBYPC9veNw
 5+91wuDgZ2+3rH0/DzgrU3tZBKgtjHB1olEaLNxtkFONOaU7XdpLWvElf0nEvdvN1hHeGNW
 KvVz4Q/lHgM1kdqJyAGdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nNoya+E1hDg=:BLrWp7gJkxiczw+MCQ9R4Z
 xlwRQBUdfDLmUAF9QWEBfww/x0e6NnAkiuvuX9zydSupKA3kWmV1UIEuxPv1AnAkoNDdcVuFp
 pfEAkgwfqbiPX/ubsZxC/vLtQvSUuLKCPSMbdFDrk664JGveDbNs/GzGc9U4Qg8ERYu3S6MlL
 Wn0ShvQykRxtXv5UkDpks85FHc5QRebggGDUyU6SqRIbamF0zxyk/MwrwGr/Aba/C/yM3FUM/
 KPGRGG9cV5qyG5s9ywPdXm9IPtNQnMQYGHYr72l7h8ZzNTdEJUXVsUkgbuoorL2PChtwrcC1/
 BFiUmcE44RHP0PhZoKDOXfMJza/hXuouQc+Flc7XZfyZa2zgzIJw4YbTxBiVq0oWc3PhI9hfW
 6P5UGBCJShiISrk4vS7ym9aggehlr5wV2b1g+jZBjfZ0qMUADakptJNYRRKCfbUNM9UWGDxV2
 d+yESbzA/8Hap4UaC8/Vcom0+FUrX+vrHiGRhAVT/BP+X+e4AH3lOLwTd7GeXvavXM6nkO1Ql
 SS/mKMTRr8pBn8M8ueUoucPRYuqGlqU8nHcEbYUk+2WXKsOHkjfEth9Zbom+jaxnAnBHpGJV/
 B/nMVlaTtl8a7Gf7R3AGWZiUMH6/0IG6V0rBP3Q53iWgfL9QIUUAdyNr4Wb4s6NQzNcSw1/sa
 rOPitnpfmMdxDKnJOWJ0VNxKUji7xWF5h7oGWyloWJ0cJR+fC1tfLMZdTRX8/Hkd6+YGq0O7M
 CMD0HM1Ei5MbjmN+0S56nDTgy3iMKVIZQh64oymFqXfSM5GLg1SU9isRWo/n5YLuOy1TBM3iu
 9c8vuk+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 23 Jul 2018, Jonathan Nieder wrote:

> Johannes Schindelin via GitGitGadget wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > VS Code is a lightweight but powerful source code editor which runs on
> > your desktop and is available for Windows, macOS and Linux. Among other
> > languages, it has support for C/C++ via an extension.
> 
> This doesn't really seem relevant to the change.  The relevant bits
> are that (1) VS Code is a popular source code editor, and that (2)
> it's one worth recommending to newcomers.

To the contrary. This paragraph describes the motivation of the patch.

It is, if you want, the most important part of the entire patch series.

> > To start developing Git with VS Code, simply run the Unix shell script
> > contrib/vscode/init.sh, which creates the configuration files in
> > .vscode/ that VS Code consumes.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This doesn't tell me what the patch will actually do.

True. Will add a paragraph.

> VSCode is an editor.  Is the idea that this will help configure the
> editor to do the right thing with whitespace or something?  Or does it
> configure IDE features to build git?

It is a start of all of the above. Ideally, I will be eventually be able
to consistently use VS Code for Git development, whether I have to work on
a Linux, a macOS or a Windows machine.

And I am not happy until the same ease is also available to others. Hence
my contribution.

Ciao,
Dscho
