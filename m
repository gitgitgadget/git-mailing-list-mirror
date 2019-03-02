Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BFB20248
	for <e@80x24.org>; Sat,  2 Mar 2019 21:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCBVVD (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 16:21:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:37753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfCBVVC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 16:21:02 -0500
Received: from [10.49.202.116] ([95.208.58.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmr1w-1hTkW547Aq-00h8a1; Sat, 02
 Mar 2019 22:20:58 +0100
Date:   Sat, 2 Mar 2019 22:21:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
In-Reply-To: <20190301190042.GF30847@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903022209110.45@tvgsbejvaqbjf.bet>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com> <20180814223246.GA2379@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
 <20190208195459.GA32556@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903011557430.41@tvgsbejvaqbjf.bet> <20190301190042.GF30847@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IynisGhKdvSJWrC8BYB6oQxYzfPMVpi+Dp11DWna87DFosEGL8Y
 7rw9+RkmL4KOaXrxiaz0+eIkahBRNkN3bDH2ZQvUtUAmH2Po3pF0704/7HhmUoS8yRvzxqn
 ASHb5VuX7CMoTJ5j5ujU6xoX+WXC3WMUuV51oJmxdwQ5afHiaHWIgFIC+moajr7HVfk+vn6
 pxtnhql9NbsRYIyq1AFhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g7bH5wpUS+s=:j4HuFkpFr4qTWtUwpMABlO
 mzZ3kJyoLFxm9JixYOQkbP9INCjSq5qrz4yfjdHv+UWwrtFUTq+4fR2WI7+UGSZKaWS4o+hw8
 30HnwCKDE5oJ4RcO8IJvDGpnYHV9Jw+c3ASvhAiS7R0gp8BrOdgUK3mp52HeWXrCPVBKX1gyG
 7j0DyBiXxp80P2hWhQEgus13nIvc/wnLg60OZXjc84sSepqsyyWTvGU2BnaHNkecLP6BEmRqG
 sm2TBvwfyvlyGKoQ8aFgrCTUrudXX+j52keeg9+rFzRhwivXkMsxS07S7d9n1iRXRh7FNxNHm
 cLYILwMwNCFKd7F7L6nhZP9POKAxyj7bfNZE4WZF7pEPjLpw1g1wL69z/St8Ir6l6u3Bq5s1B
 aE/X7f4W1steJMZ/b3Tqo/UHYAYEkE12pSy8pUp11gJFguPfvuqBU5fYeWYNxa1tZQmiXtBbs
 4fh7VnTkUuOzifqK7hu+SxzgZTDyZ03dZol1rmvzCNPXiFqWph/h7l1lPHdjuqdq2uI0O4AdR
 xwlgNRRsGWXtcvZQ9At5NU9K4nwQgPk7qLp9hoXHPZd4mRqxnM8ZHxT7S8HbavUfd0olMspuO
 vsMRABMugHCdV9jR22JNZm79DRL8vYMPptvOcT1ok0QrCr544l9qy8s+iKKeCuHFWqaIEGXSL
 FQIbjT8O6uXZoZXTiELDTH7de6413KEO6QcooHNtayVVT3Bz5UOHd15K1vtLbhA2JZYSQAEBy
 QpElRWyr7dLB2KZk3oREPM07wsPD65iiDKaKXzGVwugfcb28MQrkIOeTaeT6vQgBTrw7fFd6g
 LJeSS2jpwOtg2Bbc5OM57qGjX1uuC/vmiqpN0rjXpjFkq3Cg/Psjf9qc/IbAGXV6sMKcQXUaH
 2Iu7SwEBP1Pjr9qf16aeZOBLlSQCnkuH9fGTvp8CUwCGZ2NhBERpIuvYLVnRXi4ROyFO3g1ms
 wliLzlZqMuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 1 Mar 2019, Jeff King wrote:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b620fd54b4..4ba63d5ac6 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1556,7 +1556,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
>  
>  	sigchain_push_common(unlock_pack_on_signal);
>  	atexit(unlock_pack);
> +	sigchain_push(SIGPIPE, SIG_IGN);
>  	exit_code = do_fetch(gtransport, &rs);
> +	sigchain_pop(SIGPIPE);
>  	refspec_clear(&rs);
>  	transport_disconnect(gtransport);
>  	gtransport = NULL;

That indeed does the job:

	https://git.visualstudio.com/git/_build/results?buildId=358

> That said, I actually think it's kind of pointless for git-fetch to use
> SIGPIPE at all. The purpose of SIGPIPE is that you can write a naive
> program that spews output, and you'll get informed (forcefully) by the
> OS if the process consuming your output stops listening. That makes
> sense for programs like "git log", whose primary purpose is generating
> output.
> 
> But for git-fetch, our primary purpose is receiving data and writing it
> to disk. We should be checking all of our write()s already, and SIGPIPE
> is just confusing. The only "big" output we generate is the status table
> at the end. And even if that is going to a pipe that closes, I don't
> think we'd want to fail the whole command (we'd want to finalize any
> writes for what we just fetched, clean up after ourselves, etc).
> 
> So I'd actually be fine with just declaring that certain commands (like
> fetch) just ignore SIGPIPE entirely.

That's a bigger change than I'm comfortable with, so I'd like to go with
tge diff you gave above.

Do you want to turn these two patches into a proper patch series?
Otherwise I can take care of it, probably this Monday or Tuesday.

Ciao,
Dscho
