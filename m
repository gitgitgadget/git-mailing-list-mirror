Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554181F424
	for <e@80x24.org>; Thu, 12 Apr 2018 09:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeDLJA4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 05:00:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:47447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeDLJAz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 05:00:55 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1fElYZ2sYU-009P0f; Thu, 12
 Apr 2018 11:00:41 +0200
Date:   Thu, 12 Apr 2018 11:00:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to
 the man page
In-Reply-To: <CAPig+cRfQgz2tCab2d9g-XznHORW0FJvDKS4fe85JkLPxm2HMQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804121059110.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de> <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
 <CAPig+cRfQgz2tCab2d9g-XznHORW0FJvDKS4fe85JkLPxm2HMQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lZb0ZAUySOKeKgODjtYQ/JLfXj3WmVsKJAUjrIgbjBL4M0Dhude
 vUwoD6h3p+iZnqFuRbTAiqdM8ot1a9MPq5zqOuWng+mbPfjLQ1TmUXKG/rwnjkfWcHVz39p
 pfgHUyP0pfqFp9LZui6pzeRqX14fVpU1/o8sPTIfcR23DeGFzhV895Cf8yKcyTJvofrT+af
 RKJTsh46LvhY01WOdKCLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PRpevzKSNRk=:eWvs+em82voNyT5BGmBiqS
 LtTBQgxrqQ6HrWICUTL4x9nuNhHxw34b1QZh0Q7G+xbKB5ypC2mCNqy16Mh1duOycoQmKy3hi
 H4grTuCS48ICVjitJwV7ROxGdR9qN9X1AxWPtOu08at39/cpViluuSI5KALq0rDWeLAh1M6aD
 2rO1ZAUpqo1Z3krUyiJ5u7bRr691o+mTKAB2lVFoPl+SUMNuiS1SFLxRHTYKEXSEU2eLUkX8N
 JgtOQZ7z/mwZQ8zdYhSIS8E42dXQZ1zXey2fKSP82d5DvIH8PB/XGRy/uwne4xIUBkY7rXa6u
 FpclQfL/1xrF6Ujfszdx1TLWTwIC3UNJ4dOqbbUW+B7GvW8BD/HYKNKUEmrWqSB1rkMxI6xOy
 3r1l5WOKpdJspHOZmiIuElVmh3LM7On8nROeiifRMY0iuGnd2rii4dPwwCJyV0jjeuf9NbPMA
 xFT5mr8EG/xx64sEswFE6b8dYtTUdmIETpEQQHyY9zFpCOBieq4+wXv8TdJVLwVhjXDZTPiFd
 aylVU053AiNAuh2pMs6w3/cxqtXIgG2zY6x8EdtzLZNvbaYuRfDKulCZPC4YA/xxKH/GTX2Fe
 m1K0n15izPDpL+IhcNvCF4XOHFwdPHmSxWoqmWhwisd5YnS765TNqJD4ePzpMyYEqZGq0EUQp
 eT8BzSwQ11akBigZ8QOW7rfSczkmAGcbSe44FmBXbdfPvJFo3ygU30A79v/8yjFzfr7bspP1R
 64oqvmKd2SXPJ0Wb4blhcsO6GHLchQQGXTctLoQI6rnEZ5/PX3/Mm9wofW4GH7YCwOzfaiiy1
 XWZg48Nqn5x7SHcaCP0taXA8TN4eJyGDqV0rlDKVi63bmdSxkg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric & Phillip,

On Wed, 11 Apr 2018, Eric Sunshine wrote:

> On Wed, Apr 11, 2018 at 11:35 AM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
> > On 10/04/18 13:30, Johannes Schindelin wrote:
> >> +The `reset` command is essentially a `git reset --hard` to the specified
> >> +revision (typically a previously-labeled one).
> >
> > s/labeled/labelled/
> 
> American vs. British English spelling.
> 
> CodingGuidelines and SubmittingPatches talk about this. Junio
> summarizes the issue well in [1]. The TL;DR is to lean toward the
> American English spelling.
> 
> [1]: https://public-inbox.org/git/xmqq4m9gpebm.fsf@gitster.mtv.corp.google.com/

Thanks, I meant to look that up because I was not sure, and now I do not
have to ;-)

No worries, Phillip, I will keep spelling your name with two `l`s. :0)

Ciao,
Dscho
