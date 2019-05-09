Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1BB1F45F
	for <e@80x24.org>; Thu,  9 May 2019 03:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEIDTy (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 23:19:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53723 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEIDTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 23:19:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFDDD54478;
        Wed,  8 May 2019 23:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yVNuLABD3aGa8tEqzfevSVW5g1Y=; b=ftYARt
        xtqMPMAZ03xVF5KFpHu4Xv+Qbkzrci4Ydlc9vdQRNF8S/evpOsHwKh0P3oh2HJcs
        Xg8XwYlHtz1fDKNI3re/t9A121mL8Tn8KoldyHuKRxlNVn1IMs8780aNPtAokPXm
        y6chnirSbk3f0Z5LXr8ePOqEYzjYo53zHfNqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kRcMSNnCrMgSGoJDlD/KxfMmbMmGraXv
        3IpUlcTlc/A43joQtVLFzj3QrdL27hZyh+MkF7f3ykdz4Fa4mVTZB8pZKjXjALmc
        Uux8B35B9pwRNcu22ggioAudPW3BNKpU9v6UVfltRljpkXCiuaXzMTA/cczgWdvw
        LhrBvDTcu/w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B860554477;
        Wed,  8 May 2019 23:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6DC954475;
        Wed,  8 May 2019 23:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Gadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, chris <chris@webstech.net>
Subject: Re: Fwd: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for UNIX and Windows
References: <pull.59.git.gitgitgadget@gmail.com>
        <pull.59.v2.git.gitgitgadget@gmail.com>
        <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>
        <CANg4QoEPWcnPpbUYcgR4PmECzjCOmroAmH2fMoX-vhw+W_dVnQ@mail.gmail.com>
Date:   Thu, 09 May 2019 12:19:43 +0900
In-Reply-To: <CANg4QoEPWcnPpbUYcgR4PmECzjCOmroAmH2fMoX-vhw+W_dVnQ@mail.gmail.com>
        (Git Gadget's message of "Wed, 8 May 2019 12:45:53 +0200")
Message-ID: <xmqqh8a4fh68.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B9192AC-7209-11E9-80B2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git Gadget <gitgitgadget@gmail.com> writes:

> Forwarding this mail to the Git mailing list, as the original did not
> make it there (for reasons unknown).

It seems that the forwarding mechansim (if this weren't manual---I
cannot tell) mangles whitespaces?  No need to resend, as the
receiving end manually fixed them up.

Thanks.

>
> ---------- Forwarded message ---------
> From: Chris. Webster via GitGitGadget <gitgitgadget@gmail.com>
> Date: Wed, Oct 31, 2018 at 11:58 PM
> Subject: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for UNIX
> and Windows
> To: <git@vger.kernel.org>
> Cc: Junio C Hamano <gitster@pobox.com>, Chris. Webster <chris@webstech.net>
>
>
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
> diff --git a/contrib/diff-highlight/DiffHighlight.pm
> b/contrib/diff-highlight/DiffHighlight.pm
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
>         my ($key, $default) = @_;
> -       my $s = `git config --get-color $key 2>/dev/null`;
> +       my $s = `git config --get-color $key 2>$NULL`;
>         return length($s) ? $s : $default;
>  }
>
> --
> gitgitgadget
