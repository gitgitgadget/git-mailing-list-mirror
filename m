Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4DC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 21:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiF2Vul (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiF2Vul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 17:50:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F8E00A
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656539420;
        bh=KD6LrafHfObrh6jkgRlAvm/C7gHDTsohA5Esr1vcVS4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b4QLjMot/tFlgKtaty9x77EbxSJ8F6tYDeJ7CDD9kcMKMifQ6Q187H5IPG5jpoIWZ
         9ymmzCjEsbobPoVbOOxckUZUfT2H4vFndtBgf1skikm0eV+74WxL+Jdr8V2WPJrAba
         q+wVCXV95POfLgL6AwewrjDrkrsHrT1zZwPDWTcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.204.148] ([213.196.212.94]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1nfpZE47rL-011mQk; Wed, 29
 Jun 2022 23:50:20 +0200
Date:   Wed, 29 Jun 2022 23:50:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/2] [RFC] scalar: prepare documentation for future
 work
In-Reply-To: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
Message-ID: <50rqn1oo-p1p8-r3r5-4p21-o7os0non8spo@tzk.qr>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gcueNgcD01aXQLfwdKb2HvSZnwN5fpd5tQDtlkIVA0Ilx62T7Np
 0I3ypYjbeBQMqPYnV2E65FgCIDQp78HtFGfyHL3zUkUOZl1GbJW/S93Nrn79eNzpUaX0Y9X
 StP2hj1Ub0ri4iX/yBuQbpt1bzEguJFDIXlVVr7Xaozd+xxkBxY5sdq3AmUFJ024BSvJksK
 Dc6yav5VNSnYMkP+mwCjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vWe4Bxj8BNo=:llIO0ZXsBkVv1nHMZVVAMB
 3BZsDYqKT3WK+dPa/VjCLSKyfJ6CFI7rtOVlzKIHT850vMn5KgEEkSKz6xYTYANo4WRQq1h5r
 /iRF625kBSM0cDmpu1qZinw2NeVH6HX4ntKtNuPMoGinPlKNl6jy3ZcT4nOeDrjHolE0x4dsE
 m5QCdephiMZhBLaPOrj4QAt06k+B0/nsSbP+0Au7mEoxkOyNvoijUeVGntUxP5xeln8p/6lbK
 O4U42wKRn1yf6cbtHPKpbkLj9qgh6OhBoB5BthW5L5D+YIPpt2WjZc3e0j2aqOidcZXAFmIW5
 67y+K2nC5CSsMDYJgOwghYpXTlg3MORy5hnstkhGqd82Jb5gKNAN6eNFIGqaCCzmuvUGpMSAx
 xdSYaed9u3zCtc3u2yAB2ZP3imbNWQjZakbIsk5lm6CJAtmOpBoJD+VvpMMZo+2dcBWnuyijh
 R6XpyFKOvQ54gCK9rv38XEDT8U/ezGE5du9f2mtKLpQ9ZEzNarQpdjpisQ4AZu2WaCOPEe2sc
 AA8v2hNflFN0xRfOa+tlTXw7aUjaTS5ZOypI4lYj8V4ERha8ZGuiY3Ix3Rz/1lyJJBdxei/r8
 xO5bzufZ5XFx0+QKYAaVVnsVuM8FP4YW7yc7vPLeb8LcMZNPpML0TIOwkxH7Zc88Ox5yxMeNX
 kfsvJGW4sxRKKDSgScnk4lO+Do+KcqZOQpgAOEi3EmsLGBhPlB8TDBS0NTlmoGVk8+MjCgDra
 kI2WvHxp/IAAPfVfUplKzKuUgNDV5fQwKkj0aAxGKf68BaN3/yX3vs7zsGFCwRZqDWnX2Z1uq
 ymGMaCH9gY75EDQyJw9rWdbyP7tVdezROJt6FMcFPrN1LMRWFxhvFYAE2ba8OTqMeT0XKq/BT
 8dCYN/Xkzkkh+aETKzxzcsq/SV+34fokjkK/whvSZBi975Ta+e9xXLFK/filBpQvYLCS4NlC5
 Gj6lw70/gLvvkF/B1lt50Ro+z/OSFo2WLxjG1JJ3zKGhlZc1ciDQN9SQ9qVr+I8Xiwp/H0iek
 6AO9K9GRajcmRLeiAkCsb1o4thLshKeItkVwoRWaVwf9taQS154EjTMgcXHzs7nfE4VSfFAg8
 ggwBzJfiDPHv6ahlbFWD5qsi1IMBpmrcR8Pi1H3hR/6B+wSiIQYBnPpNw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

thank you for an excellent example of a well-crafted cover letter.

Also, thank you for your fresh perspective, I believe you raised a valid
point when you pointed out that there are better ways to describe Scalar's
intention than the term "opinionated".

On Wed, 29 Jun 2022, Victoria Dye via GitGitGadget wrote:

> A plan for Scalar
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Given the slightly tweaked "philosophy" above, my ultimate goal for Scal=
ar
> is to have it contain only what is too experimental or too large
> repo-focused to be a default option or behavior in Git. Over time, some
> features may be moved out of Scalar and into Git defaults as they are pr=
oven
> stable and beneficial to the vast majority of users [4].
>
> So what do we need to get there?
>
> At a high level, the remaining work to "finalize" Scalar (past this RFC)=
 can
> be broken into three parts:
>
>  1. Complete a few more features and subcommands of Scalar (integrate wi=
th
>     the built-in FSMonitor & implement scalar help).
>  2. Move stable, general-purpose parts of 'scalar.c' into other Git
>     builtins/libraries (mainly scalar diagnose, either as part of git
>     bug-report [5] or a new git built-in).
>  3. Move Scalar out of contrib/ and into the "top-level" of Git. Include=
s
>     expanded testing, especially performance testing.
>
> The first makes scalar "feature complete" enough to be valuable to large
> repo users (per my entirely subjective assessment, at least). The second
> brings it in line with the goal of making Scalar only contain what can't
> exist as a default feature of Git. Once those are finished, I think Scal=
ar
> will be out of its "work-in-progress" phase and ready to use as a built-=
in
> component of Git (accompanied by sufficient testing, of course).

This plan makes a ton of sense to me.

Earlier, I tried to skip step 2, but you are absolutely correct that it
would benefit the Git project much more if it wasn't skipped.

Thank you for working on this!
Dscho
