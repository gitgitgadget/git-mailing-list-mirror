Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64863C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBDIJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 03:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDIJR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 03:09:17 -0500
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Feb 2023 00:09:15 PST
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C3B144B7
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 00:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675498153; bh=FylgcssI9jiFF7sGkQbVdxp+McfBfOt0elhHOfzeEiY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=s9QoNfoKXqAlvj/RmwtUukO04shKGegMNjMm8xHDeR1/ujSdN89i0U5uMhoagfmhh
         O0aj7DzoSaR/coILlbyo9NguIZ5K1bIS5oXPemhmLrn8hjCI/GJnJSJQKgEFd3Rvpz
         7bDtviXJtyACggdUet1puCdq0G/HjqEXJllnAXzUcj7HHUw1srMSbPnOesjOLsF1wS
         yHVdG9jlQK9KnpCL74G/bAiYcuwMi6BhGAAnQre/7LrymBA91DlMNApgAUfiH5CJaP
         MsbSiFvNj7a7T5de3CFhK0LdIO9PZXUfj4w5BmdpiEfrvHnflDiGeTBMf509RlYRVZ
         6DO4Xm9z6H0RQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOlwp-1oyi1i3m75-00QDCm; Sat, 04
 Feb 2023 09:03:50 +0100
Date:   Sat, 4 Feb 2023 09:03:48 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] .gitattributes: include `text` attribute for eol
 attributes
Message-ID: <20230204080348.vqrxsk7ze6bcz4nf@tb-raspi4>
References: <20220216115239.uo2ie3flaqo3nf2d@tb-raspi4>
 <20230203125920.751-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203125920.751-1-philipoakley@iee.email>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ZBuYMKtJOJCvil5ndIY44qJRTlgOUEQoTVXLo9WiEiISBp1y7J0
 sTCF9kHXDf6oad6tUcan1w3Lhg5HbBEiVFKXpN/dtO+k7QiiziboSWoNc5qAJ65e8Gk2Rar
 Ztf+p3/qb07ONRMs/Jbo3efmTC/n2R0F/nLnLq1+/tc+2RulJxkwXEBUxc4qGojI9TepBDh
 ygtPvRASunznPtKo3gyOQ==
UI-OutboundReport: notjunk:1;M01:P0:AJvf4qHm9s4=;cNRltUyeVPBmnXHQ4BtKjA6RDc4
 Y42oyinzGeDSY2db6P0HQaNiA5mV3PiOiKjpRweDF77ijVBO6C5iiiPtgKKQrAJwom09ZNPC6
 l4h2Xwk3wGSY3KFf6P7P1YfXu/ZjEnlQJ9TPnCHOwrir3jTWeOl1yLyBwUIRM8c4d1SAhqvz5
 sjOSbHa0Ptq01Ltv15/0gFFiXiUzF1Rkqq0X7s8ez4plSKLH3Ka36x7n4Ix03XyytlluTQ+/H
 oF1W6M5+ZHdP6feA7i6g31J8Klruw6NqqP+mtl52+eAMX82RKpN3UPBdGK6hvZ+fEFoFcssrH
 P2eBCP4KEgC/tZ0+sWY+mpX65t0DWhS9o/wDCC09ZTclD60SNfp0x0On3LO2+Ptc2PanI0awC
 DSgn8xCFWVevxL3gtc2PFuzI5HXRRRCEJ+iPIcE1NBYlz1rtfg9ojWAj8jsr0gA+BzwXVQFxZ
 hmbSG0hXh4uMmiGTr63cLDM2bxwnmjai0dY0FikA7PxAaJb4EbGW8xSP5vuXXKJS41jwgIpel
 ycSWBDo6yPOQlfJQv1ELB64QfLywXYTiCUkoEkrIq+dhATdf749tJLGjEMMGNKJiDC+veDzwx
 7lVWKgS4RZ+jZeUIesBE4H9xefRDoUit+4pqDa27MLXfY8EDI8xQ5PQjRKzXz5lCBK4vjSSgE
 Icwzr8M1/9waxnKo3JbxI9Mdru/pJTu/IUJ1XSLZFJrjrQS6cWnMwUzhAvc5LDnuaamlhxWx0
 PbSiX+JsCqlrkFTAHbzSG1ybYYXPcYBC4npnUQkdCbKp23tYg8Yu7W57935NGINmo06YJofyy
 xC44aoXaL9ZDHmBmYa+8N+bYzp+Ckf7btPEvoo4Mrl2j8PYgRsNWWZrXhbUijhijAYV7yc3XA
 xfe6eIPGJlGWzuSgCvHHpGf3ujW6PkvWVcdLG77KSLbUbuJb3lp23hkWrPDhUsB+UpvVft+tj
 BZV6z19u2XvooMYMxVUSO5lacp4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2023 at 12:59:20PM +0000, Philip Oakley wrote:
> The standard advice for text file eol endings in the .gitattributes file
> was updated in e28eae3184 (gitattributes: Document the unified "auto"
> handling, 2016-08-26) with a recent clarification in 8c591dbfce (docs:
> correct documentation about eol attribute, 2022-01-11), with a follow
> up comment by the original author in [1] confirming the use of the eol
> attribute in conjunction with the text attribute.
>
> Update Git's .gitattributes file to reflect our own advice.
>
> [1] https://lore.kernel.org/git/?q=3D%3C20220216115239.uo2ie3flaqo3nf2d%=
40tb-raspi4%3E.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>
> I was catching up on last year's back emails, and had saved those on
> eol and text conversion, and was prompted by Torsten's [1] to check
> my .gitattribute files, only to discover, we aren't providing a good
> example to others. Let's fix that.
>
>
>  .gitattributes | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/.gitattributes b/.gitattributes
> index b0044cf272..158c3d45c4 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,17 +1,17 @@
>  * whitespace=3D!indent,trail,space
>  *.[ch] whitespace=3Dindent,trail,space diff=3Dcpp
> -*.sh whitespace=3Dindent,trail,space eol=3Dlf
> -*.perl eol=3Dlf diff=3Dperl
> -*.pl eof=3Dlf diff=3Dperl
> -*.pm eol=3Dlf diff=3Dperl
> -*.py eol=3Dlf diff=3Dpython
> -*.bat eol=3Dcrlf
> +*.sh whitespace=3Dindent,trail,space text eol=3Dlf
> +*.perl text eol=3Dlf diff=3Dperl
> +*.pl text eof=3Dlf diff=3Dperl
> +*.pm text eol=3Dlf diff=3Dperl

> +*.py text eol=3Dlf diff=3Dpython
In my eperience python doesn't care about CRLF or LF, both work.

And it is stated here:
https://docs.python.org/3/reference/lexical_analysis.html?highlight=3Dline=
%20endings

In that sense we can loosen the eol=3Dlf, and use CRLF under
Windows and LF elsewhere. This will make e.g. notepad users happy:

> +*.py text  diff=3Dpython


