Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74F01F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeFCIrl (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:47:41 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39831 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCIrl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:47:41 -0400
Received: by mail-yb0-f194.google.com with SMTP id m137-v6so7792826ybm.6
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=sULYoVF//d5NAIoqxcmHxOxaIwcjFdlKFuXpS89yd2Q=;
        b=GuNlB6AIXZsBiAmQJu1EKf+2a3vhUdt3kaDBSWWCdStqWyLKvMJEAytnXKJgLAnVmp
         SKrQZyVWd+tuI8Upexj4qqOYHpQJzZR6Gg0PLsv8qqaw1NG6u3uMBxMqEH4DH952GB0r
         P4hwDWO8/N3nbpYNiRrre4BWW7SqAOCLLCaTtNLb1Riame1jnAtawDA1yVqA7Cd2eFdC
         DnUPO4+vtOyKWDtdmniD4lcm+RYLkk8cc5YVH7aOX5kbNhTsbtGI/NMmZXxac6pliFxf
         7onIvcVF3P2ObCmZJHJTY3gXG+XuYS6ciDKWGxUHOl5rGtlvXooJuO6RMkJjX2YLIanP
         Gllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=sULYoVF//d5NAIoqxcmHxOxaIwcjFdlKFuXpS89yd2Q=;
        b=lFi4rQ+JJK61L11DgDMtQivbyogbPcN1ZKUtSBakYWPwdMQfo3ogzv7Kl/TcfJ51n4
         LA3rONKoF0N3MCpXeCkJfi5ILX+qjDEhoJfPTEQqfDCJKRPErV/txq5Zj2GEfd8SQ4h0
         ZTRLG29EHyR3VpZHOaFDqOnxJvD0XB9WRPn5wD+U1Ydlmho9mqgQQvziwOIJWO8oLuRU
         ldJ0auqg+/2CEzs3Y2RR/bY13jWJOWnrqKMI1sRIAUSRvicjZIEjnxK9+EvS3I7cV+vs
         +eRtm34HwgCGxvIsP9WdsPnm/VwtghdWUJwIjW7f9yNSX7qVb970To0jWYsQWBnZUgID
         w0WA==
X-Gm-Message-State: ALKqPwcySde+NnHZo4mMRpb+wnDM48dfTSzMORFyVw5QC4O3jbJT0Ejp
        nhH9R7pTbMFhuQI9wyccesq8+JM+fzUcHJAfcKY=
X-Google-Smtp-Source: ADUXVKIAmm3hNdONJi9WENlrO6Vv6GZIePE7CL4PPgZcegJ5Z2ExnAza2vRo+WUEe46si+cZHv+WpVaaWvtLtH8cyIs=
X-Received: by 2002:a25:d612:: with SMTP id n18-v6mr9144341ybg.12.1528015660403;
 Sun, 03 Jun 2018 01:47:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:47:40 -0700 (PDT)
In-Reply-To: <20180602043241.9941-12-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-12-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:47:40 -0400
X-Google-Sender-Auth: a3AzGcp14g0LMjQDaN5yjookVc4
Message-ID: <CAPig+cSkChhUOWO-V5FgCW+u09tVoZ_giDNNk15kP=QJhEA3zw@mail.gmail.com>
Subject: Re: [PATCH 11/22] dir.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/dir.c b/dir.c
> @@ -560,7 +560,7 @@ int report_path_error(const char *ps_matched,
> -               error("pathspec '%s' did not match any file(s) known to g=
it.",
> +               error(_("pathspec '%s' did not match any file(s) known to=
 git."),

Drop the trailing period for consistency with other messages you've changed=
.
