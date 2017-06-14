Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8A720282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbdFNNEz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:04:55 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35578 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdFNNEy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:04:54 -0400
Received: by mail-pf0-f174.google.com with SMTP id l89so84351383pfi.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=CGAQ+qdWvPVXqI/BDYfGlPbPVJSWyo5Jb3p2zEmT1bg=;
        b=St9mFzOmKGkLskdwAKjh2P5Cl1gymPtXlyWmiC7fgZxKZvv33yhflSTXjjT7LsWTQo
         WtHKz7dm2oSSWNulwzjPlahUEaEry9VhfuUtproEAnNSCeTY/Me+MCGiSAqLy5YgCeX/
         /oDDnMuWW9GuydRWNOw+9xsVLY+bGvIwQRThflc+8NzTif1CRYBdy7WeH68tuwVtSHcb
         di0YlczQYR08YNkclrRiVZnZPYFxO7LpRKZdp0X0seBvMzbXHJ6ZqNB0wgSyl4NcDf1Q
         TcYQmyJA1CJxoyyb4x2+I6hoHrdByu25HxDwyY5QS/teSyBpsyFYPamw6EhcvKgtBBiG
         5sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=CGAQ+qdWvPVXqI/BDYfGlPbPVJSWyo5Jb3p2zEmT1bg=;
        b=ZGJr22UEpTfdK3wSjFK8EqzOlm5oVPSSrIOukohEqjg20DTVRWCDXFwXq95+rugd5U
         xsVX1ECMzmSHdoP2zjqfnwihAng+LXPHDTzP79LRCK/NdsOKoGElpzeljTLwJQZYKEzZ
         uFxMKdK1OutIXUpdQzvVNvluVQdqsxBy/8TzdzRiFHrYDpPUPfLHl6nOC0FI3aQRMAah
         Xf7BZIB6BR0hisCni+1/04crJ+++dnMY1cPkiveBkTgbAY9pzYu3JAZgs38xA791ZTVw
         nKNshfCioxix69Z/xjQhLUMmcY+4+gu9OegJkh5k8ZZ3gx1vZYSJqZLsCzDfe24y504b
         mB7w==
X-Gm-Message-State: AKS2vOztPhGXnw2NnwJgNnI/KXXxQGgz+DRE8zbaEU3oABRz3nlZ1aP/
        166WkUncdDND+Q==
X-Received: by 10.98.214.146 with SMTP id a18mr1251pfl.40.1497445493517;
        Wed, 14 Jun 2017 06:04:53 -0700 (PDT)
Received: from unique-pc ([2405:204:714e:9214:b972:3835:c42c:3ffd])
        by smtp.googlemail.com with ESMTPSA id w2sm2411688pfb.18.2017.06.14.06.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Jun 2017 06:04:52 -0700 (PDT)
Message-ID: <1497445448.2678.1.camel@gmail.com>
Subject: Re: Small issue with "add untracked" option of 'git add -i'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 14 Jun 2017 18:34:08 +0530
In-Reply-To: <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
References: <1497278015.7302.13.camel@gmail.com>
         <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
         <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-06-12 at 10:59 -0700, Junio C Hamano wrote:
> Together with your other wishes, perhaps something like this is what
> you have in mind.  The original tried to throw in a blank line as a
> separator to help interactive users to more easily tell the boundary
> of blocks of text, but it wasn't consistently doing so (e.g. "update"
> when nothing is dirty was very silent, while "status" gave one blank
> line that is supposed to be shown after the list of changed ones even
> when the list is empty).
> 
That's right. Though I'm not sure of the implementation, I guess the
following patch would make `git add -i` do what I thought it should.

>  git-add--interactive.perl | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 709a5f6ce6..0ec09361b4 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -537,7 +537,7 @@ sub list_and_choose {
>  				$last_lf = 1;
>  			}
>  		}
> -		if (!$last_lf) {
> +		if (@stuff && !$last_lf) {
>  			print "\n";
>  		}
>  
> @@ -634,7 +634,6 @@ sub prompt_help_cmd {
>  sub status_cmd {
>  	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
>  			list_modified());
> -	print "\n";
>  }
>  
>  sub say_n_paths {
> @@ -667,7 +666,6 @@ sub update_cmd {
>  		       map { $_->{VALUE} } @update);
>  		say_n_paths('updated', @update);
>  	}
> -	print "\n";
>  }
>  
>  sub revert_cmd {
> @@ -701,7 +699,6 @@ sub revert_cmd {
>  		refresh();
>  		say_n_paths('reverted', @update);
>  	}
> -	print "\n";
>  }
>  
>  sub add_untracked_cmd {
> @@ -711,9 +708,8 @@ sub add_untracked_cmd {
>  		system(qw(git update-index --add --), @add);
>  		say_n_paths('added', @add);
>  	} else {
> -		print __("No untracked files.\n");
> +		print __("No untracked file chosen.\n");
>  	}
> -	print "\n";
>  }
>  
>  sub run_git_apply {
