Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572D01F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHKACy (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:02:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:46691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeHKACy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:02:54 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJmcS-1fn8XU0vLA-001ERD; Fri, 10
 Aug 2018 23:31:12 +0200
Date:   Fri, 10 Aug 2018 23:31:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Introduce a function to lock/unlock file descriptors
 when appending
In-Reply-To: <xmqqzhxu6l81.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808102327080.71@tvgsbejvaqbjf.bet>
References: <pull.17.git.gitgitgadget@gmail.com> <pull.17.v2.git.gitgitgadget@gmail.com> <a19904682f6984de21fbf77240ff5fb6eed1b744.1533930437.git.gitgitgadget@gmail.com> <xmqqzhxu6l81.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/SKuPg4iAqQC0NTXgYz5nHBiTn+Ijwim+YdQC3ynNJwnNnNy0nI
 /WJ0iugSPHM99oOUWq81NT7eP901DZjNsCg2EcoMxU9Ib6n0o2xRcihUHj57HJbj5BmokFZ
 CJXnAfvmy6ayPQvkxyJjhQ11NhIUncr1doQ5KBtNtW33xvC0M6hWoHYotDB16x1G4aWF+ll
 Cv7NVL1TTikQG93ixIjRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3ouyogsBdyk=:83b91xuMPt6YAuArbTRdiy
 k9t4o1f7Vio6aPh0ZH7zvcQtRw6qoiuLg/x9eZbmsgMrQKsFT8nATWIAaea3cCQHM02A8zkxg
 ABG8WmEesJpRkiNqPBi9bhyzGmEx50n6qJ2G3TUZtwqPQZnnkamHV+gMgQLqpK7HCw8bRpbJc
 AhkOp4fAuWJrwfT0KXhvTHUZzDnPk1guRmVu055Q0SqWT+ZIeB++ahB2qzK8AxkyiqI/jWEOt
 0pPTnVNOIPbZ9QAU6Lnnz1I4NIKkvMaKEk0aPjW5GuNz9T1k5mH+2V4A8Wtn+P1asmPjrZfgt
 TRNdmJjXtlVNZEUOQWHdlEsuu5PAUxDb9AHKKgot2gej0jDjGcumK067aUs72BSD/4eqw5+Vt
 VDH45HrY+cqAL/o8CXEoWr7Uw8Hs63ApXRCnzCLwK8yF/qO3CXNUKViSt6dYalPsKjfEGukkU
 FlsbDikt5T2cR1XxInjob8A3b093dxxjHwxxJzG1v6XHN7YaZMORspLrH0aWG0rYiuKlGL6CO
 QL7ShCsiObuL9AOhyVJNz44P/ORRP0SxEulPrFaxiATP7OYd5x+/5MKtKJNYiilKeXajuuICk
 vFc2tU3R+5/LunWj85LqWZqBsH9/SN1VPHfDLrgApoZ0Flms6ohz2Lev93sHGx2oYvSYDDfYD
 zu0lSM/5C3jUvvTz0UCprEow9r+SxGnWaO5Qoj8GzF5R4xh0upHe6zooUmNWynhg2F3Gx2epH
 abZHdVq+IsXQsp/7O1qzT+zpmNyFNM7sH3PvvGzU32Slr47BqpPWRbJF4qp07EwktO2M1z6zF
 95EAi6n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 10 Aug 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > +
> > +#ifndef GIT_WINDOWS_NATIVE
> > +int lock_or_unlock_fd_for_appending(int fd, int lock_it)
> > +{
> > +	struct flock flock;
> > +
> > +	flock.l_type = lock_it ? F_WRLCK : F_UNLCK;
> > +
> > +	/* (un-)lock the whole file */
> > +	flock.l_whence = SEEK_SET;
> > +	flock.l_start = 0;
> > +	flock.l_len = 0;
> > +
> > +	return fcntl(fd, F_SETLKW, &flock);
> > +}
> > +#endif
> 
> I think people already told you that this is not needed on systems
> with properly working O_APPEND [*1*]

I also wanted to safeguard against other (well-behaved) programs writing
to the trace file.

Granted, this is a bit theoretical, but it is quite possible that other
Git implementations do things differently than our trace.c. But with the
file locking that even that POSIX man page I quoted recommends, all this
is not an issue.

And this patch series implements that locking.

> 	Side note #1: and with network filesystems where O_APPEND
>         may not work reliably, fcntl based range locking would not
>         work either, so having this would not help.

At least on Windows, it would help, though.

And if there *is* a way to lock via NFS (which is the only network
filesystem I am aware of that has these locking issues, at least *some*
others are just fine), we would at least already have that function where
to implement it.

> I saw other Johannes and other Jeff peeking into fixing O_APPEND;
> I do not know how well that effort goes, but it would be preferrable
> if we can successfully go that route.  

As I pointed out previously, my mail provider is losing mails left and
right for me. Could I ask for a pointer?

> As I said in my review of the first patch in v1 series, I am not
> fundamentally opposed to a few "lock here to work around lack of
> O_APPEND" and "unlock here for the same reason" calls to limited
> codepaths as a workaround, as the damage is limited (that is why I
> earlier looked at our use of O_APPEND), but that would be the last
> resort if O_APPEND cannot be made to work reliably on Windows.
> 
> But even if we end up doing so, on systems with POSIX O_APPEND
> working, I think that function should be
> 
>     #define lock_or_unlock_for_appending(fd, lock) 0 /* nothing to do */

I think that that would be only appropriate if there were no other Git
implementations.

Ciao,
Dscho
