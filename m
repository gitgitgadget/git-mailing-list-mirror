From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] t/t5520: explicitly unset rebase.autostash
Date: Tue, 29 Mar 2016 16:16:31 -0400
Message-ID: <CAPig+cROGO0kSgTL7OpLGYN+cA7RKWHz0ES=h+FNDREcp65GJA@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-3-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:21:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al047-0002oU-8G
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098AbcC2UQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:16:33 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34948 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073AbcC2UQc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:16:32 -0400
Received: by mail-vk0-f68.google.com with SMTP id e185so3744720vkb.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=+nyHLvIgRhZi9ZIMK91ORSbKEPS/kPb51jtOqSPCci8=;
        b=jdzsr1GIRpLGrW4hCd1BRECpe5DSLIuSa5qi8wdnN5LVZpNYr9DrC6HxmF6mnBL2SR
         CSClvY0+SNXzieAZUPfUiRqxMl1TNUiTtmHZy3bJAz/BB/FllgASY9kocT3eVTaUJntq
         06pxdHRpIXTJ0BbtgmaGMqDAa2kycZFAniKxuJXbE3UK2Fn+4IidEfeBinZFfmtgMkYY
         j02i+oC+iR6rAO+QRwPXXwLYJEw6LBoE/b4bU8OzKUAFY+wQ+2AlAm3GBZI+yUV88P2J
         Z7wW0u1fdyHBA7yIS3M7KyBejwiaTGVv33nHqRKgdfTVL6vXPwDsgzVfhfx2qWHufj9B
         TvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+nyHLvIgRhZi9ZIMK91ORSbKEPS/kPb51jtOqSPCci8=;
        b=YgToe/yRft9t1NQgXmbBH65M/snjtjTGbXFZlHcidxRvjXHbAf9YSGLTtZJaymYN/4
         uRNABLtnqAMIrTuLPhPiTBwiCqRutesngzb8J91xsSn8EnR/k8BOEAI3xxkiCrqOwkNa
         RyiKvQRlOe92BeWv1+1r8TLkB//M2zGLxLBK97LV3bBcBe7agUhY2Y8H0NkqorSDi4Wr
         zpoxK80cG6869BiEbwsSCHc5ZOGw9QVlqO78kFtOjmVwGcJQGcZyDjv22EWCFxnw7EaI
         TBrrGmRVvPf6Wp9xu6JySXVzWU2Ygt/CZutw+x5+KU5EjLwUqs7B3uFJnDBf3MyxDCzb
         jn5A==
X-Gm-Message-State: AD7BkJLuv4dzeyWVRNkhaqi6u2mugsOPzAi+33M3BabHORHY9FaHSPVUjVkwNFRMckpr0+0IPAlTXapOHleXnw==
X-Received: by 10.31.21.4 with SMTP id 4mr2638886vkv.151.1459282591220; Tue,
 29 Mar 2016 13:16:31 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 13:16:31 -0700 (PDT)
In-Reply-To: <1459258200-32444-3-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: bFmZYCgn7WdTI8Wdg8fjjkLmhsg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290185>

On Tue, Mar 29, 2016 at 9:29 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> t/t5520: explicitly unset rebase.autostash

As with patch 1/5, this subject is written at too low a level, talking
about details of the patch rather than giving a high-level overview.
What the patch is really doing is ensuring consistent conditions
within the test even if some future change pollutes the global
configuration. Maybe:

    t5520: ensure consistent test conditions

or:

    t5520: make test expectations explicit

or something.

> Tests title suggest that tests are done with rebase.autostash unset,
> but doesn not take any action to make sure that it is indeed unset.

This is just paraphrasing my earlier review comment[1], however,
"suggest" is a weak argument for why this change is desirable. State
instead that this change ensures a consistent condition for tests in
which rebase.autostash should not be set and protects against some
future change polluting the global configuration.

> Make sure that rebase.autostash is unset by explicitly setting it.

The patch itself looks ok.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289860

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  t/t5520-pull.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 5be39df..9ee2218 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -279,6 +279,7 @@ test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
>  '
>
>  test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
> +       test_unconfig rebase.autostash &&
>         git reset --hard before-rebase &&
>         echo dirty >new_file &&
>         git add new_file &&
> @@ -307,6 +308,7 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
>  '
>
>  test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
> +       test_unconfig rebase.autostash &&
>         git reset --hard before-rebase &&
>         echo dirty >new_file &&
>         git add new_file &&
> --
> 2.7.1.340.g69eb491.dirty
