From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] document new flags
Date: Sat, 30 May 2009 01:19:53 -0700 (PDT)
Message-ID: <m38wkfatqc.fsf@localhost.localdomain>
References: <1243647555-25098-1-git-send-email-user@lamp>
	<1243647555-25098-2-git-send-email-user@lamp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: Jeff Epler <unpythonic.net@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat May 30 10:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAJnT-0000vL-Kn
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 10:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbZE3IT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 04:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZE3IT4
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 04:19:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:48858 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZE3ITz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 04:19:55 -0400
Received: by ey-out-2122.google.com with SMTP id 22so196092eye.37
        for <git@vger.kernel.org>; Sat, 30 May 2009 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=FXMsYlr8LGm8tevcHo8Va34+uV03KFMDMf0pBv+aQxM=;
        b=GcftTqx9H4rO2453hgZlp3uyjs+SXqmH/pTWn9u8LtbMQou91Y2ynnaQGmO+9TFCtj
         p3Kl0yqtKqK0fqHGjU1/TXUcbRd6UwYiN6RXj10S1m9vdTy47/Aubl8XfeLuoaNS2vki
         T0pybu9b6+xH7fV6Zd4is41WQjpCD9ZyZjTXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LapD0ZVkWN28oGntRBAJ5VZl8iqT0LCCGFm1j6UaLgqBIHmmg4H8LuwKDbgOxgtZu1
         /ahf+4BRVhSO3yqTEi1Oj1fVis+++eLEbYOi/yq1V1Y+gEE50U66VWB73pPz9ULmBr04
         smrteQ7T9rnODBddvdbh2ynWhA5jLj5gbj4gk=
Received: by 10.210.37.16 with SMTP id k16mr1254164ebk.14.1243671593902;
        Sat, 30 May 2009 01:19:53 -0700 (PDT)
Received: from localhost.localdomain (abvr167.neoplus.adsl.tpnet.pl [83.8.215.167])
        by mx.google.com with ESMTPS id 28sm3412140eye.56.2009.05.30.01.19.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 01:19:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4U8JP6U025008;
	Sat, 30 May 2009 10:19:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4U8J8S0024994;
	Sat, 30 May 2009 10:19:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1243647555-25098-2-git-send-email-user@lamp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120338>

Jeff Epler <unpythonic.net@unpythonic.net> writes:

> From: Jeff Epler <jepler@unpythonic.net>
> 
> Signed-off-by: Jeff Epler <jepler@unpythonic.net>
> ---
>  Documentation/git-cherry.txt |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)

Why split this patch in two? It is better to have new feature and
documentation together, I think.
 
> diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
> index 7deefda..100ed69 100644
> --- a/Documentation/git-cherry.txt
> +++ b/Documentation/git-cherry.txt
> @@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
>  
>  SYNOPSIS
>  --------
> -'git cherry' [-v] [<upstream> [<head> [<limit>]]]
> +'git cherry' [-v] [-a|-#] [-r] [-d|-D] [<upstream> [<head> [<limit>]]]
>  
>  DESCRIPTION
>  -----------
> @@ -49,6 +49,18 @@ OPTIONS
>  -v::
>  	Verbose.
>  
> +-a|-#::
> +	Abbreviate commit ids to the given number of characters, or 7 for -a
> +

Why invent new convention, instead of using -<n> like git-log?
Why do not use --abbrev or --abbrev-commit? -<n> is used elsewhere
to limit number of commits...

> +-r::
> +	Swap <upstream> and <head>

Why not -R like in git-diff?

> +
> +-d::
> +	Only show commits that don't exist in upstream ("+" lines)
> +
> +-D::
> +	Only show commits that do exist in upstream ("-" lines)
> +

I'm not sure if -d/-D is the best name of this short option...

>  <upstream>::
>  	Upstream branch to compare against.
>  	Defaults to the first tracked remote branch, if available.
> -- 
> 1.5.4.3
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
