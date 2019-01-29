Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F731F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfA2OVa (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:21:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:35345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfA2OVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:21:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPHrQ-1gk6YH1mkq-004X7K; Tue, 29
 Jan 2019 15:21:25 +0100
Date:   Tue, 29 Jan 2019 15:21:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #04; Mon, 28)
In-Reply-To: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291518550.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ciOIdOWQ0RHs+jjsr2/tsg4pdGoxqJE4YPkZ+byNU6A4tbbIqt+
 8c9idd5csgxwwgxBjZ2sFF4Nge1G54ly596Fr3a/6Whfm6Zb2LN84bMEuIq6yRJPU0YHuta
 /XB3kchAVpaosGOxix0Qv4yAu/RwYbpVOmKXzTG/7fNvkqpDNeTF5S/TRLIZ3NUPYVcNlee
 8gz+rsSwxUhYjFZltI5oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v1sW5gSCbaE=:JFJ9cYDfKvVLaqAxXMU+Ny
 m1Ry51xfTXq2etEypZIJDFJ2Z1hbmx+x+QdoGVGlNPsdAW1SpTtw5ksoW0eud4n6rCWf8RVFq
 SWoO0aVhFv2YlFYdTYD8cDzCTXero+rfcfoWCB/glvqUDPnBBQdkw02KTgr44HAWYhLS94RR6
 v5EmJtPrcx2rUNorAzJkPAW+xDTnTrgC6tUrpLLGyePQ5XwET7Oo205cMKQur2LuWG0qh5DRS
 VUi8ayvxgxKose1MgroAnSKhoOvT3ocWzNeA98nBS20Eybd7gvfSm5IEjqR4Dau7p4+wfX0UH
 VDAp9qbjTaldaVq9U87FBdy5P7co9s7rmR8allCF0kV6wh/WIDRPuoclon8VzJ/UKLo/pvM3c
 3g+KSp0Zq6mQtvi/fraMZCTB0ghQCHl86amEHbCIvJQv+IEeN6FrGBpIFEaNnEijCf8HH+HEd
 0jGE7GbQim3Jn74Ew6ke85rzf5YBGNqLsmvxK5Zi1I7YFVrg3kvrhiQRFEbhh3dHWs2PaMxKG
 LDtxhDORhZLkn6ksb2aDHU/SQAHJ8fZddsieXTmQJy391s+1ImyvhTOpv14sVmGREmIJQmRo4
 yv1be1f9mrdvqlI8Qget1TTj3zE4QjSISdbtQmUgCmc5ADj5f/YsAznSKKmPtaC+HCAKtThU7
 cnhSZ7M56pRowO+IBXA31/o9x5vAg8cjyIpCiqe+MR+pFjYbCW8t6rrKrwTETKhnF+eNCeKXh
 vsM6hdsMUEXN+NVOxORro5C6TcJlv7QIZWks/g1MuYZD8wmgGuOVwnI7klN5nUFdEdYhAoDsK
 JjoclAQBkkLbR/kFqTaaZiEPmfTE55szDxjK2umXcYRQCTcAxK8NQ2umPQCZU9t6touyD8UzR
 lQv3kD895EvgSRuSTkqGE6mV0MjVQqDi3+PSYxfSqE+kc6K7r/y0qoFRAh2G2hR6OdAZPiMuG
 tLYFVz6+oSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> * js/vsts-ci (2019-01-28) 21 commits
>  - ci: parallelize testing on Windows
>  - ci: speed up Windows phase
>  - tests: optionally skip bin-wrappers/
>  - t0061: fix with --with-dashes and RUNTIME_PREFIX
>  - tests: add t/helper/ to the PATH with --with-dashes
>  - mingw: try to work around issues with the test cleanup
>  - tests: include detailed trace logs with --write-junit-xml upon failure
>  - tests: avoid calling Perl just to determine file sizes
>  - README: add a build badge (status of the Azure Pipelines build)
>  - mingw: be more generous when wrapping up the setitimer() emulation
>  - ci: use git-sdk-64-minimal build artifact
>  - ci: add a Windows job to the Azure Pipelines definition
>  - Add a build definition for Azure DevOps
>  - ci/lib.sh: add support for Azure Pipelines
>  - tests: optionally write results as JUnit-style .xml
>  - test-date: add a subcommand to measure times in shell scripts
>  - ci: use a junction on Windows instead of a symlink
>  - ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
>  - ci/lib.sh: encapsulate Travis-specific things
>  - ci: rename the library of common functions
>  - travis: fix skipping tagged releases
> 
>  Prepare to run test suite on Azure Pipeline.
> 
>  Will merge to 'next'.

To make it easier for you (or at least I *hope* that that makes it easier
for you), I just submitted v6 (<pull.31.v6.git.gitgitgadget@gmail.com>),
which includes a fix for a sparse warning reported by Ramsay, and a
touched-up commit message to explain why RUNTIME_PREFIX cannot be made to
work in test helpers, as you suggested.

Please pick up v6 instead of v5 before merging to `next`, it really only
has a very small range-diff relative to v5.

Thanks,
Dscho
