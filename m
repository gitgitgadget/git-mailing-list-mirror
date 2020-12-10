Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E18C4167B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CA323B26
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbgLJPOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:14:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:37959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389582AbgLJPOH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 10:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607613152;
        bh=QF1zu0oJhebltmBUviJtkUUNkddKSoeVRh9WEofwRUw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U57FSc0RFSdG0eSIj+J45kRpgEpsPeJbour9QCD9Xi/6u7eFkDFpVIRCYR7K82i8d
         HVfMPFu0r1mDtk41kc79JQSAxeJDC7m4wf02fKcUj3gDWU203KuqwePM/D+QO7hmxy
         7W4/hq5sPhZuPflFvOFuzyDYEkAR5WmZT2lOtBkY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1kHtHx3GpB-00d24B; Thu, 10
 Dec 2020 16:12:32 +0100
Date:   Thu, 10 Dec 2020 05:54:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/init-defaultbranch-advice, was Re: What's cooking in git.git
 (Dec 2020, #01; Tue, 8)
In-Reply-To: <xmqqft4e1w2j.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012100540220.25979@tvgsbejvaqbjf.bet>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091510280.25979@tvgsbejvaqbjf.bet> <xmqqft4e1w2j.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gUKkqYDLvQLoqR9foAeqo3odnrV+T7TqA/hlRVVnCvPJMAHEZri
 SeMCrM5FG0P2fnkemoXwOkCZgc0xuJ7emFMls8GN25RcTcSYsblh+USPt2MqeBvnjEFEroB
 pUYmkhSqtyf5zXOWs4cezt3DcnBAkUhpvG8ON6fSbjmFd762vs3UxLxV03G9/EtlOt1fDXr
 br9/gHaKkhae94HBtS2IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MKCmxZKwzMs=:A0GDgDXxqwAG8k2N/3FlcJ
 XJ665la+h3i9bmS2/+cu8ZdrFKIsfK+15T6rU5Y1Q3q7YSOqb9FqaABkw0Oxwu9pluy7DFvPH
 RwvgWenO/acGmb4AAovE64YKoIlO96KL4CTQCYzFPB3EFxZfr6O2nBent4VWVhPwDxXfAIGTQ
 qbgD5/WPoQ+B3rHLVPNv1g2Be/AyDZzJ+vSqLRwdj69E5AGBkM34AhtL18fLrxGc+UKwvCyxf
 PkhjcCWs7n6ZLyDJvdOkyEXySxFZrfU4JECen0v4FcQqq5G76776sKAmhpSQEU9M9OhfWWjpu
 AfWMugjyvnlCkqRxZCOL4CTKSvwhA0O6R77PKcxDUfQ8wjRffQX58vaaQ4bBlpd9HqdAA9Md8
 z7dWMrWQu3kZZNEkv0cw0ebLsX7mFih2BNriE0ye5Da78IXfq1yx+j9s2LhIwf7hrd6Gr56U0
 Aj+zDqZ5F+sdmQNlyBiafJAat9VcC8dbBJqDqHAA14KeuRtMAgYMKj1FB3EPcW2IozxPAj8w3
 7Bt9HZBJH8oZkJokSsoCaJd0kdi7Z/VF6MlrSE/qLH+ITW6SMaD7ZEN5sGMbri13qbrvQB/ww
 +Aa6B1qndpk7i08zkusXPIZp4QnWen6xvHgCDKrh3ogCIZ5CMXwLTce7e/ph4jvwVQ8l6Xvfm
 zLzWl9tFIiJpTihvdddpSgHZEtTj5bB9XHXuRr4uw2wteNK7ug4Z7Z4fwhUxz7JQHqNF63PM4
 mGBS3Eg5GVDgT0CwoFpCQfz+T5QkcjTqFqcTRS8NABsB8hUthn9PZI3/m/LJwH0r43IQ+AzKh
 6yLpEAsEmD8bsw8DJKkFl20Pkh28KtnOvSaZzhMtISeG6rqRDgkdUl70x4qdSR5eH3Y5oTC8S
 xGvuEKzR5SNtSYTaAaeu5IMDquOLE2P/Nj9TNW/Vo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 9 Dec 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 8 Dec 2020, Junio C Hamano wrote:
> >
> >> * js/init-defaultbranch-advice (2020-11-24) 4 commits
> >>  - init: provide useful advice about init.defaultBranch
> >>  - get_default_branch_name(): prepare for showing some advice
> >>  - branch -m: allow renaming a yet-unborn branch
> >>  - init: document `init.defaultBranch` better
> >>
> >>  Our users are going to be trained to prepare for future change of
> >>  init.defaultBranch configuration variable.
> >>
> >>  Expecting a reroll.
> >>  cf. <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
> >>  I think a new advice.defaultBranchName is a bad idea.
> >
> > Unfortunately, this objection is news to me. Why would it be anything =
but
> > a legitimate interest to say "yeah, whatever, Git, just use the defaul=
t
> > branch name, I'm fine with it"?
>
> Message sent on Nov 24 is a news to you now?

I did not understand your message as a strong objection back then, and I
am still somewhat puzzled by the reaction.

> Anyway, I do not think those users who said "I'm fine with it" would be
> fine when the switchover happens outside their control.

As of September 29th, Git for Windows' installer asks users to specify
their preferences:

	Adjusting the name of the initial branch in new repositories

	What would you like Git to name the initial branch after
	"git init"?

	[ ] Let Git decide

	    Let Git use its default branch name (currently: "master")
	    for the initial branch in newly created repositories.
	    The Git project intends to change this default to a more
	    inclusive name in the near future.

	[ ] Override the default branch name for new repositories

	    NEW! Many teams already renamed their default branches;
	    common choices are "main", "trunk" and "development".
	    Specify the name "git init" should use for the initial
	    branch:

	    __________________________

Obviously, I have no idea how many users chose the first option because we
do not collect any usage data in the Git for Windows project. However,
anecdotal data suggests that most users go with the first one, not caring
one iota and simply going with what Git decides for them.

> If they are truly fine, we could invent init.defaultBranch=3D:random
> that chooses a random branch name and point HEAD at it, and make
> that the default.  Those who are fine do not really care what name
> the initial branch gets would be fine with that as well, but you
> would agree that it is an absurd alternative, no?  I find it equally
> absurd to say "switch to a new name any time without telling me, I
> am fine with it".

I guess that most users trust us to make sane decisions, and a random name
would not constitute such a thing.

But since you seem to care that much, I will re-roll this patch, and move
the advice.defaultBranchName patch into the Windows-specific patches, to
allow for silencing that warning when users chose the "Let Git decide"
option above.

Ciao,
Dscho
