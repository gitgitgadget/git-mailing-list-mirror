Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866DC1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 18:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfA0SWo (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 13:22:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:54025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfA0SWo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 13:22:44 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3Lw-1hQA2L1lWW-00evwI; Sun, 27
 Jan 2019 19:22:37 +0100
Date:   Sun, 27 Jan 2019 19:22:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 10/21] ci: move the Windows job to the top
In-Reply-To: <xmqqpnsn7zgr.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901271555230.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <5bdc6a08a8b8040de3082b1690f16538fcc08682.1548254412.git.gitgitgadget@gmail.com> <xmqqpnsn7zgr.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/VCcvsxkRWJ3Qh8eJmbsnDC7dCCJEt4MRLioYtz68SJT2wGQTnv
 T23FFBwPstojEz0ntZppUSUz9LZXtUXjSTzExHcg9hIk1h8Vawb7vMemDinTFx8FRX8yPKb
 lBH6GQYLPS2WALMGAccyB0Cz3vPH5LR/cS4Sb+ace7y4MIIdghuSPER7OZLJgXbvJRCXM4o
 c4oawok3RagPpXYZEeZVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IF+kz99WXCg=:tgMYZFaczAm8mMHzDjESi0
 0/KkQP9f5LyI9AllscUyMD/qFx6tW61BiERzPesSm05THZgoPI505lUqEYOUizJyOPaaEKPur
 99i2Bniqw+mg8JHPn8XHkIJ3LpJvWhPboBnhyoTuTHjrTo3pwYweC5zatBiBMZRsvv8NMPrrI
 l6AomOpvAPS3HMXm/OtuMuNseRp1fXzJEphqHz/FgEmpZdVUh/hqcJWx8pzeUaxMe1ddFJRi0
 j0NhFy2JKjqPEUbClfLAbqtB6Q8nS3ZoqW5imjaJuaeogEWf4DDpwRNplE2aMc/O6tRc51Y+P
 Cb0leOyreTGqfJaLTUmXvjG3kXHybTblnId40G5ko6yfPjLRxc+uWgfyuc2IJ540JXLD55c6m
 NF2Fu/dq6IJZ8c677mYImfHy6m7XyNHpbF6wYDyl9rI6HsX2UT69vBx7QhfP2TfMjVZzb1Miz
 kjv/ko9tFtl82n82yxfmFAItInsztZtmGTVciCD8y1GmjY7Taqnci4sXlkqMCWkWlDZzXr7Xw
 jvVArbN81dKM073KnJX66vlY96au1hPa4dFqanLEPCmY792B7WojylEBPK0GRmBIEwd3pWqWK
 IhoeYuW2SlAzn/CI/ERJi3qzqLF2Bl5YnJ/DtbYS9jpOpQma4GEN2ietrIdIVT8RM3CNhdkH5
 W6nx6bwf9A/6yf/Rr3MfWJowEE+lVFAPSCoK8j00dv0TrG4LF9+vsL+Tgwp7GxM/sOjW1ca8T
 ovVrdRVxnelJOo6JAe0eLkXaQr2Xxp+0QjzTckSwTTGRM90GD5vt6yUNG4pk2F2JGaVWkr8/Y
 kI7RFuMMqgYS/wez3+r7FgxSbOzKn8BPPfRg8MUv7piEkoOB2Ny+9nUJSXKhjJKufVLi9WnIc
 a8BMOc2Swg+AT6rbbTRi7vkCeIaVHw70X7XUUdlz+1cVyu0FkUHXUq8bqB8cmKBHvYb6uHRDx
 hN0563v7imQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The Windows job currently takes a whopping ~1h20m to complete. Which is
> > *far* longer than the next-longest job takes (linux-gcc, ~35m). As such,
> > it makes sense to start the Windows job first, to minimize the overall
> > run time (which is now pretty safely the run time of the Windows job).
> 
> Is the reason why Windows job gets started first is to make sure
> that it, which is known to take the longest time, never has to wait
> before starting while other jobs run, in case there is limited
> parallelism?

Yes, in order to optimize the overall run time. Like, if you have N jobs,
and you know that one of them takes longer than the other combined, it
really only makes sense to start that one as first one.

> The last part of this sentence is what readers of this
> step will need in order to be convinced by the justification given,
> because (1) if the jobs run totally serially, the order does not
> matter much---if anything, running shorter jobs first would give
> results from more jobs sooner, and (2) if the jobs run totally in
> parallel, the order does not matter as long as we have enough
> parallelism.

Right, I think I totally forgot to mention that Azure Pipelines offers 10
parallel jobs to open source projects for free. Which means that we will
run up to 10 jobs in parallel, as long as no other build is running, of
course.

Will adjust the commit message.

> > This commit is best viewed with `--color-moved`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  azure-pipelines.yml | 172 ++++++++++++++++++++++----------------------
> >  1 file changed, 86 insertions(+), 86 deletions(-)
> 
> For those who are seeing this azure-pipelines series for the first
> time, it would probably be unclear what the point of adding an
> entire file in 09/21 and them moving lines around in 10/21 is.  If
> somebody asked me why, I wouldn't be able to explain why it is a
> good idea.
> 
> Would it hurt readability if these two steps are combined?

The thing is, I tried (of course) to replicate the Travis configuration as
closely as possible. And the Windows job was in a specific location there.

However, I just realized that I *added* the Windows job to the Pipelines
right from the start, and that is definitely not on par with Travis, as
the Travis configuration did not define a Windows job (instead it has code
to trigger a dedicated Azure Pipeline).

So what I will do instead is to

- *not* add the Windows-specific part in the commit that adds the initial
  Azure Pipelines support, and

- explain in the commit message of that commit that the idea is to imitate
  our existing Travis configuration as closely as possible.

Ciao,
Dscho
