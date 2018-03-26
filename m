Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0711F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 11:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeCZLhs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 07:37:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:57427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbeCZLhr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 07:37:47 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRTiG-1f6yyq1yxs-00SjJ8; Mon, 26
 Mar 2018 13:37:40 +0200
Date:   Mon, 26 Mar 2018 13:37:57 +0200 (DST)
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
In-Reply-To: <87vae1h3uo.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803261333500.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com> <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net> <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8pscw0r.fsf@javad.com> <nycvar.QRO.7.76.6.1803070756550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87ina8ymxs.fsf@javad.com> <nycvar.QRO.7.76.6.1803080741160.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae1h3uo.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bNXm58eeRj+8kh8W9eq3MWjjCiicfNT5LvUqtKz4UuzuU/tP8hK
 hggQUXLfh/+Zx+YWwUyJD2YuBT8Vh1yHZDp4PT2V9o9v1hvKww8v66/zG4HrFEMFgWsYTk3
 zH1mSGsQC2tD1u16otM1jdk7kpwAhBCO81AnYPbnLB31jsWoJhCHyTSNXAzHB3avotSsIbT
 SVMIxbCJKNQY0nq9lmBsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8N656Pvx2tw=:nBS+gd9C0b081Gf8FOugcf
 b3o/u7alfIyvFOoU5I3YRn/jRt8D00SJiyLg3dq9bO/YKFYe/R2RprI5Y+vgj2nD9QVLcPcq0
 +PmYIDslSSEyqPMlqUv3UIJpGXuCro8o7eI8OQulvc5vAkV/WtWwEciTQjpCuiFzUvWs4xiad
 Qm8oOS81rIeoL9NWhopUVSz4GJYDGo+4NevILm4Kg+uMNcJWQECIWnIhK42hjGiPphD7uEnXj
 tdjEJawTHGS9xaqhxnfx9/kWQ2nYIOWnbsBRre1gW2BLL1TlnhEPmOZyoHbIOdyAdf1FyI/cO
 OMZQe37yrRGz5mYvbOci6lTdqQ/Vs/SCnQqCeuqobxflUBOma9d6YGvYiKDp2hITRZ4ObPXHw
 g65NRGwiaIwEnC1IxeZyMqBbndj+U98kwmLgucJoorQnU/YvBSse2HfDKJnahpuDbIY9J/8iJ
 mLWB6/r/DKoV1RNhcwVRu88slADYf3yqySWIJDVXdtvlNfP44GQSKrsDpvrbVyJIUSDNxPFfP
 J88+btiwAiBPSdwP+w6mchcUfXwKhaK61xz4Ed0tzGsU+pb8FqdN6zC56JdD/qgfGkIsEJhWy
 jUCxiaJmKq1oPHOfqNIQI0/zfMbFdlYvPnOC7RNIGI8nO468vGPmivh1688+kogpwe4UdFsJ6
 uUttNgL7JSUEhNyaRgF4kGF3TuyZOgwmeo2Z61FjrTCtRDkW9zWqqDSI/eVZW124Qc4QQmZvR
 3PC3UKGGXKF54UXABXJvt4VfjZrlRM5HM435qd2KQyil4Sw59RgfttTUGdcpMUm1VNbLpOG/U
 DbtpS8JccMGpT1T28dSkDV3sf0I3/NpPYXCHYTvGi19P75rsgqjySTlj2k87YCk/eS0F1VA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, 12 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > On Wed, 7 Mar 2018, Sergey Organov wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > How can your approach -- which relies *very much* on having the
> >> > original parent commits -- not *require* that consistency check?
> >> 
> >> I don't understand what you mean, sorry. Could you please point me to
> >> the *require* you talk about in the original proposal?
> >
> > Imagine a todo list that contains this line
> >
> > 	merge -C abcdef 123456
> >
> > and now the user edits it (this is an interactive rebase, after all),
> > adding another merge head:
> >
> > 	merge -C abcdef 987654 123456
> >
> > Now your strategy would have a serious problem: to find the original
> > version of 987654. If there was one.
> 
> We are talking about different checks then. My method has a built-in
> check that Pillip's one doesn't.

Since you did not bother to elaborate, I have to assume that your
"built-in check" is that thing where intermediate merges can give you
conflicts?

If so, there is a possibility in Phillip's method for such conflicts, too:
we have to perform as many 3-way merges as there are parent commits.

It does make me uncomfortable to have to speculate what you meant, though.

> >> > What would your approach (that still has no satisfyingly trivial
> >> > explanation, in my mind)
> >> 
> >> Here is one-liner: rebase sides of the merge commit and then 3-way
> >> merge them, using original merge commit as merge base.
> >
> > But I already pointed out how that would undo a commit having been
> > dropped.
> 
> No. Not for this version. You did it for originally flawed version of
> the method, that has been already fixed by addition of "using original
> merge commit as merge base" in the above sentence, and that was the
> exact reason for [RFC v2], that in turn is explicitly stated at the
> beginning of [RFC v2].

Since there is no "interdiff" between your versions, it is unreasonably
hard to deduce this, and since you seem to be unwilling to explain... I'll
just leave it at that.

Ciao,
Johannes
