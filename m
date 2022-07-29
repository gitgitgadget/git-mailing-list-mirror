Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80068C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 13:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiG2NQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiG2NQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 09:16:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A654667
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659100574;
        bh=dl44D2MphYUPPYnLZ91my8sY0tHe3WAgoagueA/JRwg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N7FkbGMeVg8apCOP6rERwhQNqX/tKvsdiw9t1s14BErO2sZNXqnmwk2ejE8+FadxD
         m08OiTdeP8n5tLagnWnyugAC3v3ioH/1g8umAqJ48xTI3jq38od8oeJsVK0895906Y
         Nb1WzHDuTULKYOmVzlDMBwSuMuKnCRJnfysaraGo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.244.62] ([89.1.214.237]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1nfLD53nXG-00pNEa; Fri, 29
 Jul 2022 15:16:13 +0200
Date:   Fri, 29 Jul 2022 15:16:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* --creation-factor=100 does not show code
In-Reply-To: <xmqqo7x9ch7n.fsf_-_@gitster.g>
Message-ID: <85snn12q-po05-osqs-n1o0-n6040392q01q@tzk.qr>
References: <1196830250.20220726145447@yandex.ru>        <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr> <xmqqo7x9ch7n.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9PV0Wo1J40WtdLmkdVhqYx8jasBoPozSggSoEZfKxD+opEq040o
 gmo/yYyKuM9/jeb/kB5lsW1NkaifJ0vJCULqCJ8NLiYU3BQBo5CzaiW9xB0N3XGXoBnkh7v
 3mU7Sx2AeupeSi1w2ejwrDJ+aEm6aJOwATzDiisAD38kNLaluCJZkGvO45eyv2o1sWO93Dq
 Okzn+hZkZXH0KxFcbMGlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2jga0anvtKM=:DpWQy/kF9hB6rmJHaCwBW4
 gb30lrfUmm4F+FqJNa65sS+LixeXwaBuIvQTKz4dhXO93ldwi8lygj3bdcJh8DzbVPpdHX2zw
 fP+EEFx2fdVoIVrB7b1VrY3Tv9sx/n4wkhGVG1nTsyNmrFPKOQG8HfZTsgJy8PjexVBxcdoOk
 RqX3/rD1hseN5+AGw/FZ+YY577lk60zbiaFYlVNh3s3CH8oF0h0RM6ajYMvtr/bQ+Lbt0yLhq
 4XgN2feA85gJwP6a6l6P6l/NKT5V9sp34jpbvQkCIX2FcvqVlAYSZ4SblsOLgZbT/5pUCzZlI
 eZMO5nB2gVFICyAVJRndxrniWrsp2HE/BjzUboE8fbMFbGhoNW/Q4nlFFfGGSLyZa7KFCEyLN
 xXy05DEpndpJyzaH73AVjunATaJvmlZARSUjVtU9v/XwmWhTSHv8/D1M/9kTsFuPA2CbiVGHj
 mAMdlcx8iEgMEawLlkLJ6PYN9VzecfoG1m9R+3b8eW3BgZGGuhI7jlOZIBvIOuHQbralM7uos
 CGz2D6h7shbiV1Oy/j399zSPxncvIyq11Gh81AewTWAQMcAbSFS4pbI3uErTbYJw8Ama1Vq51
 PEsaiBKlemWEhKIxZDrQ+A8l3ocOv9LDKCr2NaLc5IoqY9ow/V2/Jwumrxtn5JCUV3/Mw2AZ3
 qcnmj2oIShvhm+JDFzNjC0pk0W8JGnMXu9jkgZdaaVnxlvBbfLRy8GSWBUlApDi1olRWYZreW
 WApxJTYGPnlxRCnAcMHPd8U2D+EnYXo3PaB9mejkX9sg9OybY3ryed+vllKIVw1izIPEJU5m+
 Pnj4JIvKRVTkBT8Kb0RyYudd7soCk6n9owrEFFJwTs7OWe7Y1GZcrA4UrX9VwOgO/BR+xzvKm
 VhKhtWsKo9U01pxhmPqacla9DKs2tdVl6xSkWt03Vxxx10ulGqVcpwIfduucWUS6W13O1m1QN
 4ZN0mqsgD6SAoheBDBvWoLkKwB+u0nNyqPlk5xXCfKC7+VN0yKdjInrKfpTqlv0JiQlK5IRu1
 OIH/nNU3keIwHu4NlDC1IrqgRojt2yPbYPNgf5syex635Wcb9HI6xEc+VIxL0wytCV/zpvNWU
 O3oGtsROc2d3g1m/HWii/qyTU6rjYCDsdnwqwh/MxTQhrvdfNwQ6Kd35Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jul 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 26 Jul 2022, Eugen Konkov wrote:
> >
> >> $ git range-diff --creation-factor=3D100 branch...origin/branch
> >> 1:  a87daecd47 < -:  ---------- Add mocked exchanges for ...::AutoRen=
ew::General test
> >> -:  ---------- > 1:  36eaeb56a9 Add mocked exchanges for ...::AutoRen=
ew::General test
> >> 2:  9594ccf145 =3D 2:  70681dd13b Remove a call to DB::state
> >> 3:  740903e01c =3D 3:  5745ae5702 Run cpanm without tests
> >> 4:  e8e6cac09c < -:  ---------- Do not use 'require'
> >>
> >> --creation-factor=3D101 does =3D)
> >>
> >> but maximum value for percentage is 100. So expected behaviour is to =
display range-diff when value 100 was provided
> >
> > Please see https://git-scm.com/docs/git-range-diff#_algorithm for an
> > explanation what the meaning of the factor is, and why 100 is not the
> > maximal sensible value.
>
> When I had to give a huge value to the option the last time, I think
> I used --creation-factor=3D999 or something.  The thing that bugged me
> in the output of "git range-diff --help" is that SYNOPSIS section
> has "--creation-factor=3D<factor>" but the OPTIONS heading says
> "--creation-factor=3D<percent>" and the word is used in description as
> well.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: range-diff: clarify --creation-factor=3D<factor>
>
> The value is not a per-cent that ranges from 0 to 100.

