Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F01C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 13:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiADNkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 08:40:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:46051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbiADNkk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 08:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641303619;
        bh=KrVrfMyL7xmqGmFJ4tFHLHc5c+tOvLIgiIBWu/ZPcCM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RC4o5Nx5W/yPqSv+YkGF8bhFXQKaoBgAIMyQ+9DCzedHKLkWqTOi2MTqm40D7XkXa
         TU84xxsO0yNMqE2uxuuUlQr590yyiGoMR0uGe8ii5fQUxATFDWy56pn4wJ8yo5wJNE
         Fr/oEoV1rb9c9nkvBTzP5AG/ofiDwhy39Ej1LjKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1mMqdn20nI-00zpff; Tue, 04
 Jan 2022 14:40:19 +0100
Date:   Tue, 4 Jan 2022 14:40:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/3] gitfaq: add documentation on proxies
In-Reply-To: <20211107225525.431138-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2201041427550.7076@tvgsbejvaqbjf.bet>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net> <20211107225525.431138-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Y+u1i55dXT7v4iv7JExeDYLRCFP6/5Ucvabliuz2T9y2QilN1Zv
 5E9DOb/igq2dukqa8oXLHGk0ymgZiQPUxnMSZgIf73btn1vjRLPHvdCh2x4ZvNJx07UI2Ak
 Veu0+oC8wZyhzoPF3Xa+vd1O/lf2huIIpvO9xyxxoewD5FG1EdFiCwosmwU4yb9BfNxjs9K
 w8AsMY0lWBmFS53wTgLDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Zqsg7dEnSM=:UOhQVvxq0gIVnSZn9e4Xxj
 2DraUaYcZPxbOOEWCJrBWL7UDFZeZM3icYvEnpxNALoaSPUi94WOu6KiIqz3GtZF25zEMPFzn
 7Qe9x/e2QobIz4t6e4lp7BGh/8kGgoo/mL4JIvPLIbMLFoZK9qBE3IZ67T6P4UfjncVVnP+hA
 EY+Q/bYaFrUo6wExbcUQrP+mYjOQAovbx/nj/BlaIxM83gZqHXmfi/5SyQs7nq++RZ7SSnwpJ
 dvItW2S/QHhmaJWDm+fkxlzeiTYfIMmcsCJZrYN+oEN2+yt7yl96Ek2t9YrcvAt8VdILsZXoh
 kgN5Lsx1hJasFQU2MJBLChEta8ZANhDPHPHwV0CKQFF4KPsGVWCPfOk/2ddVtKo1Yi2MBSVRy
 yFnm0fdcCuwLgXbJq4fXIqD1QpgEqeS0VxSN5JYENzW/TJOYzApMm5wgd9VMJboQJ7t+vuKhH
 1RQsBH5DS96iIGDSYtTqZzxqiingIoWnkDMUGsr1ZggYQDHLN8bOsQLPMz9+8DAW8f34/4T28
 x0DBLuhJl9rKgI94Zqx6PaGeBu49KLgyivM9ccBTncuNfIjcG4nwBqHA0gUANWHqkDuEj9YJe
 im2qekolZHN/5MnGz7RlFXOyJ9/v4p0QLtP7lDM/ptFOXEivTf8QyDdCasofs2yggd7+5OIFM
 vY1T+VnONHIgMAvi0aZw8BBLdWMH33y89DTjqMEfb6NgP4t9jCSZDKLTh02rEfRyYJn30JI4h
 PbWZ6NpHNe+yoU/fvjpu07ADMq5s/Ht0C5lIy1/qURSQ0Xx6pivp5kJKkXnKk5TXGvMXMUV6F
 nlaDUBSzrwvh+HrblG7/quJsVYibSQXug4gdKiV3A7AGqc4xJmxz7+GOAgl8x7wDJg4dREr6V
 DenGjye9LLGL54YRWX3g5DyCfCMkMTrg+cZZuPo2zVXUJLUDLE/rYrDfmGVvLCbwqz4aowJAe
 le0DIejjpnb2QeDDQBIXx1iVJRiO5oJTUwk6GiIdC5A1FfMsY6xEJJjNUdbsodePv5FEWrvDN
 RNhZ6hHHTESX+KYVsxi5VJ9hD4DSGJDYaOT4+c59KuPy9sBzOcY5tMVu3FxBHdeCuCAhqE9nr
 qJWKz/dAI/1x0Q=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, 7 Nov 2021, brian m. carlson wrote:

> Many corporate environments and local systems have proxies in use.  Note
> the situations in which proxies can be used and how to configure them.
> At the same time, note what standards a proxy must follow to work with
> Git.  Explicitly call out certain classes that are known to routinely
> have problems reported various places online, including in the Git for

Not a big issue, but I think there is an "at" or "to" missing before
"various places online".

> Windows issue tracker and on Stack Overflow, and recommend against the
> use of such software.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitfaq.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 946691c153..5c21951f7b 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -241,6 +241,29 @@ How do I know if I want to do a fetch or a pull?::
>  	ignore the upstream changes.  A pull consists of a fetch followed
>  	immediately by either a merge or rebase.  See linkgit:git-pull[1].
>
> +[[proxy]]
> +Can I use a proxy with Git?::
> +	Yes, Git supports the use of proxies.  Git honors the standard `http_p=
roxy`,
> +	`https_proxy`, and `no_proxy` environment variables commonly used on U=
nix, and
> +	it also can be configured with `http.proxy` and similar options for HT=
TPS (see
> +	linkgit:git-config[1]).  The `http.proxy` and related options can be
> +	customized on a per-URL pattern basis.  In addition, Git can in theory
> +	function normally with transparent proxies that exist on the network.
> ++
> +For SSH, Git can support a proxy using `core.gitproxy`. Commonly used t=
ools
> +include `netcat` and `socat`.

The first idea I had after reading this is: where are these examples
documented? Certainly not where I expected them, namely at
https://git-scm.com/docs/git-config#Documentation/git-config.txt-coregitPr=
oxy

And then I got puzzled. Why would `gitproxy` be used for the _SSH_
protocol? And I don't think it is used. I think it is only used for
connections using the `git://` protocol. I might very easily be wrong, of
course.

> However, they must be configured not to exit when +seeing EOF on
> standard input, which usually means that `netcat` will require +`-q` and
> `socat` will require a timeout with something like `-t 10`.

IMHO it would make sense to add a concrete example, or maybe even two
concrete examples, one for `netcat` and one for `socat`.

> ++
> +Note that in all cases, for Git to work properly, the proxy must be com=
pletely
> +transparent.  The proxy cannot modify, tamper with, change, or buffer t=
he
> +connection in any way, or Git will almost certainly fail to work.  Note=
 that
> +many proxies, including many TLS middleboxes, Windows antivirus and fir=
ewall
> +programs other than Windows Defender and Windows Firewall, and filterin=
g proxies
> +fail to meet this standard, and as a result end up breaking Git.  Becau=
se of the
> +many reports of problems, we recommend against the use of these classes=
 of
> +software and devices.
> +

This is good advice.

Ciao,
Dscho
