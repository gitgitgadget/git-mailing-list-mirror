From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: align curly braces for all options
Date: Wed, 29 Jul 2015 13:31:26 -0700
Message-ID: <xmqq7fpi904h.fsf@gitster.dls.corp.google.com>
References: <1438201117-11543-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKY0j-0005N8-BY
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 22:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbbG2Ub3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 16:31:29 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34909 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbbG2Ub2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 16:31:28 -0400
Received: by pdrg1 with SMTP id g1so11509874pdr.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xoSjfGyXHYwYb9Vr0P0FxvY9Vm/yzyuHortDFK3Z+yI=;
        b=NgZY4baRZ/xGZsFf90jaqCEZS0DcO4l6LOLetABqBfIMg12a9fNTaLPmNQReMeOjH2
         WR37Mk61Lk2cHsgHYfuGGjMpse4WsvUQEIJ1dsq+0PHmCNNocm44gJ7uI/tI7PnCJRGS
         3kCHl6gvuYwrEAxHrX7CYiGbruznC7dhMns/jEdmKZwXtrvzFOiggZH7gp6DlQpqZOUo
         cQaxkwc3vRxOHzDVKOOJQgUoF0JM/IWD1y6ZaxePYhKzkne7JQEyceMtxctRAc+RgXT2
         lxmgffhHd69zV9d8xDiP7SAvjeF7GD4jubwSq4epI/UlB2A8139a3EZPQ2VGgCHeWYHL
         XC6g==
X-Received: by 10.70.36.136 with SMTP id q8mr99692395pdj.23.1438201887989;
        Wed, 29 Jul 2015 13:31:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id j2sm42335830pdk.21.2015.07.29.13.31.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 13:31:27 -0700 (PDT)
In-Reply-To: <1438201117-11543-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 29 Jul 2015 13:18:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274951>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> The non alignment of white space harmed my feelings for aesthetics more
> than it should have.

Hmm, but this does not align curlies for OPT_DATE(),
OPT_EXPIRY_DATE(), etc...

>
>  parse-options.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index c71e9da..08d7818 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -126,7 +126,7 @@ struct option {
>  #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
>  #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
>  				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
> -#define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
> +#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
>  				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
>  #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
>  #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
