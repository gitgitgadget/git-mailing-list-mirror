Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E937B1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 18:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGYSxU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 14:53:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:58821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfGYSxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 14:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564080793;
        bh=XREQUT8tGntpcvzMne8EvxDhs417t7i55HaY02p1dNU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gb0fu3mEuMlRRHZ49fJzmZTPIM6prqphRSe6xls5V2Wk4VTCDVf1FXSg4lipWgegg
         BZPDKqrHA12FlGnKDWANEieEIQ8whgR1DMEs4cX85MHygnTzNjgOD6smhawt9hM+zZ
         upMFzrC5LiyPt755Y9DhuVVa1Tp9SVBCAyK/HTv8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIdTM-1hoVw83uwq-002DU4; Thu, 25
 Jul 2019 20:53:13 +0200
Date:   Thu, 25 Jul 2019 20:53:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Clean up more of the fall-out from dropping the
 scripted git rebase
In-Reply-To: <xmqqh87aqfaa.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907252052570.21907@tvgsbejvaqbjf.bet>
References: <pull.293.git.gitgitgadget@gmail.com> <xmqqh87aqfaa.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wobLOOj/thiC1cZDL0Ii8sRluDCeB8zDjNWTyOAd3UaRK3Yp1c3
 iw7shpOhUarc+YLpk/CbotWsoBVt5Aekptgz9N+w+Y64PTr3iu2eKGzqFp2pZ1xJbFqpAS0
 aus8/IUinQETUz3iBf56X5D5t/CzUhpRDJWFx/tBzPV+bSaLamQlKGUFPdA6F/FCJcacbFL
 x1juEnXaEUinHw4q+p67w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XfyamP/L8+U=:cHmxi4iQsRH4IZt09O529g
 9Y1Z1XrKwSZXAbUQlDDeV8VGRnlLmGEJ7CToY2HC+CJVGxwOBfpTZuGuNYrsJuvR8yPymxnMv
 /v46lbQLqzhs+23vFAeBc2DWwdwLEPjLhFxAuSGH1/bFZm+dZLYddLX+6zkiRqBFSYUXJrUWT
 whKn2Sx91jU2XhMLtYI0fPBOdxnF1FWcuSMtA6S3wXP5HsMult4FwLPA5ysgrmUQCusqwCwml
 tihCMjwEybMiIuqJ9jwaLCd6Q30IcryDwASwbDAygpt+zXA5Yw/Yxm3ZlviGTgfxED5j9vP71
 ujaOhWN9fJjjx1xd60IWxvs2oLKKxv2CyXgIw1MCskGjJ1iQvBZeA4BPI+O2KaYEn7SiYPOR2
 jTu4x7vMR8zdXYSorRyF5T/ssS02Mk+GHmdZz0WkNzmysWLiH5NHy52l3n3abaTs8fwD5KfdM
 NeHsvEz4hXapEDZoiKCdjdRKsxDqr3vbFUriD9++WcK68xD0C/Hql+RXAZX1HnALb4PJXM3Wg
 hHF9nVRHQ8VuIABIpfkPTEfCvqxaubuowRe47nc6vWIBh/yu4f+BTFjyowLozq539shc18ABl
 6/K16Jdv/rjgLKBG3h8/NY4Sad8DqTMNhtpbOtlS+YgBqTOnciJbhhZDhjnq1WE+wPx+gEYYm
 KDeqmSnHOnjeMvK4PLyRpgY5VexDdxeSgeqoM3nlLO3GsVSI8YQ+rVpnIxHH936p2RTJVMSDP
 2HMl6taXk81HWwTYsc62eJS63vilNq/Vs2niLKmLDsy6UeLv2gpjYwRd4VlZAhgj3azxXr+Bv
 SvCzaVdVfKBFIGeQjQ/mOhyIjIc4EKrsxJWwxeiy+CVVUTNjb0/1CWA6l+9OMOdDnMLO3HBp/
 NeDFO+jv7IcEdoAnesTuT2fH5uOS7j+d8KRVipWPmM741oPPgxM7RAgm10Vv2q8EBFYdD9YKW
 pKtxGE7/eEluA6xQp6yGJSMK8no9vhZmlf1fydO/tSG7oKLyu493v+6n2UcUuXfNuYv6wCdNn
 ObLucbrN+BruRh2yfGgdFIdDkaOu37dC9Ltg+x70VulSOGq5UGgWIW+fAWhUdCwvsTZWfsP6L
 Ex/J7jWKnZ2Prh6kEGUSCg5ShF2SmuHdAPT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Jul 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > I had prepared these patches even before v2.22.0, but deemed them not
> > critical enough to push into that release.
>
> Thanks.  Both of these look quite sensible.  Will queue and
> fast-track.

Thank you!
Dscho
