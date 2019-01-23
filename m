Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5681F453
	for <e@80x24.org>; Wed, 23 Jan 2019 16:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAWQX4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 11:23:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:51757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbfAWQX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 11:23:56 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6ioC-1h9LsI1Ktw-00wXAr; Wed, 23
 Jan 2019 17:23:50 +0100
Date:   Wed, 23 Jan 2019 17:23:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Fast CI for all branches in gitster/git, was Re: [PATCH v4 00/21]
 Offer to run CI/PR builds in Azure Pipelines
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901231713200.41@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ejK76TKp2/fmA9bOKlciRl4kwgL1FjidAaPYzMNsG/RrNbJcPsJ
 qNjmNl7b4am7d/R3SW3LUE4KoGfUa6tgwUvV0vMzoSsOhMKucTIqElUqUK8LfQtM4cPDipF
 OELCWsV0QuULPKDYXoNb4YWb10hozdNjXPwH7C4GL9NQS/0C4Q88McvRnc2Fq1Gt1+mUecO
 wt6xDcbusqpMyrjnkNgyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bZYppdtfucw=:H58EiiwcQMSY3Y9i+glW6A
 BUNeZnOs3JqBNc6p7Vk0PGBJYZuyeY01OxQdlSeHCV4y0LEVZ2Y+3Pj1ShZrZV/wS1GI3X099
 LjKN3NDN1UekvI9kebqgJVrgsGIItTl4FOCZwT3T0of7G5KZwXY6zoFcu+uVVLdANMpx3JGee
 Kr2nks4vYkuE7yBbnXaDmy2VWF0UgEkwKgW2dQse10bJ0ooXFaRIlVKkIT4anWAtNX26PFcaL
 6/iaZkeratPw5g/oZlgkPgsoqzLJRPYa8DctphV54+Qv8WneDjNFNm7RgycoCqtSfu5w8B9pu
 w0oOSscJp/MOL5ygmqnvYM2yNngrk1EKuTOXRyRSFb0RqjK2qwkp9IeDkl2nlH7W9rkHlvPnf
 6Fd+ft9gS5vhSSiB2c47ADZxJER+qCJT5QB5pnYXs1FzDPXXNUA26tWWlpDdN78eopEkbVzqR
 ENohl7sV0nzTMK888B0T1ZrNtM41wkYcDoYCr4LuywaGH1RQq9oV8yCKNQqBEtr5obiqRQ2hc
 1wHC+eFXO0itzQxBBm5qVFgTf3+l0nhtYlADvvTqecW/jR9HoP0Y3a+A8cwQTkRlZbaVKh0PJ
 QwXZ+7XXchFkwxL2YQEq9PhK0nQgXZQzn/n0UjP9ysZdgTxS2K1VukwkPPSu7dxMCjwXOFwIT
 jb7waLs/rS3yiKwk/a9XnLlDLqrN1Nqz3BkoR3kBu8+mh+oMtvsEFdQoo2nRHhb0rLophWB9d
 IU395BzT8DLAmZbfva28EPkIxQx38/UdSmLTF7a64BaDv3MIvcAk6azNmh62FQh15CwUUaWfA
 kad5LagbuYCW2uLpfRSteP1aS9PvWU3ATSxJM2TJ/kaof/Rftlz5DVYFu8m6dDwLhik6YCP6K
 pX9S097R1HMo5SIZnh5bWuLiF0RtoTsc40kEQbYVpp0kV2gv3ujUCYhW0BCDw6jFVLJbGebHf
 NgdF9h24YPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Wed, 23 Jan 2019, Johannes Schindelin via GitGitGadget wrote:

>  * The Windows job was split into a job to build Git and 10 parallel
>  jobs to run the test suite with the artifacts built by the first job.
>  This reduces the overall run time from ~1h20 (which was the run time by
>  the Windows job) to ~35 minutes (which is the run time of the linux-gcc
>  job).

This improvement in run time is something I was very, very excited about,
because it finally lets me use the cloud as my build & test machine,
effectively.

And not only me! You can use it, too, because I ported part of this Azure
Pipeline to GitGitGadget's Git fork, it is now the default PR build. It
takes about 20 minutes to complete if nothing else is building at the
time, and if it is all green, you can be relatively sure that your code is
good on Windows, macOS and Linux.

If you want to test your code that way, just open a PR on
https://github.com/gititgadget/git and wait for what GitHub calls "Check"
to complete.

Since the Pipeline is now so fast, and since I have to mirror the branches
in gitster/git to gitgitgadget/git anyway (so that you can contribute
patch series on top of other patch series that are in-flight), I also
decided to turn on the same PR build as CI build: whenever Junio pushes a
new branch or a branch update (and when that change is picked up by the
Pipeline that mirrors it into gitgitgadget/git), the Pipeline will run, so
I will never have to bisect `pu` again (which is a pain due to the many,
many, many merge bases) but instead the respective broken branch (because
I can now see which branch is broken directly).

You can even see those build outcomes yourself at

	https://github.com/gitgitgadget/git/branches/active

Each of those checkmarks (or red X marks) represents a build, and you can
click on it to see the Checks, click on the Details of "CI for
GitGitGadget's Git fork" and finally follow the "View more details on
Azure Pipelines" link to see the full build log.

For example, the build log of the ph/pack-objects-mutex-fix branch is
here: https://dev.azure.com/gitgitgadget/git/_build/results?buildId=248

Enjoy,
Johannes
