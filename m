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
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3481F731
	for <e@80x24.org>; Sun,  4 Aug 2019 19:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfHDTPI (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 15:15:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:38391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfHDTPI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 15:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564946101;
        bh=I9DhtUPxsOJyzOp5WLr7iz4X4VbOdgNAZsQRr77qljI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PV7AbncmB/tdYqkimFnbAu9pdLc6GSvWjrTTRlhUaZlF5ohaVaNMuEa4Hq0lmzWYC
         bYKoVQsI/a1WH4qZ8NBrbBvAzk4QY6czgxy8Ago6X/nrOqZMbfIe6lMtH/oIJhN9rW
         /lbWLpgjPt5egNiuxTep28l+UVDtrdfgFkv5cjq4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbaS9-1hbRfk26Ld-00J6L3; Sun, 04
 Aug 2019 21:15:01 +0200
Date:   Sun, 4 Aug 2019 21:14:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: show the test name at the start of
 verbose output
In-Reply-To: <20190803080126.29488-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908042113300.46@tvgsbejvaqbjf.bet>
References: <20190803080126.29488-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-467239743-1564946104=:46"
X-Provags-ID: V03:K1:35+qTpJpqylHH4qtpmBSCjezEH37MdYz5oOsZ9kaXabvcaR+l4b
 UobWWRifgRHw4ZuLDSFe6D2n0hwo10mVWb2v9SOVkRdUN1W0Paw4qx1ZlLqF+CqCCGXQkD3
 AiwumbJsUTHcF/TJEbNPVSpaE8Y1vVRAMPr5buZefML+h17aQoTE4HPMQmJQplAC5jdHwCd
 +nkATbivc34y32BsYRdHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wD+0V6xKv3c=:Ta0KpXtvttl/Samc1xukq6
 FE4Qbct1Np4EyBC997VnxcyNPl3JIcPLnoNdyuH/TY2KpS+aNn/OgkPXT2aXOonAxBLcTSC9U
 uDxonCEdLqAHF6crMxdWKLMGcI/D/W0SDPCjgtiyoqqoN7b/VF29IBcWOqda6XmaN5RyFFCgM
 4wM9HoYltBMLNLb7yHq/cZnEcfvFB0aiJUj2GKZwI6PfGDL4UefQFJbRTIWNLxny+Hen4pB1X
 TZS7RqAn/+M3XSkvWBdKpv5slcZ8HFG3gJ7u969MZLDY/xRCZyTdnCJ/y6QoitQp98MKt51Rs
 20kufYmZbgmOQQB97Fe4wl4nGjUCdPjfdqsx2mdZfml+SBdNg52wYMLW7H2+1R0ak+8h1raJT
 5WSifeKkGn/KW9AJZKbCtWSCjGZrqgLU21Sj61XyWEd14AzCr4lCTGy3KgABGU4xi0UxhxNAn
 O9ALZbCU7y2GeBg+BUsoDUUoT2e67+fMZCyLJ6ezElytNWbH7YJHNerza1XgBHaTQMTQDKYtv
 JOgIba2di3lhtj01Wi+CuatY84HQiUNXgndExq2gi4TiS7WiRNWGwjLKwtlvSZ8mKEyIGCc25
 FsriYEOhigvXMqpzJ7fC0tSVMuHPqWkqhWcj6ob6vW0RdoMIoyemDN+lGzzyHVXOkZGlpft7s
 7qKC4VXt8T64KT//SITfdgsUWXQBH6O1OB0A/SylMV9w5qOeW3vPRAs/OynPpuCROrH53a/re
 wBOCN/Z4C/GFi2i7vueL0kKi1FfhH7TjwOVzHy/xnObQrrPc7qzmzZiP00bdLC2nc7hL9hUK2
 7/SjTp47CCkXQkX91vk4+1DVVnTSuPcWuIdSKIQpZkmYZisikzqPD9CEGSuLonlo6arXVm4EK
 63UUJ0kxXDu1kP3jbFMmCgAvF7Tv7QpxKznKT489kETJYCqHVGM22seeEDDJu2Fs1xHAndZVe
 YXrJ96ODpNT7/gyupnygPwG/WH8RVbRKMxc1qT0X8KgUgnCq1TFcfyByFZkNExIV93wkjAEV3
 fKpwmsjLWYed1UOFbhXhq7vCI3OewcNJru+MW7PNsQ2BKoQrLFNI3V0idw8zl63W4x/nfbDWe
 jxOp6wM1U+fYx4wT1BfCGleyl0QA4RU11LOdwJD1oDJMM9tVwZq0AhOoKfg3+INZPPiOonWCL
 lW+TE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-467239743-1564946104=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 3 Aug 2019, SZEDER G=C3=A1bor wrote:

> So the dummy test above would start like this:
>
>   expecting success of 'commit works':
>           echo content >file &&
>   [...]

Maybe it would make sense to also mention the test and test case number,
like so?

	expecting success of t9876.54 'it works':

Ciao,
Dscho

--8323328-467239743-1564946104=:46--
