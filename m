From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/config: fix inconsistent label
Date: Fri, 21 Aug 2015 10:11:24 -0700
Message-ID: <xmqq7foo7eir.fsf@gitster.dls.corp.google.com>
References: <87lhd4wuj9.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 19:11:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSpql-000091-De
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 19:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbbHURL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 13:11:27 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36225 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbbHURL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 13:11:26 -0400
Received: by pawq9 with SMTP id q9so56628660paw.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OzpPif3LD7KGL01OrxUR6ZK1e6x+S3EVJe/Aks8jntg=;
        b=wCJmWoZ/G4+6HNGU1gPDO7oDl1CeYMKaWQ7eV5nVXrxy/CLLeqgXRoETzFUzHGiB1I
         7RznLI0KjwA8EcebKi5xVIQqz4CIZgkdaI5NXMRNow1neD7M1+MZyiPxqSXGReX99sTG
         7VNZJMKDL3cy1xbvfwc8NQq2gLBNBuYGcST8jcvMuF4XPnSf4OZ9gdmWGcnRBIYYAFaE
         RLo/JdEhzykUZZ20GBVbeTCiYiu0GiulsLkTPAekkrRVBEz7gTYO/HtVBxu9rNaRFVmF
         FX+tuvRDXlu9TSWH6HksRuTPdF7XrLZmREloxRnURqjz9O6tT6WOcl8cca6pUwuI9eC9
         Z0sg==
X-Received: by 10.66.249.101 with SMTP id yt5mr19125081pac.116.1440177085764;
        Fri, 21 Aug 2015 10:11:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id w17sm8441322pbt.17.2015.08.21.10.11.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 10:11:24 -0700 (PDT)
In-Reply-To: <87lhd4wuj9.fsf@igel.home> (Andreas Schwab's message of "Fri, 21
	Aug 2015 17:06:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276313>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Change <ref> to <pattern> in the description of
> gc.*.reflogExpireUnreachable, since that is what the text refers to.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---

Makes sense.  Thanks.

>  Documentation/config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 75ec02e..b4f7c46 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1329,7 +1329,7 @@ gc.<pattern>.reflogExpire::
>  	the refs that match the <pattern>.
>  
>  gc.reflogExpireUnreachable::
> -gc.<ref>.reflogExpireUnreachable::
> +gc.<pattern>.reflogExpireUnreachable::
>  	'git reflog expire' removes reflog entries older than
>  	this time and are not reachable from the current tip;
>  	defaults to 30 days. The value "now" expires all entries
> -- 
> 2.5.0
