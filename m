Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69E2211B3
	for <e@80x24.org>; Sun, 16 Dec 2018 23:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbeLPXgv (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 18:36:51 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:35546 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbeLPXgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 18:36:51 -0500
Received: by mail-io1-f46.google.com with SMTP id o13so8697731ioh.2
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 15:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjvFFvebTbmfjCe2PwWcjGAI9fnjrWS1Oarz4rRGq2Q=;
        b=XG4n0ugrdRojh3w2AOZNdTDW6kcYEUvdDj/YRZVQpCj2KD0+7EbESJA7wpwNipdchV
         Ntv3PSwSAXXfpA2L0WDHW5VOw9LJHtUcIhuoUTYaWYzSej8l2/xBAMrdOY4opgRUuA5F
         r5WN+bsBm6Ag32qG0y2Y84C86ydvP4F+CLIY35ODXxzMENZi29sk5VpeGmaPFxB5rUn9
         DaFe896Ypi20uR8garmGCnYeVFMYIWOpncYRqUiuKXtybbdq1/o7hMp+11E8xewYFtNN
         GA/3ban6l1IUlE4ReRJxEzMh9iyPTBFNLzfqfhpu/v57tNIALlFfHKp8xZ8otsAmcZiJ
         eFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjvFFvebTbmfjCe2PwWcjGAI9fnjrWS1Oarz4rRGq2Q=;
        b=qmvWfQss3v7dz8e3HbTgzI3NvsEijBWI0iFItx5XmiJwwiX9e6Qz5Cf7g7Dbkoz7vM
         9sMY/Qh1CikkcjCHXzUwPBfhf/PwIwjhq4xiZLZlVHc2DgbCer62EfNau1RpqFc1m84i
         hIKuFcHnCYiq/FFJNtKjuvLvaKycK6Lc06PJBdcOYl6+y87Y0GTvMp+Qr3jtpd0C/AEP
         M+edxNmoV99LJ8vMJsDRbq2JERfn61P+8VNp1jTLSAGPsbG9+kUYOkKmM4ft7W+Z3OPh
         vBc8XE+nQHoHxT4uFLidJRgMaLdda6QHxX1Cqh9TPH1x4ylzHUa13Rwop+ped3cT9Z2F
         q/ng==
X-Gm-Message-State: AA+aEWbqL9qD1Ahv8apz93AyiBi2mHzSRLWIJLwXpfITrRvYX/Y5odzu
        NOhSykCgg/c3WqO8rj7g4CjJN3HDket0UoLSoLo=
X-Google-Smtp-Source: AFSGD/Vs8hJwOGAdg7IVq0zvYUZwdwP4e/1yDNmfu2RKSPEHuyR1WhqEIqgQYaNYuNYrUFRQNdT8zYSX2DYUGfKrOXA=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr9412307iom.11.1545003410563;
 Sun, 16 Dec 2018 15:36:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
 <20181216221457.GH75890@google.com>
In-Reply-To: <20181216221457.GH75890@google.com>
From:   Farhan Khan <khanzf@gmail.com>
Date:   Sun, 16 Dec 2018 18:36:38 -0500
Message-ID: <CAFd4kYAaMLvOhR_XvwoQ=y4c6CZC=+-q5BmAXO79qTKOLNFtZg@mail.gmail.com>
Subject: Re: pack file object size question
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 5:15 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Farhan Khan wrote:
>
> > I am trying to write an implementation of "git index-pack" and having
> > a bit of trouble with understanding the ".pack" format. Specifically,
> > I am having trouble figuring out the boundary between two objects in
> > the pack file.
>
> Have you seen Documentation/technical/pack-format.txt?  If so, do you
> have ideas for improving it?
>
> Thanks,
> Jonathan

Hi Jonathan,

Yes, I have. I think the issue is, the compressed object has a fixed
size and git inflates it, then moves on to the next object. I am
trying to figure out how where it identifies the size of the object.
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
