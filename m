From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 03/12] attr.c: update a stale comment on "struct match_attr"
Date: Mon, 16 May 2016 16:34:53 -0700
Message-ID: <CAGZ79kZW6GRC8As5oX6CXbTarcU86x_+e8=ksABQubXJGkVhiQ@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-4-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:35:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2S2R-0003d1-91
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbcEPXez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:34:55 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34723 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcEPXey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:34:54 -0400
Received: by mail-io0-f180.google.com with SMTP id 190so2930002iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=vvUzMvUIyXxFJtLpw5fi5PWHSJ1EW2C88WuorhLormg=;
        b=ky73xlsPHakRpsH31FWSd4VZTHDnE3m8muKlUnT3Enl/J/dlvx7t7lWyrIxD0mXRQZ
         AKaFesPTrw6vJGz7Momf8ZUXVqMlthip+BIEpaR9pqazvwlMPAf2N8MQSoZV5R+gvWON
         FNXqC96akHMJnVf73IBQ9e+mm8yUHqR3gIkT8Jd5SzcFRMDt5Zga5x7rKurKwbzb+1RA
         qROjAmRxoWhTlKG8U1CqCi1HOkYC8SFlL73Y+MuJfMCC159KMf9ez5qzwM64zoKW94Ks
         s2n2/RXqDmpK+32uTSRdojK3uwuVFgR2+xVfSTgoDTsrK20cQvVHnnHasoRZRxm72bYA
         QOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=vvUzMvUIyXxFJtLpw5fi5PWHSJ1EW2C88WuorhLormg=;
        b=Sd6SdNd9pUt3ZnebSIShRhPUxfUhmEvDjFyPWbwT9dqx8gpiKsNpqyysEbsjAFOHi5
         5Xx7zbD3cfSz/PpmPPEVoZdsp3WV11c1RmwDJHvkd0K/eNV8YD8YYjkzsQhqz7ZmcCnm
         dRkPwGVLymHePQEi/j2n4HxCFOxejFkZ8kLUcVT5zU6svcMk7vMK5+sxvawpydJkZwwn
         EhlOQqdPfaun7FP+UCJkOMj/H3TidLQhM2QFT+8ACFg81FrvXY3Y54wWi+/OQegcox09
         4ErBllbRJS80ghTLKlpEQ+St+Q3xlElc/966uq9V7jIln4kWEpydnB8adatQIQOePHNH
         Jl5w==
X-Gm-Message-State: AOPr4FV2nSKPzPc+amAvUahIy/nOtVXrZxgWG1Rzp9nPPA+4MdkylG364Nuvo504xpwMgFpWvb+hic8RSqToYpIV
X-Received: by 10.36.107.129 with SMTP id v123mr10696690itc.52.1463441693296;
 Mon, 16 May 2016 16:34:53 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 16:34:53 -0700 (PDT)
In-Reply-To: <20160516210545.6591-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294817>

On Mon, May 16, 2016 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When 82dce998 (attr: more matching optimizations from .gitignore,
> 2012-10-15) changed a pointer to a string "*pattern" into an
> embedded "struct pattern" in struct match_attr, it forgot to update
> the comment that describes the structure.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  attr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 45aec1b..4ae7801 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -131,9 +131,8 @@ struct pattern {
>   * If is_macro is true, then u.attr is a pointer to the git_attr being
>   * defined.
>   *
> - * If is_macro is false, then u.pattern points at the filename pattern
> - * to which the rule applies.  (The memory pointed to is part of the
> - * memory block allocated for the match_attr instance.)
> + * If is_macro is false, then u.pat is the filename pattern to which the
> + * rule applies.

and we don't need to talk about memory ownership here as that
is clear for 'struct pattern' documented elsewhere?

>   *
>   * In either case, num_attr is the number of attributes affected by
>   * this rule, and state is an array listing them.  The attributes are
> --
> 2.8.2-748-gfb85f76
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
