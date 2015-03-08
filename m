From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH 2/2] attrs: add "css" to the list of userdiff
 bulit-in patterns
Date: Sun, 8 Mar 2015 19:02:44 -0400
Message-ID: <CAPig+cTTy+Thkpb-jR9e5PGq_NN2Z+wgRB=csgo5Z0Y39M_ZFg@mail.gmail.com>
References: <1425812624-6671-1-git-send-email-sh19910711@gmail.com>
	<1425812624-6671-2-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 00:02:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUkDj-0007Ho-1d
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 00:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbCHXCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 19:02:45 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:41385 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbbCHXCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 19:02:45 -0400
Received: by yhai57 with SMTP id i57so6210823yha.8
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ADuwrFQj0nGI82WI51w+EyBqKhfPKW3x9/5904Y5Mmg=;
        b=oxtFbxS5qk8PH7JDFPzep+/J5WGSEmASqTbPEnGg9V17xS4IxKx53B2aSuObKwUxPn
         P6m9I/0q/qAFmFnr8GkyihVbKEVZGNCmf41AQhI+bpFkpOfUS6LdP/tBOTMwAkgb49jx
         fST3VYj4RLfBHwP1HFertjrLmaSnvjfKvAyj7F/JBrqfd04Q/KBwm/4x/jPA4nYzR/KR
         IR2/iuiJ+k5bpXfbtMFZfS/aauR80M/FDtINWCyUlyS+XsQdHkGVlHXzDrE7vgCSyOo1
         zMuTssz2wPvHQxRFb5vhSlimVT3j+TSib5u9Jp/IdPe55ptlJpbXI186Jo2ozay8KM0u
         yjtg==
X-Received: by 10.170.188.10 with SMTP id f10mr27764190yke.22.1425855764449;
 Sun, 08 Mar 2015 16:02:44 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 8 Mar 2015 16:02:44 -0700 (PDT)
In-Reply-To: <1425812624-6671-2-git-send-email-sh19910711@gmail.com>
X-Google-Sender-Auth: u6JG1ykYjLuEcS_cXVr6UkrnvZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265117>

On Sun, Mar 8, 2015 at 7:03 AM, Hiroyuki Sano <sh19910711@gmail.com> wrote:
> attrs: add "css" to the list of userdiff bulit-in patterns

s/bulit/built/

> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index c892ffa..8904a2a 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -525,6 +525,8 @@ patterns are available:
>
>  - `csharp` suitable for source code in the C# language.
>
> +- `css` suitable for source code in the CSS documents.

Taking a hint from the 'html' case, it might make more sense to say:

    `css` suitable for CSS documents.

Considering how directly related this change is to those in patch 1,
it's not clear why this change needs a separate patch, so folding them
into a single patch might be sensible.

> +
>  - `fortran` suitable for source code in the Fortran language.
>
>  - `html` suitable for HTML/XHTML documents.
> --
> 2.3.1
