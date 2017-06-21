Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74AF20282
	for <e@80x24.org>; Wed, 21 Jun 2017 02:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbdFUCzj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 22:55:39 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36559 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbdFUCzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 22:55:38 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so78347929pff.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=iFaW4kaBOIR4OHctffanlmVp1FYyo7pDJExIHvNgUpU=;
        b=fbaWM+8zrPGR/QklSXsQ3++T/cCQOspL4jYI/fNMa5Lf7aN0bKIQw3ZFmmKRb9nAU9
         eyjs0vHc0pKUblS8r31E4wiE0nkk2+GFfFBUNzy39OxuzSALx++ETFXMBC/UBOra6ZpX
         hN95khgiiZSYIsH/N+yFzMnNgd8JvOgUFt/mO8kt+UP6TArMhYPE0Hx6GaV61FMLP/DT
         IkMYNINbSMOgYv739tr3fdt/ObjGx2OX2r6wDBm6T/gK0qCo8WMrUC3k7VOvNXyc9UeR
         Y3a51IfA2RRMAB09o3GfPHqF3+IM3J6adpVMszzTRt5pE2n+LAdB9j+v24+uZJc1n7lP
         d3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=iFaW4kaBOIR4OHctffanlmVp1FYyo7pDJExIHvNgUpU=;
        b=MDkhk1NiAp0LLITkrybj4ssil7kRvunziiJAg3SyV4BahfLYOFJ5XGwI096OrgKxOn
         Ykh/NPbyUcfZZo5WaLhVCDim4IzdGtR/F17eSjEsrYPhTueVTcb4XWuuKE5mKXN3t0CH
         7RGz46rCHyX4pQOuGKSDnmTdyuBL6TknIiRR753gX6YlaDJiw0v3Cdef8N/4RW/Aah4r
         p1pRJvJ1mC0ae+pk4NHcoF2/Gft7jOPYntNpmgNeryKa5llto8+42jB/NxpuPWO1mat9
         4ouzIzuIVXOwxC9HhmP+3ZQHbwqyxTVFP9mxh7pPRB+0GjfW1fiCIFf64kG90cLR18e4
         HWXg==
X-Gm-Message-State: AKS2vOwcao1MnlSSepjA9bcBfuqnC/vVdbl1NXbn+R/SLsfYIqsApMJj
        zETgCKJcFBobOHVIM+c=
X-Received: by 10.84.136.135 with SMTP id 7mr39152336pll.98.1498013737898;
        Tue, 20 Jun 2017 19:55:37 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id o66sm31169614pga.64.2017.06.20.19.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 19:55:37 -0700 (PDT)
Message-ID: <1498013726.5419.1.camel@gmail.com>
Subject: Re: Small issue with "add untracked" option of 'git add -i'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 21 Jun 2017 08:25:26 +0530
In-Reply-To: <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
References: <1497278015.7302.13.camel@gmail.com>
         <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
         <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
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

I tried applying the patch and building it locally. For some reason I
couldn't see the change in effect. What could I be missing?

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
