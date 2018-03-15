Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA3D1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 06:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeCOGAI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 02:00:08 -0400
Received: from mail.javad.com ([54.86.164.124]:50771 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOGAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 02:00:06 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 98EA53E92E;
        Thu, 15 Mar 2018 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521093605;
        bh=pUIjFZGMoO3gvDNtGyqb5A15EBvJMxPIZPECdUmer44=; l=2270;
        h=Received:From:To:Subject;
        b=leU/ITjG7yyZgY3xnb8g4LGIsirNMF7OXgrmr/gcD4VXOWHveqGUU0JP2Yd3XrD2o
         2yIRvj4CWuCRuMO5oL8G8Ruy/3LQa/bFKLeXlNov907+AB842mc4K2I198z//t2wgT
         EQ/XQeYhNV88eATM1YM0eJRKs4OUUSyvWU2voxLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521093605;
        bh=pUIjFZGMoO3gvDNtGyqb5A15EBvJMxPIZPECdUmer44=; l=2270;
        h=Received:From:To:Subject;
        b=leU/ITjG7yyZgY3xnb8g4LGIsirNMF7OXgrmr/gcD4VXOWHveqGUU0JP2Yd3XrD2o
         2yIRvj4CWuCRuMO5oL8G8Ruy/3LQa/bFKLeXlNov907+AB842mc4K2I198z//t2wgT
         EQ/XQeYhNV88eATM1YM0eJRKs4OUUSyvWU2voxLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521093605;
        bh=pUIjFZGMoO3gvDNtGyqb5A15EBvJMxPIZPECdUmer44=; l=2270;
        h=Received:From:To:Subject;
        b=leU/ITjG7yyZgY3xnb8g4LGIsirNMF7OXgrmr/gcD4VXOWHveqGUU0JP2Yd3XrD2o
         2yIRvj4CWuCRuMO5oL8G8Ruy/3LQa/bFKLeXlNov907+AB842mc4K2I198z//t2wgT
         EQ/XQeYhNV88eATM1YM0eJRKs4OUUSyvWU2voxLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521093605;
        bh=pUIjFZGMoO3gvDNtGyqb5A15EBvJMxPIZPECdUmer44=; l=2270;
        h=Received:From:To:Subject;
        b=leU/ITjG7yyZgY3xnb8g4LGIsirNMF7OXgrmr/gcD4VXOWHveqGUU0JP2Yd3XrD2o
         2yIRvj4CWuCRuMO5oL8G8Ruy/3LQa/bFKLeXlNov907+AB842mc4K2I198z//t2wgT
         EQ/XQeYhNV88eATM1YM0eJRKs4OUUSyvWU2voxLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521093605;
        bh=pUIjFZGMoO3gvDNtGyqb5A15EBvJMxPIZPECdUmer44=; l=2270;
        h=Received:From:To:Subject;
        b=leU/ITjG7yyZgY3xnb8g4LGIsirNMF7OXgrmr/gcD4VXOWHveqGUU0JP2Yd3XrD2o
         2yIRvj4CWuCRuMO5oL8G8Ruy/3LQa/bFKLeXlNov907+AB842mc4K2I198z//t2wgT
         EQ/XQeYhNV88eATM1YM0eJRKs4OUUSyvWU2voxLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521093605;
        bh=pUIjFZGMoO3gvDNtGyqb5A15EBvJMxPIZPECdUmer44=; l=2270;
        h=Received:From:To:Subject;
        b=leU/ITjG7yyZgY3xnb8g4LGIsirNMF7OXgrmr/gcD4VXOWHveqGUU0JP2Yd3XrD2o
         2yIRvj4CWuCRuMO5oL8G8Ruy/3LQa/bFKLeXlNov907+AB842mc4K2I198z//t2wgT
         EQ/XQeYhNV88eATM1YM0eJRKs4OUUSyvWU2voxLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521093605;
        bh=pUIjFZGMoO3gvDNtGyqb5A15EBvJMxPIZPECdUmer44=; l=2270;
        h=Received:From:To:Subject;
        b=leU/ITjG7yyZgY3xnb8g4LGIsirNMF7OXgrmr/gcD4VXOWHveqGUU0JP2Yd3XrD2o
         2yIRvj4CWuCRuMO5oL8G8Ruy/3LQa/bFKLeXlNov907+AB842mc4K2I198z//t2wgT
         EQ/XQeYhNV88eATM1YM0eJRKs4OUUSyvWU2voxLU=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ewLvn-0004zn-Hy; Thu, 15 Mar 2018 09:00:03 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com>
        <87vadyd9az.fsf@javad.com>
        <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com>
Date:   Thu, 15 Mar 2018 09:00:03 +0300
In-Reply-To: <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com> (Igor
        Djordjevic's message of "Thu, 15 Mar 2018 00:11:09 +0100")
Message-ID: <87zi397uak.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> On 14/03/2018 15:24, Sergey Organov wrote:
[...]
>> Thinking about it I've got an idea that what we actually need is
>> --no-flatten flag that, when used alone, will just tell "git rebase" to
>> stop flattening history, and which will be implicitly imposed by
>> --recreate-merges (and --preserve-merges).
>> 
>> Then the only thing the --recreate-merges will tune is to put 'merge'
>> directives into the todo list for merge commits, exactly according to
>> what its name suggests, while the default behavior will be to put 'pick'
>> with suitable syntax into the todo. And arguments to the
>> --recreate-merge will specify additional options for the 'merge'
>> directive, obviously.
>
> This seem to basically boil down to what I mentioned previously[2] 
> through use of new `--rebase-merges` alongside `--recreate-merges`, just 
> that you named it `--no-flatten` here, but the point is the same - and 
> not something Johannes liked, "polluting" rebase option space further.

Not quite so. The problem with --XXX-merges flags is that they do two
things at once: they say _what_ to do and _how_ to do it. Clean UI
designs usually have these things separate, and that's what I propose.

The --[no-]flatten says _what_ (not) to do, and --recreate-merges says
_how_ exactly it will be performed. In this model --no-flatten could
have been called, say --preserve-shape, but not --rebase-merges.

To minimize pollution, the _how_ part could rather be made option value:

--no-flatten[=<strategy>]

where <strategy> is 'rebase', 'remerge', etc.

In this case we will need separate option to specify strategy options,
if required, that will lead us to something similar to the set of merge
strategies options.

> I would agree with him, and settling onto `--rebase-merges` _instead_ of 
> `--recreate-merges` seems as a more appropriate name, indeed, now that 
> default behavior is actually merge commit rebasing and not recreating 
> (recreating still being possible through user editing the todo list).

I hope he'd be pleased to be able to say --no-flatten=remerge and get
back his current mode of operation, that he obviously has a good use
for.

-- Sergey
