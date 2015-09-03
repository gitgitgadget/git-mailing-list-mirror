From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/11] Documentation/rev-list: don't list date formats
Date: Thu, 03 Sep 2015 15:36:22 -0700
Message-ID: <xmqqvbbrgmft.fsf@gitster.mtv.corp.google.com>
References: <cover.1441144343.git.john@keeping.me.uk>
	<cover.1441316394.git.john@keeping.me.uk>
	<cfc780ad4f30521a4f54eba2a96ced8e0bbfc519.1441316394.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 04 00:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXd7L-0007KM-W4
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 00:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996AbbICWgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 18:36:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36496 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695AbbICWgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 18:36:24 -0400
Received: by pacwi10 with SMTP id wi10so3446640pac.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RsBg+ilzlbUkvJ0f7r9yu9kI+nLI4FjNlXAIanlcOj0=;
        b=GjieyjPIBwq4FzJR27Er3IafW9uNroY4x5wPGQ5LEtaFxDLtjcyptvjYwDm8V9Lb4s
         brEGShF23+VLd7d1I+yLi4fWt/Y5ZsBTVUI6EDvYFjY+2p/eSO8vMnSGXiYHhKlQY20n
         OBRCylEWDmkhFmMdhfWTIhI0SaWEkF1JtwN1bfniSf5Genr3Np5s6+nnB3mOgfyCISyy
         Eo+UPu2XmwFesb/ZWji+LAfQIq0l2fAWOSdBKWDngGdiej5MeppGbqu6t6ApoEDg4qqQ
         CN4KtAwbee5WGxAPFPyaxFnLPJO6b5lK1HdIwoNVLwtY2QZWRpkXr6ZP+uBn1YYWXfKq
         2yCw==
X-Received: by 10.66.163.161 with SMTP id yj1mr718872pab.34.1441319783933;
        Thu, 03 Sep 2015 15:36:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id ok4sm164586pbb.65.2015.09.03.15.36.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 15:36:23 -0700 (PDT)
In-Reply-To: <cfc780ad4f30521a4f54eba2a96ced8e0bbfc519.1441316394.git.john@keeping.me.uk>
	(John Keeping's message of "Thu, 3 Sep 2015 22:48:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277276>

John Keeping <john@keeping.me.uk> writes:

> We are about to add several new date formats which will make this list
> too long to display in a single line.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  Documentation/git-rev-list.txt     | 2 +-
>  Documentation/rev-list-options.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

After seeing 1-3/11 this makes me wonder if we still have a list
somewhere in the documentation.  I'll read on first but I may have
to come back to this later.

Thanks.

>
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 7b49c85..ef22f17 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -45,7 +45,7 @@ SYNOPSIS
>  	     [ --regexp-ignore-case | -i ]
>  	     [ --extended-regexp | -E ]
>  	     [ --fixed-strings | -F ]
> -	     [ --date=(local|relative|default|iso|iso-strict|rfc|short) ]
> +	     [ --date=<format>]
>  	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
>  	       [ --unpacked ] ]
>  	     [ --pretty | --header ]
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index a9b808f..14c4cce 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -699,7 +699,7 @@ include::pretty-options.txt[]
>  --relative-date::
>  	Synonym for `--date=relative`.
>  
> ---date=(relative|local|default|iso|iso-strict|rfc|short|raw)::
> +--date=<format>::
>  	Only takes effect for dates shown in human-readable format, such
>  	as when using `--pretty`. `log.date` config variable sets a default
>  	value for the log command's `--date` option.
