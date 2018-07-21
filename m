Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91301F597
	for <e@80x24.org>; Sat, 21 Jul 2018 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeGUWul (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:50:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:42845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbeGUWul (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:50:41 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfC4q-1gMdDi1l04-00orMT; Sat, 21
 Jul 2018 23:56:22 +0200
Date:   Sat, 21 Jul 2018 23:56:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment:
 a function to solve least-cost assignment problems
In-Reply-To: <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807212347330.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet> <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet> <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com> <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet> <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VKAA3DarYwZXvdCvkgFDhK9nLXTmJANLFROm4sSKXKjqlvdMDd4
 adpE0DB/2ssLlk+BWx29c2udQzwec/tGYnhfTosazijwQ7+HZ+JHOxfZ12TY65fUCbIwuSH
 xHgJNgupnNltawiMVN1/3KvaRBc3t/Jm3RmQZDeyS1Rs1bvqr12pzHNh7PHxDQX0bQEYPMh
 0M1exOG1l2FLnCxMzwsuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q244dGwAWH8=:41VDDD02WK+q0nzDYCNPAJ
 3tiE5wrtXIKoO7Za1fjtqhabJJuo6KxqJ0uuAUXM9ppmtuJ14xOI5a6caRBrE/kyIwAX0ozkG
 erZ7QdX652Q8GOflVC4bz8Ns85erUgFgJ9nHMmRko17xQS7seGE4l9NLPG75hcQlU4pIFlJ5m
 wJiaO/RMl8DRcowZnAEtVijZ2ViPTePKtDjoteDNRElcwjX8CSVI5ZFNAm6YlIal8S7sHoBSD
 YDgh0SJFgs/AhgtZaM786QzpwTeQPf0sFfRMxu8DkPRRHp2qDGnT85A6r3tlsFV14i53PEwCr
 tfcdXLDdqlcE8WAoDggmnU/HbJn8Jh9J/mNmnK66JmoWiStDcXuAAZ8JESFU35ZrTAMWHCUCf
 QZZYSerkw1T/NaivP+EPQDQIQkbbOBsbHgCgtcYisRAs+exmbd0tbfXMoxXUlV1hbwhdGutiS
 77R58umRzzOeN39rz1dc3fQ+iaum/vsHMNyx45bdMB7Ncoj8yq8dCmcT4WLE8ie2U9ltqemty
 utAuLI6s/h7yCJkqaZWPdz5FqUBblI3POPj059oqGyAJ6Jh/bc5ajM5QY+GtpBBLVIWu2ArvO
 AcdO5XyyjxWYG5l5Ud3Af6mbu44v0FDJANQshIDdprfRS3tI8dzi0WC6xWCRDiu0ZZSGP8S0S
 UD3d7RhphXT/V7wVyLzWS97537j8zj9jHRYoYUpK6Cs+99BRf8IITmUoPIG6HbzXFKWVdiiPI
 5zmu2kuvjpTm8868qYuPE7kAhFgwvHctuRrAudmFBkW0iAF7pUS0W7R9AsPxlYpjONPs1a5KU
 aGFRfLh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 20 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > AFAICT there is at least one scenario where you run `rebase -i`, the notes
> > get updated, and of course the *reverse mapping* does *not* get updated:
> 
> It turns out that I never had a rewrite hook; the notes.rewriteref
> mechanism is the only thing that has been used to maintain amlog.
> 
> I've stopped populating the reverse mapping, by the way.

That's just great. I ask you to make my life easier by keeping the
information correct, and now you just drop it altogether? Just great.

Seriously, I am trying to *improve* something here, because I really do
care about contributors, and how hard we make it on them. I would not have
expected such a backlash against that.

> The script that I feed a message from gmane or public-inbox when I need
> to learn the set of commits that resulted from the message instead uses
> "git grep $message-id notes/amlog".  And that is fast enough for my
> purpose.

Awesome. You might want to make sure that Peff stops advertising the amlog
notes, then, though.

> There is no good reason to abuse the notes mechanism to map a random
> object-name looking string (i.e. hash result of message id), other
> than the ease of "quick access" when somebody is making a lot of
> inquiry, but that "database" does not have to be stored in notes.

Right. And it does not have to be stored anywhere, because nobody used it
anyway, right?

Well, I hate to break it to you: I just found a really excellent use case,
and you are making it very, very hard for me. Deliberately so. I don't
know how I deserve that.

> It certainly does not belong to cycles worth spending by me *while*
> I work during the say with various history reshaping tools to record
> and/or update the reverse mapping and that is why my post-applypatch
> hook no longer has the "reverse map" hack.
> 
> It is not like anybody (including me) needs realtime up-to-date
> reverse mapping from amlog while I run my "commit --amend", "rebase
> -i", etc. and the reverse map is constructable by reversing the
> forward map, obviously, with a postprocessing.  And I think that is
> a reasonably way forward if anybody wants to have a reverse mapping.
> The postprocessing can be done either by me before pushing out the
> amlog ref, or done by any consumer after fetching the amlog ref from
> me.  If I did the postprocessing and refuse to use rewrite hook you
> wouldn't even know ;-)

The idea that you publish the amlog notes just for your own use cases,
sounds a bit strange to me.

So to reiterate: the information you have in amlog is useful, if faulty.
Rather than "fixing" it by stopping the useful reverse-mapping, it would
make a ton more sense to instate that post-rewrite hook I already drafted
for you.

Besides, while you spent all of that time to make things harder for me,
you still did not look into the most worrisome of my findings: there are
apparently Message-Id mappings where *none* of the commits returned by
said `git grep` you mentioned above are valid. Not a single one. I will
dig out the mail for you on Monday, because I care that much, where I
provided one example of a Message-Id with two commits that match in amlog,
none of which is actually reachable from any of your public branches, and
I also provided the commit that *actually* corresponds to that Message-Id,
and it is not annotated.

So at least in this case *even you* should have a vested interest in
figuring out what goes wrong because even your own use case is affected by
it.

Ciao,
Dscho
