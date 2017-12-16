Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974FF1F404
	for <e@80x24.org>; Sat, 16 Dec 2017 10:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbdLPKFe (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 05:05:34 -0500
Received: from mail-ua0-f182.google.com ([209.85.217.182]:39849 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdLPKFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 05:05:31 -0500
Received: by mail-ua0-f182.google.com with SMTP id i20so7780356uak.6
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 02:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6vhVAtvn1hMBOy0q4zUWZScQnvtzaNkmobFB2xAtYsE=;
        b=cCuywTgthZKWkGecpWFb0ISJaU36iekvKm/XInRPyiIC2xP9sYm/sUkXvCJNcadnWp
         bTmGvOaAWUNhtezjPsu7vvktvzemZCk4KFvWUPpZdnEesbDDj5V+R3UeK81QsQd05ok8
         hdi5J/UmpS1aSpwq1Az6+vlZSnuPGw70KbgrwlxO2zUMylnXSi2YDeVVupMHIUm5+wji
         PaTQNp8RFwVu79XS5TZ6cNgYn6TgQw1mkwSBtebPL2uOGTLu+KkMZu1121KfYtPY6+wI
         oz8iLVOXtnskSH4t7xjvFOvyQrn+gWYjNB6/+lVc498elkT1Q4wAS4o67dp3v6qaQDnn
         YWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6vhVAtvn1hMBOy0q4zUWZScQnvtzaNkmobFB2xAtYsE=;
        b=WMfRLnDjFBpFJvnLH+SYmVSTKWC5C8D7WSTHNoN6GvEycer+w/T+PEFk1jl1+TnV6Y
         D1RNIHlMLW7rFW+bTxNANLnZKDBT+W1Od+njABsr1Ulek5CKjfos0XAL4EuZMOp+Zn1J
         xoekCJp5pPCL0skvOFSTngpMPzAAwoJwAGnEQvxeOMYc2dTiFqB3d2/lRCaTs99Z9NAK
         B0mBwQP02vHQRZeDCJLsWOo+evx+YTn7ikYeoAJf06i+jQMVNx5RUrLJLJ+uB21MJ7L7
         eDH9BFqSq7UXkA5zk/Gn0hbIE8Dac2E8thPa5V4MFyoil58x3T7+la5PBc91Sanhq/UK
         E28A==
X-Gm-Message-State: AKGB3mJTphwZj1TcG5HoMWy1Jt46l/fZzEGYnGfurmFlLwTRf9Ovd60f
        vP9e5SlGg67AFhpjjwtouSTmmayg547rDz+1JSo=
X-Google-Smtp-Source: ACJfBouOFb4NQOYXLW/mmGJzRgS1Ixn0/JaHD2oIjWi5Dnd05m0TNhGLFmHu0PMftMK8s6KnNPpQtGB2KP5LUV97o1g=
X-Received: by 10.176.89.39 with SMTP id n36mr17827846uad.30.1513418730736;
 Sat, 16 Dec 2017 02:05:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.25 with HTTP; Sat, 16 Dec 2017 02:04:50 -0800 (PST)
In-Reply-To: <20171216094840.GA32706@sigill.intra.peff.net>
References: <CAFTSPUV1E+jCMHzx+rq9Y1agthxcYrzDVY-rThTNCG7BfnPeTg@mail.gmail.com>
 <20171216094840.GA32706@sigill.intra.peff.net>
From:   Asfand Qazi <ayqazi@gmail.com>
Date:   Sat, 16 Dec 2017 10:04:50 +0000
Message-ID: <CAFTSPUWOhyBamNEJzbSDqZW+GE38+PeW6R+DXnY77yo1dbYQ7Q@mail.gmail.com>
Subject: Re: Trying to use insteadOf trick to use different SSH keys for
 separate github accounts - not working
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks it worked! I was reading all the tutorials wrong all this time...

Regards,
     Asfand


On 16 December 2017 at 09:48, Jeff King <peff@peff.net> wrote:
> On Sat, Dec 16, 2017 at 07:50:02AM +0000, Asfand Qazi wrote:
>
>> I found out about the 'insteadOf' setting, and thought it would work.
>> So I added this to my global git config:
>>
>> [url "git@github.com:MyCompany/"]
>> insteadOf = git@work.github.com:MyCompany/
>>
>> and left the SSH hostname setting where it was. Then I tried doing:
>>
>> git clone git:github.com/MyCompany/la-repo.git
>>
>> But it won't work. With GIT_TRACE=2, I get:
>
> If I'm reading it right, you have the config backwards. You want to
> convert git@github.com from Go's invocation of Git into your special
> "work" alias. So:
>
>   [url "git@work.github.com:MyCompany/"]
>   insteadOf = "git@github.com:MyCompany/"
>
> -Peff
