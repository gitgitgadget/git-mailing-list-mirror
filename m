Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4631F20323
	for <e@80x24.org>; Tue, 21 Mar 2017 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756822AbdCULH2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 07:07:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:53263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756550AbdCULH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 07:07:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1czfZ72Omo-009Ouo; Tue, 21
 Mar 2017 12:07:11 +0100
Date:   Tue, 21 Mar 2017 12:07:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCHv2 1/2] tests: create an interactive gdb session with the
 'debug' helper
In-Reply-To: <20170318161400.19753-1-szeder.dev@gmail.com>
Message-ID: <alpine.DEB.2.20.1703211206050.3767@virtualbox>
References: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com> <20170318161400.19753-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2093216316-1490094431=:3767"
X-Provags-ID: V03:K0:I/ZViSN7obl9sVwj7YuJzIeA+L33s7TW0WibBmDZD1Boluxw/CF
 KlKM3gJa4SLirc1oF6eGwAg1LGVVFCpVI2MnyKsD9KdxBUKXrxr39OiB8/UsJAFwum3niNj
 9RholZueugSbGckZj5Iu/9wqlyoRRVXvq5+goT9kD0x6g8PSb8lRCrr8EIEm+Eqf9jaeWUq
 JfF20zlmFb39E/qsw1sJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CxFV6lfmz2Q=:XLjg+08vUxVT/6FBC16ElZ
 HX8jU+xhM3+ujHVMlLi5tDGIaOLNRMm1r/oGG0OMP1vvjb8Pn+1XJTZOmL9ERfwbO6yW2vycG
 bJFa0fMHs/0X5vBia8TEfGeNU9zOFU9aBUGrS+S1oSZlkcC9/+TlypTIqEqzfEEQ++QV2laDL
 zv5fvpPLV44DCjHWtYV+uykd1RK36tCuX5QwkK//O1ekcQVuTfwEGAUCdzW7ZiUqUV81d2Mry
 E5M27O7D1Kc3aLSGyxFaRn2zd3x6+yimVA+8YQGZhRObq/IaamCt7zFzQQ+P7mQ6lAi4JwyQz
 5OhrvY/wJd2UeVsjLRPbRbbjGc2j7OMRJeg+LHKZbzRSWFbIKoTMUMMckjAgst+I6XhLD30ta
 iYD9Dssna+xEOW6e8AJgdeV/y+nEjRwCn+wxmULWo5ZqAs3S8wZuzTUCz8clMSjPcRGepN3mT
 Bf/eWOK7lmrcsPv0pPEwwE7rMNOHuiE49WYsUzQm6DEmXCvfbBgKZ/GRAEAbcsmayjwjSp9Jj
 6lkWrQAaM2P/5CEDtmnUfCz7sx1VNXftaPeMvYSojkLL5oEEFYmh2khrKdcGgfYH03Uu0RXzj
 WDlQY72OL0amWQkqvPjIi4nWJvKwbEwZ1DdMYPFBTcd1xBMNy1WTZuGKCLcTXaerOmChX4MgW
 cnSqJbMEFQQqFiA/h1ee4tOroUUrgoM3UC8iJaxMTenTuHLF+KkkGkbp4RxlS9lX1KjnIDExI
 dvyWnlxTxxk7vouSP0OGGisOV4alTDJbVkPVxzeZv4AGx3UPWNx1Ka390L6VLH8GzpsPbw66X
 3LNgucGEmctNqNUiulT1Dezrj7zOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2093216316-1490094431=:3767
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 18 Mar 2017, SZEDER G=C3=A1bor wrote:

> The 'debug' test helper is supposed to facilitate debugging by running
> a command of the test suite under gdb.  Unfortunately, its usefulness
> is severely limited, because that gdb session is not interactive,
> since the test's, and thus gdb's standard input is redirected from
> /dev/null (for a good reason, see 781f76b15 (test-lib: redirect stdin
> of tests, 2011-12-15)).
>=20
> Redirect gdb's standard file descriptors from/to the test
> environment's stdin, stdout and stderr in the 'debug' helper, thus
> creating an interactive gdb session (even in non-verbose mode), which
> is much, much more useful.

Thank you for working on this!

I meant to clean up my local patch that tried to avoid redirection
altogether in the case of `debug`, but I never could make it elegant
enough for my taste. Your approach is much better!

ACK,
Dscho
--8323329-2093216316-1490094431=:3767--
