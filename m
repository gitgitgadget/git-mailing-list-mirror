Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99771F461
	for <e@80x24.org>; Fri, 21 Jun 2019 13:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfFUNED (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 09:04:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:58947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfFUNEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 09:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561122240;
        bh=YbD9TASZo/qT7kKxXOq92+J2xvkdpwmQXWan8oF7jYE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GeobomI7Mbg7xyvVdzQuJtN3f5OyPD0mnAPY79hG9yTw71oug5BN3crdhq3lsOr4n
         Np07zi9FO1OXonKaEBftu4X+tnISiMgoeR3M4P25ie/DjZ+b7UFy/oDyw+0SgCFBOJ
         FypFt4c3Y8Z/icafaHyCu78HjnqwcdwMR63Op5BY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1hcwYm4AfL-0032LQ; Fri, 21
 Jun 2019 15:04:00 +0200
Date:   Fri, 21 Jun 2019 15:04:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/8] ls-files: add --json to dump the index
In-Reply-To: <e3b8d7bf-486d-d52f-9a33-6a7ff837552e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906211501350.44@tvgsbejvaqbjf.bet>
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619095858.30124-2-pclouds@gmail.com> <e3b8d7bf-486d-d52f-9a33-6a7ff837552e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-12195129-1561122257=:44"
X-Provags-ID: V03:K1:UdMWXPESOs7A6DsfTaJpoNKRhY1Z/8mCI3Sr/gUMY8lGzqArNIH
 1KYbE7B0Ad/50H30hyyR94TqqU2p2Ww2Z5NQsf5wUKGkEXyhapv6QVQ64JnOB/bmnHWOwk9
 id510CwBFTOUVHkh8ZFVvkOV/89WsXRuzPFIXX63AS3HrxBHIbhx069NlENW2ek9TfN7YZB
 i61Xijoli1MtgvTM5l3gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PhfO9BoHyv4=:NaR5do9hGixutF0q1EiyDl
 nVYJQeGiTUncnRDV1t9aELpzEFBVk+RVK7rvVtCprnUKGOZ61CnWHlSfrmIBlfPcMGUpwn6lL
 Tg59u88Bwk1h7DrvN/eWiMv2RJrSc8TKfCh0zonx8G4U3hVUlnPXndbmTZ+fRhfCV1Wdg/IB9
 nV+5C/zT9s/IN38shgw7zMPT8A/nWyfcv5aeg1INJrXsb9noizbS49FlOLpXLzKPyRWFUT3cp
 VQjvaAMkHiPjsOHdSvMR+6VwVxrCQWSwGZAPPHW2fFR9QGHnXGQ1H8GJ4s1BYVEr3cIpWB9Z+
 +CXWkwSSOLs+5CkFEE+HRjCs2DiUj2wQqrGQ41waTP0a5wbzoDNFMkJgKbYZ3UevdFLCGuHXM
 97pW5rxTJgX8SL0/hKORmb4PrOFyoWMPlVSQ7cUH8iCjfpm7Gv+7GUdtJotXoDOF8xcTq8L/4
 pKlG2o3zRJzLVHBfHjxgVC26EWeF/+csVhlSaJXqi7ZqohJZ/nLrCpbGx7bObIKsC4qZc4Dw9
 y2SD0WdsGDOIK5jWeM68qqoCGJ+QhSmMr9UlbAGl8igElrBn3p2bWekVwhl+Kel8H+IvERpUk
 dKAHAQ3Ik/0A8PWJM1uCQl+uuayCj2t0nvKwuUOp+y+VQmisFSaBt7YVRobvFajvfj7Rq/R0W
 0KdtLqp+nLQaWn2Qzk1mkF2IJaBnemOhFd/adbmPuBHEWL7htjxmfUKwGC2ncHAGXrwRj5U9L
 RMk4kyPRVeF9uOuRXPtMkCVzAwscWdDWP118MbQD42WaEUk1o/Zghub+Ry2dDiMJNjLXKkXHa
 IfXGU7dd5pEziF/d4rwmIGQz/vaKEhRQ7+i9/fyY2++R3Q5wquHgiuLetqrJN0M96d9QPcyHe
 da97wV9VOenIJccor+FEBEDzyFfgi5bB1eArJQo/f0O35NeaCjjIoNGxEiqvBq+Vj3ULh3ckY
 olLJOUxEDnjx7lCUjh6ZM/k7B+XSa9Sssm1b6sIezvDy6JaKARmEi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-12195129-1561122257=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 19 Jun 2019, Derrick Stolee wrote:

> On 6/19/2019 5:58 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > +--json::
> > +	Dump the entire index content in JSON format. This is for
> > +	debugging purposes and the JSON structure may change from time
> > +	to time.
> > +
>
> "...purposes and the JSON structure may change from time to time" may be
> better as "...purposes. The JSON structure is subject to change."

It would probably make even more sense to mark this as an experimental
feature for now (i.e. prefix the description with "(EXPERIMENTAL) ", so
that users will have a harder time to miss that vague statement at the
end.

Once the feature stabilized enough, it would probably make sense to start
versioning the JSON format (`--json[=3D<version>]`, defaulting to the
latest).

That would make this a pretty useful feature not only for debugging, I
would imagine, but really would set a precedent for a better "API" for
3rd-party applications to use than the current one.

Thanks,
Dscho

--8323328-12195129-1561122257=:44--
