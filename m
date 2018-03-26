Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E9B1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeCZWfi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:35:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:49847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeCZWfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:35:37 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0ML6qP-1f0Jaw2BKD-000Myo; Tue, 27
 Mar 2018 00:35:27 +0200
Date:   Tue, 27 Mar 2018 00:35:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
In-Reply-To: <CAKk8isp_qx1ajgRryhBw6TYBoaa8fJU6hP3JyUWAx20knQSLXA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803270034040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com> <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com> <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com> <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
 <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com> <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com> <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com> <xmqqd0zqd8dw.fsf@gitster-ct.c.googlers.com> <3d845e99-e392-a62f-b83e-33b58482fc54@jeffhostetler.com>
 <CAKk8isp_qx1ajgRryhBw6TYBoaa8fJU6hP3JyUWAx20knQSLXA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fOFRXJxJ17/Wu263+FgbenkGIeBLfW9zwthKmaUrUpzPS1RhONu
 7UOWTrmP5LwcPaW1dJgtj6lYJh6mFnj0eK8rbVcbBb7BwaivZm/PLcKP8NpLMuEqTWzzvTI
 4+TJcGewZ2SqyXjBzfVhObeQCFtSkpR3dkFIcj+LZId8LuynWfg1G/Av+OrguRJ5tMpgSaw
 HkwHQAWgMWM+6JE1ckIEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1iCKKQzUARU=:l/ImPcVy4apJnznUWG+Qxt
 7qzYyTwwg41Tc69savr1ozEJY8Nwslq+dYmu40+PaSEU6ibZgCgPEUGusdZc/agz2BgtpA78J
 ti8IRf1Uo8k6Wik1mb4xFbnb2EMFBRkWVcUhCrUFswH1FWjGyY/MMujJCyvjiXFHgNeQjXjhs
 WYplqPRiJO6KwzAgYPxhnGfJDXwPDKtepVlBcTBD6N2Eu8OgfbO/1GFU53N7KI9edoUI0FLOi
 pOYdNMJq2+St80nAMsfy1uqV0dpnqfXNcMIYP/+sCMzHmRZYNtRgklg0OrZwxBOlOhE07/7do
 6HYcOUc/sJprD5xXAmveSX2r/nhGpt9YuvgLjGnWBr1tD2qWizBpkMjlAzLFeTrOPmQm1V2u3
 NgjHJPLZZWy4JM6j28y7hhavV1HRAksIzVNSdrCgEvuuzrWD284AGCUcgUmTr91pLNd/DjusQ
 6yCArstZtfmAhRcPB0wjno7z/pFpi9JNGAyOgTgYHEqRZVLqQS/iZ+YmXXtZF2zRxSyUKeSuI
 9dESFdHrGVnDrHe8z5GsSj2tQ5Bp6uN8rLirBTAMTdCAOIGARoMzB4U6jSMnWWt0mLO+XSe9r
 7GICNh3Mhn+9uQGTsUMvIJxuXgMLTGQIvqP7yuMNh7omSMMzaKLz9olLRL0wefwr8EPP4XvUm
 PTDBKWlCe8C714iuf/hEM4COP5410t/DMfs6V0QjWrSFxvzFY6Qah9z1rRXrB3JpqEEVU4zln
 SmdQBE5H2Jz5kUIr6Byx3/erdhoiXHQZOXWDqMnK5SFgwbraw3Lx4PX62eZUeKEKj92K4jt6g
 ygrobmLl4fkEY99Z9p9HrznGNkXYi7AzHwk2sOgL/Mmjl9SrD1DuNQifMIT8XLztmJWQf4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Mon, 26 Mar 2018, Wink Saville wrote:

> > I was just going by what the reported compiler error message was.
> > It said that "unsigned long" didn't match the uint64_t variable.
> > And that made me nervous.
> >
> > If all of the platforms we build on define uintmax_t >= 64 bits,
> > then it doesn't matter.
> >
> > If we do have a platform where uintmax_t is u32, then we'll have a
> > lot more breakage than in just the new function I added.
> >
> > Thanks,
> > Jeff
> 
> Should we add a "_Static_assert" that sizeof(uintmax_t) >= sizeof(uint64_t) ?

To come back to the subject that all of the mails in this here mail thread
of you gentle people bear: Wink's patches look good to me, and I would
like to have them be bumped down the next/master waterfall.

Ciao,
Dscho
