Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD181200B9
	for <e@80x24.org>; Mon, 21 May 2018 10:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeEUKlX (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 06:41:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:44149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbeEUKlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 06:41:09 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1pn-1ffPvR13gV-00LqU4; Mon, 21
 May 2018 12:40:58 +0200
Date:   Mon, 21 May 2018 12:41:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <xmqq603zpkih.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805211238520.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet> <xmqqr2moqlw8.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805062355190.77@tvgsbejvaqbjf.bet>
 <xmqq603zpkih.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xvpjXEMC8UqRtIvc+MGyLm5KAdyh6wPoEtpixArm+0JvrD07jwt
 kHaKJP94Z562uqcWjHYSZ1MrfUUBx518rLua1TEhAfPJ7WWEXBv+YfnVHBWYNrcMx6iNYo9
 TBYO7hmDl1TAk6LhAkElGoULCUObMp0o1S6EUwkE6o4M2TSHUjmm69kvI8sAAkDP9ZwQhIj
 qzuTPzpmca45b2+wg32iQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1YFKvZJbnLM=:QlNnn1B8dmjleQj9XodQDy
 AR1b2Zcjbvncdo+IrPxxG9u6YK+zFdNbtrnEAzcqXNTjsBvFmYcI63zaYfXBugIFIeCBV1N/x
 Xo0wCrk7zk25XqlkLZzccvHUnjJq+0REyvYt6N+L+cP6HYbuY5XHH+2BF0IyarT2Gk5AXsKSl
 M06hRK+a01vjVijEnnfbXaBunmPChaPVBy84+NKloChgu0o+vNqTDi8R0Ks/plPOlOTWaT4MK
 42R33g7f4RDUQ1SgTsqHWEF2oeoD9jIISi/C4O1mkePXfcxaPGKKsfFGdoGlBMbn27RSAHV3X
 lYIYXJ1LejNv2sic2yKwrTy7dTK9+w5+Pw62CZZhhkUx9K0OffIkUlEaAlbVRZOjwBoUcPrzL
 yIwZiUcTYP+gXlMsLczIhKE1gBPR9yQkmM5yvy5ExI16qYl+nAuLgHomHPJ7UgbFdnXJ8xvR0
 kF027dVFqOhCwfy3rGBcE0PHWhFh26qDNVZVNZ5Mux7J/ZvLGvX+hiJkPHcayyq7owb0FKXVf
 SmhgTSV1MclTqpv/2mLjOLahCOt/usIiLIxzUdUsCQ0079n55ly5pI1PbFauVbqiTeS9OVMiF
 F8QBYw8RbGXKGXouDAIt/VPPmQNtTGv9er9b95kqzU/nW9Oz5VzpjR/OJl0AzBrM2jHioLWze
 P6iQHGSdlv6FPDycAyVhgULTXcJ6uAYdpSzPfk7tM0FcI1lxFjFw7HbZ8yVdz8OX7LKA5rXsM
 mw6mlQVbVwhRyE5FVUPmn620PzohlWaQZIahVpFVlt1b7QRcXerRpirWzUFJDsKV3Qpi7tcxS
 eRdnkhv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It would be easy to introduce, but I am wary about its usefulness.
> > Unless you re-generate the branch from patches (which I guess you do a
> > lot, but I don't), you are likely to compare incomplete patch series: say,
> > when you call `git rebase -i` to reword 05/18's commit message, your
> > command will only compare 05--18 of the patch series.
> 
> Well that is exactly the point of that "..@{1} @{1}..", which turned
> out to be very useful in practice at least for me when I am updating
> a topic with "rebase -i", and then reviewing what I did with tbdiff.
> 
> I do not want 01-04 in the above case as I already know I did not
> touch them.

And you are a seasoned veteran maintainer.

To the occasional contributor, this information is not obvious, and it is
not stored in their brain. It needs to be made explicit, which is why this
here command outputs those `abcdef = 012345` lines: it lists all the
commits, stating which ones are unchanged. In your 01-04 example, those
lines would be of the form `abcdef = abcdef`, of course.

Ciao,
Dscho
