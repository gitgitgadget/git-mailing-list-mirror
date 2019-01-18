Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AC51F454
	for <e@80x24.org>; Fri, 18 Jan 2019 12:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfARMHC (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 07:07:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:52861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfARMHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 07:07:02 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ltqb7-1hBWJp0dgT-0119fs; Fri, 18
 Jan 2019 13:06:56 +0100
Date:   Fri, 18 Jan 2019 13:06:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v12 00/26] Convert "git stash" to C builtin
In-Reply-To: <xmqqa7khfh0c.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181305460.41@tvgsbejvaqbjf.bet>
References: <https://public-inbox.org/git/cover.1542925164.git.ungureanupaulsebastian@gmail.com/>        <cover.1545331726.git.ungureanupaulsebastian@gmail.com> <xmqqa7khfh0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wxQE1nLDty3JoB0DoPoOVamadgH27nMvtJrQStHUklqe46eMKQJ
 YOSW87dBKSDymHTMLTX+Nu9bCJoc4FqVhu9RlOt17OSBscWsWNQoHImy8rYyNJU3Eco7SGa
 tqRPqFa4kuVGBscPuns7eX25iNw6E4khkiyvFiR/+TzEIKUU3ii9M5h5yvpytkKAe+Xgln8
 N64CaFhA3RylhdbUwRuSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VAUuzlf1nqA=:LNW6D4zqw9GBL0aiWy7+QN
 3od2UESo3co7Kna5yN6NKGqof/Mqvk6DaIWujPiG3vVZP5j/RAfTb+QUukmDlegwyI0g1U8Ex
 DbcGZ/hZaZ06ekPHZnexljB4j+2l2AtDVgHtQYca/uyNOfSkUzDS6wYGK4w/2i0R05/U2/xNP
 Ro14VSCJYsYX3YjIhB/pl22esviImiUBymCVVeOyI+1QEAL8BGhot22ydG3RDxkif38K9r/Zh
 aq10RuaMfEW8O6yo9z1L8/8X3Hu22TLqetMHzP+ah8GyioJjttzZAzKo4VBCzO6thykQQCfwM
 qfd2MMeSneiQSYWKxiENBxKeLFk7lF6wu2iZSXYoENoqq14pPFUfLRt3CV+R2o+P3KLDsJzFF
 7AJf70MEMTJpHiuDQHHsX+8AqeKVYZjBHLWDeaPWOM0YyCu40+tVjMlJnKaya+A4/Ln+RpJoL
 JmOVmqfmZ9NssA6wizcVpQwlu4pNbaDruy1wwXzxsim+n2A03a+WrE79Zw1NtYMl7rgQeF49+
 kxNMyovWDL9i5wOZg3f7FbkiiuRY+bhl2FLvZDlPAHItZq6E/2DJogxJcobg6MZnmT5ELHNN7
 L/C+M3XQ607OUM86J9jKczKbxMFYkHZy5/8+nXvVp9MBs+rbSesappgBg8gnJtrQhRQUAHePh
 bVA55RrdT73EIS8PZpekKsSFBRwFZ2l9Yk75lsbwO0G2waeFOlJV+eRrVCGxuZtMxzlPgztZI
 Qbw5lZAI0H/zMdlC7/FvOBd26yIqcztAmpA6t3c+75XS9GkC4J0u8NloAs+nFIow2iNnKa84Z
 UnY6NUYvmX5PTH3SrowP8y7Eg/ZeI9IffAyrCOjHq6EgUX4oUizdLrcAbKf3ooaVZdJN1Lt+g
 bvBgCFpbM0bRh5t2V5xd5Vo+mtF+MMm1o7k/SJ693hnr9OyCLpNM81T9imcw5OEkBXaozC484
 QigwLd1z3Hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 3 Jan 2019, Junio C Hamano wrote:

> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
> 
> > This is a new iteration of git-stash which also takes
> > sd/stash-wo-user-name into account. I cherry-picked
> > some of dscho's commits (from [1]) to keep the scripted
> > version of `git stash` as `git-legacy-stash`.
> 
> I took a brief look and left a comment on 04/26 last year.  I had
> some time blocked for this topic today to take another look at the
> whole series again.  Thanks for working on this.
> 
> It seems that the last three or so steps are new, relative to the
> previous round.  I made sure that what is added back at step 24
> exactly matches the result of merging sd/stash-wo-user-name into the
> current 'master', but such a manual validation is error prone.  Is
> it possible to avoid "remove the scripted one prematurely at step
> 23, and then add it back as 'oops, that was wrong' fix at step 24"?
> That would have been much more robust approach.

Sorry, I should have thought of that. My mistake.

As it is, Thomas verified that they are identical, so should we go forward
with ps/stash-in-c as-is? I'd prefer that...

Ciao,
Dscho
