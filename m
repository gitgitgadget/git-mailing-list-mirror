Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC741F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbdBBJak (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:30:40 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:32856 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdBBJaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:30:39 -0500
Received: by mail-io0-f170.google.com with SMTP id v96so81146893ioi.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 01:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hE0Be2W8Zb+30gQG8viOrnCNkwe3fMBUrEnQ57s2H4w=;
        b=C/kd2do08i2Agae0XFEJPTY0NrtWLDvPkKDpwFJZM2kyA/ymDYGS6SwcYFocPIEPU+
         BXnMLACRCztdHyjAQ7ucPjAGHsYO4yLbtQvSaH5DNXL44KEhijDhcaq79QBAWe6Sych0
         DihmWecdyHjl3CwiJrPKIJSqxhhtcSZ1UI4fICsoiDB3FmuoPGf4jY8V+p7IA8sTH0Ci
         uFNafX8j7o7y3EBNIWzIAqrC8htnITOkyGQX5IDwzthGprZHE8bqMyIj1R+wjRhFAr3u
         z4xy3GInFLCzgoW2cwvRQcLXGHzDZWYthxvayEcBpGm5z9Gs/p5OVSY0fcRepD2Hlm9p
         n8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hE0Be2W8Zb+30gQG8viOrnCNkwe3fMBUrEnQ57s2H4w=;
        b=n5CpmYNKE4HekR1FiCc1Q5kaw7WGboLeY2UlL2I3b2TRjioHXZGbaxoffz9U9v2OqF
         HpUo/fberCC8DGOlGRiPdoR4oq0wH0gXQegv13SkNNTqPUq072iw5rRWLRhd1CmgYK8A
         l2um4UeDhyRC2N2EEE1KOWVZzD53SFFlhso2FAYBSdLvXcTcccb1HUOHl92fnnYHQbWN
         vUZDvk/ViTS9fmBiOfSB2RRtj5kgQB4Ya/EzKiUs3Iyxm+HCeIBe2CJYRWb+ixqvHQEY
         At7AaEAB/huoHTs00xhfDM+UXeWo7rc88TLgKdn8VdNNJKBdNifDriCJjzsWoQr5tedU
         pt2g==
X-Gm-Message-State: AIkVDXI/n1S+JGD/rcBDo3yJ1xgy2w3FYPmhhTMr6Dyj3r7WopGR+fK5er/M7TALZCSwGtPECF3IcjUQGh0ddn+V
X-Received: by 10.107.3.160 with SMTP id e32mr5542072ioi.52.1486027838079;
 Thu, 02 Feb 2017 01:30:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 2 Feb 2017 01:30:37 -0800 (PST)
In-Reply-To: <20170201230753.19462-2-cornelius.weig@tngtech.com>
References: <20170201230753.19462-1-cornelius.weig@tngtech.com> <20170201230753.19462-2-cornelius.weig@tngtech.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Feb 2017 01:30:37 -0800
Message-ID: <CAGZ79kbN90qNyuQ7HkcTMNY3nMu_cx6i3gEVmXrfOBo5=h94ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] completion: add completion for --recurse-submodules=only
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2017 at 3:07 PM,  <cornelius.weig@tngtech.com> wrote:
> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> Command completion for 'git-push --recurse-submodules' already knows to
> complete some modes. However, the recently added mode 'only' is missing.
>
> Adding 'only' to the recognized modes completes the list of non-trivial
> modes.
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> ---

Looks good,

Thanks,
Stefan

>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ff7072a..fe3b0f8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1675,7 +1675,7 @@ _git_pull ()
>         __git_complete_remote_or_refspec
>  }
>
> -__git_push_recurse_submodules="check on-demand"
> +__git_push_recurse_submodules="check on-demand only"
>
>  __git_complete_force_with_lease ()
>  {
> --
> 2.10.2
>
