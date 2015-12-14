From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] refs: mark some symbols static
Date: Mon, 14 Dec 2015 13:55:36 -0500
Organization: Twitter
Message-ID: <1450119336.1678.9.camel@twopensource.com>
References: <566C302F.8090103@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 19:55:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YHp-00079H-GT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 19:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbbLNSzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 13:55:38 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36247 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbLNSzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 13:55:37 -0500
Received: by qget30 with SMTP id t30so19900834qge.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=WlAxb+EwyBT1yygY6IJ90R3Iet/07a2gQCfvu4Ga9tI=;
        b=RK4bXrZRsc3pjbuVseBIegIhN32/vYWiFDKWbynQcHb0AVIfOUVMb5PeSwEqOx/rde
         DiThvZB8Wkoqpyr1du85r5W0LkvGZJ/vwKwpif0AYyk9F1k5aKs/mfelkbx4cta/6/vG
         vu1x2N1RI6FHxoSQiIM97m95Kx+CsCUh4ciYBb5/poaqjYcvnQcqVfXsbVxj5bWMwRkC
         zF2vQPCbjeeXU8VvVPsO5Ful/EX6g0FWe6aATM/J5XqX05f9vBajluhEMGIExQycvX1C
         Zt027+gyv82sdEF4Mxp7QrNV3v9zMpG5/o+P8KHZ1SLxNm96l7CvH2XnaqayekSMrBpu
         /unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WlAxb+EwyBT1yygY6IJ90R3Iet/07a2gQCfvu4Ga9tI=;
        b=NxPephREWAWv0J+EZDMSl20NfNT0j6ruZ/u96lsjQmrC2IyZdYAJcTMNfGkzmKutuw
         ZemGegAzIxLniM3Lg2/R2DbOhhtmowF4vzzRshKCQYmW2LoRiiGWeSkg2zkzlww5KA43
         jvd0keflN8vTJ48YG55QTH98OKIlcASTbYMHa97ArDuzZrj6c6OU8ESDqHGY69aHSOjz
         9bTlEAmQjcK6wpqIyysuVS205aWyOip/0wv/uPK2h13KnEU1d3HRzU+1e1w7yfXbppfJ
         yzmjqTlL/GvDgMWTADOkJuJo6k8T+qeGuoJBWfEhba8FPu1zl9lDKoR84zBYutYPrl3H
         uayA==
X-Gm-Message-State: ALoCoQk1Kkp+LcKdLlnff3c0PT/h81zEU662FDLIfHkry8tWYkMUInRrf3y4LNWcFuNoW3oKLXMcwH3Ww30c+EM32kJsGnND2A==
X-Received: by 10.140.105.182 with SMTP id c51mr44420124qgf.15.1450119336445;
        Mon, 14 Dec 2015 10:55:36 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id m107sm4592796qgm.19.2015.12.14.10.55.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 10:55:35 -0800 (PST)
In-Reply-To: <566C302F.8090103@ramsayjones.plus.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282377>

Will do.


On Sat, 2015-12-12 at 14:33 +0000, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi David,
> 
> If you need to re-roll your 'dt/refs-backend-lmdb' branch, could
> you please squash the relevant parts of this patch into yours.
> 
> [yes, I didn't reference the movement of the external declaration
> in the commit message! :-D ]
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  refs.c               | 7 +++----
>  refs/files-backend.c | 2 +-
>  refs/refs-internal.h | 2 ++
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 0be7065..c0faa97 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -9,7 +9,7 @@
>  #include "object.h"
>  #include "tag.h"
>  
> -const char split_transaction_fail_warning[] =
> +static const char split_transaction_fail_warning[] =
>  	"A ref transaction was split across two refs backends.  Part of the "
>  	"transaction succeeded, but then the update to the per-worktree refs "
>  	"failed.  Your repository may be in an inconsistent state.";
> @@ -17,12 +17,11 @@ const char split_transaction_fail_warning[] =
>  /*
>   * We always have a files backend and it is the default.
>   */
> -extern struct ref_be refs_be_files;
> -struct ref_be *the_refs_backend = &refs_be_files;
> +static struct ref_be *the_refs_backend = &refs_be_files;
>  /*
>   * List of all available backends
>   */
> -struct ref_be *refs_backends = &refs_be_files;
> +static struct ref_be *refs_backends = &refs_be_files;
>  
>  const char *refs_backend_type;
>  
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0efc507..e8181ae 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3280,7 +3280,7 @@ static int ref_present(const char *refname,
>  	return string_list_has_string(affected_refnames, refname);
>  }
>  
> -void files_init_backend(void *data)
> +static void files_init_backend(void *data)
>  {
>  	/* do nothing */
>  }
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 9c17fdf..8fb360d 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -313,4 +313,6 @@ struct ref_be {
>  	for_each_replace_ref_fn *for_each_replace_ref;
>  };
>  
> +extern struct ref_be refs_be_files;
> +
>  #endif /* REFS_REFS_INTERNAL_H */
