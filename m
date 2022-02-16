Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B927C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 11:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiBPLAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 06:00:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBPLAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 06:00:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5233CFDC
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:59:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so3682738eje.10
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=82lZgkXSVDPrKN2iqUQdTOC6B145Q9hGeA+wuz680mc=;
        b=bEEx8q+TrIMuvgGTPjhXgN6XtdAH/1oHicAVdVwHaHgP2oCBOr/u+yJnzla7A6E9Yg
         oyb7MFL7f6/AiAzzbnQA2dv2IwPUWfxyhoAmGb9xUYD8c1iRC7LmbYZB2xQ98GdXYugc
         VVFRY4v2PJ+vczdEFwnIcFcCYxw0cCNA99qMqU8mrZMoSE8B58Ebr7+V70FiswgHqo0a
         3LaNwKfzLmN/QCQi7ydN1Ocgzc4Gud6JIpFWxQmDXEd2nj8HGwuUGOuxcXwJhSsz5Euu
         IjGePLA84rA3jkkG/Fe4DHSmBwDl3m2BP2TPC8aqKghrHZ1TdfektwznSHA8mMGG0keq
         Ur/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=82lZgkXSVDPrKN2iqUQdTOC6B145Q9hGeA+wuz680mc=;
        b=XdLa9Mr1nPnIsqK2z3DQ0gPNLN04N4Bgd/VItXArSP23YKTwKMyEB6x8JnWw5iwdrh
         UdIEa6iLydHzzWIRAc6q5jail+OLx5Q497X5R5+dpBRAXI8QrrSh8iPGBwTbSl5eGtuW
         51k0WFS+D4FqfBLiwVhTaMP2LFUdRGg42y0NJ5S9OudzSDBsBGk4A6DJf39AK4qPEFUr
         J6x4wuiRxrrc7K97R39WnJ2MibyZfES1ya3qn1cHlvwP8zbOha1sAyHsuMxOZbRrfZ2A
         7Ufr6Hc/XBw6wqQAmxA0F44KSfhN6ona7wmiJU8DCfccEBh0y6kpOF1jhlYHlNZIj8o8
         p3ng==
X-Gm-Message-State: AOAM533PlqHodolEr17rO3/jY+T7HBDFgWkBiBmoDcqfJx5bWNdWQSPX
        chf0AtxjNhO/6lvBQtMMDJYKOtGJsG6NBCJ//RBnhez1akM=
X-Google-Smtp-Source: ABdhPJxIjN8TdBTIqC3PJ0Cevd5sukIOhwWOQXJBZOQWIEPLK2zA7OYrBCEd0Nct976oGXPjIVz3pxFsK5GggI5KyTw=
X-Received: by 2002:a17:906:3ad3:b0:6cd:382b:86e5 with SMTP id
 z19-20020a1709063ad300b006cd382b86e5mr1752836ejd.145.1645009196556; Wed, 16
 Feb 2022 02:59:56 -0800 (PST)
MIME-Version: 1.0
From:   Doppo Sekino <doppo.sekino@gmail.com>
Date:   Wed, 16 Feb 2022 19:59:45 +0900
Message-ID: <CAKg9Jn92h2PtiAtB2xt2XDPCHCQm+yW4Y7Puw_8dn38aRJCe+w@mail.gmail.com>
Subject: =?UTF-8?Q?=E3=80=90_I_WANT_TO_CONTRIBUTE_=E3=80=91by_Doppo_Sekino?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community staff

Hello, I'm a Japanese Software Engineer, and I love Git.
Today, I have a question about contributing to the Git Book of Japanease.
URL: https://git-scm.com/book/ja/v2

In the first place, can I contribute to the Git book ?
If I can't contribute, I want to only share existing problems.
If I can contribute to the Git book, could you tell me how to do it ?

Git Book of Japanese for website, there are strange links.
For example, This page.
URL: https://git-scm.com/book/ja/v2/%E4%BD%BF%E3%81%84%E5%A7%8B%E3%82%81%E3%82%8B-Git%E3%81%AE%E5%9F%BA%E6%9C%AC

When you click the link, it returns a 404 page.
I think it is not expected behavior. I want to fix this problem.

Thank you.

Bset regards,

Doppo Sekino
Twitter: @Doppo1033 ( https://twitter.com/Doppo1033 )
Github ID: Doppon ( https://github.com/Doppon )
