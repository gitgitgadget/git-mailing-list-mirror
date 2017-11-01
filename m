Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BC2202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933490AbdKAWMx (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:12:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:60759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933402AbdKAWMv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:12:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYbFe-1deeSm3Yvq-00VQut; Wed, 01
 Nov 2017 23:12:42 +0100
Date:   Wed, 1 Nov 2017 23:12:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
In-Reply-To: <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
 <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com> <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uwAqZQjpEYi90OQqdPR7REw7RDYMQ4nHMYcao4zs8BqJBNLmcoZ
 hzgXY94qWpk+9My56a2yqdhXkUrYv6MzTmn60nqYWVLMbBxVW+urULNUadz2vtCzMFfwgLM
 QHxJoh5RNGKbVLM/egBLGl/3CzlwDYchoDcrvb9tmDaORT2UoMFhugFrbCwIq6XX0zIYF5z
 W4G18HT+/v69ynUwRBCnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/SpJE0/JNcg=:xoE92pu677hJdjM/udAoRv
 n02nc9Sky9Usyj0JWC3wAFJhLleSHHIW1fs+dYflXhqz1jFaFTjtfAFvSp0TXA2ggFwXmKvCu
 0qV2NuiiP5Nj9OzpS4py8KLdkty0T6UhDcJnmc0LnKMtZgG+gJesNPj6xwF1CvsMkTVRk7+F+
 N0xqABqzGm49GmkKbVLF/eiOfTjPATAfEXAs8AU7vr1mRiyZYgfmV9Qxi6Bfo7fdv7LHz9mI5
 O/nVeQRerCwqIIr65zwvrybpih3OpxOODKnltN+VNnaHePuRS4JtT9ZVfBJOlNR6L3txxpOHB
 ulvDLxgpcW1/pUCRhNPV221OfnhNU7aPGxP5RicRQYwNsxcrZLrCdph2iXLXGRubyes8uhN+M
 7OdeVTRGKghNW+wHw69tv9XVyBbnNy/tSnxyWQWwhZytB6+WU9/7GoV7vluUDgL3NeIJiXPaZ
 iPjdHTG+TLYujtfHZzl/mcuvPcgIaNz+DAJ27eJGOOPmWcbnzR96icspqsq6q99Nfkf5Y/YSo
 XTGgX2vyoBKj12b8Jz4YrW9FGXK0pnf2Opf0uLRhGLF1MWTk73OFQTNcKweb68k1eaz7K7Who
 vgd4MvW3jKRm8ILeYEUsl1nEe1/smb5oG6RtjRYawc00KIGrnk89iffUaiq1LIEenj9qZZJON
 UkeETkgAHZt7016MY/ZQQ4FQygR97Zw5MwbMsPCRJSi9zspl1ZshN1oBtvTWW/D+CAJTNZJbN
 yNihNaBAl0NOzr0FZts/q9/J8hfrY0MPYQWcK0EH7QnnIAQJKECWEk/fjZBEf3Bx4nYsPiEK2
 h13y6WWxlDmnTcIDHMgs/38gy83uO/Ub9ut2LooGwH7XtpLBO0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 1 Nov 2017, Jacob Keller wrote:

> On November 1, 2017 10:59:08 AM PDT, Stefan Beller <sbeller@google.com> wrote:
> >>> Does the code describe a9dbc3f12c as v2.15.0:GIT-VERSION-GEN, or
> >>> would it always be <commit>:<path>?
> >>
> >> As the blob is described using this function:
> >>
> >> static void process_object(struct object *obj, const char *path, void
> >*data)
> >> {
> >>        struct process_commit_data *pcd = data;
> >>
> >>        if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
> >>                reset_revision_walk();
> >>                describe_commit(&pcd->current_commit, pcd->dst);
> >>                strbuf_addf(pcd->dst, ":%s", path);
> >>        }
> >> }
> >>
> >> i.e. as `describe_commit()` is used on the commit part, the answer to
> >your
> >> question is: the former. I guess that is why Stefan wrote
> >`commit-ish`
> >> instead of `commit` ;-)
> >
> >$ ./git describe a9dbc3f12c
> >warning: reflog of 'HEAD' references pruned commits
> >v2.15.0-7-g980e40477f:GIT-VERSION-GEN
> >
> >So as noted below, this output is less than ideal, but technically
> >correct as
> >v2.15.0-7-g980e40477f contains that blob as well (you don't have these;
> >it is this very series consisting of 7 patches on top of 2.15, none of
> >them
> >touching GIT-VERSION-GEN, hence that blob stays intact.)
> >
> >The way Junio asked, we actually may prefer the commit-ish to give
> >that commit that introduced the blob for the first time, i.e. add the
> >--reverse to the graph walking.
> 
> I know id prefer the first commit that introduced the blob. That's what
> describing a commit does, it finds the oldest tag prior to the commit,
> while --contains finds the first tag that contains the commit as an
> ancestor.

It is very easy to wish for "the oldest commit introducing a blob". But
since we're in a DAG, this question is not necessarily easy to answer:

- A - B - C
    \   /
      D

Let's assume that all commits except A have the blob, and that B and D
(for some reason) have the same author/committer dates.

Do you identify B or D as the commit introducing the blob?

Ciao,
Dscho
