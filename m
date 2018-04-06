Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7965B1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 12:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeDFMPZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 08:15:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:58969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbeDFMPY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 08:15:24 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVGq-1emkrf2Oau-00Hcj4; Fri, 06
 Apr 2018 14:15:19 +0200
Date:   Fri, 6 Apr 2018 14:15:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] Document the new color.* settings to colorize
 push errors/hints
In-Reply-To: <CAPig+cRW6VhZGrV3qN5gDyMu1Oc=hjDOpyo_OY43jyoQNc6Q1A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804061414330.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518783709.git.johannes.schindelin@gmx.de> <cover.1522968472.git.johannes.schindelin@gmx.de> <516b28e82ace0a0b6831c644f246c19dad1187ac.1522968472.git.johannes.schindelin@gmx.de>
 <CAPig+cRW6VhZGrV3qN5gDyMu1Oc=hjDOpyo_OY43jyoQNc6Q1A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h7Rn0y113id7R5cnLAYuJr72YnqCbNGpr9uEuV9bKbVsENtusBa
 H1aMiYf7xal28iLvYy3lcHs89Nte67umyQe0et9kCqZ5dF2YMuU3PsoAOVto8FtSEBiYzAT
 gCAPk7YCAbwl7QzJKS/uIP0PaFWDRGYC4NtmSUfqQpQ7lBevllhNJNji8+tLmJsUcJ+qYGI
 QGYKfbhfG4p2e9gyoUD8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fzPEB9V5jLU=:rKlb0rEsm/ob9wLirAqnrV
 zmulhtsYEgcXw5KOgTl7pP0JT+wbxpxo3m/p2ie7u/UIALfSZb/F7TxLGRrQRwmWYdGYer+Ez
 Cj8+Db7td6E8SDkYniQUlUrVPu3hyqSNNgNtvGzKaXJ46b6IQekRIp+XnEhy4eysTXU0wi51u
 4+742POapcOnaMRTx0lWErEz4FBKlEpHeLVbh8Yqgs5sk7grgdBKpMhEruS6V3K06mAHigU5Y
 xuohYwZKxFv026Ms7ZL8u8TYhYeMSiE+n5J0e6RNysFEnsWRLM6U9Qf27Co5G+4UFK4E26NJq
 EKsbCXm0j1FMhr42m0yek/ItpufLLcz9Srq09CAhcYgXFQVq4cGJFaT+s3IQrd6/kqpES7aEm
 toLhxMdMMJ2eZ8dgK42q3aYLAxmXadAlPi4lfCFE1rlgYdtxPSjOgw2KEi315dlebG1fEw+kA
 lXCcioQkUTloSaXVz+Q7XNKADGhf3laX86TkgiI/9lOT+7RjZMKNPTUb3I/0tVseUC9vS0DNT
 Apr+aVPna0YhE6i+CxiiaXaaUf12AaOJ1Ete/ZnUaRrW/rtQQHLLprAhf04wWqQjG5OA+9/O5
 EwmTQC3+Y2OSFjKl5mEkLbz41a9eCcOmtCqVAvVUkRsb+P7mF1mJrffF/VPP3XD/84WxUBpNM
 iSKIXybPQCckQihzsHzrASjLB2SeEChCvPEIIizWc3JXmrwmlGM7/AW7AA1aHeuswQzy5OBQ9
 GQuir/xrGMJa5BS+TA9qdzZeeDvPLJqTLgviTc/IT35PLhC/bhx+pUJ/6MuxImc5WKSsIpf4S
 CWS0Rxy2sc1CpWkC2r949w3FCGLmdK7ZFnaSCMkoq5MX0TDyI5wwOTgQuxLRtHQB6wUslGe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 6 Apr 2018, Eric Sunshine wrote:

> On Thu, Apr 5, 2018 at 6:48 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Let's make it easier for users to find out how to customize these colors.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > @@ -1088,6 +1088,16 @@ clean.requireForce::
> > +color.advice::
> > +       A boolean to enable/disable color in hints (e.g. when a push
> > +       failed, see `advice.*` for a list).  May be set to `always`,
> > +       `false` (or `never`) or `auto` (or `true`), in which case colors
> > +       are used only when the error output goes to a terminal. If
> > +       unset, then the value of `color.ui` is used (`auto` by default).
> > +
> > +color.advice.advice::
> > +       Use customized color for hints.
> 
> Is "color.advice.advice" correct?

As per the patch, yes. But you're right, it sounds silly. Will change to
`color.advice.hint`, okay?

Will be fixed in v3,
Dscho
