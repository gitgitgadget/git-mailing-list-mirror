From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/13] delete_refs(): convert error message to lower case
Date: Mon, 8 Jun 2015 09:51:42 -0700
Message-ID: <CAGZ79kbT3x=CxKwwxk8qsfNh5ee-0i2Toe4sY584CkjbadDGjA@mail.gmail.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
	<49bd60449c003c8a7fd060095fe743bb9efaba99.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20H6-0008T0-Qg
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbbFHQvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:51:44 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:34888 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbFHQvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:51:43 -0400
Received: by yhak3 with SMTP id k3so38029699yha.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d/9xTA9Hv/kp4em6eK/ykY/HTp2gDUb+ZCkpB27pXtM=;
        b=nVLuoeLVWtvzLBYFVXeEKqfSVFMmYKPA4nYTI2OaPb3Sjn8E+FQPTPLxRVPsWOzDy6
         8EFsc4ByB8xTjkwbNiFRBe+Ls08bKtpoJOWYvo1hT2C1561svhG5ij9uIa80IghOFJ6B
         KTfcropBk3wLYqnpfpOlRXwr7h+SF1Er/HRcLLLdMjudSrfW63DOt2UL34r7/pIkOBZ6
         AR6NGxG9KK55emHpXaXQ2WbwLjUu60J4FZPm3LD6BcRsjaeGpm5fN6agJfmfICMp8tXS
         bc85VT+gA+XL6ykooeB/QwTM2jnPXNZublsQGAQEeYp3jR7cOaWzC7+JJgwOh/pTYhSg
         AwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d/9xTA9Hv/kp4em6eK/ykY/HTp2gDUb+ZCkpB27pXtM=;
        b=UBCo9kRf8/hn9eZnlG0MRwYTkaYGnHie42vVZbY7DXr29UV1LJjLLDbW7RLuUu1eXi
         lslX3lRWffl/6HGz2CQ4/7Cbf+aihMh5/Hl4R8mz0GVcdEp0SEAlIlOAoKfXWjBFNE/U
         gs//6cfZe9ksBHZg3CPq7QzuP7HJzGPKLu/FKE450HzZWw2uUzHVDFGS2unTeSPIvq2K
         IqfUEQCVV02lGNbcPkVG90ofK1hdMiwF3yo3RNOtXd2H2R4iUd69mKFzMW+hpCFkZCWc
         uMFDn7aISaNxbh7gS05TVOz6LjPoZb8IwwfjokWouRtvj4tvqgAj+owNqXJe4YuiPM+/
         7Lxg==
X-Gm-Message-State: ALoCoQkoZj8vzegMNEq+b7rrkRngWqD1UYwUdpN4oaNXJi3OSzvJ8jnJMYOMrNXfr46D2dJrhipt
X-Received: by 10.170.43.16 with SMTP id 16mr19643291ykl.119.1433782302415;
 Mon, 08 Jun 2015 09:51:42 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 09:51:42 -0700 (PDT)
In-Reply-To: <49bd60449c003c8a7fd060095fe743bb9efaba99.1433763494.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271074>

On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This string is going to have to be re-internationalized anyway because
> of the previous commit. So while we're at it, we might as well convert
> it to lower case as per our usual practice.

Although the previous patch and this are addressing two slightly
different things,
we may want to squash this into the previous without dropping any of
the commit message?
(It might make reviewing easier, I'd assume)

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 2a2a06d..a10aba8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2827,7 +2827,7 @@ int delete_refs(struct string_list *refnames)
>                 const char *refname = refnames->items[i].string;
>
>                 if (delete_ref(refname, NULL, 0))
> -                       result |= error(_("Could not remove reference %s"), refname);
> +                       result |= error(_("could not remove reference %s"), refname);
>         }
>
>         return result;
> --
> 2.1.4
>
