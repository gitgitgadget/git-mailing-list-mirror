Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D0020A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 23:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeLJXsI (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 18:48:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43068 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJXsI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 18:48:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so14455848qtj.10
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 15:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D121ZB5qXJD9EPHmG/dpnGuixTVKicynwjWSaACM3CA=;
        b=N3kWzDSqsOyXFLnisubRYJ+z+p2lhjtaa9ERZfxWguzmdPJficq8arOLYwZiAAmBEe
         sI0nWudMs8EjddDasRm9pVxWtzfPIUUwUrf+1XiZeS8KcWiJX+bwjbz5X2Gp9CCv1KX2
         nekqfucG0cJvMW7/UhBgHMyURLZn1xcQcXJcunN+LvddJgSo/97c3XYTebJqv7sr0de7
         qzNEU/Za58XindC2d6l5ZEJdkdfRVy5flNAatBOKCTib11NhY7Ra+OaOrcvUMrZhWawI
         yJh+p1XGH+PUTxKO6Jnp/Icj/21V95c3f2NePBQ2FZrUrykTdni4si8ikaWQWGjuR6Fi
         W7Fw==
X-Gm-Message-State: AA+aEWYBS9lLFyf/2OaaKyfCZQycJfyyGRZIu+xqPXrWHu8UcvqyvVTp
        b+uuMLTsPeaMtwZ444qRdKByml0z3kN7ZsYfV4hsn49crZA=
X-Google-Smtp-Source: AFSGD/UUIPqgEIwEWQOqCXJmkKh0JGZUA0+Qo+KQD8Lhg9y0aR847mohp6Hc/WKpBI6yASU/dSWQAtAjJzFwjIZU/RQ=
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr13643516qtx.352.1544485686513;
 Mon, 10 Dec 2018 15:48:06 -0800 (PST)
MIME-Version: 1.0
References: <98295da2b5295795414eaf85a40b9ae62b1b2dca.1544482124.git.silvio.fricke@gmail.com>
In-Reply-To: <98295da2b5295795414eaf85a40b9ae62b1b2dca.1544482124.git.silvio.fricke@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Dec 2018 18:47:54 -0500
Message-ID: <CAPig+cQW5_9fH-P8X50Mx5kGJRwEOskw2L49Ajk+3D4xWpcOHg@mail.gmail.com>
Subject: Re: [PATCH] http: add http.version option to select http protocol version
To:     silvio.fricke@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 5:50 PM Silvio Fricke <silvio.fricke@gmail.com> wrote:
> HTTP has several protocol versions. By default, libcurl is using HTTP/2
> today and check if the remote can use this protocol variant and fall
> back to a previous version if not.
>
> Under rare conditions it is needed to switch the used protocol version
> to fight again wrongly implemented authorization mechanism like ntlm
> with gssapi on remote side.
>
> Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>

This looks very similar to [1] which is already in Junio's "next"
branch (although not yet in a released version of Git).

[1]: https://public-inbox.org/git/71f8b71b346f132d0dc9a23c9a7f2ca2cb91966f.1541735051.git.gitgitgadget@gmail.com/
