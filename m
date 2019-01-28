Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACC81F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbfA1Rbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 12:31:46 -0500
Received: from mout.web.de ([212.227.15.3]:44611 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfA1Rbp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 12:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548696703;
        bh=Iyh8P+pHRTNKU+utcstjCPPH0uehHXK0A4gmyMM+yNU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=i9Rv9CvJOa3j5jzuRxB9EiS7EV2ga5vSn8yJ3k6kh4Ilsmyi8cr3VgN3CNdgCmSjZ
         qDT9DRLJnzYsOYiQzdrmPhfZU8XBqageDlct8g/xe9BXM63WtNsQEC8tJvBPQLHjVo
         mLQaOOW/tcA5udvDd6N5QfY8PZztHaQVOiJplvAg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3k9J-1h5hi2007F-00rF6O; Mon, 28
 Jan 2019 18:31:43 +0100
Date:   Mon, 28 Jan 2019 17:31:42 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Sergey Lukashev <lukashev.s@ya.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unclear docs
Message-ID: <20190128173142.5v6varper55t3apk@tb-raspi4>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
 <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:gqEoZvppBRemRYflU1wbZX9GUJxqm+qgJHgc4fJFWeBucibL1UX
 esLNenC6UTQKtnsqLy++6tL9fr/hEuLNKpOTX7BrDbIzLknSrh1pgdf4h4dHmQdhinK6B9v
 pKWsrfgDeZXOszd1fYJwd80wYqn3JfCO5YmteTEb7uO5Vj+xaQIuc0RGouwb4dC250nz8L+
 1AU0mfB4Hva79E4l4Yx2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zxmvvLjIM7c=:n+Dqrdy5GZoAsEz3jN8p+7
 93EGq+WZGzpWHB5gtO0KxdZKKMc2ZrwWNh4xcCrW88cXVCCQBXGeN8NMrpt04BbPb3bVNN891
 F1J2Etc+q2o9MGzpusfTNUCs5KnHJzDabqv+ekLgVhv0/c0lV+hz0kRpmDLFz6qKFf5Xr622M
 GlXpJcQh0x6e3ht9fcFzrYxuvaLek+zle1iHWWGlcFoAqpKn5HTSkL7x0im+LmeMcLMk6D/Gz
 z+GrgLCo542jdVuJTn2ajvoC1QPInwA0DlAyf/8YBY0ATzmix0eOvdz5M4BNNV6Hk2OpdOaAG
 KhfZgZYZfYlCqyfwfAwiaC7uaQpGjLNSH4tXANqxpvrlxANfLKjWP/mfH4ZjfuTfDVlBOJWY+
 P5fsSCbv+K2KDvAtM7EvHIzU78b7jA09H3SlJfZDQSjW/i4QKxadQGvG3eoSPjIxUKJlMQ++J
 s0tKgPcxsoarTjVU9NzD0M0hv9fBXws+93H8UfNSrqBRv/yCjD1OGyF57r071ScajAcA69bva
 u2NBb3z4X2wDlDZcV7d2CTvebT8oHiKARcOfDKxKBH6Wa6FLfewMKCrBH2Kgh7pO/5UzQiEdv
 slRYHb7Dm/1cXjiX1VThV4232X/flz3kg+nfjwYcChTrdv42ynjUM/hYPAU3ScMqTP8zYyld3
 5oh0T6Uc2t/RYcB8a50BdNiFDRwa5Xvszk3EezO4Sy8MuL3nGsoesIQZgJyXABy9qEfUcTVCL
 sR8MoGeWhF3qW0NQv1Pq28p5YQmP1EHE+VD9sOWFgb/dygqLGIHyvRhWdl3+KxmZ9WCmftq6x
 v+i7mGsUwxb7IYPU+XM/PpXYZV4GQJdDyswTZpFuyYBMoSfJf7MhmCnkshpSwAL4NrNJJ6Y1s
 QgECEigL1xmTpeOBVuO2mYFFJKk/4c7eyoQHpl3NNmnmfHpnSSbo8F44B0OMKX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 02:55:23PM +0300, Sergey Lukashev wrote:
> A follow up on my previous mail.
>
> Well, I have two problems:
> 1) The endings I get with core.autocrlf=3Dfalse depend on whether I have=
 * text=3Dauto (a file was commited with LFs). At least in git 2.20.1
> 2) If the quote holds true then autocrlf=3Dfalse is actually "true" (for=
 output conversion) on Windows by default because default core.eol is 'nat=
ive', which is CRLF. I believe autocrlf=3Dfalse is supposed to mean "no an=
y conversion, input or output, read or write the repo as is".
>
> 27.01.2019, 13:05, "Sergey Lukashev" <lukashev.s@ya.ru>:
> > Hello!
> >
> > Could somebody please explain what 'core.autocrlf overrides core.eol' =
means=A0given that we have the following statement=A0in core.eol docs:
> > "Sets the line ending type to use in the working directory for files t=
hat have the=A0text=A0property set when core.autocrlf is false".
> >
> > I would like to know which line endings I'm supposed to get in the wor=
king tree if I have core.autocrlf=3Dfalse and '* text=3Dauto' in .gitattri=
butes on windows. I get CRLFs which is consistent with the last quote but =
I don't understand what 'core.autocrlf overrides core.eol' means in this c=
ase.
> >
> > Links:
> > https://git-scm.com/docs/git-config#git-config-coreeol
> > https://git-scm.com/docs/gitattributes#_checking_out_and_checking_in

Given your .gitattributes file, you will get:

core.autocrlf=3Dfalse core.eol=3DCRLF    gives CRLF
core.autocrlf=3Dfalse core.eol=3DLF      gives LF
core.autocrlf=3Dfalse core.eol=3Dnative  gives CRLF under Windows, LF ever=
ywhere else
core.autocrlf=3Dtrue                   gives CRLF (regardless of core.eol)

Does this help ?




