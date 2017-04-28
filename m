Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8870C1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 07:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755101AbdD1HVU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 03:21:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34480 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdD1HVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 03:21:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id g23so16160233pfj.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lxU+MSvWWfELneGUla7m+x8qpBuu2CGSLUiOMcMBMrE=;
        b=d+h1wzO8j5Nt6oAr12mPCpv+xhG4GSmjxAOlnJ5A9sUnWRWB9xT/+YsoTdGOqxjQFc
         Vs3a3vabkfhtJWR57ePw+7bNoVao2/8vQUAEBmpl5MHNoJSECbo2sVwmTn+arX1YQAHA
         Ns0wpnisP9iMLykMyurGMA7lAFpXNajM5KLz4o8TIoWdTR1VIgaHoS533NH9MhypT/CZ
         owjhoQWaCg8OHYwkabS8JKA13c88lXNHcwZMuw27xvnfrGxu5k6HqeZR5msoq8OM0Fhy
         BYTNO9SpFD+5N7aL6BaZWDLh6X/3tLhded0SZsLWl6g/TV6o+98YIbTA900TAIYT65+U
         Bn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lxU+MSvWWfELneGUla7m+x8qpBuu2CGSLUiOMcMBMrE=;
        b=e9xROmop0bwGPol1bnphncCr8vRe8HbBW0VUYuim0x4YqNYaRW4ng5FKMxr44B+XjW
         G7yB99+3dR9D/b9jbIgOoQ0xV+2FDCEUR6hMldF7tQHR1afvhZFV68rIOj9SLDbl4Tld
         LIPidARWcjxHrAnnozbFD3E5rOTZIOw5GOt4XVG1UJZrWeAw+ZZymhT36wfxtP2YyI6B
         gDKPh9wyXn812xkfyw2rts+nnc2fMYbe5Fo8tsqP40MnZLyLQlNoCjokMcqal2bud5d5
         k8gyAFXAzp0RoQQoC93PAsLRaQV3dMi6BkxVI+4W28eW+f5mtXEuXoY8HVmJKXDdQbzd
         2LIQ==
X-Gm-Message-State: AN3rC/7IBM266I8Y7jVuOa0Fv5kQ8XukRITGFxFF6JFfguKB8bh4w8xI
        LuxeBAlZgsrGMg==
X-Received: by 10.99.174.75 with SMTP id e11mr10424064pgp.177.1493364077816;
        Fri, 28 Apr 2017 00:21:17 -0700 (PDT)
Received: from ?IPv6:2405:205:820a:8c42:60e6:2188:30f9:a9e? ([2405:205:820a:8c42:60e6:2188:30f9:a9e])
        by smtp.gmail.com with ESMTPSA id h89sm8528348pfh.45.2017.04.28.00.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2017 00:21:17 -0700 (PDT)
Subject: Re: [Suggestion] Alternative way for displaying help menu of patch
 flow
To:     Jeff King <peff@peff.net>
References: <b55bd985-be6a-7fd6-1744-7ffb9d8b4ce8@gmail.com>
 <20170428063723.2ni2v6akosm4ldvy@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <4d6eb11e-f102-7695-7f4a-562407ea13c0@gmail.com>
Date:   Fri, 28 Apr 2017 12:51:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170428063723.2ni2v6akosm4ldvy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 28 April 2017 12:07 PM, Jeff King wrote:
>
> If the hunk is big, that message scrolls off the screen. We could
> probably put it after the hunk, but I'd worry that the ordering would be
> confusing (because it comes between the hunk and the "this hunk" prompt.
Probably it could be better to clear the console after each user input, 
before
the result of that input is displayed. That could probably remove the 
clutter
and could allow the user to easily differentiate from the current output 
from
previous output.
> Or it could just not re-display the hunk all (like what my patch does
> for help), and you'd get:
>
>    @@ -1 +1 @@
>    -old
>    +new
>    Stage this hunk [y,n,q,a,d,/,e,?]? j
>    No next hunk
>    Stage this hunk [y,n,q,a,d,/,e,?]?
>
> at which point you could "r" to redisplay it if you wanted to.
This seems good too. But, I guess, the help menu would probably hide the
hunk and could make that prompt a little absurd.
> I also suspect that other menus in add--interactive have the same
> issue. E.g., if you have a large number of files what does the
> file-selection menu "git add -i" look like? Perhaps the issue is less
> common there, though.
>
> ---
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 709a5f6ce..81f62331b 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1237,6 +1237,7 @@ k - leave this hunk undecided, see previous undecided hunk
>   K - leave this hunk undecided, see previous hunk
>   s - split the current hunk into smaller hunks
>   e - manually edit the current hunk
> +r - redisplay the current hunk
>   ? - print help
>   EOF
>   }
> @@ -1385,6 +1386,7 @@ my %patch_update_prompt_modes = (
>   sub patch_update_file {
>   	my $quit = 0;
>   	my ($ix, $num);
> +	my $skip_hunk_display;
>   	my $path = shift;
>   	my ($head, @hunk) = parse_diff($path);
>   	($head, my $mode, my $deletion) = parse_diff_header($head);
> @@ -1451,8 +1453,13 @@ sub patch_update_file {
>   		if ($hunk[$ix]{TYPE} eq 'hunk') {
>   			$other .= ',e';
>   		}
> -		for (@{$hunk[$ix]{DISPLAY}}) {
> -			print;
> +
> +		if ($skip_hunk_display) {
> +			$skip_hunk_display = 0;
> +		} else {
> +			for (@{$hunk[$ix]{DISPLAY}}) {
> +				print;
> +			}
>   		}
>   		print colored $prompt_color,
>   			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
> @@ -1608,8 +1615,13 @@ sub patch_update_file {
>   					splice @hunk, $ix, 1, $newhunk;
>   				}
>   			}
> +			elsif ($line =~ /^r/) {
> +				# do nothing; we'll show the hunk when we loop
> +				next;
> +			}
>   			else {
>   				help_patch_cmd($other);
> +				$skip_hunk_display = 1;
>   				next;
>   			}
>   			# soft increment
Regards,
Kaartic
