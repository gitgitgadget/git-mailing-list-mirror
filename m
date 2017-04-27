Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D79207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 20:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968530AbdD0Usx (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:48:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35264 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967179AbdD0Usv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:48:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id d79so7144511wmi.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=YQbE0q84YiRYVvu1W6w0FW1Dr8iGxsFtgvFaPex2WJc=;
        b=slIcdWyOry4b792V+a6pWGxL+OgfIZuJiBnTzpOF7JWRadpM7hPRKPUBvPJMF8zh5t
         NAc/2UyJb65Wrbiy1gvQzXot15PnS44R/87wTfO9nEZb0hsC10b+DNwC2KVFWCrERr8/
         NxCtwxmNWiE3rCU3dxKF2lrqbtJXVaeXUPPPsPZVgHgsvScWbDECmnDHP9alTL0HeE9y
         eALMjsSDNSpSNcjwfCTnK9XoxMesO+//TmGW/IglT65AbWyYWtStY2N/n8fLMqTDvHig
         iU/7cEvw8em2g+RoEIh3isK+B0uE2cvR7m1Tt/jiZfvE99RcCKX87Zx1Nop9FNULIPPm
         SbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=YQbE0q84YiRYVvu1W6w0FW1Dr8iGxsFtgvFaPex2WJc=;
        b=Vju9r1TBullUrAo3YtLY9Pvevp1cqTRSWfX3IEwWxvgrkm3mBFVLQ7tIz+1EWlNc9l
         ECPiPi8MCR9CQa46tw+PP59daChkjOOKU966T3e8IuvQWZR9UCkIG49i5r2zsZ/iKRMD
         DxPzWWsBZ39IfQZi0vzvhw797CH60Ae9BOQ7VChY/bVq/QA+tAuxq5TnWNB3RvZPgtuX
         acjj6+Cnr1Zgr1V9Xf3uIKN/UZI/kn8sTYYix9D0OMCxfoG6gonjKTL7lRl1JpExiPEM
         CLyqtLTu6EyDbmNQyIVmGA7XGkApJMf94rcpr8h3LpWafVuS4ATgeQmyk1t450twKBkq
         x5IA==
X-Gm-Message-State: AN3rC/4ljBgUnwE3NSrOUMUYualbBjPtp+f4AwMHRS6WUzdAKeRtsPpU
        gaXLgnYrol8xiA==
X-Received: by 10.28.71.8 with SMTP id u8mr3482188wma.39.1493326130090;
        Thu, 27 Apr 2017 13:48:50 -0700 (PDT)
Received: from localhost.localdomain (x590d8d4d.dyn.telefonica.de. [89.13.141.77])
        by smtp.gmail.com with ESMTPSA id g90sm5121005wrd.11.2017.04.27.13.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 13:48:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Add --indent-heuristic to bash completion.
Date:   Thu, 27 Apr 2017 22:48:36 +0200
Message-Id: <20170427204836.14129-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <bbcbdf11-5065-8fcb-d78e-74db03814781@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> The patch adds BASH completion for a newly added option.

There is a '--no-indent-heuristic' option, too, and a
'diff.indentHeuristic' config variable as well.

I'm not sure it's worth it, though.  As far as I remember the future
plans for indent heuristics, this option and config variable are only
temporary, and this heuristic will become the default after a few
releases of testing anyway (assuming that nothing prohibitive pops up
in the meantime).


> --------------5BA49415AE751679784E55AA
> Content-Type: text/x-patch;
>  name="0001-Add-indent-heuristic-to-bash-completion.patch"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: attachment;
>  filename="0001-Add-indent-heuristic-to-bash-completion.patch"
> 
> >From 316355276a9772cdfdd24a81f19400f176944df2 Mon Sep 17 00:00:00 2001
> From: marxin <mliska@suse.cz>
> Date: Tue, 25 Apr 2017 13:35:17 +0200
> Subject: [PATCH] Add --indent-heuristic to bash completion.
> 
> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  contrib/completion/git-completion.bash | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1150164d5..8fb25594c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1395,7 +1395,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--quiet --ext-diff --no-ext-diff
>  			--no-prefix --src-prefix= --dst-prefix=
>  			--inter-hunk-context=
> -			--patience --histogram --minimal
> +			--patience --histogram --indent-heuristic --minimal
>  			--raw --word-diff --word-diff-regex=
>  			--dirstat --dirstat= --dirstat-by-file
>  			--dirstat-by-file= --cumulative
> @@ -1482,6 +1482,7 @@ __git_format_patch_options="
>  	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
>  	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
>  	--output-directory --reroll-count --to= --quiet --notes
> +	--indent-heuristic
>  "
>  
>  _git_format_patch ()
> @@ -1681,6 +1682,7 @@ __git_log_common_options="
>  	--min-age= --until= --before=
>  	--min-parents= --max-parents=
>  	--no-min-parents --no-max-parents
> +	--indent-heuristic
>  "
>  # Options that go well for log and gitk (not shortlog)
>  __git_log_gitk_options="
> -- 
> 2.12.2
