From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter: fix indentation
Date: Wed, 29 Jul 2015 21:41:11 +0530
Message-ID: <CAOLa=ZQf+_BkvjFC4Fv=X8_3A=KAs7e4JB2CZC3n5U6yffSLpg@mail.gmail.com>
References: <1438185150-31730-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:11:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTxK-0000Yn-6t
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbbG2QLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:11:42 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35875 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbbG2QLl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:11:41 -0400
Received: by oibn4 with SMTP id n4so7618555oib.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZyhE7UYLhvqMbidnkVsHHZmbP4DNvbGndu+3p31Fuj4=;
        b=k/k3AciMUeBBS0u8ygtfaMcgKNMGAddBwQna6OXdvNOPrriGw/1r2r05lXt21MZYS6
         kW1LJbB8MJIk8Qo7ySHhB+Pc7kq6/xtOHRSwYquvVJ0D0J8p41nb5n+W7dOEs0K/y6SG
         PWGLFz6fzdc5AKMi/fjorPYg5Zj/M4saDhD3PbT/AHODWsyyeSrNZFVj0m2ZDZ0/rJ8K
         MRUZmC0pzKVJuDLWQ+zx7fH1UCNmBNdiItRGbMR5pTgFX634FxissXlzCN6KiSNLaUuR
         7QxvvXHVHztBE/OtT6ksPUe2KSFngnrbocGH2nj64LxwyihrG6Uxjyx6kxjZu4K4SO8B
         vwoQ==
X-Received: by 10.202.92.6 with SMTP id q6mr39076972oib.11.1438186301107; Wed,
 29 Jul 2015 09:11:41 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 09:11:11 -0700 (PDT)
In-Reply-To: <1438185150-31730-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274916>

On Wed, Jul 29, 2015 at 9:22 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This is meant to be applied on top of kn/for-each-ref.
>
>  ref-filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 43502a4..3fbbbeb 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -868,8 +868,8 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>         struct ref_array_item *ref;
>
>         if (flag & REF_BAD_NAME) {
> -                 warning("ignoring ref with broken name %s", refname);
> -                 return 0;
> +               warning("ignoring ref with broken name %s", refname);
> +               return 0;
>         }
>
>         if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
> --
> 2.5.0.rc0.7.ge1edd74.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for this :)

-- 
Regards,
Karthik Nayak
