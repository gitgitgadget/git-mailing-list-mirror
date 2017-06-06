Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2446D209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 22:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdFFWXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:23:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:58087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbdFFWXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:23:16 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaJWs-1djPgT252k-00lzjp; Wed, 07
 Jun 2017 00:22:51 +0200
Date:   Wed, 7 Jun 2017 00:22:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests
 for console output
In-Reply-To: <20170602175455.GA30988@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706070008440.171564@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox> <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com> <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox> <20170602175455.GA30988@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:av+QPt5NNdRTyNeHoU7aW6K208MA2LS+CRwDCiDROidOCd91yxV
 11GzlcjzzAOKHO385Xn20zxQQWs1KqksdKXKE1mivO+Q2XLiMB9uV4Gbhg6f+qYSU/0EyF2
 uA2b1feMl3uH5iQzsUNWwrf4Vqpd/CJH3WAfl9N59ks69QulrAyvGLtqNCezke7DVAbcR+U
 5bB4//7da8nNpBHbCf9qA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YS1i1sPWxmQ=:83liDcKBN7F3rwEdV6Ts9W
 4o5TYX0stOZux/EuLDff/bQEN8jmMj6CWHr5vGjLjR5zjK36mHlJovE/wMebOzQAEqj5Soz1R
 oxjiYK/CdrvZghKLK6k/vBWIBpAsO17GJ7Zw4Y2/haVz/H8Yt3f7j47njqWB6tkVFO5/0aDGc
 JE7Wx+/TJmmr2EPiRCYLpnmAJdBsCuyXV78jv/oCw0SDvjmMQS5P0g1c6lOw8g5dB5OVSjrqA
 FnUEd55kNTHQccURHV6bBRDrwc1QzOcqJkI3GHxjf/aLo4CpDXUlk1VkdLGLcTQaF/QS2m4pK
 tQiWf4end9B/ZJXAiQeiCHJJIqNGlPm/piscCh6Wd3qwkE7IYnwZ0olgsYbAwFkHQv00sS8Ev
 jQ6N8y05fzUMHJN9lNbQBV9wvgnaFJspasQ+E2Rh5V8Ly+WLimLfH236Yy30Z+b2O1qc/7irc
 MJVzlQwWBgvMitKq2rKbpcuK8YjdcReLUReQBbgVONaC2myTuEmyPxg7nVznKvTM0ntSvXsyV
 NEGhK6bHAOsjrAOkzR+VdaXJjp7VzNFj1Z95TfNiiThIGONq7p9NwgStnqIdHFximDZIxJly8
 BAwJ2Hi56Nx6W+nxRF/PoGr/zt5l0qKD+TwMQ+N+Om6DQf6sfuOgskqoXzmsXa7Zgc6A87Jk/
 kcdW9fspzpBbWJCW8txUwv87pOHlp6GvacJHdELR95BTOiXb3pb4SnIVz6pQOz6qRa6UFCnAP
 oQH9yFF/snG8mxwlq9VJrvPFBmI9BFz5ZfiXePYoj5EYm8RBKy3jurWmHP/bGtTzkhnBAlPF1
 1IrqKPs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 2 Jun 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Thu, 1 Jun 2017, Stefan Beller wrote:
> 
> >> We had a discussion off list how much of the test suite is in bad shape,
> >> and "$ git grep ^index" points out a lot of places as well.
> >
> > Maybe we should call out a specific month (or even a longer period) during
> > which we try to push toward that new hash function, and focus more on
> > those tasks (and on critical bug fixes, if any) than anything else.
> 
> Thanks for offering. ;-)

Undoubtedly my lack of command of the English language is to blame for
this misunderstanding.

By no means did I try to indicate that I am ready to accept the
responsibility of working toward a new hash dumped on me.

What I wanted to suggest instead was that the current direction looks very
unfocused to me, and that I do not see anything going forward in a
coherent manner. Hence my suggestion to make it public known that a
certain time period would be dedicated (and contributions would be highly
encouraged) to work on replacing SHA-1 by something else.

But:

1) this cannot be a one-person effort, it is too large

2) it cannot even be as uncoordinated an effort as it is now, because that
leads only to bikeshedding instead of progress

3) the only person who could make that call is Junio

4) we still have the problem that there is no cryptography expert among
those who in the Git project are listened to

> How did you get the impression that their opinion had no impact? We have
> been getting feedback about the choice of hash function both on and off
> list from a variety of people, some indisputably security experts.
> Sometimes the best one can do is to just listen.

I did get the impression by talking at length to a cryptography expert who
successfully resisted any suggestions to get involved in the Git mailing
list.

There were also accounts floating around on Twitter that a certain
cryptography expert who dared to mention already back in 2005 how
dangerous it would be to hardcode SHA-1 into Git was essentially shown the
finger, and I cannot fault him for essentially saying "I told you so"
publicly.

In my mind, it would have made sense to ask well-respected cryptographers
about their opinions and then try to figure out a consensus among them (as
opposed to what I saw so far, a lot of enthusastic talk by developers with
little standing in the cryptography community, mostly revolving around
hash size and speed as opposed to security). And then try to implement
that consensus in Git. Given my recent success rate with SHA-1 related
concerns, I am unfortunately not the person who can bring that about.

But maybe you are.

Ciao,
Dscho
