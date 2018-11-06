Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD861F453
	for <e@80x24.org>; Tue,  6 Nov 2018 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbeKFX11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 18:27:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:41539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730421AbeKFX11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 18:27:27 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF4iR-1gI73T1Bs3-00GH2g; Tue, 06
 Nov 2018 15:02:00 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF4iR-1gI73T1Bs3-00GH2g; Tue, 06
 Nov 2018 15:02:00 +0100
Date:   Tue, 6 Nov 2018 15:01:59 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for UNIX
 and Windows
In-Reply-To: <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811061501210.86@tvgsbejvaqbjf.bet>
References: <pull.59.git.gitgitgadget@gmail.com> <pull.59.v2.git.gitgitgadget@gmail.com> <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:syUGHABV7fLjRxH/Wv9+RMu6wq6ROkos2jv36BvmMPJPIEHm8Is
 6gqyfcC5Z6hdWtbbYtIMTgiOof5f0RLXG01tBNNpZ64eE2X8ZXDh1nXy8T9TFGBP6TB7Eoi
 Surb8iGNonZLJppjaZBbEusZ/5BNOiQe0m8AQOI/WxAT3cguxN5N7OR3TlX+XrO2y9yj+Sg
 qXh0I9pzaoxcvr9EFpG1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kbbP6TI6h0g=:rVSsIk8kM3OxV86kSRt5xK
 8h0QKqbPRaKfgTLlSo43aEf7IOybIYTelCDrxF6PmDRt4jMqFt5YJob4Zyy+d7YiC4WJeo0jv
 szuq5EvPyUEjuIDtXBfZuZGa0HmSgsyfc2w7WSjaz7A4Yv59K5wUeZKbjW7EBMSyY7Y8OsCzN
 +wA6I0nGnN0YjDt6dm0pDXQ77sCVuQjEakvLErIHTYLRay+M22FuEgVSaQxXIXwfXLKIT22ho
 iqTm/Scjjl8K/SzdMOon26A2MGtEcHyXFxUpPtl/Cg+kOI2CZFFkKaUejFJWFIB6LybBOxc/n
 HrPc7jQ/NAVEUyXgkY3wXvQCTC0goGAZmNahXeTY5NRvdDmyEqxuW7iNSY5C/dz8PEFJE5mnz
 LgGkCdYGYhvvp6IZkWecHwzK7hpgA4B4fwCimqMToGSVI/FP5rSiNMAayfpOKmGQ/pmukHJOj
 yDMHyjTIL8qvul+g0k+HSmFv3NmylJ+FvwIGynF6nXfWpmE/v4LcqNP4Qw0YCwwqDxd6B7FXK
 x5fWOT5HM7ZlW9/zWJCgvnYKUgQl+vuIno7r5Ml4kf5kiqLk9gOcXawIqbGBMC1eFPCMcShyq
 IJxK1P2svO7uIqrf98hX+jpq0RNsSJHEdiyjsf3XZIeuFM0k17Uyq9JbsRJSInqNB715KaZVa
 oFrcW+IYnb240Z4Yaxzhk4MPJm8ITplRpBop8y4kFZEe8CiupTmX87y0deumMeFGnup8JcfQv
 P9yhS6LeWf0ARYG75OvG46Ud52Ke1tUpOqakOsTQiFM7OihPwuWYZ3xdxoy4ty0d0p8VQBe2k
 KADd/ykLslD8FxrwNZDUrIAQUj1iS+ngqIhp5abQuhtuRqqPks=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List,

I have no idea why this mail made it to GitGitGadget's email account but
not to the Git mailing list... Sorry about that.

Ciao,
Johannes

On Wed, 31 Oct 2018, Chris. Webster via GitGitGadget wrote:

> From: "Chris. Webster" <chris@webstech.net>
> 
> Use File::Spec->devnull() for output redirection to avoid messages
> when Windows version of Perl is first in path.  The message 'The
> system cannot find the path specified.' is displayed each time git is
> run to get colors.
> 
> Signed-off-by: Chris. Webster <chris@webstech.net>
> ---
>  contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> index 536754583b..7440aa1c46 100644
> --- a/contrib/diff-highlight/DiffHighlight.pm
> +++ b/contrib/diff-highlight/DiffHighlight.pm
> @@ -4,6 +4,11 @@ use 5.008;
>  use warnings FATAL => 'all';
>  use strict;
>  
> +# Use the correct value for both UNIX and Windows (/dev/null vs nul)
> +use File::Spec;
> +
> +my $NULL = File::Spec->devnull();
> +
>  # Highlight by reversing foreground and background. You could do
>  # other things like bold or underline if you prefer.
>  my @OLD_HIGHLIGHT = (
> @@ -134,7 +139,7 @@ sub highlight_stdin {
>  # fallback, which means we will work even if git can't be run.
>  sub color_config {
>  	my ($key, $default) = @_;
> -	my $s = `git config --get-color $key 2>/dev/null`;
> +	my $s = `git config --get-color $key 2>$NULL`;
>  	return length($s) ? $s : $default;
>  }
>  
> -- 
> gitgitgadget
> 
