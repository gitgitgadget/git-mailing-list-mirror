Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0D81F404
	for <e@80x24.org>; Tue, 27 Mar 2018 14:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeC0Oa2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 10:30:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:47919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeC0Oa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 10:30:26 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSduu-1fAgx00TC8-00RaYQ; Tue, 27
 Mar 2018 16:30:14 +0200
Date:   Tue, 27 Mar 2018 16:30:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/10] Hash-independent tests (part 1)
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1803271629030.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qbht7qRK8Fb+JN/AASw3osEeZ9y+svTHfxzJmw7ZHRNGIL4y8dY
 M6eC5lESdID16X5cfgQ5AKc4N2Ko977wQruHIsmDuhna1/Z48IqCgvZo3cYdJIq8q7DkLwI
 DpzlVd/tZ3mXqbLBD2fPKwB5RizaAA3QCMWBJNPP+Vgs/NysO72PPLj93o9iB2CPb9R3Yl7
 RNMIJScpsVWjsb1ln4xlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hFwU6SfvB/s=:/dEMx87jP84vjT/Juq7MzC
 NiJRz0W6nnTZu/agMXL2hPDSAZ2ZlVFdxH2YNiMO3fvmcQ7gFP87ajYFI/oxkyq/U1wFRC9yt
 nvANWdJqUBxEj/0LYhVgIPvsRR0jMlFDcXQB5CyMib+PFRG02zyGsx/EJhJyPVIk4cEwpbGHV
 asUTXeTXRYC7csgg8W4LUggKjPYzoqWCqZxH5OwXZzyeLhLBR++vNv4QRmGaTTddnIWOpQ/vW
 kEObYYmQUKAXUOeJnjJ37A3m8ymsN8AdEc0gC02jJStsmlOZFJMrqP145F4H4KSjoXfJN+wUM
 0f1bzsLKwjuk0jvC9odfwC78tfDk38LEjX7JtLAOPaRV6QBPGdHamyaHccKncbntA8JbUdpmq
 c0jPSLBQQnaRIubSIyzpYRajNqgcCek/hAv2IjJSS6847XWFR6C/EkJ0EziViegCVmSleYYUS
 g1u8IH183XgHcEkJP0x1osqWq4ut1Oc6KFmUPZQGiCkn4LCnumS4xbAcVGbvGkVirqb8NWumm
 nUgnEU91hFCFs+WZD+xS02JNA/MsuLZCoNb5eJNBqY72SXaAeeXXRmk4qZ0QY8NBfPfu1g0tu
 1BgEi/bKW1omUQDhdBJr2D6RoubCQWhwSVRCH3malDYXvKAfDj9rQsG0X+F7zjHR/5LQxRwr8
 +8BUBo8Uift1sbIyyrKaMY5y1sDxudYqqMbXSS0GdtsdIp47TJWu548CMYlNid2Ha+oEXMjmQ
 kJ+vcJpl3sTfJ56bQBuNI8RuotgRGeN3JWGI8oD9esBPbK0G0mYup6JHsGk5Sw3dm8AlCgFc9
 8qgIks6dxQCrWBpZ78Zasg7SJJIeHFuSW0jPwA3MLsLzHQTyT1Tl5QlLsJh1mixhHUS/5SK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 25 Mar 2018, brian m. carlson wrote:

> This is a series to make our tests hash-independent.  Many tests have
> hard-coded SHA-1 values in them, and it would be valuable to express
> these items in a hash-independent way for our hash transitions.
> 
> The approach in this series relies on only three components for hash
> independence: git rev-parse, git hash-object, and EMPTY_BLOB and
> EMPTY_TREE.  Because many of our shell scripts and test components
> already rely on the first two, this seems like a safe assumption.
> 
> For the same reason, this series avoids modifying tests that test these
> components or their expected SHA-1 values.  I expect that when we add
> another hash function, we'll copy these tests to expose both SHA-1 and
> NewHash versions.
> 
> Many of our tests use heredocs for defining expected values.  My
> approach has been to interpolate values into the heredocs, as that
> produces the best readability in my view.
> 
> These tests have been tested using my "short BLAKE2b" series (branch
> blake2b-test-hash) and have also been tested based off master.
> 
> Comments on any aspect of this series are welcome, but opinions on the
> approach or style are especially so.

Thank you for this patch series!

I reviewed all 10 patches, and while I cannot say anything about whether
they miss any spot, they all look sensible and correct.

Thanks,
Dscho
