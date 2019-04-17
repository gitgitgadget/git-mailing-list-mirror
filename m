Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C5F20248
	for <e@80x24.org>; Wed, 17 Apr 2019 12:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfDQMu2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 08:50:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:49813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbfDQMu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 08:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555505421;
        bh=inKoWvKfsbWbXACAxLoCGYytYNDf9j7zM27rLedtltU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YfZGWvf26DJKqTQLMSHDIX6rx2WhbhjmTOAXe2DtIvcDg+5qZcfhqjLXVoINAVBnu
         KTeqTZxULJ39dDt/3nJcNy++TJdnV0Jg4psmyCZM+20Dl7hMFY5Y/URvVD84tm8GnB
         ql49o7h/cXoxdr+k9fJoIWq0J8vvGbMC9EZ1ZDEo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8MyE-1guQ2x0Vko-00vvh7; Wed, 17
 Apr 2019 14:50:21 +0200
Date:   Wed, 17 Apr 2019 14:50:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jc/format-patch-error-check, was Re: What's cooking in git.git (Apr
 2019, #03; Tue, 16)
In-Reply-To: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904171449330.46@tvgsbejvaqbjf.bet>
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AIe89ojm4JzEKbyYrjN/fBEKs/D/8ITzLaX00uDZfy5d5AFodfL
 GnKrbDs2RaVQR2Rni4NcVyJaBdGmx/yHwvFf0D6IDwwOJ0NVyNZtFy9Ce2UO3betBbOVDOz
 rYTZqieeHfDnkhqDT4kzAHz128bd6X9A+aErDFSeRT21IQMUaMRUEdMUgR5/kGOY74z2PFZ
 IoPd4gz5KQ7baXa8otFOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BOqZqrNNXXg=:UZPs5OtdPvWcpwwJnULcNN
 NhTLQ4N81fjT+41u96lN8sTKMkqFf/NwVdO+BkDpVP2Q8nN6lnMqH8m5bYIttdrAmubJF8bav
 KBf8atTjOaJG13SMihw0QI6q/LsWXkx3UQYHxJbmV6WGylHaiUc7W4JSnnR/mua/gkHU6bvDy
 v9MKAiBS3P1Pu0WegaZK3ftdsfAXJedcujdE3aZcZyucORcYWimyjApSxofhz2rEZJ/fGxH0i
 mRdGDgl5tbf1DNmKL5ZCU264GTgfD1QfbVYvpwyJ2dzS8e0JvhXPcw4ewZ/16DL/w3Jjjf1ab
 cm5E6gNTUcbDncFVaXY1vmvppfjEQgfVoOCsWU14/4RhB4Sml8zGX3XDkgMugVbdPiBHp561T
 LpDJ5j0tOPfWxW4APkpMCGL8ROlzXzg0tUo5CSZxSRjFy6h3kP+8ApI6pXWJspalHDlEsUb2S
 JpGw8Xv0kpxU1/hjXecgxRhk6HxDqj8PDp4+eBqSEfLqwBjhN4Eo3u5V5NPRYwqsWlLJJTc7a
 5DZaXKNzJ7vrnQWDR/y2MwIUz33eJISNi6j6yi1hhbONWVQ0rFv3lW4Y1EhOmVUR9h6cw2xeo
 ubLIrujNzYIfe0NC6qC0BwQyP6WpnnW3xpHDNvgqNfi+yJXzkK3y7vXOsUrhwn8kTG93Iap7Y
 Ej3uG2OL3i6m6WMq3GOjyOx2UR7B6Tysqq43HMXwz/tANvazYaMBKQxVnfm+mEh+VGHcs4UUD
 hP6vwasxHYBFpuunJpdfauutkCzQBTyR17F11JsbaqRROucPlWXHsVYAi6luDZOLV37VYgPLT
 leK6QCHRlqoX1W835f8CoZ0maYmtbFP1r9avuGtiJWhc98zKkt/up1QppHsgwpU8f5f8kMAGT
 3BONNkZIyT8y3555g6J5WFb9o2jX09U66NF+MJeBAYgLUCZMjurYMaMPdFA1e5aqlkMyfze1Q
 2Co3jfHZ3GA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 16 Apr 2019, Junio C Hamano wrote:

> * jc/format-patch-error-check (2019-02-22) 2 commits
>   (merged to 'next' on 2019-04-10 at 6ca358b7ef)
>  + format-patch: notice failure to open cover letter for writing
>  + builtin/log: downcase the beginning of error messages
>  (this branch is used by jc/format-patch-noclobber.)
>
>  "git format-patch" used overwrite an existing patch/cover-letter
>  file.  A new "--no-clobber" option stops it.

Is it possible that this description needs to be adjusted, now that the
=2D-no-clobber option patch is actually set to be discarded?

Ciao,
Dscho
