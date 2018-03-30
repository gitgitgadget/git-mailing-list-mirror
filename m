Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA261F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeC3NlY (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:41:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:32779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeC3NlY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:41:24 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgqQQ-1eDwKJ1HZ0-00oBrR; Fri, 30
 Mar 2018 15:41:17 +0200
Date:   Fri, 30 Mar 2018 15:41:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Sergey Organov <sorganov@gmail.com>
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <87605gd9oy.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803301537250.5026@qfpub.tvgsbejvaqbjf.bet>
References: <87y3jtqdyg.fsf@javad.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com> <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com> <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com> <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87woxyf4lk.fsf@javad.com> <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87605gd9oy.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aAaWrFBb4w/Q0yi7ePEwHjnjTm5RP3MNynwqu7yTsmnC6NkpuFf
 l4ZMBwGutYAr8nexTZAEDk+ITTMJC9OkddQOEAEmFUy3geV3HKNHHCrkOlv5V4aMBNVShIS
 lsKq1Uagj5vrFnaW02mymraWVAEiCB4amL0cONzk4wAzQpGO0SDYiF61j+T6ghclox5FRVg
 WgCKlAobuS7r7KoFB5nOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6X9TzBuk5Vk=:B7g+mJUdtVH2xNMJxDJFzA
 chgWdX3fddJRa645PUNUceZqDcE7OTEKW22pRGbCou723LJnDfGwAN9cf3hWFDe63adU3PSMc
 5o6IICv8ujjQXVNs1ngdByPzrMJnweVASzlTUf2hDKLsGr6K40dAQDxsqOjlCKok0hVG0dOJn
 LBdjUSoLUMjO9fy9f5i9MHioy50V02vOzwYaIS5brRwoRpFi7Zwcyi8vBH/mYeDYv4nQszEnQ
 WAAQ9BJRTkoliVLehu7Sl4ApgEzvW+N0sQN5DXzV++bFBiyrhAXmiUP3zZRnVL6IpCGcVwc8P
 x4EQ2kELXsKnRn2ee9VyTjc4O9SAE13t6iyEDuGhhdB7xlpXaWu4uQ2yi6LCGJMysypBkclRX
 7HsH8JrDfIqDIzaTVPJ4eQMiLMQrlFPKUvLAprDx9yDRs+2/X340rgfAZ7eNG82TI0F9R+HYN
 rvvubZPHtJ/BYhESN5qFWBQ0716mrLn9lBiMJ3jBLs+hJV9Ncd/jIWksFQfMkxOK/ZsOzru2A
 XjgG/X3C9vMnP2ZGiL9haQw5aqbIvSQzviufAorZdR4llmr8BTX+cUgE38Rge5XbRSF686t8q
 aYpk2IlrphQhV7Z27qbXYDyc+rdT2YviRwR+qBA6Lo09OmGrzZu2UWdm/FCgInarFjGIBQOvt
 TMrsZeszwQAqA20dNHm4m3hcfEQK9k3OvXC+9w1l3a0y8MgnW7Hz3L8OBrB1Xb6m5EqEEQ/a4
 X0glVXsmcGW2KKaijCCMZUshl2GSCiZ0HINVvPt6MHQ7nxNqdzUCfr0zSrUY7UeH3XxRGKChP
 s0kSHvsvVWb27yi6S4cUkhtRkTmmcDzFjd17k+ww9uG20Xd4u8oyCBUbQlJAfgHEYxRx/Rn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 28 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I use rebase every day. I use the Git garden shears every week. If you
> > do not trust my experience with these things, nothing will convince
> > you. 
> 
> Unfortunately you have exactly zero experience with rebasing merges as
> you've never actually rebased them till now, and it's rebasing merges
> that matters in this particular discussion.

Who says that I have 0 experience with that? Oh yes, you do. Like, as if
you know.

Guess what I do with those Git garden shears' merges? Can you guess? Of
course you can. But you'll never know until I tell you. It is a little
silly to try to tell me that I do not have any experience with rebasing
merges when you have no idea what strategies I tried in the past.

Now, Phillip's strategy is clearly the best strategy I ever heard about,
and I am in the process of doing Actual Work to Put It To The Test.

> > You are just stuck with your pre-existing opinion.
> 
> I'm afraid that it's rather your huge experience with re-creating merges
> that makes you stuck to your pre-existing opinion and carefully shields
> you from experiencing actual paradigm shift.

You know what? Whatevs.

Ciao,
Johannes
