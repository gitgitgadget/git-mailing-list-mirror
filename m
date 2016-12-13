Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5882F2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbcLMPuj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:50:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:57141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933015AbcLMPtI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:49:08 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBFgr-1cR1y70iA9-00AE6a; Tue, 13
 Dec 2016 16:42:22 +0100
Date:   Tue, 13 Dec 2016 16:42:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
In-Reply-To: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612131641291.23160@virtualbox>
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IA3AVYnarueLP8mTbV/Ga2sXQYIifUVx5Gk6wxPTw/BDbmQwHcb
 Vcka9TayqMxfXoy/OTiBV7uptWBL/YBkwsXTRh72oD/oVzAPA7ry98sXjJqPrLT6Gpxx7ua
 qslCyJWO0rTRiN0vawrycHqXSzTXawPX6dFYoSvec8uwNnni71Jx2b2Xl1ZL4I4ihbPAaby
 3pB3TPZXDdKuKfgWomkVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tTgtm83K5M8=:O2Y7Xk0pC1F1aajPWul7Kq
 PxatcxnIAvO3qrndJtS4waXW5X1hj8i3nX2bqFTkJp5LK04B399Up+P6tp2JIr6pgJL7+x+i9
 Jf071RhOD6Sq+7ok56rTW+pz1PYf8WZ3Q9wge89TfGjbmSi2lMBaXQRgUMBS8d1pMDTeyuL4p
 S3CLhhrFKIvIBGi9Qm6PZOcL1W1Jvb993O8hqEVeIewZKZ3bHMqA+tyAO0ChN0vVqOrZpa7yQ
 p85HDQw5nOlzCteAD8d9HZUICZCuEcs4vErxR2ntBQ0lqA5W8N62K4oz8NateN4skY2kg7O69
 01kSxkwEeeCc8GUMDf7ZOY1ddb+NoZiz3fvr/IQHSjALhDAiCZP9m5VfB3PuNzQw1uf+4yfPs
 4/eA90v2xgIiPMhRWXYonbzKOfpMA6Wne0Lim6C49iuZZV/XOvl/FOxhRbjxP2qfV+AUz049k
 fz+iuIf6isAtvPW1fUx0f3BY6bzGKV0A0hM+JtiTvy8b1AIeTaVbIrERgQgj3fpX5vDWOhjJb
 v/IvURSXQ+KqMpP4jhf1GP8d7HKoFAzOYOgJxsqWwl8cV1WHlBmlvIqX7FzxwTS6b9eKEI3DW
 IBC2gvTKajexrjYMI7Mx9xDGb+yHsakZ/6YPcUCXFJq+2Wp+fSftCK/AlAXPWo9NIcwvonAZT
 GKUsRL0Dam5lIZsrjwhxJRJq9q1tefe3+aGOXxnKlfA1GWOzrCcZA/beXAdF1qD9OKN6kihTc
 5Ii/GOYDdH0PIb4m24nGwwkVfrmRUSHT0ovkCHYCixtA3ofQ/ieqKxBwx5+4cvcGEPk6ba0bv
 MHjFNlc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Dec 2016, Junio C Hamano wrote:

> * jc/bundle (2016-03-03) 6 commits
>  - index-pack: --clone-bundle option
>  - Merge branch 'jc/index-pack' into jc/bundle
>  - bundle v3: the beginning
>  - bundle: keep a copy of bundle file name in the in-core bundle header
>  - bundle: plug resource leak
>  - bundle doc: 'verify' is not about verifying the bundle
> 
>  The beginning of "split bundle", which could be one of the
>  ingredients to allow "git clone" traffic off of the core server
>  network to CDN.
> 
>  While I think it would make it easier for people to experiment and
>  build on if the topic is merged to 'next', I am at the same time a
>  bit reluctant to merge an unproven new topic that introduces a new
>  file format, which we may end up having to support til the end of
>  time.  It is likely that to support a "prime clone from CDN", it
>  would need a lot more than just "these are the heads and the pack
>  data is over there", so this may not be sufficient.
> 
>  Will discard.

You could mark it as experimental, subject to change, and merge it to
`next` safely.

Ciao,
Dscho
