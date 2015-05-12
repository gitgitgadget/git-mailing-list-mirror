From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] config.txt: Clarify allowTipSHA1InWant with camelCase
Date: Tue, 12 May 2015 17:24:06 -0400
Message-ID: <CAPig+cTc7qE_tD2-DtpnMGrSFthwaGakFnOWAtkq=a5aOQNMbQ@mail.gmail.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
	<1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHex-00073n-Le
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933971AbbELVYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:24:10 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35666 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933858AbbELVYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:24:06 -0400
Received: by igbyr2 with SMTP id yr2so121207058igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xHDJ6sFgLNzK+7gc0WN+Lq9UsigxIr67zlBGZkc0b5A=;
        b=MkVGRRjlF4Tnt3gmVuQixJd0zYonWBqWtHguvpcu+DXxmIAHmbnh6FmJtA3Qii2nOJ
         3HzKp68sZWD8iVAARklow5k1DMrosv/EdfTPCjGMxJBkoOmGdv18C5ImOpjS2k0b+irc
         u7a622YNdtIGwyscfMlNJa7NP23WTCrPcEQgiJcFyG4Gh1KavXeX/uOtLcbdZrL0kbP0
         CESr+3JU/MrlbFqnSVw9A9BYfqT9VWmIhinvY+PlkSQLitAf3yr198v5xsGINyitLLu+
         LHz7Q4hFkjDkuxxCQINg9okOinDeN3jxTKxje1vti1bz7yIy9/9Yt7SV51bFAemxnIk7
         Ed6w==
X-Received: by 10.107.169.74 with SMTP id s71mr22560947ioe.46.1431465846425;
 Tue, 12 May 2015 14:24:06 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 12 May 2015 14:24:06 -0700 (PDT)
In-Reply-To: <1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
X-Google-Sender-Auth: 0QTBzLxDOUFvrK0exFg3ARN5ud4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268889>

On Tue, May 12, 2015 at 5:14 PM, Fredrik Medley
<fredrik.medley@gmail.com> wrote:
> Most of the options in config.txt are camelCase. Improve the readability
> for allowtipsha1inwant by changing to allowTipSHA1InWant.

Missing sign-off. More below.

> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..2b86fe6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2530,9 +2530,9 @@ uploadpack.hideRefs::
>         are under the hierarchies listed on the value of this
>         variable is excluded, and is hidden from `git ls-remote`,
>         `git fetch`, etc.  An attempt to fetch a hidden ref by `git
> -       fetch` will fail.  See also `uploadpack.allowtipsha1inwant`.
> +       fetch` will fail.  See also `uploadpack.allowTipSHA1InWant`.
>
> -uploadpack.allowtipsha1inwant::
> +uploadpack.allowTipSHA1InWant::

This was already attempted here[1]; some inconsistencies with acronyms
and abbreviations pointed out here[2]; and delayed here[3]. Perhaps
it's now time to revisit the acronyms/abbreviations issue?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/265225/focus=265225
[2]: http://thread.gmane.org/gmane.comp.version-control.git/265225/focus=265262
[3]: http://thread.gmane.org/gmane.comp.version-control.git/265225/focus=265282

>         When `uploadpack.hideRefs` is in effect, allow `upload-pack`
>         to accept a fetch request that asks for an object at the tip
>         of a hidden ref (by default, such a request is rejected).
> --
> 1.9.1
