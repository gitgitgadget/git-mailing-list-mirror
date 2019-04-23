Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F891F453
	for <e@80x24.org>; Tue, 23 Apr 2019 22:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfDWW3A (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:29:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41054 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfDWW27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:28:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id g6so14123920edc.8
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=x9KxXzU6yR90uWs+JT2iskAmEsL/cHh5wio1cJGEyeY=;
        b=X/JamoZTV0IjbrK6cJ/AGFYifYUSPLh4faRkddE10ZivcAIiOnAqO+cIj4RusVNSyh
         rD5xWmIZkE/+vwL5L0pKXdK2S4dR6d5cSbQ+sDcpYUCTscUxDtjAUvP9zxtkcfi6GF7A
         Va+YyRwIhChwfTCo3PqGylyyAwh/0gyBkQZ3yUQwDa6nLP8tSPZ8Sb9Y8H/0GYoLlfAB
         yHnZf/TAbYjHyq5iAF8tYNphfwbl+XBvybCxVMs74ZE3KLPZBfPE1wFk7W5NIv93b4lt
         pSF2/INrBaTNv/OnuZDKdNAauYFb1n7kKHEYY55cDKfGNuSZsFzhqVA4tCRTUk5qpyS/
         ZgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=x9KxXzU6yR90uWs+JT2iskAmEsL/cHh5wio1cJGEyeY=;
        b=gY6j/XEVjUlbVTa9Tqgq9KPCjOr6i/ufbd/Sp2jz6y5o5ArlnXLHjCKFLuBORqpkjd
         B4AVAJhT7IuzipgqKnfGJR1mzGzrznTsW7TEOfJR9Rc6BXQMX/FVfosHQAqhkaympNTV
         jRJEIqEKRJlj2wWl3Z8APYoG65LqkKlEcZtRqCkeKNJZyAg4SBVHHRWQlL8oCdPOTjde
         ODNcc0SLSGHNyny0iOJ/uJ2TIfiOwgVP5O4ukI5ka8o3ESH7ArdvMTKdC5f4dUfpX9Vy
         SbgRQAQC5KauQpSq4P8RDsmgGP7CjB2H5GcrwHTbjtp/HhfkM0GLsILdkPwptR58MEpj
         v8ag==
X-Gm-Message-State: APjAAAUEpgrrfEuoaBMbmPHgAbQIUvu+B4ftRl4wjuYxAwae2dgyJduz
        acx35T+h0lSOhoy1hSGczjBSStsHwwCmEd1Uq5iuHIpE
X-Google-Smtp-Source: APXvYqxs892ULcg9YGq+3OxOXp6DnPr4R7b5D0ri/BAJMTLdxQiuY+UEET42ti2nZ1hpXOlFWfTKe+apD4+rBvvrb/U=
X-Received: by 2002:a17:906:8419:: with SMTP id n25mr8921831ejx.288.1556058537509;
 Tue, 23 Apr 2019 15:28:57 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 24 Apr 2019 00:28:46 +0200
Message-ID: <CAP8UFD3F0MLd1N6fCEv1duP052FbQ9U_o8UOznt8pqFt4r4uDw@mail.gmail.com>
Subject: Draft of Git Rev News edition 50
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Fabio Aiuto <polinice83@libero.it>,
        Santiago Torres <santiago@nyu.edu>,
        asymptosis <asymptosis@posteo.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-50.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/369

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Friday April 26th. (Yeah this is on a Friday not a Wednesday, as I was
too busy last weekend with kids and other things.)

Thanks,
Christian.
