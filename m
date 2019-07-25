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
	by dcvr.yhbt.net (Postfix) with ESMTP id 381351F462
	for <e@80x24.org>; Thu, 25 Jul 2019 12:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404412AbfGYMA1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 08:00:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:32855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404362AbfGYMA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 08:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564056025;
        bh=jB3MmV0CavN5LlRNel8XEV8uI99xES7UY/9r25buzeQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Beq6h90A9HIuafjo+OEXHJZWt4Alsf6OH5lvOcSYKEzWKsfxH+JsAD5Ur2AApI4X9
         6Zw3HbfCKarOh2U9ebTvLHZO+I0gLoDfrTl+HqgZ4c8o7S/Py/8u8CTQfClJX0FMdD
         19ps6Z833RsSq2lDdGWj7dHesw1qMGwm09KX8dgU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKbZD-1hrzzy1CBr-001yvn; Thu, 25
 Jul 2019 14:00:25 +0200
Date:   Thu, 25 Jul 2019 14:00:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     git@vger.kernel.org
Subject: Re: Where do I send patches for git-gui?
In-Reply-To: <35506bd2-aae9-6608-ed4d-a408e0c831b8@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1907251358450.21907@tvgsbejvaqbjf.bet>
References: <35506bd2-aae9-6608-ed4d-a408e0c831b8@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HldhuT6Gb6oNtsp1mhICuVYuv4ksoDjnuPqx6GqyJUNHABmE67X
 go2oz971kvMf517eIEohUih962+kcBNma6Khhkx8CLW5tZzaWNLbQD7Np4GbiAsUBcnrZue
 LzIHmXBM4mx07/PjwhapzsoDg7pSfLSJ+kg2m12DSjzZC9jpRAWDuXQSWS1MPbsUFyCHnpH
 JVvT0/rmeEX0eIoVonyeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m+PW+jYyVbc=:Xabs139S56X7jgONHmaaCh
 GLo+V19veTfjFLc0KWyI9OeOHeRx3R5qEYxIyysG1QJgFvHv4ySTb3+yUpcG96pIRYeZxggks
 j2fXyn8HTo4zyvPDMk7UhjMLCXxWpIrj6dwAibQNneUGjLTaSwS+dBmm9pN6axgOeomS6cA3C
 czdYxzxrAaIsilHI6GGDX5v+7j4Kfou+vC+WDkfY1+c8k32Zi9Y1goeHKfmxWiSK0ZCFblm2+
 M/sZAnrHgbgtSOL2nu2xZd/T4asas5CAGGyQafIqAN5uUDLW5EVMvBAXC9gVWnKsqvXIDz9OE
 pQuBwNGvsrKiYa72TOc+sAhyY69pfohL7vQS2HzgovBPx9Tnd2OISiYh57WSsf7HWFKQJiLu/
 +V0z0rLzeUFMSTgY2zyFdqwsYt03nsyrZxl9cN2EcV2nOkB56KMtWZ1stSpCBzrlPP8nZrHjp
 N1O6Rxn399OH2+v235HeUJ4AcQJQD1AZStdQkhXvMpApC899v1cc5BMQnxXaS+1XVF0NxE3Hk
 IdIvgJCUhWfAFKfbNqtvqMdnD0gpnXgSvR4UzETNEPrL6pmiCVB6WoJYYIbhPc3NJqZecuog9
 QUH91aXzyz9HBI9SOH7lM9yD9RKEcd0P9oVoukoFZD9T1R+wK8CM5ebonJo6iCqABq9Jawu2i
 IOL+3pHQXWtpzDVZT+OtjVQEqlgOwzMBI2y4LesSI2WVVl8JqLuXI4fZ7zahPAO/vbBQB/DiM
 MEhvds/QerCL8yZP01nER9srWL+v0BZi5mkJnSl4WOgyGWgAKVD4OU4tzsFSJJYa9XQVaReQs
 xbcOxaILZBxFIuSFr/8g6DDqvRy1f4GOlrVFaITAqeqmYqkyGmjrlQGSjSQm5coOwvAswg9Vy
 Xi2qzBPVTNloCx767UlafTEvqajxTYEUPVOnajUYatyWnd5KJAHROmhF7EwzdY7dhka3DsM9/
 j0ZKtuxW7uZc2owC0W3uusg2zVyqrSnZPkY0LlSgodTLPezUJ0zQRLCODpzRAhVjeh/EiyxJ8
 +pzyx/tnXF0XSK9zbmFeQ6eeRSDKYLas6r9uMWTvTBo/6buZJvjGalVlIFmOmykmp7CHynMVs
 IPC729OzYYwTMxQQJDv3WJZEvYVAscdQA84
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 24 Jul 2019, Pratyush Yadav wrote:

> I have a quick little feature to add to git-gui, and I'm wondering
> where should I discuss it and send patches. The git-gui repo [0] has
> no readme I can see that would point me in the right direction.
> Googling around didn't get me anything either.
>
> Should I send it here on this list or is it somewhere else?
>
> Also, is the project even actively maintained any more? The last commit =
was in
> 2017.
>
> [0] http://repo.or.cz/w/git-gui.git/

Sadly, it seems that we do not have any active Git GUI maintainer,
indeed.

The latest repository for Git GUI seems to have been
https://github.com/patthoyts/git-gui, but even that has fallen dormant.

Your best bet is to send the patch to this list, and we'll just have to
try to work together to our best abilities to review and improve and
integrate it.

Ciao,
Johannes
