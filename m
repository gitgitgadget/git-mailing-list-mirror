From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] refs: reduce the visibility of do_for_each_ref()
Date: Wed, 24 Feb 2016 14:28:16 -0500
Organization: Twitter
Message-ID: <1456342096.18017.2.camel@twopensource.com>
References: <56CBAA31.7030809@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:28:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYf6q-0007HL-HF
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 20:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbcBXT2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 14:28:19 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36694 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbcBXT2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 14:28:18 -0500
Received: by mail-qg0-f47.google.com with SMTP id y9so22685335qgd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=h1uoDku14o9/0mPxYdGHtfDGmgW6L780+L//zwTbrh8=;
        b=1V29Q0PERP1P/2wZJ1bOzS9pSBiKDC4W4NjvjLBCvSTvdYhMrYU8+OW5hDyr9l38t1
         CLjFkgGSHsNeeiDSb6/10kdUHPicFH2VrskN7E4tFKsLbWiL+LAZI6AwID/HHps0udJW
         gSXBcMbkNkGFJgfg8aeUB22I4fhfFe4m0k212L0qFGgRBfqQWCa2RMD6ORq/R10yHqbd
         W1Rh+xAVl8LFDhvvJKb9tEH4U4pLuFRd0c5+CCR+CopQGcsrgVE+kavtt1EUi124EhBb
         XCTvVTiOTGviYuL92F772l0PPZ8c47L7FqJxMfJFrabu8Skr/0MP4vyB46U8jx8Fiy/D
         6brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=h1uoDku14o9/0mPxYdGHtfDGmgW6L780+L//zwTbrh8=;
        b=m8TwGdnodc3Q5YEOucsN9QjH/w1Ewwen3SH6HerQ87K2XNYfcRkTCnzhxS2JjtFFYs
         lG0huxEono9PuiI1hxRZUQkNRc9t9/X9fTMRE/bWZX1HKr1RZYsaZ3xQR0XteZ6o3zom
         32sFZ0H6wIeMf52yNLg7gI9tVUv47GVamkYI8b7e2RsROIEjh3c8+0C6bWj1mdBvih0a
         90AG9InQBzqTo9q3fSoP3x1jSk/eaqjktP+ajhJMnVzsQKkGiqeRVfxeLsUYZJ2wMlN7
         7Rxxwn90s3wbNPcShuHt6mIxzYnuTc92/fKFZtHc87FZvxUtteVDDpzvF28Cx9lvx1jV
         ylpQ==
X-Gm-Message-State: AG10YOSoo2kjxzXDOUXdbQcpS8nXztd04onODSP6ftM2Wh3PbsblKdtRjhmuDL8MSw9g8w==
X-Received: by 10.141.1.87 with SMTP id c84mr54081015qhd.1.1456342097669;
        Wed, 24 Feb 2016 11:28:17 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 85sm1799414qkw.19.2016.02.24.11.28.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 11:28:16 -0800 (PST)
In-Reply-To: <56CBAA31.7030809@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287218>

Got it, thanks.

On Tue, 2016-02-23 at 00:39 +0000, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi David,
> 
> Again, If you need to re-roll your 'dt/refs-backend-lmdb' branch ...
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  refs.c               | 16 ++++++++--------
>  refs/refs-internal.h |  6 ------
>  2 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 337f110..bf70876 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1236,6 +1236,14 @@ static int get_affected_refnames(struct
> ref_transaction *transaction,
>  	return 0;
>  }
>  
> +static int do_for_each_ref(const char *submodule, const char *base,
> +			   each_ref_fn fn, int trim, int flags,
> +			   void *cb_data)
> +{
> +	return the_refs_backend->do_for_each_ref(submodule, base,
> fn, trim,
> +						 flags, cb_data);
> +}
> +
>  int for_each_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
> @@ -1501,14 +1509,6 @@ int resolve_gitlink_ref(const char *path,
> const char *refname,
>  	return the_refs_backend->resolve_gitlink_ref(path, refname,
> sha1);
>  }
>  
> -int do_for_each_ref(const char *submodule, const char *base,
> -		    each_ref_fn fn, int trim, int flags,
> -		    void *cb_data)
> -{
> -	return the_refs_backend->do_for_each_ref(submodule, base,
> fn, trim,
> -						 flags, cb_data);
> -}
> -
>  int for_each_reflog_ent_reverse(const char *refname,
> each_reflog_ent_fn fn,
>  				void *cb_data)
>  {
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index ced6af4..4922e25 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -227,12 +227,6 @@ int do_for_each_per_worktree_ref(const char
> *submodule, const char *base,
>  				 each_ref_fn fn, int trim, int
> flags,
>  				 void *cb_data);
>  
> -/*
> - * The common backend for the for_each_*ref* functions
> - */
> -int do_for_each_ref(const char *submodule, const char *base,
> -		    each_ref_fn fn, int trim, int flags, void
> *cb_data);
> -
>  /* refs backends */
>  typedef int ref_init_db_fn(int shared, struct strbuf *err);
>  typedef int ref_transaction_commit_fn(struct ref_transaction
> *transaction,
