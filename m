Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A441F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 19:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbdGYTWg (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 15:22:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:52130 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdGYTWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 15:22:33 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1dGdNj280t-00JWXy; Tue, 25
 Jul 2017 21:22:20 +0200
Date:   Tue, 25 Jul 2017 21:22:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #07; Mon, 24)
In-Reply-To: <xmqqinihbgci.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707252046190.4271@virtualbox>
References: <xmqqinihbgci.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NM1zTkrR8zrNeD/HKvTe4lAq/UFrEAyxC3K+WQFH+oA2ZCmCGUb
 y4VmXTyUw2YY/ab6i40X17waOqqeSO8xSrfzhwDKTTjo6VABYBZkH0Lg7Tg7QZUDjeDInzb
 PX3TOipeBqJh4NHpeeMnIaHy19BJ9wxUTQSVglZeB/MRXbJ3OS3/pmTz1AfXd5jgZvRviBL
 F5VZdhTw3TepYEpKnG0dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TdQrJYHi+Yk=:JXwco0pbyyZjoNDMTsyHNa
 SuZmKCrSx8kp6ggdNfaOsIFsNrLSfkU/nzn875nfEYQNhHyh0qDcP4Rut1Hj5zbyu/AoRSHkN
 AjEcJRdWl+aF6XMDcwSRmMPTyYkD9s6X/XtNLGBm1aSLzDW+sGDVGa3XDJCJeVtZFZ5oPBJjx
 8bc9wcFaSBrUIvn0HNfPy8AWbeUTlYu0X9e+UYvdKQI7coukArkSMjc9sThR35fN2inQvnkGr
 wqEPzSTH2FpqPHqoXCAtcgGfro8jwpvco8HU2tHPItpXCESlrqxavnrWNCrIfATPD/3jI6Xxz
 R/F/WLhkUfOVonvUEZWLQkqB9rPUXFbM4RUJmHY5sZILDnLUGayMKt/8O7JVNrklo//JyUQjt
 Kr3uQKYUpk5VtMuc/AT/fKNNOg8g38bS9No0jhWl1amo9RxU4Kgx4F3DDL4vxawbEsx85SX+U
 1L9gL7DyLVKQhrumVcFDsNpwwZIhT5vOKX28eoS/jsA3BrroR7Hwr5PRLAdmrFaQcHNUld8p7
 Zo07fn4ed6g3Ntyy6drq9X03qBzqI8swcDgmjqC25MCB6qBtYiNyMNyIYiGvxAV7hUoSAjx4u
 Y8UdPMKTTJ3pJN5BCrXspRReFIyKLNcNNwBqiKbUD13CYciU97QsHgoIWJpXPU8ahq03LB3Pr
 uezZBU+g2pNj0IrGSjp5LAH/0ycydbxYO+13q3ODFWKRCJKP6uRcLrl4DXl31L/Dzp2yka8zN
 LGAKDPGf1YzDr6TGxUMiiEIc87lnEqpUAYSWDW4PsPP6rjKy2uQAelsZtls1AC4FgywKyEK2V
 diyd3sfvBvpeQMT/LEfiOLSXUa6FXnTQzEo826uv/e7S4V9vWI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Jul 2017, Junio C Hamano wrote:

> * js/blame-lib (2017-07-24) 1 commit
>  - blame: fix memory corruption scrambling revision name in error message
> 
>  A hotfix to a topic already in 'master'.
> 
>  Will merge to 'next'.

This sounds more critical than `next`, in particular since you said that
you do not want to move anything from `next` to `master` before 2.14
final.

> * js/rebase-i-final (2017-06-15) 10 commits
>  - rebase -i: rearrange fixup/squash lines using the rebase--helper
>  - t3415: test fixup with wrapped oneline
>  - rebase -i: skip unnecessary picks using the rebase--helper
>  - rebase -i: check for missing commits in the rebase--helper
>  - t3404: relax rebase.missingCommitsCheck tests
>  - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
>  - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
>  - rebase -i: remove useless indentation
>  - rebase -i: generate the script via rebase--helper
>  - t3415: verify that an empty instructionFormat is handled as before
> 
>  The final batch to "git rebase -i" updates to move more code from
>  the shell script to C.
> 
>  Expecting a reroll.

Since you said yourself that you won't pick up v6 (even if I made clear
that I have a strong preference for resolving merge conflicts myself
rather than have you guess), it may be a good idea to change this from
"Expecting a reroll" to something else?

> * jc/http-sslkey-and-ssl-cert-are-paths (2017-07-20) 1 commit
>   (merged to 'next' on 2017-07-20 at 5489304b99)
>  + http.c: http.sslcert and http.sslkey are both pathnames
> 
>  The http.{sslkey,sslCert} configuration variables are to be
>  interpreted as a pathname that honors "~[username]/" prefix, but
>  weren't, which has been fixed.
> 
>  Will cook in 'next'.

Just so you know: an identical patch has been cooking in Git for Windows
as 26b08ecec8d37b976be9e85055a0a9e3d16a56da since Dec 11 2015.

> * wd/rebase-conflict-guide (2017-07-17) 1 commit
>   (merged to 'next' on 2017-07-20 at c78e758b23)
>  + rebase: make resolve message clearer for inexperienced users
> 
>  Code clean-up.

This is not a code clean-up. It is an improvement of the user experience.

Ciao,
Dscho

P.S.: Sorry for not branching off of the thread with proper "<branch>,
was: What's cooking" subjects, but I am seriously short on time. Please
accept my apologies.
