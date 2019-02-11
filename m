Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676681F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfBKXku (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:40:50 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42510 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfBKXkt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:40:49 -0500
Received: by mail-ed1-f49.google.com with SMTP id r15so588105eds.9
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTBsiRlVdUCFe+Ce031OyBNvMAhuVs6Z/4g0lpRsglk=;
        b=qZJh9nbTZ6DOHV11sgozdQkKwtwCRmJ+48Tv+tTCH57wXot0TUPBzQtHnmsrRvUIZz
         egNJM2OL99tHRdZmP23svuZ9VQATvF9nT37n0cFzK8MSE7tB8DZtW6mb3+WP3+qxQqY3
         nYHL2FQ09lKy3SKzE/VocH0EYJH+JcA16vI4mRvyJUY7/xtoFaVzz6bvOuty1ojfMJbj
         r+ptcsPN2mKl+NRuTPOJJlxLTn5c2pJhb9V9xRKpIMtctHoNTcRvVWl3Yap7Av+OIGRr
         fnErAM7jS/3I2aa87gJPuT4Aua1g4foRow+RVWBnGt9jSe/NKDrb194eDAag0miWTpYL
         0emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTBsiRlVdUCFe+Ce031OyBNvMAhuVs6Z/4g0lpRsglk=;
        b=QSG5YuvjoWNV9cFBGJ90mnNLmZVsU3qI1unIZl15kCPGnGLKhLYC2dFN/7nhm35Qdp
         MgslLdX+QIkYqTtms3t93dvziJzIcnOpX7td2wO/16WUD4VCDHBEAKyK9c5O6QhMJyQD
         If4DXIy+5o0N8A5JV2IhlSXFE0508+W2aSsEUxDg5M9mtbHAUyS1/jl/JXE0lAzv1YJM
         CTgk64+gd7KhTkclZSpRQEsJ7Pdir2zadIszXUU45Uojlz2NbJ30KnNznK1waKIHXEEf
         PJcQjnx0lUJi1+oJdW1EPB4Bz7Gh0nbU0sGo4cq2WgItssI39Tl9c+fUD/ENQjXE8by6
         obvg==
X-Gm-Message-State: AHQUAuYTxHaV62/zA16D2x1FKRBcMBAuJlceNQSHGWGIqI1s8N6nNba+
        U0TGx5mNE9yVHpkazSOA3uZIdVpeoRXnB0tlAYABA/Xg
X-Google-Smtp-Source: AHgI3IaAldZrxbYPD5jS+BxwxLzHkOL5IFQnMitzU87NOeEtDnXfgTxIVTfJD5MZgH5Gr4xaWYuGxzeMuebmvlX9vUA=
X-Received: by 2002:aa7:c594:: with SMTP id g20mr489294edq.79.1549928447754;
 Mon, 11 Feb 2019 15:40:47 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimxwqcqw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimxwqcqw.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Mon, 11 Feb 2019 23:40:08 +0000
Message-ID: <CACUQV58vvDzhqRrtutZMDV_Kkz137oP6rLUODaniMekfGa5gyQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2019, #02; Wed, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 7:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * du/branch-show-current (2018-10-26) 1 commit - branch: introduce
> --show-current display option
>
>  "git branch" learned a new subcommand "--show-current".
>
>  Will merge to 'next'.
>

Did something change? I may have missed it. Until last what's cooking, this=
 was
marked with:

On Tue, Feb 5, 2019 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>  I am personally not yet quite convinced if this is worth pursuing.
>

I also suggested a different implementation which simplifies it and should
remove some unreachable checks that can be seen in "Git Test Coverage Repor=
t
(Wednesday, Feb. 6)"
https://public-inbox.org/git/20181107225619.6683-1-rafa.almas@gmail.com/

I was expecting Daniels to squash these changes into his patch or for it to=
 be
dropped in favor of something else. For example adding `--list-head` instea=
d,
as discussed in early versions of this patch.
https://public-inbox.org/git/20181011223457.GB7131@rigel/

Cheers,
Rafael Ascens=C3=A3o
