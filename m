Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5726C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiBNU4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:56:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiBNU4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 15:56:36 -0500
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 12:56:11 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF540338
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644872121;
        bh=oycGgVA37oQU5fpSro+bmV/8amjmIImAtpCiw/7Ww4Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Yj3D7iv/qsVRns7xyR92snwiZwyKl3t6T1Rlx99K3oPMyBxadEtvBmh8/+7HLbcJa
         pMmDWE8BHDZqmwsyXgIkdk0j7WCQkcqbfZPnh7V3wF8h966fiMXSQPTX29R4qfDE4m
         dGzUoibRNdZDKcee6vtoRXhO5wH1AGNA76l00V7w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBVh-1nyWZp3Z0X-00ewcD; Mon, 14
 Feb 2022 21:46:32 +0100
Date:   Mon, 14 Feb 2022 21:46:32 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Message-ID: <20220214204631.mquj645jt5qajwku@tb-raspi4>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
 <xmqqilth2u28.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqilth2u28.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:M4vVBAANe83viYPAD3jFR8h82mU5cJ+wOe7/MO28irm+LLP1rcc
 Y9ppfdEDrah38nuU3igOxloh5CaMdBE85+Sb+Mdp1+wQPsKlihuakWq7Y9I5avUt1rYMMcz
 SpWQSCQDMmOfZaw3Mp8kdl20hyWd2ncerqCXWh1Iies1rYj/5Z9za5bYWnLJgSSubqr6Xhr
 nUYsPe/aubLub8Xj19Zsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e3LUFDRmgmU=:giRpgKpRgbyTsws1Zjew8x
 c8678HQz+8K22Et0ZS+XgKdRItQa3CV/ek7yywPf8GbjX598GNBsREb4zOJ/1gtpfNF/McdjA
 pkc1NhaM5CsXfMd9T8KfN6pJmIpzQL1uBJY9IbSVxnsReMy1GD4mPuxh1lVzqfE5fmsEIsz4C
 frZXPVxDC0VChtisBvbrO96dwiWhQie35tsL7FgI3/pFjOE3VShcBypdp8jIhw+9qvonGS2kG
 GHX92MxoSGR0nPkNVa+vZGq6+jKL67VzS658/n8A6ovUO+6tsQx+xOG/76RR4ftbmnbWP6R+Q
 6ax4QpTyMISMQ97pTf66/45r1DPzZYvMaOK/KPxUHWREatWnucU6yAzgS6o3wBr3CAk4PQEhV
 QrRl+AfsMzv4uxNTt65HmeRkDlEQ8pK6wmugVq5+gX4TM5sC5dzilaeZOBzHNfBUlafqzGOjC
 +YcOT6WH5wo756RniAh7J5vWLA6GUPxvoAB73cgBsCXXovm7mLrQE8jBM0i4dRv1QSNPc2Xxa
 qKswMqk7PMTsi+rf8PGfsZqgdZ0JCJSW365f4obqK4zuYQgCYLc+nkh5cYIY2t0FWmTnL6h93
 g6M8YnOC472ctCeogEBofu/7Co9qWPSkA0v7U7OZJaha1u1R9hK1MjeXNvQhtJokIO+mcj4sv
 w6UpGBDg5wME1XEoVtyjbX9GgDpLVE8Pl5s4XpHMweJ4GNkCzwR00HXoQFUmY5oM7pBj8vHVd
 VIn6TyxACR2RkrQVK3rQ7ceCW9mB52IhrDCmfOhalFm72UNrSc4ZhiF0m7MINaft0e568jvLZ
 C/DK0cmEdJHhoT9urYcZkn0xTC7A+KRKmdq+jPxZwYuc0F0FWT5/Phg6Zzvr7oUgoiugckZRa
 7A+lMaAm+akPXv4KFr+yFoMHMdK7JYNxQ7nQw7+BemHklzWFfpUPHIebF/rY32qjCrvBm5GnQ
 fAbDvUa9qKOljAecYVeEq8OJkUmd5AnZIenNikC52Qcy6zetAYB0uddKm7hGKFsGGhspxvPtm
 wVrcDeVhccUJRizuo0lQMAZdC46hgqLNvFfF/XWc8poc7TLOEJSn6K56lD6Fb+JwzDJjRuicQ
 Z011vYhj+jvi2M=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
> This seems to be a replacement of the two-patch series that was
> merged to 'master' at 8db2f665 (Merge branch 'bc/clarify-eol-attr',
> 2022-02-11) and was merged to 'next' at dc1db4bd (Merge branch
> 'bc/clarify-eol-attr' into next, 2022-02-04).  The changes seem to
> be in the second step to update Documentation/gitattributes.txt and
> it needs to be made an incremental update.
>
> Thanks.
>
> ---- >8 -----
> From: brian m. carlson <sandals@crustytoothpaste.net>
> Subject: doc: clarify interaction between 'eol' and text=3Dauto
>
> The `eol` takes effect on text files only when the index has the
> contents in LF line endings.  Paths with contents in CRLF line
> endings in the index may become dirty unless text=3Dauto.

That is a nice, precise and short summary here in the commit message
as well as the patch further down.

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/gitattributes.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git c/Documentation/gitattributes.txt w/Documentation/gitattribut=
es.txt
> index 60984a4682..a71dad2674 100644
> --- c/Documentation/gitattributes.txt
> +++ w/Documentation/gitattributes.txt
> @@ -161,11 +161,12 @@ unspecified.
>
>  This attribute sets a specific line-ending style to be used in the
>  working directory.  This attribute has effect only if the `text`
> -attribute is set or unspecified, or if it is set to `auto` and the file
> -is detected as text.  Note that setting this attribute on paths which
> -are in the index with CRLF line endings may make the paths to be
> -considered dirty. Adding the path to the index again will normalize the
> -line endings in the index.
> +attribute is set or unspecified, or if it is set to `auto`, the file is
> +detected as text, and it is stored with LF endings in the index.  Note
> +that setting this attribute on paths which are in the index with CRLF
> +line endings may make the paths to be considered dirty unless
> +`text=3Dauto` is set. Adding the path to the index again will normalize
> +the line endings in the index.
>
>  Set to string value "crlf"::
>
