Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B111F424
	for <e@80x24.org>; Wed,  9 May 2018 17:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935153AbeEIRyy (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:54:54 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35848 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbeEIRyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:54:51 -0400
Received: by mail-ot0-f196.google.com with SMTP id m11-v6so34958427otf.3
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kWP6sMUkjZ9EjG2XBbgea2bASXKKcr1uA3YTT9rTjyc=;
        b=as+1hQUazSpfs4szk1doRNccny0Mor/pMIrgbtWXfEQFuLkn/StimhTc4e8L+/29i7
         QrHFMG6kjlFoMXy1tV8IIFu1dMKFO12cBoyJz7SLJwckz0N3ytojbXNB98zVcLWEm17+
         MXNat/ylPzVomtKAlOcIsuw/Jcnoql5ynPYcP5d4G7PGyBvbkb+6VgY2vp1i8ccyVbSu
         bHQNrNUWLDQHSGcer1Xw8XzQEZf/NvvmXp8RfSQJSganjfVFoSwjKvgyneVkB4y2xTcD
         unFiENVS+/n8l8AG9Z7QYWqRn2e70is9mdduAfbyF0xlmVhIXY/IWmTwFUGzXNYocAnW
         gssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kWP6sMUkjZ9EjG2XBbgea2bASXKKcr1uA3YTT9rTjyc=;
        b=FjgbVKcu/TDGxEicYPeLIh6WYssTU7trN/G/sp2igF/vWW1C8u2LKZhgmY86JCdBby
         uUnFEa2KgenaseyjVzo0oDIfZoBthjJzPBSy5bQymeB89M7M2y9qtAbuy/v44oOktg5r
         CCRmEtCrwN573wmU1gXLXiieH79wO7XdluH2mWFmwtI4U2/mY3zT02HHjnaXnP/bTLTL
         UsimYITmZt9VBS3D5JLtspV03Xiz87cS1cuFtSZjOj1YmOBeCv8dX7Uo+uP1+zWhnZuW
         pLwStc0GZ7kIC5MjNTtF7T0Glu5JpZyM4sqOSZYgqJSjSvtNvhDkwh7Q9xG8o0BJ6Rz4
         TZdw==
X-Gm-Message-State: ALQs6tDSzufbbN2RPsYtjb1+39htpHgC9w5p8xLEOjgwmqjN7HTuXmUf
        IRREXAwP5F/QQsVOqV8YyG8y9Z7jVzYysOCXDPY=
X-Google-Smtp-Source: AB8JxZrVpx9Ehcmvty5WNNx6TL6n/vhYGs/qBh0w0Kp7hCMjmq25mB+dT1Kp/S5C72CyqtGxHVOglMfilwQnOnJRBl0=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr35130406otb.152.1525888491227;
 Wed, 09 May 2018 10:54:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 10:54:20 -0700 (PDT)
In-Reply-To: <CABPp-BHGLkEnYaR2rQqLRSraMgxW7E=fmS1=bGTVeSi2VrPKcw@mail.gmail.com>
References: <20180509170409.13666-1-pclouds@gmail.com> <CABPp-BHGLkEnYaR2rQqLRSraMgxW7E=fmS1=bGTVeSi2VrPKcw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 19:54:20 +0200
Message-ID: <CACsJy8DFnWreLW_9xTsxJejvgXcT9EGsZ91cx7h39QpP4_p4Bw@mail.gmail.com>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 7:42 PM, Elijah Newren <newren@gmail.com> wrote:
> On Wed, May 9, 2018 at 10:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> the_repository is special. One of the special things about it is that
>> it does not allocate a new index_state object like submodules but
>> points to the global the_index variable instead. As a global variable,
>> the_index cannot be free()'d.
>>
>> Add an exception for this in repo_clear(). In the future perhaps we
>> would be able to allocate the_repository's index on heap too. Then we
>> can remove revert this.
>
> "remove revert"?

It's obvious that double negatives are below me. I'm going to the next
level with double positives! "remove" should be removed.
--=20
Duy
