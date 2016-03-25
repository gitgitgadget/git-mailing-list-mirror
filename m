From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] api-parse-options.txt: document OPT_CMDMODE()
Date: Sat, 26 Mar 2016 00:38:44 +0530
Message-ID: <CAFZEwPOaqZmE4oUy7PWDNv_Qvz+hPgZH2YO6VKk5XUtGYL-ziQ@mail.gmail.com>
References: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
	<01020153af24cfbc-a145ad2b-0cc2-4378-bce9-6b1f68251ce8-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 25 20:08:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajX6J-0003T7-0E
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 20:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbcCYTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 15:08:46 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36555 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcCYTIp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 15:08:45 -0400
Received: by mail-qk0-f193.google.com with SMTP id e124so3860706qkc.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7HFrgsFw3ih/nLl2yC593aUX3j12+tdDq8Iu/aBDmRE=;
        b=z+u7DmU/UX7Kjz+n69hL7xIw6QWZoBney616q5hlUyfJQAFjYx7WFNgyRJE25g2ffv
         O1OZa45nBm+JgLY8q/5nB2n0jxfHY1rMfmHU1kYv792gESlQcT1chw1gEwLmE7hz4dkj
         zwpDRzODOGS/4I/5ddD2T5+kq3rAP0PTv2CQkUv/elyJFZDetIdtsgMr6n8uuXwpm1UU
         KeaZjgbuRxnzrs/yCk6nP1tgG1ovG2afdKsoKMjE7AzoXXEuQYQj+M9NKXMTa/0AOljq
         nMXxOqvlC0zhTIBPlZ4F+/ZAv6Hf7GQQEuqE+m6syCC1v+g69uep0X7wmDY0/L7wTfzA
         wo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7HFrgsFw3ih/nLl2yC593aUX3j12+tdDq8Iu/aBDmRE=;
        b=T/8onIvVpBgVHLvfx2vcFvhi02RYbjRAQNCfREzR2l/yoa3a608w6orP3F/QgmpbLU
         CPkqUp9B6RWkE0ZkSZ2orVwONIbpg7Ui4pEBoaXa/KnZaqxQMXsCVvF8b9gJaRTx4pFk
         E5HfUrdqMAla2EGD2yMlBccjStBQbYfDMBB4s/RcUy2+ApBs1+3eDUp8vUKEoV7x0KWf
         5H6yU9aOmyftC0ysF3fuPLi4ogfXXFsEOqK2MxO6KivuPogUOc6boEn67m34/rWox8zJ
         CECL06O8bK96vdpwgqyJpYdHDlNakdF4JFuowsNiiwnlV9F6+oy88PetAvIC9tTPIXmP
         lbDg==
X-Gm-Message-State: AD7BkJL0UGBOHothn8U3sZzJUfldminffwDqPDdfZmR3tWH4ea6pot7/teK1nlScGUHodfP4NLmMMvcHvJsX2w==
X-Received: by 10.129.77.135 with SMTP id a129mr7898991ywb.243.1458932924625;
 Fri, 25 Mar 2016 12:08:44 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 12:08:44 -0700 (PDT)
In-Reply-To: <01020153af24cfbc-a145ad2b-0cc2-4378-bce9-6b1f68251ce8-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289946>

I have used bits from your email. I forgot to add "Helped-by: Junio C
Hamano <gitster@pobox.com>" . Could you squash it in?

On Sat, Mar 26, 2016 at 12:28 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> OPT_CMDMODE mechanism was introduced in the release of 1.8.5 to actively
> notice when multiple "operation mode" options that specify mutually
> incompatible operation modes are given.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  Documentation/technical/api-parse-options.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 5f0757d..695bd4b 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -231,6 +231,13 @@ There are some macros to easily define options:
>         pass the command-line option, which can be specified multiple times,
>         to another command.
>
> +`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
> +       Define an "operation mode" option, only one of which in the same
> +       group of "operating mode" options that share the same `int_var`
> +       can be given by the user. `enum_val` is set to `int_var` when the
> +       option is used, but an error is reported if other "operating mode"
> +       option has already set its value to the same `int_var`.
> +
>
>  The last element of the array must be `OPT_END()`.
>
>
> --
> https://github.com/git/git/pull/219
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
