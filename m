Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4D01F404
	for <e@80x24.org>; Sun, 18 Feb 2018 22:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbeBRWf1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Feb 2018 17:35:27 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33458 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeBRWf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Feb 2018 17:35:26 -0500
Received: by mail-io0-f181.google.com with SMTP id n7so9489633iob.0
        for <git@vger.kernel.org>; Sun, 18 Feb 2018 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GZVW91mBzMXc3UjfNLp779CdWLoGW8qPCTcGLmV1wGI=;
        b=UN8MIU6NU78B1AQgHSrxfvEVuEi35ePPQHQfMT0r3L5YDJEPDqAAERhVaNZJKOFD4M
         EIG1ILWIrsVO7Lnyy8AJI8UJiFrcVAfy1PINzg4aRU0n9vfF0/BDlRHrdX05D9BgMrGB
         vob2OlsO3kptbZLnITck30shf7lY8c8APariU1I5Qfmffm+xagJbwJtGLrNz+4bLEvj3
         yhbhlvFiGeIwFueIkMTNEcxhdL+joxpvFmzCC9tKj6gOXFYE9SY0mEzwoWLOtfSjQ02W
         eopNTgoOHVPJGNJ1lZ5vq4glfIHRe4AZY1pLGqwTz/jQcuxtI/cP96sd/KC5DdRNxTlD
         s0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GZVW91mBzMXc3UjfNLp779CdWLoGW8qPCTcGLmV1wGI=;
        b=YyVjCp5Ct+Q4u+MipbBBlUCuoKNLbWrqABb6ZSYmIVnATiXSgrsk36cRE2HuVT3zFF
         B4Y1/PBFkcuZ/Hj7Ql4ycSAWzSYPOOeOykpCQSBLpFVH0hpy3Fyvz8K7dpxqZamdCgF/
         4MF0JXTI/BeMnoR9FGd6lcHaneb3xwxyC5CJrK+uxOblShc0+otxLGcbrSFQuyMrOO0l
         R4seTZAi74lF00Th797DTHYwopvqVEktZ25qsjoSzTMNI8JTqUKrVjJkFT2wiHGd2/xm
         tFEc0W2M8X2x0yqaBj9oODQfdW+/nuPvHWkT6JT4xbOM955PSMM0ufmfbBtkJPwwFiL/
         mwKg==
X-Gm-Message-State: APf1xPCRhQGaUlCkjOcVOLTkNUMaqxYqCMbe+6IKTc6YphhF3Y+X7uIo
        uG88/L2DzcswBwbyocr2ZrYW4zwzxiVC1P53eNe2pLBk
X-Google-Smtp-Source: AH8x2265sHcWGIfQanS66m2zZ8QWobNkLkE/k9Fk3xPW0YqwWJv/Z7Y4hRmNITYzgNRqOAdNe1R60VzXu4IzkGMP1Qg=
X-Received: by 10.107.144.197 with SMTP id s188mr17111853iod.53.1518993325187;
 Sun, 18 Feb 2018 14:35:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.150.157 with HTTP; Sun, 18 Feb 2018 14:35:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 18 Feb 2018 23:35:24 +0100
Message-ID: <CAP8UFD0Qqf23Ya3BP4oL641G+EsZ9pP17iKpSEV4JFsEbEPPKQ@mail.gmail.com>
Subject: GSoC 2018: Git has been accepted as a mentor organization!
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just a quick message to let everyone know that Git has been accepted
as a mentor organization for the Google Summer of Code 2018.

If anyone wants to mentor or co-mentor, that is still possible. Just
let us know so that we can invite you to register on the GSoC web
site.

Dscho, I just sent you an invite as a mentor, as I think you said you
are ok to mentor.

Best,
Christian.
