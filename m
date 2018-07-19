Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8869E1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeGSRWG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:22:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:34439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732053AbeGSRWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:22:05 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZhoi-1gRIvD3ac0-00lV1Y; Thu, 19
 Jul 2018 18:38:00 +0200
Date:   Thu, 19 Jul 2018 18:37:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
In-Reply-To: <afc090ea-840d-6c27-d6d0-2202914f1ccf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807191834390.71@tvgsbejvaqbjf.bet>
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com> <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com> <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
 <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com> <nycvar.QRO.7.76.6.1807181427120.71@tvgsbejvaqbjf.bet> <CACsJy8AbT3=wzKecGqvj8ibHmquU=NfP872f1cAM-VFOLSLSGQ@mail.gmail.com> <xmqqfu0glbqm.fsf@gitster-ct.c.googlers.com>
 <afc090ea-840d-6c27-d6d0-2202914f1ccf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k/Do9V0DSN58RlDEKz0zzs49D5I5TJluO9C2V8Llz6an+MwoEWU
 vekXJ3JZCmrLgzo8x5rQ0gWcO8F0L2zRd0Woe9XONCEOCD3MGrg4gextQNqXZ26W94v/uwt
 5MFOV1UgzkRexnQydIXDLKjOd/5b+5XTabkyQNWnBFaDXHiEgogLv6xq/XnibuUeVWEUoUm
 Be8sG8OumqqsmkuDcOvJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NR+cEu30rm8=:2iru/c5H6Wt5VTppj8M0/1
 VTRogkBbP5MWNqUmkjE/kYAg16FRVefJPMMkxkWRW20PCuHs+epeolHsuheIXZp83095rwmEX
 r8mIdkLB2dD7mnKko09c0awRWz209MTNZqObkdUvyyySGFXjySfVqUBs8JMROhxhMJNlPmtdU
 BA7IGlDnaulvEflMZHMuMirl2e9qWVCh2TU3dk1Dm6GsD/V/7y/vJbyfceDD+ZXpMI7GoXnxJ
 zx6SLR0tXMocyOC0AMvaNGL4sGorJAjhtTrjf69mMTR+uGmZKCnHTCeN2+jNmB1AZtGfr43Zy
 +xutnJrZJ1LyUMpYHqBirpa17zSE1QA5ZuoaBtL6ZvrdB8inu/MbVMvF2JLada0LSpI7oYp3N
 bh6in1tbTgzJvsYtFLGMJkVvKQSEc2oYB9axwghX35iwOuNPzuJ+5PUU6bA3nLSrbBMvy/0ol
 0zU0geSmvkBhG2u4qsHs0r7QDo6zTOhFxJAT0T227txE4C5Cqckb5GNwc1IFDVNkig/6d0HRR
 sra/GregP9EV00oB16raESg7Y4uFjnZpOg6Pf+jy2UoWisWzsW75DLD3Pf6oY7l7gisc37hNa
 jX3419g3ha7Gh7qsja4wa8OsZehE00lwCy9WaKSlzI/4VysVudiOegDaqp3sBwRHmDLshAy6D
 VCTFE0IGC+SoZFvDyKy6DTs8+oTRSXXcfOrI3x/Ddo0vRrnoKyXhIbaFwfAlSdewUPGL9EwAy
 2ZsjikzGQO3KvAnkt0UAgcze7k/kbnt6kqPvdd4P0rMYr3uA+XRlW25LjPXyGpXnCbIQC/w21
 k8uMc+9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 18 Jul 2018, Derrick Stolee wrote:

> On 7/18/2018 1:01 PM, Junio C Hamano wrote:
> > No, fixing a tool that throws such a harder-to-read patch series in
> > reader's mailbox is *not* something I'd spend my primary focus on,
> > especially when many contributors are perfectly capable of sending
> > reasonably formatted series without using such a tool under
> > development.
> >
> > That won't stop those who want to improve the tool.  But I'd wish
> > those who want to make Git better spend their time on making Git,
> > over making GitGitGadget, better.
> 
> I appreciate the feedback in how this series caused reviewer pain. Hopefully
> this date issue is now resolved. Any further feedback is welcome.
> 
> I'm choosing to use and contribute to GitGitGadget not because I'm incapable
> of sending series myself, but because I _have_ had difficulty. Using the email
> submissions creates a friction that I'm willing to overcome, but we are
> probably missing out on contributors who are not willing to push through that
> friction. Perhaps having another way for new contributors to feel welcome is
> an indirect way to make Git better.

While I am a seasoned Git contributor, it is *still* too painful to
contribute patches *even for me*.

So hopefully you and I will get this easier contribution process to the
point where other oldtimers do not want to take it.

At least we now have something that does not share the downsides with
SubmitGit, and is extensible enough that we can teach it new tricks.

With a little luck, Junio will fix amlog so that it is not utter garbage
for anybody but himself, and then GitGitGadget can give contributors
useful feedback about the state of their patch series, including automated
notifications when their patches have been mentioned in the What's Cooking
mail (which no irregular contributor reads, as far as I know).

Ciao,
Dscho