This sentence is a bit misleading because the factor _is_ measured in
terms of percent (not "per-cent", nor "per cent", see
https://writingexplained.org/per-cent-or-percent-difference).

The fact that we multiply by the number and divide by 100 makes it a
percentage, see e.g.
https://github.com/git/git/blob/v2.37.1/range-diff.c#L331:

		c =3D a_util->matching < 0 ?
			a_util->diffsize * creation_factor / 100 : COST_MAX;

The reason why I chose to write `<percent>` in the original patch
(https://github.com/git/git/commit/ba931edd284f) is to avoid confusion:
0.6 would be a factor, equivalent to 60%. But I had carefully decided not
to extend the `parse_options()` machinery to allow for floating point
numbers, hence I chose to allow specifying the factor in terms of a
percentage, which could be specified as an integer value. I _just_ noticed
a minute ago, though, that the synopsis makes the mistake of describing
the value as a `<factor>`, that's on me.

As to the original claim that percentages only go from 0-100, that is
easily refuted. If you wanted to pay $12 for something but ended up having
to pay $30, you'll end up having paid 150% more than planned. There you
are. A percentage that is greater than 100.

In this context, the explanation in
https://git-scm.com/docs/git-range-diff#_algorithm reveals how this
percentage is used: to determine the cost of _not_ pairing a patch on one
side of the range-diff with a patch on the other side, in terms that are
relative to the line count of the diff of said patch. The cost of pairing
two patches is the line count of the _diff between their diffs_.

This also explains why the default value of the creation factor is not
100% (as the original poster might have come to expect) but instead 60%, a
value that was at first picked out of thin air, but that turned out to be
reasonable: https://github.com/trast/tbdiff/commit/92ed41c84a89c.

Side note: One of my math teachers insisted on _not_ calling percent a
unit, as it is by definition unit-less: a percentage leaves the unit of
the value it modifies unchanged. Which is absolutely true. So I think we
should heed that advice here and avoid calling `%` a unit.

Ciao,
Dscho

> The SYNOPSIS section gets it right, but the body of the documentation
> said "percent" which confused readers.
>
> While we are at it, rephrase "smaller one" that corresponds to
> "larger value" earlier in the sentence to "smaller value" to be more
> explicit, to avoid misleading eyes of the readers to an unrelated "a
> large change" nearby.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-range-diff.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git c/Documentation/git-range-diff.txt w/Documentation/git-range-=
diff.txt
> index fe350d7f40..e49630e8ad 100644
> --- c/Documentation/git-range-diff.txt
> +++ w/Documentation/git-range-diff.txt
> @@ -61,11 +61,11 @@ This is known to `range-diff` as "dual coloring". Us=
e `--no-dual-color`
>  to revert to color all lines according to the outer diff markers
>  (and completely ignore the inner diff when it comes to color).
>
> ---creation-factor=3D<percent>::
> -	Set the creation/deletion cost fudge factor to `<percent>`.
> +--creation-factor=3D<factor>::
> +	Set the creation/deletion cost fudge factor to `<factor>`.
>  	Defaults to 60. Try a larger value if `git range-diff` erroneously
>  	considers a large change a total rewrite (deletion of one commit
> -	and addition of another), and a smaller one in the reverse case.
> +	and addition of another), and a smaller value in the reverse case.
>  	See the ``Algorithm`` section below for an explanation why this is
>  	needed.
>
>
>
>
