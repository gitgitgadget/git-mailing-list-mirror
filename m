Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84866C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 04:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjEBERg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 00:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBERe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 00:17:34 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A328C2D4B
        for <git@vger.kernel.org>; Mon,  1 May 2023 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1683001047; i=tboegi@web.de;
        bh=OWcdXit/ETNjrJL4tpBdToM1oVcKeUqdY4Hvt9nRNPg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=b6iN31WSUpLs4j1WdkwAn36uRmxtyzi09k/zF7GQjNCO1iwFP9f8JcXFfsTBcnaWO
         jJs9GIMaTDf6nx+SRei3cW5oXf2h985PRwMLPElC1MEWi13Waw23nRD+HBdDLoqFlh
         4uE/KozBY7IfGh4KubVvcFVdRAJLwUbof1V3nrzs2V3P1Bm1sHlKvO+j7VOREAFGUc
         XilXANWduz0xf9Qqd3oUIaMwQcJ9vu99t/1zf8kGi+blFWHZZuMzbMvNWdfwzwAxc0
         jwYfS1idytjGGGARzu5CUbcX0WaTPdv+0/K86tgghc737szXYIJd9fOmD6MjvofOgI
         vTHL2Ji2i68LQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1qRONJ3szL-00gXYx; Tue, 02
 May 2023 06:17:27 +0200
Date:   Tue, 2 May 2023 06:17:26 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 1/1] docs: rewrite the documentation of the text and
 eol attributes
Message-ID: <20230502041725.7zbv3i4srdb7fqrg@tb-raspi4>
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
 <20230501023533.35370-2-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230501023533.35370-2-alexhenrie24@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:6WKN4POkZ+p9ctwG8gRxLCF4tYzQpqNPt+Dr8Y667UN0umvpVa/
 IYknz+NZ/W4k+KbqnBiNAWwvdHh0mEtRYPoOHVZ2e8NCOsd8X7etu4XpB4rtNz4iKCuWsms
 j/4S2V/guAmcpYArDUvqjb0qBsNfx2zUdm/YL701zfQJV0BiFDq8IadDKM2lF+onwu2Qj1o
 qKxDN0TucofNereeBEEaQ==
UI-OutboundReport: notjunk:1;M01:P0:40e9WIB7GcQ=;OjTjSavFUTNEH2Ja2bLiDTiCa7P
 i0qyrsV+YE4gU61BYaVMa/raRgRPvuE0szm3WX9NA7zr1pm+MDE5NSR+b9k3vqiyphY+6n73k
 /GUsPO6mB1ULOZQxigM67Q3Y11Zm1L5q0tzcPnITWNz+Ux3r7Of+A8zyTEqlDuTAl0FDcoHP6
 EGx2XVqE3DwFdUqas3AGjmbnDEgPEGSoJaMy5qYpCa8yldoYEb0T1PxqFM+Cyd7HQIOwwJiyz
 Y3XLURMKb6brD9mEZyPw6ZlsA0E4Bjj6kuuyljxgzKdZUkuO/+Nr54PCCnUW/uaYJtAAGhdWm
 0TS+AbYq8u9E7knQoYHDw3JR7802hbYv1DeMiqmRJbEzGLTTrnh6aR+th0ENIg+iSq1FAJYL8
 7F98J6bXnybJ8zHU+AiDp58HI/66U607BjmW6sf1EFV6t+1JQGFMVwHbUotSvfbRvRQ6vTZQz
 tFE2paCdCJgJ2OApSk+/X4khqYG9UHEfCvRERhwgMnzJbh2l2BSzUfrzbMMZV9j1NFmFUwifC
 F/k1spSPviCLWpRTxVPrLuNJKwY+GVuH96UVTfb3DxR+7iW2ciyxkMgIeztPqGvV1+FWcTd5h
 ig1AS0UyW1oFw6RNVB9U/N66iHs4IZr2zQvQwlQAc9635WyIVWzxvjtxvgYdNhoU5fF64LgIY
 IRCIkswQU4KsYp2CTBRpsWP4Epmh5tyS21JQKO96eB9fUD/jvnEKMe+UOWyJhpaGtKp7KYs68
 Dpid6vG6wzIcInCIdb39IhB7mvLTBVJRNjaTMol7K9YvygdZyc7ZPxhTSnyzb2imisqgtotpC
 /yOtUGSRcSSuIbvHvzlkfmGN9qMXjNNFdoWklhvo0b8nQY+ty1gAy8fk4zQZapcZSRkRJz47J
 2lDqGLUnootSFLoKjK4Y7CfqOzHSo690YJUee9GuZQCbApIXc7Pm6XBit4o+U7so5NpDATRUX
 ULV7hkjXLg0AtdpR/48wFx2H2Kg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This looks much better, thanks.
I have some minor comments:
a) The commit message from above:
>  docs: rewrite the documentation of the text and eol attributes

The word "doc" is used 2 times, that feel a little bit redundant
(and should start with a uppercase letter)

"Docs: rewrite the documentation of the text and eol attributes"

Or may be shorter:
"Rewrite the documentation of the text and eol attributes"


b) Some more comments inline:
On Sun, Apr 30, 2023 at 08:35:33PM -0600, Alex Henrie wrote:
> These two sentences are confusing because the description of the text
> attribute sounds exactly the same as the description of the text=3Dauto
> attribute:

The word "These" is somewhat dangling: Which ones ?
May be "The following two sentences" ?

