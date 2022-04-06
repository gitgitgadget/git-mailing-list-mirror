Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EADC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 19:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiDFTOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiDFTOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 15:14:05 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35C46465
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1649268276;
        bh=IaQDZcD+qrry1s+5MCIgXavnsFV5Vnu0l6ZFedjwZ/4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=syTNO6yjiNPnx+PjswEFzgaJ74CwixYwF+XAuLjz58JMK2Hbiw/UqI+Tra2K1E96p
         JlHh1mGpFU2kmyK/AtM5PPXpRPhGLWVqa3XTZm+P5/W1/bfpuUO0MuI24H7i9Q/oSW
         wd7BSBv5RLVcQMuqjd359Z0HDT3uZAmo024iPdkA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjIE-1nhhOB3n6C-00C8UU; Wed, 06
 Apr 2022 20:04:35 +0200
Date:   Wed, 6 Apr 2022 20:04:34 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, tao@klerks.biz,
        gitster@pobox.com, prohaska@zib.de, eyvind.bernhardsen@gmail.com
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
Message-ID: <20220406180434.4zlb2bwpu6cfumta@tb-raspi4>
References: <20220405053559.1072115-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405053559.1072115-1-alexhenrie24@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ZeHXCEWIPtOnTI48T+N1w30RBjpD4dD44L2GSjX1u+qGOs6Ij+7
 Qu4QYDjps9uqnG2TzsUJS7G3z5Qy0HfeafYVpYV/dtgCsYNivCB4xC4DC62/FOuzNlUNgHU
 L5NhVWeCDFx1yC/PQAL90ljeoi+asdl2+71r4FkuWTweuHl2f7jARvbPuKcV1RUA+W7BBQl
 nfGj8vJdl3Zvvbe7kShbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XuAMgUv2v2s=:XqYmd8O1hL1SSSvbxKPWNp
 GY4fmb4Z7/jeIUEYKoAHrXqLDYPG2v2n+qQ/t6KXAcB+45xrRgwRi5fOm4lCuMOAi6bGMEmAT
 +7aAAq5P9Ev6jN24hpuWM2neJSCPY/6GS+RNLLCCGbbFnKshQFubQUT1X2sSBlXMnGRUGg2UH
 fS7Oe72RXzyG3J7r+OaVJM8dAWhpiCNyR7p/G7s5GIoeUTuPRVN3tEnq79jL0/CT9L0cnfu7R
 Xw3OwQYIxBa0BmD6PNdDvoiy30nnQ4yfccHNNUWzs1hmnM6KZwt3bcpIU/LIaPF1dBEz01b7S
 wS9dnW33kccfcqjcNBu5PARE5wqQb5itrKM8d3hC91rLRGw2WLSKABIDkMsPzsiVYF/DYSDdT
 f9kyLnKCv1BSUnt8m9GIa2kLySyfkUIps20R4bTYgL1aXiVw7ZZI9qQmlp4j2Nlnc9YGVwSSk
 ZbV0lZ5QAR0o1wir66sAg3s130H5Iwm/mo3ul85WAxdDSBvT+9GRglGWoH/KTHqcqC7IT2w6B
 tYwXDzeHP8ltCdViB1UR5vW2a6s0ORAnFPru1A9s0yX0sqZt8S/hWKkLoEWjo7gNHOhB0s6am
 l6s+ypG5qggRiIfwaPytHXvlCay8c9wCYJT/TbEZNY1lcJJ8oJFnyZEWZE/yMOBrQ9juGFV8S
 tmd+uloNS9AeOBUcK0jB+MW1lyh9KYUuNGiZC6hN1PPA4BjG4kvQgsd0mkF65Bc/3AvO9aO0L
 I/Ekp1Ndca3g5f8LgAfwJbK7E+SSs++Tt5SIMzus//OkmK9MCAuESpwu1IWzQq6nZgC5JszX0
 eGujB42VWAMrp2sxNw4exrpzUWfkx63Q5EM23B3jO2SKd2P73TxYiOhyhSZWr2HDU9QS6rGmq
 wmWJ7RysQTNstK26Q5k9RDiyhQDTna6PIk8zsSsjvEiq8QRQZTFPWumQaV0joWIg3szLqs8ax
 /gL/0UeHIz8coX/rPJ3gztZy25CHkIzGz+T2uE46vl9rGQwLtNZFFFVvSHjToBgmNUIBwSujw
 cWuOyJG36BEYkdnt7t+zdpM0SORRI2qJvbBgNME0FhjR3mDEajmH5BfPEtH5dOfbFg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 04, 2022 at 11:35:59PM -0600, Alex Henrie wrote:
> The warning about converting line endings is extremely confusing. Its
> two sentences each use the word "will" without specifying a timeframe,
> which makes it sound like both sentences are referring to the same
> timeframe. On top of that, it uses the term "original line endings"
> without saying whether "original" means LF or CRLF.
>
> Rephrase the warning to be clear about when the line endings will be
> changed and what they will be changed to.
>
> On a platform whose native line endings are not CRLF (e.g. Linux), the
> "git add" step in the following sequence triggers the warning in
> question:
>
> $ git config core.autocrlf true
> $ echo 'Hello world!' >hello.txt
> $ git add hello.txt
> warning: LF will be replaced by CRLF in hello.txt
> The file will have its original line endings in your working directory
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v2:
> - Quote the confusing warning in the above commit message
> - Move the file name to the beginning of the warning message
> - Put the file name in single quotes
> - Use the arguably broader verb "touch" instead of "check out"
> - Remove the period at the end of the sentence
> - Remove the second sentence entirely
> ---
>  convert.c            | 10 ++++------
>  t/t0027-auto-crlf.sh |  8 ++++----
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 8e39731efb..733e581cb9 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -195,9 +195,8 @@ static void check_global_conv_flags_eol(const char *=
path,
>  		if (conv_flags & CONV_EOL_RNDTRP_DIE)
>  			die(_("CRLF would be replaced by LF in %s"), path);
>  		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
> -			warning(_("CRLF will be replaced by LF in %s.\n"
> -				  "The file will have its original line"
> -				  " endings in your working directory"), path);
> +			warning(_("In '%s', CRLF will be replaced by LF the"
> +				  " next time Git touches it"), path);

(Somewhat late to the discussions), thanks for picking this up.
May be we can use "updates" instead of "touches" ?

"In '%s', CRLF will be replaced by LF the next time Git updates it"

Or may be

"In '%s', CRLF will be replaced by LF the next time a `git checkout` updat=
es it"


[snip]
