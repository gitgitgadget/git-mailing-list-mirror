Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD82420248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCKQ1i (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:27:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:36741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbfCKQ1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:27:38 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3zG2-1glAQs1g8o-00rWAy; Mon, 11
 Mar 2019 17:27:28 +0100
Date:   Mon, 11 Mar 2019 17:27:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/2] built-in stash: handle :(glob) pathspecs again
In-Reply-To: <xmqqh8c9kgy6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903111726050.41@tvgsbejvaqbjf.bet>
References: <pull.159.git.gitgitgadget@gmail.com> <7b5cca61dea4f01f9bcdcb6d5d2a913d58a341d3.1551972571.git.gitgitgadget@gmail.com> <xmqqh8c9kgy6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SvGmWHeRgOFdErjnQ2NxYCYRxJZn/VMOk5NecFdV2H0cmIDQgd9
 6lfxtDbnHtqWEIYdnyZ9/EjbWO1gp8yYovDCJszJLpRC2V1KYYqiqR5dqBuQRcj2AyeHsRN
 UYrITCmsdofWZFqVOA6/JyjVTHRfPRxPKJxHKnw6cmY5SN9+7yn7bXp5qG+ajh8fGIkIzwI
 0OgIKq6R/6Ql7ytgNustQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rkweSR7P/gI=:QkFrQURsOPEXlZRtOKhWmO
 o3SkW2ao2b3EmWOqY444clT3c9Z+7IzDYEerWCUJTzFoLqxsMuYF8t6Qn1oZWnbp8qFQeyaMF
 nXis4/aKIwfbuvsO7kQpuC2trJaA6D6xCI1/q+pLqjEEEugusFOZhvn8ozHpgGwLlkGG6mU3a
 pEKmh1tcl0n2INkfssu+ywS7IgD/tm3bUTS0BmSiA7O2KvVr5Ul0nfE7mCbchR9P5PzyEYJom
 HiLJBNi+ecSwTf8Cq6jSc6VNIFUtfoxGj3K7T9Z8XVd5YgdRI7siktoX24++zMlr2jqmONfYx
 IlLhQySZ+uBIz359Q+BA75uM+F8D7IXKwv8aGQwgbRNTQEZj8PsBAqZ13+0TB1vMrD/fH6bKE
 Z+Qg4qjlusFIxffNVavGlvUZTEIbwtJag30/lWg50WdRsPU6EJd+cRQVUh9jU79ZMZuz4zc49
 I3judZWS2ZH1bv5s8H2noIt29je7aTxsKdVRpIqVTuuVyTVeyBuswtBtu5RE4ROG5jiBpGJC9
 reXxqJv4hkuy6zo1UebCBpos3YbqeXQ8dXf5YkJz6/y7DCTxc3WwtKNEc+IKy3jyG+iqQF7e1
 Bb7QL+T36FWjZVSvuwUAHMWox3Du2LvDyXdS1O6ibV7Zobi+I1jIg/BewPxwpLLd1TX7OprF4
 +v0GREo7GTAmlyof+Byhn03C2M8D7yly0oR2ksJRXU9rGNUvqHvy5iyWpOFTVi5zhO8InWS7o
 Sfz2Vaqamaemx5ZIor7ylBXTWJboDunyWZvS4CWV75V18ci380LFzAU3g4iW75UfFeQeTpTo5
 BpodAPKpgtfan4RfGeD7f1sm60ft5UKjsardYT3iv9qJvhhInazXgJnvY1szTTxkZAn2pOr4b
 hnzLvmxmPdLg8Wa4Rw8+WFy12uVms9QPj+Va9SLe3QjX3mHPT0ivlIy32F5t/L7IzZ4REOcQS
 jxwGsTkBuxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 11 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When passing a list of pathspecs to, say, `git add`, we need to be
> > careful to use the original form, not the parsed form of the pathspecs.
> >
> > This makes a difference e.g. when calling
> >
> > 	git stash -- ':(glob)**/*.txt'
> >
> > where the original form includes the `:(glob)` prefix while the parsed
> > form does not.
> >
> > However, in the built-in `git stash`, we passed the parsed (i.e.
> > incorrect) form, and `git add` would fail with the error message:
> >
> > 	fatal: pathspec '**/*.txt' did not match any files
> >
> > at the stage where `git stash` drops the changes from the worktree, even
> > if `refs/stash` has been actually updated successfully.
> >
> > This fixes https://github.com/git-for-windows/git/issues/2037
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/stash.c                    | 5 +++--
> >  t/t3905-stash-include-untracked.sh | 6 ++++++
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 1bfa24030c..2f29d037c8 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -830,7 +830,7 @@ static void add_pathspecs(struct argv_array *args,
> >  	int i;
> >  
> >  	for (i = 0; i < ps.nr; i++)
> > -		argv_array_push(args, ps.items[i].match);
> > +		argv_array_push(args, ps.items[i].original);
> >  }
> 
> Yup.  I think Thomas and Peff were also looking at the vicinity of
> this code wrt the pass-by-value-ness of ps parameter.  Their fix
> need to also come on top of this (or combined together).

I agree. How can I help?

Ciao,
Dscho
