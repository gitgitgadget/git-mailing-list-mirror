From: Stefan Beller <sbeller@google.com>
Subject: Re:
Date: Mon, 11 Apr 2016 21:33:07 -0700
Message-ID: <CAGZ79kYD7o3O_-zSGD24_DUy9hDc9=u6pPYXOOWp+-i-PW7vjQ@mail.gmail.com>
References: <001a11492f107354a305303a369a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Williams <miwilliams@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 06:33:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apq0o-0003l3-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 06:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbcDLEdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 00:33:10 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35314 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcDLEdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 00:33:08 -0400
Received: by mail-io0-f178.google.com with SMTP id g185so13450006ioa.2
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=T+OtT4Csm4grY0CKFKSEK9hO/O5Xchx7L8WESOMyO0Y=;
        b=nbl8sLdG7S12XY5j25qD3jf2AKdHncoPn1YS/DlDA97w3rXwmps9/R4949H3vRj1AO
         TY27KY4YibV56OXmE6hxkgE90c3S2RV538uiaSA7R2TBGDTw4UEhgVrF9CjACfysdzsQ
         P7t0jvSuyqWBUuRY6k4Hs3wL2SOqr9BmYp9XscWlzZr/YzhLeZqzmqwi4q9M9hjKRAd9
         ammFB7hIWDen8EeKfk9bV3m0JN52xJ1CiK4nubbtjXI0Yb+MBaTLaOHHe5R5ImH8Lxo6
         T4G7oGPTnrDsrUo/tbbHak630dXKUwYAmgWIbNDvNoCNq6TY0BalltoFt7RU36+cJOpI
         XhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=T+OtT4Csm4grY0CKFKSEK9hO/O5Xchx7L8WESOMyO0Y=;
        b=GBsaGi95ctXd+ddBcudajCXRYs3RLFq+WmzwUHp9jAbW5AqCwKEMVVWuEMWk2KrF3A
         cWFqw6ZlM6sk+X1rC63DiQhsJQZ8IWeND3m3ZYYq5N9uU5iFFsbhjkVTigi+7k8itWlq
         qtJF1jA50x2FIa1TXNIu/kVaLDrHrjStCQ9WQHOouh1fBtOFzuyaxHdxdL210/TjZtER
         wdI0gLv1G6uLvKvyFyNAbufshXh039hXZbKrGPzG04se5dn9cM2Ot7XM1+I8SOQ6Hlvb
         rHy3WIom6WmyO7rfv+K3+Eu63R0yWrh4ENlu6AZzJHp4UENDq7hBz0+lTvvdaRYYLKkU
         o7KQ==
X-Gm-Message-State: AOPr4FXErM9UmRrNY4g2RXCnfxbOykG2DmZ9q7Q8FIdnAtSYH9hjD9/TmnW6P/29k/kOthV/Y5I3A0/JA0Mobon3
X-Received: by 10.107.184.8 with SMTP id i8mr1573856iof.96.1460435587831; Mon,
 11 Apr 2016 21:33:07 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Mon, 11 Apr 2016 21:33:07 -0700 (PDT)
In-Reply-To: <001a11492f107354a305303a369a@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291243>

On Mon, Apr 11, 2016 at 12:04 PM,  <miwilliams@google.com> wrote:
> From 7201fe08ede76e502211a781250c9a0b702a78b2 Mon Sep 17 00:00:00 2001
> From: Mike Williams <miwilliams@google.com>
> Date: Mon, 11 Apr 2016 14:18:39 -0400
> Subject: [PATCH 1/1] wt-status: Remove '!!' from
> wt_status_collect_changed_cb
>
> The wt_status_collect_changed_cb function uses an extraneous double negation
> (!!)

How is an !! errornous?

It serves the purpose to map an integer value(-1,0,1,2,3,4)
to a boolean (0,1, or a real bit in a bit field).

> when determining whether or not a submodule has new commits.
>
> Signed-off-by: Mike Williams <miwilliams@google.com>
> ---
>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index ef74864..b955179 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -431,7 +431,7 @@ static void wt_status_collect_changed_cb(struct
> diff_queue_struct *q,
>                         d->worktree_status = p->status;
>                 d->dirty_submodule = p->two->dirty_submodule;
>                 if (S_ISGITLINK(p->two->mode))
> -                       d->new_submodule_commits = !!hashcmp(p->one->sha1,
> p->two->sha1);
> +                       d->new_submodule_commits = hashcmp(p->one->sha1,
> p->two->sha1);
>         }
>  }
>
> --
> 2.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
