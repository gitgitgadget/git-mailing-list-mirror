Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211A81F731
	for <e@80x24.org>; Mon,  5 Aug 2019 11:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfHELcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 07:32:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:48609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfHELcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 07:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565004747;
        bh=rgCdwwiuPT4PnS/rVv94H/ZwNt1jQrbN8roY01Pm8PQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MkLGIHMHXsnO5dI90MMkXLNIKjz3CwDcSXpX/tC4U5nktyGhX5dLvy7m3vZZHH3w/
         opaW48MRRAT0VyMIMyUJdIY+kTX8A2kx8Ke9QqJ0uNt1+AeNsSjtWnXO9k/EC2L+fB
         X+oCyR0Oprtft59xFNJ6bx/2yJ7K5Y0XiwsOKSE8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgt3g-1hhS3v2XSK-00M25n; Mon, 05
 Aug 2019 13:32:27 +0200
Date:   Mon, 5 Aug 2019 13:32:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: show the test name at the start of
 verbose output
In-Reply-To: <20190805101237.GA20404@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1908051329301.46@tvgsbejvaqbjf.bet>
References: <20190803080126.29488-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1908042113300.46@tvgsbejvaqbjf.bet> <20190805101237.GA20404@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1170205063-1565004747=:46"
X-Provags-ID: V03:K1:LBpPYq+p6ApERfCsk9IwJfo2wAGNmKZzFOEUQYLAeWxpFCcQHf8
 PqSqRtE+F6go2KbthBMZmrrurR1uC6kjGmjWSphFHQvjs8s+vaWr6P4Pcuq+V5tJh46v3pW
 WrOlYo0QLaMQcJs1rzhPQoZ9QV1al8GleL/st7dj6+D5LO+yBZsI4DceofDfFdN3Iaihc2u
 6NPrBtmV9COuKZ7oD6iCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8aqDzBH6XE0=:mB1nMPoXRHNZPVf78CBv3w
 2VSNCeePow7lSujdfaYQWXssQRbCe/M1lWWNiNLBUD5/QL+gTSYomPJaHTDSijlPwCxtL2wZk
 DMHC4EnV/zOtuln4sA3Uwsvpc7m7aBXPAwL37f6i8hcwUsc3XhEJTgNv1JxG5BvKCAX2bM0fv
 Qe5B3GqGAtmcftYn8QwYJSEGehCL7BAw+5MeGIbdVfWDTLbF9pI7tffeW+Czkan7pZ7q06Tub
 nlz0oUhOGb9RGz3yIqK9zJuf7MWuaY3cQw1ixpF0HOUaFvV+tsrRH/22u3H6mb8vdfKTuNM74
 YxE26rADGHT8BkE50GH57cU2yLPV/I4zFi6pAwFc8sHTMNIFQOHnsjEtWAdswb9FuLIFvLAIo
 A4kiygGcdWIkz+u/no+c0OPJvKHbmOIc4UuYTouNIsnJoTYQxtx1ChkCvayFlDBrsRnNZi9iS
 p5k02DHDQvAOH2iQItZwxeQMk2CYVlgLZb8Z/AV1KloBMF8rj6plgNxrpB907T9fYqZpqoVHn
 FQMV6DcxNp6p3ENUSIKD3NoT5YSRww0zU+MWG24D8aZnaA4X99jts0+n8IVDzrjwygfSkiySd
 ATJFTmkF3kZ8PcFInRSXkBk4gMFsad/xz3MEHXo1OYvYYSfAdlqybLLnrSCtKEvFq/rl+7P9i
 LR3wtTovGpvUEdQqTXt48+iLq86jZgAkEy7PUlxl8+r703SGWi9Qq9fVJL2Xs1vV/1xHTmUqC
 bGEPpyh+Va8Ar0ZfbmNNeKKZm9Tc/z4cHfW6H6jcEmDCSIf48usWlryZ0kWGkErY8YpI5pQkv
 ceV57576I/Zi0TiLzxuSEWAb8Bz+HVwRHvdf2e88K0HZpGLexeX+NtPHMRk2TRB24leqAKD8+
 kWMe60NKIe9oZqikaPhZ5qcSqIwdPjEzTHcZxTuXMn7Wqq5swHo8CD2jX7CcqqV2aXXK51THm
 XHaWdgocIbWSTFLeN+BMbKLZs/KOB1oOX+V8z1Zvu3luEDGrPHPVsy6lfRrlscqE6zUM7dve6
 MmM874NXvTcBmhjNYLVarCdjqjCFeF15Qc+CG/HWPcyA5y+UrJRslvOO0/kflYeXg39ole88J
 4kpwQy8LCeGmtB+Xzk/ePX9+JuSRFX0uof/ChoTRVaiInwJjEbpWE8DVQjV8V6VQxmh/b3tQ3
 w0tH8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1170205063-1565004747=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 5 Aug 2019, SZEDER G=C3=A1bor wrote:

> On Sun, Aug 04, 2019 at 09:14:46PM +0200, Johannes Schindelin wrote:
> >
> > On Sat, 3 Aug 2019, SZEDER G=C3=A1bor wrote:
> >
> > > So the dummy test above would start like this:
> > >
> > >   expecting success of 'commit works':
> > >           echo content >file &&
> > >   [...]
> >
> > Maybe it would make sense to also mention the test and test case numbe=
r,
> > like so?
> >
> > 	expecting success of t9876.54 'it works':
>
> It's easy enough to do so, but I don't readily see any benefits.
>
> The '--verbose-log' of each test script is written to a separate
> file, whose name already contains the test number, so there is no use
> including it for each test case in there.  When running a test script
> and looking at its '--verbose' output, then surely all test numbers
> must be from that particular test script, so there is no use, either.
>
> As for the test case number, since the test cases are not numbered in
> the test scripts, I just ignore them right away, and look for test
> names anyway.
>
> Could you give an example?

Oh, my common way to read test logs is to sift through CI builds' logs,
in particular for the branches on https://github.com/gitster/git that
are based on commits without support for the convenient Tests tab in
Azure Pipelines.

So I hit Ctrl+F and look for `not ok` in literally hundreds/thousands of
lines. Of course, this is already the unrolled log _only_ of the failed
test scripts. Still, it is no fun to scoll back from test case 64 all
the way to 1 just to find out which test script contains this particular
failed test case.

Ciao,
Dscho

--8323328-1170205063-1565004747=:46--
