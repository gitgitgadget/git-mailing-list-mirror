Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057B21F453
	for <e@80x24.org>; Thu, 14 Feb 2019 16:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408010AbfBNQid (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 11:38:33 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34568 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408001AbfBNQid (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 11:38:33 -0500
Received: by mail-vk1-f194.google.com with SMTP id y14so1545184vkd.1
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1h8hiPkAAGj2Vc91AY6EVHokRq1T9BxY4iRto4vyU2Q=;
        b=Q+mogMmkVpoZz7dKjsEJPep17zWCNZsFeL+aK7KPkGR7iaRsqNQfHojeDl6YNaWTyo
         +UgvRltN5ri6K16V6UIX44ZVEGonitUZT1qP/utuAPIlgttzVlJQdZia6kx5RpLFkxHD
         EmkG1ZOfm5Nv+NlPm/HAofe39AmBicTxNs3JUYWjc1xO8TrfR8M9KAqxM6g4FraOEoJr
         S02IXd+nkjGOl8TuISPAD4eTVg++XpB0CG95HboohITfuxetwNc9bIX/VSHSyFW5Zugc
         pR0m9v1XfJZR42ZZWh6M+KOk8eahVuAJ+Aws5tcweMHfmHKwdImiAFrTg5MmKYS9gVzF
         tA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1h8hiPkAAGj2Vc91AY6EVHokRq1T9BxY4iRto4vyU2Q=;
        b=VPARDZDhLd+HXqmJNVThM8xCuxF3SX/Ajo7P75TRlxz47rH2+Te0n9RQevOEJC6Yxo
         jIT6kp8QDzr8fF3EZCicKc9cLKmAZ9IiYyW0I1rbcyrzVt4KNdqrjuZZKX3r5V6sfHs6
         lC8IQA2wDBoFVDL7DNrQgpH3qLCJkDQwNU0Kx4ooE2es3ws+MfwCAuqpbDxKys+HsEzg
         CGL4YvdRGhlhC+aSS+NjoOmBSYp25y1Qldsj1a2YSI2YRtzqTWZibpOvGBou+xzKT9j7
         GQdfqaXIVg84C65d/2dqwlOV8Bx+Z03ZDs4UPwrcvNhCu8Rw38b/4/md3gd55OPkghlO
         RG7g==
X-Gm-Message-State: AHQUAuZaAQtqyyYW2Nj7KccJWLONvHjbVRvcy/1c7pAiL2n7i9ZRn4bT
        34H2T3ypx6fCFHGykp0ACJ7oizbEpsn4vnqdC4Af3O1nrMs=
X-Google-Smtp-Source: AHgI3Ib2ONfspM/DhMgZ6J0PrhaXo7XNXC3sK8W3bpdKDWyVE8YMovpFeI6+24eeSMJ72L3mjkJaeC3ucYFBGE3otBY=
X-Received: by 2002:a1f:a28a:: with SMTP id l132mr2396732vke.37.1550162312544;
 Thu, 14 Feb 2019 08:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20190213234433.31597-1-emilio@crisal.io>
In-Reply-To: <20190213234433.31597-1-emilio@crisal.io>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 Feb 2019 08:38:20 -0800
Message-ID: <CABPp-BFLW5mgPH_Ui3+HGToBtS8eHiAcJ54231_rZ-qC6rOj2g@mail.gmail.com>
Subject: Re: [PATCH] docs/git-rebase: Remove redundant entry in incompatible
 options list.
To:     =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 7:55 AM Emilio Cobos =C3=81lvarez <emilio@crisal.io=
> wrote:
>
> The --autosquash option is implied by the earlier --[no-]autosquash
> entry in the list.
>
> Signed-off-by: Emilio Cobos =C3=81lvarez <emilio@crisal.io>
> ---
>  Documentation/git-rebase.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index daa16403ec..daeaa1d0c7 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -529,7 +529,6 @@ are incompatible with the following options:
>   * --interactive
>   * --exec
>   * --keep-empty
> - * --autosquash
>   * --edit-todo
>   * --root when used in combination with --onto
>
> --
> 2.20.1

Oops; thanks for catching my mistake.

Reviewed-by: Elijah Newren <newren@gmail.com>
