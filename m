Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904BBC77B73
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 13:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjD3NTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 09:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3NTw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 09:19:52 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667151711
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1682860784; i=tboegi@web.de;
        bh=Um4iO8KW6NVS8WCeP+CqKMofSRXgdvA1ITd1GaSssS8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DOM/5A+dNKTmbGRyL7i5DCOlQ9FoKO66/f2xq/yHOmW3gDnEz5QGo+sn93QFNs0g/
         mbFi02YjQ9CBYz4zWRfJ5+ip+WoGXxiTjO5VRWx3PciVttRVhbXKwqTI/VzBQLYPc4
         NNxO9pncB8tDOUooYlrCBqQ/+Q7cyCkU0PXQnxsJs4r8dPIhAe1RxV8+9vJf81O4x+
         RDavq4DUV3W/pp2nuQFmJydFBEFs0+fZ8dXYmopnFeyP2bICLt14LR4NhCt8eFOuR5
         FZGkbSe8swxrsc0y4kaS2rohJP67INaBuhmQuzipCOHLKilkMljYEw9ze+LUIoswFR
         goYs6z5PXRbVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1pXaT34BcE-00LpKA; Sun, 30
 Apr 2023 15:19:44 +0200
Date:   Sun, 30 Apr 2023 15:19:43 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2] docs: rewrite the documentation of the text and eol
 attributes
Message-ID: <20230430131943.4ag5gawuxkvuywlv@tb-raspi4>
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
 <20230428042221.871095-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428042221.871095-1-alexhenrie24@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:HnWqi2Q3OgTVBSklYP8fOKk8aTDo2uOSiiBZWcggf8B/Xsxcucg
 cohFVryE2+YL0OzPpEq/qxRsr4AmEA9iGY2+g8y2paNuZuwX4E/pxug10QYe8OlPVaY4kfw
 XBArchs/o1mIbih6f2QJvRy8X3+d9lGXkjnKI/EYd9LXi7E0DFsUN+r20Wr3+qqRR2pcjjV
 gS73jWX8l6DP2afknSooA==
UI-OutboundReport: notjunk:1;M01:P0:24nKLh8Bmac=;ZoB60PvgAESOaVLajcO0fCfFzO8
 XyDEhqeRyLHE0B0MMwhWUSTofPuRSeRCwhtdXQ6M3mBqXktj5Bzk8vhfMi3ymjl8PxCpbXT4d
 thVPk8xDujTwQ0Zfy1VJQcOQ6w/QSjoAgt8fNfmNFc4Qc5za454ULzC7hg0dlUnWuWCV2cptW
 Yyq4DaVSGMlbJ6K5tYHuHyx4DrQ3C1Ppwimj/Tu4XFvsrH+D5DB/xbvP1jwXCVEkyZrdWcRLY
 StUNq8wheTtFdZp454y7Sh8/Xiq0cRKic42YilNppIiCgRgrouq2xR40lCgI44kSyfZ8RiskQ
 yCaMDQ2sXX/6BBSHgR3mXviGk1/tn0r9cpFPfzz6kHoMOmCFovR2oMmd2KIBTqK4S8ZqoQ8t0
 EfPKyEFfXMLOMkYhUofD3JxxGYAqL0hEkqU0CmuN79RidMwNzwx5FvP/u/Gm17vDPIsjudP9G
 aA+vgJHv+Fz+LPiiL4W5VEi08gv0n3c6zTs577mPbDweG8j4e7jS6v3K3GUpt+6WYJFRjCgqE
 LWvlXO//1bD3ViLMzp11OnYfjodUS0DCNwd56xts71u34Vm4xa0zT+s/Hp8qrskfpmfhhZ+no
 zQmUy/Ec0b1OxaV4lCuzm013mTL8YU3gezfewu6pM2UnGanR3pUqLcCWcRD4pTi+6XNpkDhNh
 3vvkB0A22Vg2z7svyhnjWW0F75O8MGaCv/65XUJDg74Mmxw26ZkM5qwsWFbXwpvlESGfHeGWw
 pnLShKVE/aY9o2a+/kvdwUHN7l+Y5ZpFFnehUjSflRPp0M9ovdaxtqD7SGMN00gxgmhAn7qqD
 rnvm5u6rUZPuPGF2lQH1UuopoEodkJx4oXG6xhD3CkCwMVpEpWWwdwCZtNYNwah5YIVg8wQvq
 LPzjLWe4//FQ+MdZaCbhvzYeEIJhvJGb6EPNNdEvqJzGs1xwXGEaEI4i7S6HRT0DU1JV7o8pX
 7L/ENQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 10:22:21PM -0600, Alex Henrie wrote:

Thanks for picking this up.
There had been some comments from Junio, I haven't had time to look at
them yet.
Some of my comments inline, lets see how we can converge things.

