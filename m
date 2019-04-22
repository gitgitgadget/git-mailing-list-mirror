Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECB11F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 10:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfDVKAL (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 06:00:11 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39128 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVKAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 06:00:10 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so17346817ita.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/dyyl3gPCaBzDe8rPJyAb38SeSM1SUpvcQ1OYwPEzA=;
        b=XIC6bQAlQR5d8nzGuKQLRAJMY4knUmkiTPOZzHqhwysvzw+1GVt2a1I7CUzzJxS8BC
         SvC3tt+xCmVuIBKO/gmFfRFkDTnTQnZUotLD63LtdF2thh/bhh8w3jvphv256e+IBRfZ
         ptugn12IGQeR5VXRfpuq1BU0ECXWrzbjdP8A9crX85K4BLX1JEYXTKOh3DjQawiF5isX
         x9MQvTYoiPJA3W1inonEmq7w+QdJI072PSQdfV7jGik357HzMfwXIGMUof9XcgWGQmdB
         I0QLyd4gqHR5w79FLeLc8Gd3kCTPdZ2H4KLYIt1eNyGzSUUbI+7C/0kJS8OtltWwl3x1
         yxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/dyyl3gPCaBzDe8rPJyAb38SeSM1SUpvcQ1OYwPEzA=;
        b=fdZLq7yaVVtfq8sScAiOZ0oHTeae+peBNBIS58/1N1EomD1IsMFD0cfEgduHf9I88T
         e73lOwwQckI6RrnL9jl2Ttii7F6xNmkA2xm6cqQMenDJ/oEmiDSHO5kUPuoNteZCBW4A
         X3rEfMTd6ZKnFygiJVOOHg7qnNkd0PRbDM/P0eXanHTCrfE8tUYEk6A4zI+HPx4tuE8u
         gJQ8EP77NJVj722XI4zzgGMJCNAQDaRLBNYRqWvqGEWzsvLPdWtDsdTv3CkHN0c7kBWx
         Q0EaKZrfCMOrxfY4tleEVhab92QR5mW+QPPuoLG4B3oRqb5qTRYl528Vg6UMCvk3FcHQ
         +Nig==
X-Gm-Message-State: APjAAAVuibmck5GnkxwM28PkhmUs2KPwM1yna/WM7fhWctszJn6Mu4Gv
        62TtJQjuX+gNjgRIuIyVA19WWrbLiBksX2r30+U=
X-Google-Smtp-Source: APXvYqxq3pZz3TafXjj2vtdeFvf9tUWmEC/+qI+QyaWVuoAoUqC75QCL8AqGQnvWSbV4xUVuyB22EAtBQjgGe+MLIWk=
X-Received: by 2002:a02:c64a:: with SMTP id k10mr6129647jan.30.1555927209886;
 Mon, 22 Apr 2019 03:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
In-Reply-To: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Apr 2019 16:59:43 +0700
Message-ID: <CACsJy8DB3k=9PaQT4CBz-K3=yjQ1oJAtz6p00PAOjy047XvAyA@mail.gmail.com>
Subject: Re: [PATCH] revisions.txt: mention <rev>~ form
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 1:14 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> In revisions.txt, the '<rev>^' form is mentioned but the '<rev>~' form
> is missing. Although both forms are essentially equivalent (they each
> get the first parent of the specified revision), we should mention the
> latter for completeness. Make this change.

Do we really support this, or is it a bug in rev parsing code that
treats <rev>~ like <rev>~1?

Hmm.. digging... ah 621ff67594 (rev-parse: fix meaning of rev~ vs
rev~0., 2008-03-14) at least it's not an unintended bahaviour.
-- 
Duy
