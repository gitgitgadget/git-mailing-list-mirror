Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66E820899
	for <e@80x24.org>; Sun, 20 Aug 2017 18:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbdHTSDg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 14:03:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37341 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbdHTSDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 14:03:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id z91so14364855wrc.4
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=instituut-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2OfDCjy/iU0BDlfJdfhKKeEfQ91SAzJStviL/mWGYgg=;
        b=Eb1qDaz+cSQqMq5U2hwA48ngT9bCRErmlczFwGk6cKPpxVO6ld0YaOOSPM8t3cfRcn
         TaqRfy5cTupV70NvO5Jsz77BMNWT+mhlOiwFERlXQCKM8b6+9GS26wEwaMfwcxDugNRU
         sAtv/N0SDglbu0VuyZp1Ps9KeCV/N4jsKUIka0WLXntcZV/4T6fCj8+Fgv8goLZwCwIH
         qjS33Gx8+dFxbq94gcwEbRMY8r4vqyPKw3OS9g3XyIp+YpKMKe/zxlr1dlcR4i2a7An0
         l8U6ljiC05z759biEIvZ2cpYSSldOdKhjUcAyxoop+qWnUff2SYRleW/nufAzldXp8It
         FhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OfDCjy/iU0BDlfJdfhKKeEfQ91SAzJStviL/mWGYgg=;
        b=Eo2NjpMdA4Hfw5ugy5XrWNRKi7vOpwJ6hICv9U+qGQeN2GsYmGGGzn7gygRaZIzPjB
         iYo2crUD+zuBbDPnRKa9Hm/0I2WRzu420lcL3AOz2KHNUKnXryCoFCBf9ajFZDT7lPxJ
         8sc2qavS0zAcfturms0sz+NQVq83jBDAXOxqIjnKB4w3lkGUnAIsGkg1kP9qBBrpwIkZ
         6yrDZgHkXhajUpZu8sI0E/6KAcIV8iGXjFJU20DQqgOEWtqbjZtKRXMTsnovkduPFE2r
         acKZnSrg+c9vcNMUALAUS1moM6mJdXxoDRSymldPGJUv8RLcA+X3Q8yN9VkJZ01Mpl4C
         hBSQ==
X-Gm-Message-State: AHYfb5i2gdyTDeh6a2IN5sbI8i+rYV4Z2OEXs7ySML2PontZXZGHvXWE
        4FY5MWA7NqcgjC8IYwnSgQ==
X-Received: by 10.80.157.198 with SMTP id l6mr10428495edk.252.1503252214183;
        Sun, 20 Aug 2017 11:03:34 -0700 (PDT)
Received: from localhost ([2001:67c:208c:10:953f:533f:272b:889b])
        by smtp.gmail.com with ESMTPSA id 3sm1866942edv.52.2017.08.20.11.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 11:03:33 -0700 (PDT)
Date:   Sun, 20 Aug 2017 20:03:32 +0200
From:   Job Snijders <job@instituut.net>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, yashi@atmark-techno.com,
        giuseppe.bilotta@gmail.com, jnareb@gmail.com
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
Message-ID: <20170820180332.GC39363@Vurt.local>
References: <20170802185901.GA27243@Vurt.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802185901.GA27243@Vurt.local>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bump? 

On Wed, Aug 02, 2017 at 08:59:01PM +0200, Job Snijders wrote:
> We often work with very large plain text files in our repositories and
> found it friendlier to the users if we can click directly to the raw
> version of such files.
> 
> This patch adds a 'raw' blob_plain link in history overview.
> 
> Signed-off-by: Job Snijders <job@instituut.net>
> ---
>  gitweb/gitweb.perl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3d4a8ee27..ad79c518e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5961,8 +5961,11 @@ sub git_history_body {
>  		                          href(action=>"commit", hash=>$commit), $ref);
>  		print "</td>\n" .
>  		      "<td class=\"link\">" .
> -		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
> -		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
> +		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | ";
> +		if ($ftype eq 'blob') {
> +			print $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw") . " | ";
> +		}
> +		print $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
>  
>  		if ($ftype eq 'blob') {
>  			my $blob_current = $file_hash;
