Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586F31F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbeGLM7g (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 08:59:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:54535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeGLM7g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 08:59:36 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfC4q-1gSNFc12Vs-00orDv; Thu, 12
 Jul 2018 14:50:04 +0200
Date:   Thu, 12 Jul 2018 14:49:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] rebase -r: support octopus merges
In-Reply-To: <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807121448530.75@tvgsbejvaqbjf.bet>
References: <pull.8.git.gitgitgadget@gmail.com> <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2wKJFlO739oHXZ5jHJ/MkxMsUPMMsnIh2pExcOs704CzissUe6w
 0J62cIKWMXYgUDX9L55DlgaFcACYt7b9dYkQo0qCN8nkFPAcVHgQ1O+6GB6DfSeUN0AZKQK
 seRZjBsG5TvB6l5m9YCsHrrFJZB6X/QOdFhQGGCsVcw9G72HUafayYN3ZNqSi/vjhH0iLT2
 V8dQQwTwCd1qE/n6wRokw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o1tVSoVNRXQ=:h3QxxXeNK9xWeoSaIFAtGs
 saCcfXzdqBf44oAsSmG+o3olaBw6FDnijIUOl2nyAiQMzMS/ps/q8S/3bg3DB4RlCSE6ppK0t
 iG/ScKc9Ew8Ah2SEQHouHogDTNp7Hmejx4TtrXTzgZS1yaIS52hHtGrjoMBV3zYRBd9o6vCKp
 VToGgMW+rjPU/suJThzVK3TzoYt9LBb4c+kBKzd+2VvUySWyO5xncMZKN5ptVAgqYVfg5s83H
 ulEVNxpgoJkWPw3nueP7nJgzEyg2SyUREbussJGZxkggRqxrwih02RsBb4ywtF+5rk+YKYnq1
 T0VrLa9OlrQ1V/RHTOn6haJDMmz/N17OZLtteHz/Xz6sZz8GKWE0Oqnjtd3aKRt5um+pM4ODi
 x0WjtwjEa7/sRxEzjHQmhzX9izSCHYKKsNWFty6v2+EPmR7eI84gdhIi2TaEuM4Ek2oa2OZh7
 dq2jc9iI1aydfLYK2YJDe/sbj7mt+SmmK30rnm005MkWnKzKwQvXEp1pgOR2WnKks3SXt5xf3
 5vfU0/lo7vKlvZ9g6/rsG8i3ciSemixL9p7+gxJQtUfH1a8cUh8PO5q1Yg0QlI7zpmK1/znSs
 vVXwDQLKaIuhMgtPAVUaD3cU1cmUQJ3DT8OZ30JDVbC6EOyR+NRePuhUy1o0FhFkMuWXLxvgC
 b7rNiRhoRMu9CyBM/VFIDDOM/hmEzEUroy43Ygg98Pqg/uN1KglXvvqlf4DsL5AV2ysKkjYIJ
 BRIhLtLPOVirugfKNxjOeG6KRJ4srU/iGzrXBaXlC8TUoAXh8dgKqJ6XQS2C/VkQLUwBuRcyR
 99mGn7L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Jul 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > The `--rebase-merges` option of `git rebase` generates todo lists that
> > include the merge commits that are to be rebased.
> >
> > To keep things simpler to review, I decided to support only regular,
> > 2-parent merge commits first.
> >
> > With this patch series, support is extended to cover also octopus
> > merges.
> 
> ;-)
> 
> To be honest, I am not sure if there still are people who use octopus
> (even though I freely admit that I am guilty of inventing the term and
> the mechanism), given its downsides, primary one of which is that it
> makes bisection less efficient.
> 
> Nevertheless, this *is* the right thing to do from feature completeness
> point of view.  Thanks for following it through.

--preserve-merges supports octopus merges, IIRC. And as I want to
deprecate --preserve-merges, --rebase-merges *has* to support octopus
merges, whether you or I would ever use them or not.

Ciao,
Dscho
