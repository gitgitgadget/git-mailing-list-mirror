Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956EB1F45F
	for <e@80x24.org>; Sat,  4 May 2019 09:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfEDJBB (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 May 2019 05:01:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55251 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfEDJBB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 May 2019 05:01:01 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so13099188ite.4
        for <git@vger.kernel.org>; Sat, 04 May 2019 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neuxpower-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7GElYr5N61SMtDkl0MkmkQnm6DSfLZMnNm7/+/nxHAA=;
        b=hhKyEibFkLn5tZYfHjBXr8Pz3LpcnKo2rA2vl+AVbBsAIigEY8GrzL8WgYioGW3kQ4
         O7IoHQOTyte5MMYcN4h5pIrp5HlvS3BNkKkBSZaZR/fXa1CMyz/RGZ2jgASKd2r4weWU
         ZpP5QiPARuLG/dfHw/zaU/h01Q6/zRuQteAZL7cS9ZQ+S1Yxjw6Vc6v2iwJgb0ppTB/q
         x4sJ3sKPQGyGzeILy/hx9p6BCXjlNWJBSwsnRWRlauAi6NCjwr5wuvrva3D0Ia14Rv0J
         82U6oIXqaLUo/vGzmcmfqYKIhHNFnU7v81vv6m1yhHWzY8CcLgjO7A4GBWEySbhsvQGB
         8Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7GElYr5N61SMtDkl0MkmkQnm6DSfLZMnNm7/+/nxHAA=;
        b=kekwNvkkX2bPT3TirG4cdh9dqz6hiz0oigjzzPIQKFneG8bQm1JR77+6CNVO2EodKi
         QbXTHtLFjpIWJPafFqe72KWzDoGv0XNv1LgdZzZTEb0Ng+HNIy1S3x+/Eg+HOvdLHf9q
         GmJNjjpESBi7wmaqR5zniRpbm0s0ztT9Pw6X0JKcJf5MoXbw/v5rTcFHu3/3Ur9WjZBu
         ynXaoqKLp7fCBv7Ge/Zjp/OHxfmjmEENoAxbK47KXlgAis3Bn54/sfEzFN1dDK9Glmkl
         JI8Yt97nvTl3kX0zjHHrnW5iVqW+pOIlj4JBlLoBC7Xcg27SWRAQG6bTz6CTBUnDKj9N
         FRFw==
X-Gm-Message-State: APjAAAWxRP4CFfHAAfjRniEOJTeBfffOJVhbJTB8nvHPNuaou+MB7dUK
        pfypMdj5ZaTb/Gc23QZlgASgH62J4iowCllb7ULWaA==
X-Google-Smtp-Source: APXvYqwXB0chGXTjm20HR9zrt+/dnwL/Xx2UDcXsFTlVrpRLGqn0eQe9vNJjwJht9HdCx6HqD/J9iDCF4LdBlTfsepo=
X-Received: by 2002:a24:de54:: with SMTP id d81mr989897itg.125.1556960460475;
 Sat, 04 May 2019 02:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190503140952.9029-1-andrew.molyneux@neuxpower.com> <20190503170148.km4ftgg6gbgzd6pn@tb-raspi4>
In-Reply-To: <20190503170148.km4ftgg6gbgzd6pn@tb-raspi4>
From:   Andrew Molyneux <andrew.molyneux@neuxpower.com>
Date:   Sat, 4 May 2019 10:00:50 +0100
Message-ID: <CAJzfGS_9qUBbOEjEZxSJdRTJfVBowghM=c1Zn0oh9j03LPhpCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc/gitattributes: fix typo (UTF-16LE-BOM)
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 May 2019 at 18:01, Torsten B=C3=B6gershausen <tboegi@web.de> wrot=
e:
[snip]
> I think that patch 1/2  is in upstream Git,
> and even in git-for-windows/master - on which codebase are you ?
>
Sorry, it's my first time submitting a patch, so I'm probably somewhat
incompetent :D
I was trying to follow the instructions in
git/Documentation/SubmittingPatches and based my patches on the
"maint" branch from https://github.com/git/git.git.

- Andrew
