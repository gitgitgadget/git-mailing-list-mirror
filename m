Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5638D1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeCZVEp (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:04:45 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:45061 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZVEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:04:44 -0400
Received: by mail-yw0-f169.google.com with SMTP id r29so6576306ywa.12
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/9qeeEkXP20gDjUvwMAHxtp0gczqukOXChE4DWRXNVI=;
        b=UeNfOGaaswQauhxycEPpCY9zxA9VPhPGcECM0igMZoUWycmGUq99CBdcDaKZGK/iED
         jvKpy+PUt2Wz5jT0pQ1uhvAo4s20syP74d8FdoGPDwKXKJYtrnnOa5KP2h+xcDYAD8YO
         UuQ5KHXYdSjGkDguz1bO4T/xWWJvrYhMhBj/PzuO4/01SUBfopmYyMVyTnxw8OQ11Vme
         kucUIr/pnkNt2UvNoyz3FljWgna+GbVUbFL18S9mfcUpe6Rj9AyNtq0JGrrs6btv8q3Q
         VZ80YVvUWfcXzum8M4Xu+jFg5HI2J6X+OsatCsdUqnZJgjANGbCsZIwDqQb3w+UpGd1m
         li5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/9qeeEkXP20gDjUvwMAHxtp0gczqukOXChE4DWRXNVI=;
        b=q0OylpwTB6aBkQ13IKLsa2gjElryiFjbAmQkXklDqnuLN3EKx4PU+/Nbd7maLvCV5f
         9Au1GkGRTkTPbxUHO6JhVszBvlumk63fD6PeZj/AlO0m/R8mg+jSUOdlVwze6bjKEis+
         gw1soYebQJYkvlwfQ2QzYy2tedNOH6ywvkmgUJpg8VNrNW1zF9I49HoFSTnhBG7pfUfU
         qPTWBIsnWcGJbfRkoJIcDSVKdOz5Rt/KMOW5GqWSeXYkX9T6GpaC+CZOR9l7mYOuXcV2
         BXdrv+hT0qvlefYw1laNIHKzz5ilJZkH7zWt3mdsflqmVM6P++8BgoN9omBgrYdqplE0
         ls3g==
X-Gm-Message-State: AElRT7HPeuAAwBBJnj0BGHDh5pmbErYfyZ7Wp3uO9q1fNUsckA9LN9Hn
        q8ezdEX6m8VVIzogCWtJ/B8/FBx48PzQEQXnw5iodg==
X-Google-Smtp-Source: AG47ELsWu0ic1x9g/S+HZLdyV57gfUu5WX143u3pUD5oPAfYGw3K+mG36AiXEAzGygV1/7t6zAKpDlKBuW5/2Xfwf6Q=
X-Received: by 10.129.159.195 with SMTP id w186mr24323762ywg.414.1522098283495;
 Mon, 26 Mar 2018 14:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180303113637.26518-1-pclouds@gmail.com> <20180323155523.22269-1-pclouds@gmail.com>
 <20180323155523.22269-2-pclouds@gmail.com>
In-Reply-To: <20180323155523.22269-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 21:04:33 +0000
Message-ID: <CAGZ79ka0ptbwHU0Ym7aGm86o+YG27goHR6iS3uf5yUkj0Uj15w@mail.gmail.com>
Subject: Re: [PATCH 1/1] repository.h: add comment and clarify repo_set_gitdir
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 8:55 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com>
wrote:

> The argument name "optional" may mislead the reader to think this
> option could be NULL. But it can't be. While at there, document a bit
> more about struct set_gitdir_args.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

Reviewed-by: Stefan Beller <sbeller@google.com>
