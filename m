Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF9C1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 12:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeCKML7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 08:11:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:42843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbeCKML6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 08:11:58 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MexFh-1fIxhR0lAn-00Oa6z; Sun, 11
 Mar 2018 13:11:52 +0100
Date:   Sun, 11 Mar 2018 13:11:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <CA+P7+xoOVzxnmZN893ND4+55=OhtrE-gt7jRhtxoOUL=G_CrgA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803111308320.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
 <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <CA+P7+xoOVzxnmZN893ND4+55=OhtrE-gt7jRhtxoOUL=G_CrgA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:O0S3pOTm2cyU/AyJ2+B+WSJxUqJICRJG5LQ7KqG9pwAdCgWqWTv
 a9Ch3z1Hasdfxe3PXdo5MV6RmbZlwVuxTQyPZH8YokSe/S8N3kbSnS32GKQvYu8TX3xg0Q6
 TV52AeWCvaGV+KdbSUJ5SvUQJMYkRTr4RECcKMWYE8FuHC7Blg6xGanPHHuflwK3JoTXxdw
 QU70dNctU7WyUiFzK6DBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fdx2dLdgzyM=:ehFxQPp4402oOFVxxrQsRJ
 wcSZhB02sXHzAAbMVEsBZQ6h3IQh8PdVa/r60doN0q/uaW4VwIQq3Lx4fLYsuaRtY6HWVFhIr
 pUkubp8/GaUryjbQo6QKdWmTgC+Q1W9dE9aDZLXGv7dA/SE4tMkUd+DS0NUIFXeVl7EYofTEB
 XOYK1oT60Pu8x9SQWZf6sv1CFUIZ3oIDaxUsMqY1sf7SK69FwsUR5qmXLBAfWDk4aW8lZMCXq
 R/fLySQO4/hefvs3yQwUJkyZqlrBWjQWeXyLlI1VKZA4Uu7d2PRDoiR9m6B+O3dEaIdXjY4nj
 ae/5nnKd5f27cAoFt6uB9TQQEGO3uANr4+J1iyb/vK8L+jz+zeuc24MWO4QjLjiMg2iZRUZZB
 FtLR0e1jPvfAJpULJiKr1a+aeRMo4bUwg9NqVccVLOlc2Lw93nVMzjhaHA9gNQJRTjviRWHMM
 OelxyFLmsgxug41bOZFqMXHiRAGW/6ssPsiq9k6N/qDNeCe4jrv55sOYsEHiJdbCDNRs+1pht
 PmpeNF9AR31Dyj/wq5lE6h2TJgiMcHN7HJOo0QYgbAZaUeHbywhgTNuaS65GEXQC9hH1u3c2O
 PZMCxktBJ7XveMR7UfQfxLvDFMd0yyUi/dpqD7Sl3puNE7L7nrMzIZBeObFDN6IkN0TSp10E+
 l28HwPQwna78OWH66B3gm31eqbPIb+x/AIxkGA4o/B3NcCw5NTUqePfTb71b8227cWSwc0Aay
 2EiK9uQRy9oN3V4HQ/2rjPP2Vp6d84VHtMdKMQsYT9xGqv2axb/JYhQrtin5LWLJGNGXUcQDv
 QiFZ9MW7alFh4gBfnwfho5zm3Va4zDILBuseZpATX/DLv82Bz1wa2bSZ35DnvS1MHwMuVJn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 8 Mar 2018, Jacob Keller wrote:

> On Thu, Mar 8, 2018 at 3:20 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> > I did wonder about using 'pick <original-merge>' for rebasing merges
> > and keeping 'merge ...' for recreating them but I'm not sure if that
> > is a good idea. It has the advantage that the user cannot specify the
> > wrong parents for the merge to be rebased as 'git rebase' would work
> > out if the parents have been rebased, but maybe it's a bit magical to
> > use pick for merge commits. Also there isn't such a simple way for the
> > user to go from 'rabase this merge' to 'recreate this merge' as they'd
> > have to write the whole merge line themselves (though I guess
> > something like emacs' git-rebase.el would be able to help with that)
> 
> Since the ultimate commit hashes of newly rebased commits would be
> unknown at the time of writing the todo file, I'm not sure how this
> would work to specify the parents?

I agree with Phillip's follow-up that the `pick <original-merge>` syntax
would pose a problem, but for different reasons: We already tried it, with
--preserve-merges, and it is just a really stupid syntax that does not
allow the user even to reorder commits. Or drop commits (except at the
very end of the todo list).

As to your concern: The ultimate commit hashes do not have to be known
until the merge commit is rebased. The current approach is to use labels
for them (`label <name>`), which Simply Works.

Ciao,
Dscho
