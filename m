Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18FCF1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 12:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeC0Mzw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 08:55:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:52855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752086AbeC0Mzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 08:55:51 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWSwU-1f2Sp02miY-00XcaI; Tue, 27
 Mar 2018 14:55:44 +0200
Date:   Tue, 27 Mar 2018 14:55:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     phillip.wood@dunelm.org.uk,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <87in9igl0s.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803271454010.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
 <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
 <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8pscw0r.fsf@javad.com> <nycvar.QRO.7.76.6.1803070756550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87ina8ymxs.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803080741160.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae1h3uo.fsf@javad.com> <nycvar.QRO.7.76.6.1803261333500.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87in9igl0s.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9m47gkf3ifMTiNCM3Ri2OXy4LXlpRtKB1ZFiPX3VxMo3Lyn9tPY
 qO03z/eHeyjReT90qq2xIsdzV5GAg/65HpwJqHodoZIPq/jjBaAAciHBNQ50cNmumGqGSv5
 VFd9LMAHU04oW0ciL1vYPtNmhvYUgT0BddtZEewJCu7un26DbND/N0fsIchgJuU047RPK5q
 YurxGmMtgJ/CKSnPbz+wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eEiYTk23HN8=:73wYcRy/11zwTqGJl6BY2V
 OHAjU1sHdAo77FEjxkXmL0iE4FviwNElL7nif3NlwEiNyfj+WLN8Zj3rLuajHeCW10gF7Q9Rj
 t5Rj+lb9fyHFGyv12Z5xVmHpexyTlMb+pMIwd7E+Zpw7yBFVXNsvj9JgHsUVNHTM9Lo6Ci1Me
 UYBmdHk5sEP08ULU2ovUT6t+aJTTDUjpx1KUu6Ltn33znu/RhJc2r6VXvLUVuu/vtjRqlH0L9
 FW5/kYaR0xP5EEBsP+ojpxqvWJmJI0VUyb26ILnoyz6tewG8qb6DWeSzJqDIqnxvjy8TCi2OV
 ZygEAdXl5iARdEmH+7GCFzh1hGGxrWgX6FisUIM8LwWNOpQ8sWYTrIS6SKOPw8msyhhkC4CFn
 Ju8x/nOthNu5FTyvvMDDOBsWBoik5kPmy42/JUDkFF2qTf/O1sXmwH3SCgv421l1K0FeryCRt
 aPlM6dNbU9dvmKZv6O2CYeLKC7JNBbAoIcgh9g9KuP6zMrnToO3CVHZh6ZL03KBd3vWICTA85
 CsvcSsQH2dFlfObdcbO4PE5iXZCrgfW1dvKqeewhoqbTs9YjqU/A7TCl2wU8cKDB1L09iYvyH
 45XLa7V7rM6aG5s1AcBS29XFzYwXGDyKhOKESSd3dX/PvDneZLQWTYRHG6zlx+1r0nq0YFSYm
 8q9/UNayM782UVt6nDz1RjrvC/0MqEKXhgqYDRcBJ1aMxeafvyfUaw9LbG7ZASMx0k4DPIbNe
 RKSYKXnHiG88zacWM0S1otsJUsl6N2vWxVQiLVGuCz2lDEGnDvEPf+NDdQbqu0HDjLWeWevav
 Cue9PfMiDQtshjv3B0yn8pEiIDAiYQb3oCWp0EqXqsR9ydhGT/xvYaaSuBCzmUKr8at8jlP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, 27 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 12 Mar 2018, Sergey Organov wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> >
> >> > On Wed, 7 Mar 2018, Sergey Organov wrote:
> >> >
> >> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> >> 
> >> >> > How can your approach -- which relies *very much* on having the
> >> >> > original parent commits -- not *require* that consistency check?
> >> >> 
> >> >> I don't understand what you mean, sorry. Could you please point me
> >> >> to the *require* you talk about in the original proposal?
> >> >
> >> > Imagine a todo list that contains this line
> >> >
> >> > 	merge -C abcdef 123456
> >> >
> >> > and now the user edits it (this is an interactive rebase, after
> >> > all), adding another merge head:
> >> >
> >> > 	merge -C abcdef 987654 123456
> >> >
> >> > Now your strategy would have a serious problem: to find the
> >> > original version of 987654. If there was one.
> >> 
> >> We are talking about different checks then. My method has a built-in
> >> check that Pillip's one doesn't.
> >
> > Since you did not bother to elaborate, I have to assume that your
> > "built-in check" is that thing where intermediate merges can give you
> > conflicts?
> >
> > If so, there is a possibility in Phillip's method for such conflicts,
> > too: we have to perform as many 3-way merges as there are parent
> > commits.
> >
> > It does make me uncomfortable to have to speculate what you meant,
> > though.
> 
> It doesn't matter anymore as this check could easily be added to
> Phillip's algorithm as well, see [1].
> 
> [1] https://public-inbox.org/git/87efkn6s1h.fsf@javad.com

Ah, and there I was, thinking that finally you would answer my questions
directly, instead you keep directing me elsewhere ("read that! Somewhere
in there you will find the answer you are looking for").

My time is a bit too valuable, and I will not continue a discussion where
my questions are constantly deflected that way.

Ciao,
Johannes