> These two sentences are confusing because the description of the text
> attribute sounds exactly the same as the description of the text=3Dauto
> attribute:
>
> "Setting the text attribute on a path enables end-of-line normalization"
>
> "When text is set to "auto", the path is marked for automatic
> end-of-line conversion"
>
> Unless the reader is already familiar with the two variants, there's a
> high probability that they will think that "end-of-line normalization"
> is the same thing as "automatic end-of-line conversion".
>
> It's also not clear that the phrase "When the file has been committed
> with CRLF, no conversion is done" in the paragraph for text=3Dauto does
> not apply equally to the bare text attribute which is described earlier.
> Moreover, it falsely implies that normalization is only suppressed if
> the file has been committed. In fact, running `git add` on a CRLF file,
> adding the text=3Dauto attribute to the file, and running `git add` agai=
n
> does not do anything to the line endings either.
>
> On top of that, in several places the documentation for the eol
> attribute sounds like it can force normalization on checkin and checkout
> all by itself, but eol doesn't control normalization on checkin and
> doesn't control normalization on checkout either unless accompanied by
> the text attribute.
>
> Rephrase the documentation of text, text=3Dauto, eol, eol=3Dcrlf, and eo=
l=3Dlf
> to be clear about how they are the same, how they are different, and in
> what cases normalization is performed.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v2: rewrite completely and rewrite the eol documentation too
> ---
>  Documentation/gitattributes.txt | 58 +++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribut=
es.txt
> index 39bfbca1ff..bcea84f439 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -120,20 +120,22 @@ repository upon 'git add' and 'git commit'.
>  `text`
>  ^^^^^^
>
> -This attribute enables and controls end-of-line normalization.  When a

Hm, not only, I think. The terminologie is probably not very well specifie=
d.
I would say that it "controls end-of-line conversion".
There are 2 type of conversions, from CRLF into LF and LF into CRLF.
The CRLF -> LF conversion happens only at `git commit`
(strictly speaking already at `git add`) and is called normalization.
Because in Git a "normalized" file has LF in the repo (and index).
The term normalize has even been add to 2 commands:

`git add --renormalize .`
inspired by
`git merge -Xrenormalize`

> -text file is normalized, its line endings are converted to LF in the
> -repository.  To control what line ending style is used in the working
> -directory, use the `eol` attribute for a single file and the
> -`core.eol` configuration variable for all text files.

In general, the `eol` attribute can be used by more that a single file.
And that is what we (or at least myself) recommend to do, in a kind
of best practice fashion, as an example:

*.sh text eol=3Dlf

The core.eol is the fallback, when the eol attribute is not specified.
But the we look at core.autocrlf, before looking at core.eol,
as pointed out below.
And if none of them is set, Git uses the platform native setting,
whih is CRLF for Windows and LF for all other systems.


> -Note that setting `core.autocrlf` to `true` or `input` overrides
> -`core.eol` (see the definitions of those options in

Looking with fresh eyes: I am not sure if like this historical construct.
First we say the the "core.eol" sets the line endings (if not defined in
the attribute) and the we say that core.autcrlf overrides core.eol

This is mainly due to historically resons.
I think that things goes like this:
When text or text=3Dauto (and Git identifies the file as text),
and the eol attribute is not set, then:
core.autocrlf=3Dtrue gives CRLF
core.autocrlf=3Dinput give LF
core.autocrlf=3Dfalse looks at core.eol:
core.eol=3Dclrf gives CRLF
core.eol=3Dlf give LF
core.eol unset gives the platform default

> -linkgit:git-config[1]).
> +This attribute marks the path as a text file, which enables end-of-line
> +normalization on checkin and possibly also checkout: When a matching
As said before.
 ...normalization on checkin and possibly conversion at checkout...
 or
  ... conversion on checkin and possibly also checkout...

> +file is added to the index, even if it has CRLF line endings in the
> +working directory, the file is stored in the index with LF line endings=
.
> +Conversely, when the file is copied from the index to the working
"copied" is not an ideal word here:
We may specify a filter and/or an encoding as well.
Would "transferred and possibly filtered/encoded" be better ?

> +directory, its line endings may be converted from LF to CRLF depending
> +on the `eol` attribute, the Git config, and the platform (see
> +explanation of `eol` below).
>
>  Set::
>
>  	Setting the `text` attribute on a path enables end-of-line
> -	normalization and marks the path as a text file.  End-of-line
> -	conversion takes place without guessing the content type.
> +	normalization on checkin and checkout as described above.  Line
> +	endings are normalized in the index the next time the file is
> +	checked in, even if the file was previously added to Git with CRLF
> +	line endings.
>
>  Unset::
>
> @@ -142,10 +144,11 @@ Unset::
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

Side note: We previously talked about files. path is better.
>
>  Unspecified::
>
> @@ -162,23 +165,28 @@ unspecified.
>  This attribute sets a specific line-ending style to be used in the
>  working directory.  This attribute has effect only if the `text`
>  attribute is set or unspecified, or if it is set to `auto`, the file is
> -detected as text, and it is stored with LF endings in the index.  Note
> -that setting this attribute on paths which are in the index with CRLF
> -line endings may make the paths to be considered dirty unless
> -`text=3Dauto` is set.
... Or `git add --renormalize <path> is run.

Adding the path to the index again will normalize
> -the line endings in the index.
> +detected as text, and it is stored with LF endings in the index.
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
> +	in the index, whether they are LF or CRLF.  However, unless
> +	`text=3Dauto`, adding the file to the index again will normalize its
> +	line endings to LF in the index.
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
>
>  Backwards compatibility with `crlf` attribute
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> --
> 2.40.0
>

Thanks again for working on this.
/Torsten
