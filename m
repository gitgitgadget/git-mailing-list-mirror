Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBB21F403
	for <e@80x24.org>; Sat,  9 Jun 2018 20:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeFIUEd (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 16:04:33 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37994 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753449AbeFIUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 16:04:32 -0400
Received: by mail-vk0-f67.google.com with SMTP id b77-v6so10181307vkb.5
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eaT5NKZoDRsDhOJMJe4fi5pvAupPOaNoNuID6UAusq0=;
        b=YDV1Xk1R+5bf7MhllB6T2RehVw3Ak9vL2EYnDThuucE/0Szze00GqvjCzMb5LGyzkP
         p45UYYsue3VPQjm8N4Nza5Ky9zjExnSL3/ttudCYqNppO4x+lUuvWpnJGMLWHqdniZ1+
         cN4kLplamhLqsTrYCz5tXe1MSHyRP8rlfl3e5epIbBs8AqtxNYJoKYlQHabB5Jr72JWr
         XYllyuYMVUTC3yDAEi7QQn5VY0FXXrttSiRU9PxkvGwB4qbOTPfEP33MpS+/FlyKCSd1
         MikFYWbWMRMyJ+elvioSrkzk45CbwZrKkaUA4/P4zwK8B5EqUTsU1p85qLw4aHe7qBv/
         4DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=eaT5NKZoDRsDhOJMJe4fi5pvAupPOaNoNuID6UAusq0=;
        b=UTwg5GfT5zYxsBmE2ro0pibNajnHK2kQJhSvGwFDHeN2Q6L/d2LRorCWajQ82hhGcr
         vh+UTDKhSswY32h/y+slB9wgmq/M4AYiuCtsSZiBKxUkgWJrHzw7iuHMh/MZloIBcydF
         Cy3n741FHE7Q92emQH2TdSmH9eWkJgmiiiiryiIx062bGRmEzC3owU6NP1A5vXGMn8Ob
         SZ93GDA22JDNbbD4JqiJib7B9912IxeE9YHAjAuJTRVt8cK7Kp34zJVjVpF9xh2AQBDY
         yOzdaUrp0ngS2lIUKGmgdnGl+gy6cRS2q9Ml9C4EeVom2m8MKlzAizUH2Q8ptZgRpNvZ
         r6rg==
X-Gm-Message-State: APt69E36RzleeEOSrJH9SMFekird/pcTXgDhI5QNqvux4rp+6Thbp+wt
        6/b+2b7iI/L/cQedDK6OcOHYPfHoz2J/b5y2l0c=
X-Google-Smtp-Source: ADUXVKJwf5UoEk1QO/QeIqk1qcPuGi2hgFC/K/kKmm8NyfC4fjdgKx1WcE0pF03Qonv5GCkC8M//HXXLIeWyWmBSd4s=
X-Received: by 2002:a1f:4e81:: with SMTP id c123-v6mr6440634vkb.184.1528574671431;
 Sat, 09 Jun 2018 13:04:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 13:04:30 -0700 (PDT)
In-Reply-To: <20180609190154.yl4ig6dxfihgm5qi@christoph-lap>
References: <20180609190154.yl4ig6dxfihgm5qi@christoph-lap>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 13:04:30 -0700
Message-ID: <CABPp-BG9HQ4O8h7-b4oL7KLu+boe6-QV1fvcfW_4O3Rax3W_Hw@mail.gmail.com>
Subject: Re: Why is there no force pull?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 12:01 PM, Christoph B=C3=B6hmwalder
<christoph@boehmwalder.at> wrote:
> Hi,
>
> Since this is a use case that actually comes up quite often in
> day-to-day use, especially among git beginners, I was wondering: is
> there a specific reason why a command like "fetch changes from remote,
> overwriting everything in my current working directory including all
> commits I've made" doesn't exist? Now, I'm quite aware that something
> like
>
>     $ git fetch origin/branch
>     $ git reset --hard origin/branch
>
> will do the trick just fine, but (like I mentioned, especially for
> beginners) this kind of seems like a crook. Why not have a single
> command for accomplishing this? Afterall we do have a `--force` flag on
> `git push`, which practically does the same thing in reverse.
>
> Just reaching out to get some input on this, as it seems like a quite
> curious inconsistency to me.

Upon reading the subject and before reading the body, I assumed you
were going to ask for a 'git pull --force' that would throw away
*uncommitted* changes (i.e. do a 'git reset --hard HEAD' before the
rest of the pull).  But then you asked for both uncommitted and
committed changes to be thrown away.  That difference isn't something
you have to consider with a push.

That might be a reason such an option would be confusing, or it might
just be a warning to document the option carefully.  Anyway, thought
I'd mention it.