>
> "Setting the text attribute on a path enables end-of-line normalization"
>
> "When text is set to "auto", the path is marked for automatic
> end-of-line conversion"
>
> Unless the reader is already familiar with the two variants, there's a
> high probability that they will think that "end-of-line normalization"
> is the same thing as "automatic end-of-line conversion".
Good.
>
> It's also not clear that the phrase "When the file has been committed
> with CRLF, no conversion is done" in the paragraph for text=3Dauto does
> not apply equally to the bare text attribute which is described earlier.
> Moreover, it falsely implies that normalization is only suppressed if
> the file has been committed. In fact, running `git add` on a CRLF file,
> adding the text=3Dauto attribute to the file, and running `git add` agai=
n
> does not do anything to the line endings either.
True.
>
> On top of that, in several places the documentation for the eol
> attribute sounds like it can turn on normalization on checkin, but eol
> only controls conversion on checkout. It also sounds like setting eol
> (or setting a config variable) is required to turn on conversion on
> checkout, but the text attribute can turn on conversion on checkout by
> itself if eol is unspecified.
>
> Rephrase the documentation of text, text=3Dauto, eol, eol=3Dcrlf, and eo=
l=3Dlf
> to be clear about how they are the same, how they are different, and in
> what cases conversion is performed.

That's all good.

>
> Helped-by: Torsten B=F6gershausen <tboegi@web.de>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/gitattributes.txt | 60 ++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribut=
es.txt
> index 39bfbca1ff..076a056a72 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -120,20 +120,19 @@ repository upon 'git add' and 'git commit'.
>  `text`
>  ^^^^^^
>
> -This attribute enables and controls end-of-line normalization.  When a
> -text file is normalized, its line endings are converted to LF in the
> -repository.  To control what line ending style is used in the working
> -directory, use the `eol` attribute for a single file and the
> -`core.eol` configuration variable for all text files.
> -Note that setting `core.autocrlf` to `true` or `input` overrides
> -`core.eol` (see the definitions of those options in
> -linkgit:git-config[1]).
> +This attribute marks the path as a text file, which enables end-of-line
> +conversion: When a matching file is added to the index, the file's line
> +endings are normalized to LF in the index.  Conversely, when the file i=
s
> +copied from the index to the working directory, its line endings may be
I still stumble accross "copied". May be shorter:

"the file is written into the working directory"

> +converted from LF to CRLF depending on the `eol` attribute, the Git
> +config, and the platform (see explanation of `eol` below).
Good.
>
>  Set::
>
>  	Setting the `text` attribute on a path enables end-of-line
> -	normalization and marks the path as a text file.  End-of-line
> -	conversion takes place without guessing the content type.
> +	conversion on checkin and checkout as described above.  Line endings
> +	are normalized to LF in the index every time the file is checked in,
> +	even if the file was previously added to Git with CRLF line endings.
>
>  Unset::
>
> @@ -142,10 +141,11 @@ Unset::
>
>  Set to string value "auto"::
>
> -	When `text` is set to "auto", the path is marked for automatic
> -	end-of-line conversion.  If Git decides that the content is
> -	text, its line endings are converted to LF on checkin.
> -	When the file has been committed with CRLF, no conversion is done.
> +	When `text` is set to "auto", Git decides by itself whether the file
> +	is text or binary.  If it is text and the file was not already in
> +	Git with CRLF endings, line endings are converted on checkin and
> +	checkout as described above.  Otherwise, no conversion is done on
> +	checkin or checkout.
>
>  Unspecified::
>
> @@ -159,26 +159,30 @@ unspecified.
>  `eol`
>  ^^^^^
>
> -This attribute sets a specific line-ending style to be used in the
> -working directory.  This attribute has effect only if the `text`
> -attribute is set or unspecified, or if it is set to `auto`, the file is
> -detected as text, and it is stored with LF endings in the index.  Note
> -that setting this attribute on paths which are in the index with CRLF
> -line endings may make the paths to be considered dirty unless
> -`text=3Dauto` is set. Adding the path to the index again will normalize
> -the line endings in the index.
> +This attribute marks a path to use a specific line-ending style in the
> +working tree when it is checked out.
It enables even the normalization at checkin, see
$ mkdir ttt
$ cd ttt
$ git init
$ echo "*.sh eol=3Dlf" >.gitattributes
$ printf '#!/bin/sh\r\necho hello\r\n' >xx.sh
$ git add xx.sh
warning: CRLF will be replaced by LF in xx.sh.
The file will have its original line endings in your working directory



> + This attribute has effect only if
> +the `text` attribute is set or unspecified, or if it is set to `auto`,
> +the file is detected as text, and it is stored with LF endings in the
> +index.
It took me a while to understand it.
Should the "," after "unspecified" be removed ?

Or, should we write:

The `eol` attribute automatically sets `text`, unless `-text`, `binary` or
`text=3Dauto` is specified.

I dunno.

>
>  Set to string value "crlf"::
>
> -	This setting forces Git to normalize line endings for this
> -	file on checkin and convert them to CRLF when the file is
> -	checked out.
> +	This setting converts the file's line endings in the working
> +	directory to CRLF when the file is checked out.
>
>  Set to string value "lf"::
>
> -	This setting forces Git to normalize line endings to LF on
> -	checkin and prevents conversion to CRLF when the file is
> -	checked out.
> +	This setting uses the same line endings in the working directory as
> +	in the index when the file is checked out.
> +
> +Unspecified::
> +
> +	If the `eol` attribute is unspecified for a file, its line endings
> +	in the working directory are determined by the `core.autocrlf` or
> +	`core.eol` configuration variable (see the definitions of those
> +	options in linkgit:git-config[1]).  The default if `text` is set but
> +	neither of those variables is is `eol=3Dlf` on Unix and `eol=3Dcrlf` o=
n
> +	Windows.

That's good - I wonder if everyone understands Linux, MacOs and others as =
Unix.

May be something like this:
The default, if `text` is set but neither of those variables, is `eol=3Dcr=
lf` on
Windows and `eol=3Dlf` on all other systems.


