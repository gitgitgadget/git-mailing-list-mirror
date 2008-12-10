From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: builtin-add.c patch
Date: Wed, 10 Dec 2008 17:26:32 +0300
Message-ID: <20081210142632.GA4137@myhost>
References: <200812101238.mBACcWQk023480@axiom-developer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: daly@axiom-developer.org
X-From: git-owner@vger.kernel.org Wed Dec 10 15:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAQ2K-0003f6-8R
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 15:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYLJO0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 09:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbYLJO0K
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 09:26:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:42756 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbYLJO0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 09:26:09 -0500
Received: by fg-out-1718.google.com with SMTP id 19so233278fgg.17
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 06:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=84SkLdAuFGr5qEGpCGzWFkKvi5F/9lYOQwW0VyrJ67U=;
        b=Fwc0pK4QiKgDgghepYxig5vk1b+PWXqbYr7bJDFMTIABQ8RqlGxPDABUZck3pZNnY6
         BShy8GNZSIy+s22gDEnNrBK1AcmYcfKgJBrudJ2q3kBN+Jswcfpyv5Z3NZiLdskXLrUl
         jGlMN+hOKt2OMiW3xvVUh768YHoWdCjArnbVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kSA80g5BDluYV0M2Bs7VAD49JBuY1GuVEng/86FjS5piFXKabvc55oqRslKPubGLNB
         eDwPrJ2NPOYtUEO5o0B4FAbMHUd6FdoZFOsM0eiGz2pzpP6osp1eY3omokfGfb+vLou7
         OJKGPBos3NaINyM9Yud2aUWjw9VuMMZn18JSU=
Received: by 10.86.31.18 with SMTP id e18mr676526fge.72.1228919167087;
        Wed, 10 Dec 2008 06:26:07 -0800 (PST)
Received: from smtp.gmail.com ([91.78.100.86])
        by mx.google.com with ESMTPS id e20sm2412761fga.57.2008.12.10.06.26.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 06:26:05 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Wed, 10 Dec 2008 17:26:32 +0300
Content-Disposition: inline
In-Reply-To: <200812101238.mBACcWQk023480@axiom-developer.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102689>

Hello, Tim!

On 06:38 Wed 10 Dec     , daly@axiom-developer.org wrote:
> A trivial patch to fix a typo -- Tim Daly
> 
> 
> diff --git a/builtin-add.c b/builtin-add.c
> index ea4e771..5f2e68b 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -23,7 +23,7 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
>  	int num_unmatched = 0, i;
>  
>  	/*
> -	 * Since we are walking the index as if we are warlking the directory,
> +	 * Since we are walking the index as if we are walking the directory,
We probably should use subjunctive here:
"Since we are walking the index as if we _were_ walking the directory,".

Are there any native English speakers? :)
>  	 * we have to mark the matched pathspec as seen; otherwise we will
>  	 * mistakenly think that the user gave a pathspec that did not match
>  	 * anything.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

It's also better to change the commit message, one should be able to
realize from it that the change is a typo fix in comments.
