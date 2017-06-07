Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27DE1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 15:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdFGOt7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 10:49:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:65214 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbdFGOtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 10:49:47 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln7wj-1dmijH2EIP-00hPWD; Wed, 07
 Jun 2017 16:47:06 +0200
Date:   Wed, 7 Jun 2017 16:47:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests
 for console output
In-Reply-To: <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706071520280.171564@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox> <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com> <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox> <20170602175455.GA30988@aiede.mtv.corp.google.com> <alpine.DEB.2.21.1.1706070008440.171564@virtualbox> <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4/TtBifPp2nHoN1Jl5H6RRsNiDR9drDWT6vxVPuOnh9CcoP797r
 gSi2l90lf8cR3xxK80WCnJkD4FYmFlxvRIu2REW5641GtXsS7aCjwajVEaWD53mVEM4EWpd
 s50Rt+cA6G/9nrc+OyX97mbwayWBGpC2p0Le1SkkinMo0gG+6YmnhEhFwwbyjBmd3YXN/xk
 B6K6O1O1zNg5VMa0j0xIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:700NDpB35do=:q8i5lIEiEgIkYd1AfzkA8r
 DjFBXTV3ZFDMfwa2/MEI3+TD5lgxx4wbaYBq28WMJGcYmk8M4baadjbFNp1PKShNnL0UoH5mK
 Ayq7GyF5fIFspykxm/2kKoYUZzmnHwhZqeZZc7qQpAcA/X3eb1aQlkZspZidKEqU2gvvrIR8y
 lIF2SRzDeuuq9EfWmcO0HCO7HjrC6op1c9F5fLZiv3c7X1lnrgiLtI9vZPs+AJ9CKoNymCXhq
 S83W7154JTC7hIlYLWSyB/4iDK+7JHmTvpYca9Kk2ahmqCHCBjAG0q3e101ntPX1Lctf4SywS
 m++1MVuqTuKltaTXRbxlheWCqaCHWETXLUJFBgl0JVkWhztLpqv4QUQCeU77G7b64SpkKdDGl
 zmp0CoBIngJHlZX/ER0H3WTA7gGKDVZattOMcUcHCRJeEgUQmukh/u+y3qYWoF884UBrq0fWf
 OXd03ZcvGn+W7Y+Gi5jvXR3E7A1XZo77OrIAUd2/ya9I9puEKOXmLsTE1/uHmTScTxKeUJLCZ
 K8NknpIhzviivViaHLq4kvzDjdJ5cIZdcmh6R8485vnOTGLMSVZmSrBvq0oONnsrc1CM3pJD9
 x7t9vJ4SpWqpOFQsHTXEKHF8u0fx7BCKiNlprAmrcdAzH8MTsPQX6+6hM+9/LnhnSBAY+kdgf
 7+6mzxuO1DKFXy3xJkbhkXWsyIr7eq/qIglICPjlNgPBMngPAjtqyU74YH+6FwqhF0B0ZKSVk
 E68GMYG9xUQ5ZgmA6sSwfrwsdujQsJLuOGOg24T80GMKBwtmSDsxJIuIM4FutXx7R64ZVzxmJ
 ZgRdNR/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 6 Jun 2017, Stefan Beller wrote:

> On Tue, Jun 6, 2017 at 3:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > 3) the only person who could make that call is Junio
> 
> Occasionally I think the same, but in fact it is not true.

Again my poor English skillz make sure I get misunderstood. So bear with
me, please, and let me try again.

The current What's cooking mails are full of stuff other than the
transition from SHA-1 to a new function. In fact, every once in a while I
see brian carlson's patch series with the remark "Needs review" while
other patch series get reviewed even by Junio.

In my mind, this sends a message.

If, hypothetically, a couple of What's cooking mails would have in their
header some language to the extent that we need to focus on transitioning
away from SHA-1, and maybe even have the promise that Junio would not
review other patch series as long as there are patches to review that
prepare the tests for the transition, that convert more 20 and 40
constants, that convert more users to object_ids (and maybe strongly
encourage to coordinate with brian so as not to trip over each others'
toes), to implement a command to convert a SHA-1 based repository to a
repository based on a different hash, to implement caching of legacy SHA-1
<=> new hash mapping, then that would send a wholly different message.

And in my mind, if anybody else than Junio sent this message, it would
sound ludicrous. For example, if I sent a mail to that extent, I would
find it ridiculous myself, in particular since I am a very unprolific
reviewer, and the promise to focus on favoring reviews of SHA-1 transition
related patches would sound very unsincere from somebody like me.

> As said above, Junio has strong veto power for things going off rails,
> but in his role as a maintainer he does not coordinate people. (He
> occasionally asks them to coordinate between themselves, though)

I never had in mind that Junio would coordinate people or distribute
tasks.

Instead, I had in mind that a certain time period could be called out as
focusing on that pretty important direction.

That would be mostly symbolic, of course. And encouraging. In a positive
way. With a direction.

> > 4) we still have the problem that there is no cryptography expert among
> > those who in the Git project are listened to
> 
> I can assure you that Jonathan listened to crypto experts. It just did
> not happen on the mailing list, which is sad regarding openness and
> transparency.

True. Same goes for me, of course. I just felt pretty uncomfortable
sharing the contents of my private conversation publicly, when I tried
very hard to convince my conversation partner to join the discussion on
this mailing list, and they refused.

The gist of it was: SHA-256 should be preferred to SHA3-256 because we
will soon have good hardware support (and performance is really, really
important when you need to work on the largest Git repository on this
planet). And if there is no consensus about that, BLAKE should be
considered over other algorithms because it has been studied pretty well.

Ciao,
Dscho
> 
> 
> 5. The timeline you seem to favor would be really great for people working
> on Git at $BIG_CORP, as big corps usually plan things by the quarter. So maybe
> by having a timeline (known in advance of the quarter) can convince managers
> easier.
> 
> >
> >> How did you get the impression that their opinion had no impact? We have
> >> been getting feedback about the choice of hash function both on and off
> >> list from a variety of people, some indisputably security experts.
> >> Sometimes the best one can do is to just listen.
> >
> > I did get the impression by talking at length to a cryptography expert who
> > successfully resisted any suggestions to get involved in the Git mailing
> > list.
> >
> > There were also accounts floating around on Twitter that a certain
> > cryptography expert who dared to mention already back in 2005 how
> > dangerous it would be to hardcode SHA-1 into Git was essentially shown the
> > finger, and I cannot fault him for essentially saying "I told you so"
> > publicly.
> 
> Heh. The community between 2005 and now has changed. (I was not there
> for example. ;-) ) So let's hope the community changes for the better.
> 
> > In my mind, it would have made sense to ask well-respected cryptographers
> > about their opinions and then try to figure out a consensus among them (as
> > opposed to what I saw so far, a lot of enthusastic talk by developers with
> > little standing in the cryptography community, mostly revolving around
> > hash size and speed as opposed to security). And then try to implement
> > that consensus in Git.
> 
> Sounds good to me. That is why I personally think point (4) from
> Jonathans list above over-emphasizes performance/size over security.
> 
> On the other hand if we find a smart way now, then this hash function
> transition will open the road to switching the hash function down the road
> once again with less or even no penalty if we make mistakes in choosing
> yet another bad hash function now.
> 
> > Given my recent success rate with SHA-1 related
> > concerns, I am unfortunately not the person who can bring that about.
> >
> > But maybe you are.
> >
> > Ciao,
> > Dscho
> 
> Thanks for bringing the discussion back to life,
> Stefan
> 
