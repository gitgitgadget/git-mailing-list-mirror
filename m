From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] t/t5520: change rebase.autoStash to rebase.autostash
Date: Tue, 29 Mar 2016 16:06:09 -0400
Message-ID: <CAPig+cRv98OSAt1RVUV9CuqQwJ75U+FF8+t7wxQ-ih=V5yi+jw@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-2-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:10:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzuH-0008Mh-8c
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbcC2UGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:06:12 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36076 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbcC2UGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:06:10 -0400
Received: by mail-vk0-f68.google.com with SMTP id z68so3736897vkg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=rZF4I5dTyHIYsIYDZLPyuBq5fsu6LXzzrhb9iML7c44=;
        b=K/5JBbcXbrGoAIY9BQP0hYCoK7zJ3N5JyYVQ9/vig+5RxxL5gJUha20ZLiOQd/nevd
         j29/MhZFNLpNZoWQOY1aC7AR6kWiThjKICGEG9imwxfSTW3+cJkJqRFJiJ71PGW+/CQQ
         4UGR8Nuzguj3Y/XSTmXIot9WN5PaDkC/4uA84eJEKMdnenHPaX8+XQDXp85V5z18A0eq
         NgMRciES/kIvw3RLRAD/5jWSRqndvt+AyEVhKHtvLPie7w7c1PsoX8ZbgLvefplPwvLM
         aFeDKnmIXNE8578vZrlynq7JxB2ia5oNXI3R0QfyLS1NUVjmFTp0dP53VUsejI8tu2fk
         ZKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rZF4I5dTyHIYsIYDZLPyuBq5fsu6LXzzrhb9iML7c44=;
        b=O9PaV9uD7LL8zM/YifqAd7fc758dQUKUy0ET798WyhqlSwEQa4479W7j2KqZxt16My
         aO2y3B3vy8gBpAE87gCG4N0YWIse0yBLz0OlZmFY+c8EVi6clSQDyYtYOPhwNIZDWlNz
         2p4HtNZ3beok6OemfFDeYJmoOgRtAq4sCblYn8P5evMIgFQeN9ld1ab9kauP117eRw8j
         DerzbfyO+RdLO3/jHMWb7Wxe5GGSjTzTr7LvUo2lgu6Vl8YSF/pM887hP0Uronh3sCSq
         V55neNuE+7h1UN1FHwk92JK9SVzjru/rFQ+Y+BZWt/v9Nc3briqmYX489tQs35EgyadM
         NMJg==
X-Gm-Message-State: AD7BkJJN8OreP0ouyTRxFvt9kScb5MdtCCdm7czhuUK/Urjx6jITBgjtyw6dTSsrHU/1VlHTMqiqQT8ToO4qgw==
X-Received: by 10.31.150.76 with SMTP id y73mr2661695vkd.84.1459281969197;
 Tue, 29 Mar 2016 13:06:09 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 13:06:09 -0700 (PDT)
In-Reply-To: <1459258200-32444-2-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: jqhB5MSPIXWYz_m69P4pl8248ZU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290180>

On Tue, Mar 29, 2016 at 9:29 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> t/t5520: change rebase.autoStash to rebase.autostash

This subject is written at too low a level, talking about details of
the patch rather than giving a high-level overview. A further
shortcoming is that there's no explanation of *why* this change is
desirable. Here's an attempt which addresses both problems.

    t5520: use consistent capitalization in test titles

(Note that I dropped the leading "t/" since it's implied.)

The patch itself is fine.

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  t/t5520-pull.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 745e59e..5be39df 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -267,7 +267,7 @@ test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
>         test "$(cat file)" = "modified again"
>  '
>
> -test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
> +test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
>         test_config rebase.autostash false &&
>         git reset --hard before-rebase &&
>         echo dirty >new_file &&
> @@ -278,7 +278,7 @@ test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
>         test "$(cat file)" = "modified again"
>  '
>
> -test_expect_success 'pull --rebase: --autostash & rebase.autoStash unset' '
> +test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
>         git reset --hard before-rebase &&
>         echo dirty >new_file &&
>         git add new_file &&
> --
> 2.7.1.340.g69eb491.dirty
