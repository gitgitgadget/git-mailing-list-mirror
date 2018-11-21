Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46031F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeKVBQN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 20:16:13 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35540 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeKVBQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 20:16:12 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so9190035itj.0
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8QluwGxaueTNYXFgPZf8qQiC4MqHaAJSq1y3Zw+acOk=;
        b=Zdw93e2WNy+rH02gRhvy+09xWlEa+aIW6aP2Np29B2B4U9jQN5XSnId3chrE+CsVGw
         cZLiR4/YoTlnvkUUlZQiYPnAAXcqFIkFI1ft943otsHyadYiOXvvF9irNSieMzS6eQPq
         /2ET+L/75trms1BKgJtqWANuQhwZuP4BrDjLe3DBstag72hqDd/TpIgMxvYoteW9X94y
         Opvv15MTvzcpWsZzAideWwWBl5wd4MITYb4cbyLb89NuSfk7HQQ8gsMuPuu28d075Mqn
         AMeCHBMFEu7avXYeE6GLs0PL0v9AYXuAJv8KMeklhNsco83XQZt5UvND+AC2SXYqqQyt
         Xvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8QluwGxaueTNYXFgPZf8qQiC4MqHaAJSq1y3Zw+acOk=;
        b=QQQ8bQFEuLuoDqXtmyImuDFTgyXXnWtT/bpE/bDIAOFIxworJ0exDx66gMGbasUoZU
         fhuWBJN1s9n4hL0lkCFkaYcJt0AFNJJnCRNAzCD/Bdynx4eG+GUXyLgU/5lUIhtmHDAO
         s9QMkhkwNsDsSl6xDVySMXFByKKiLBbuc2MbWQ0ZAKtuEY7KC+W8mI4IBgLqd74/L9M7
         Ij9baa/gfNJrPJwksxPm6IXGg3lA2128aKZWH2edgyrpmqQh/2+8AT2nW9mgk7xfdkaF
         00yQBlz2HH3vwIwjRbc2CbZT86imBjLkOGWLmYIxd1ZszHniUquuS69o+hsYXrb+T0U/
         TUgg==
X-Gm-Message-State: AGRZ1gKoj/jk/GFbU/465WoKsxBjQr+/fgzRZA6XpZ9E8m9EYbtYw7Ev
        2QfO02AuwRqfdlhgLp0z4O6FiK3MMBksk9LRoqT59HMs
X-Google-Smtp-Source: AJdET5dtuw7nDFN18zVa3qDMl8xRBDElHnee7y2ZLGscbmUMAfCoYusMzMNRVdGOVweKaZhg4qLHLPRDITOYjh9H3dE=
X-Received: by 2002:a02:9c53:: with SMTP id h19mr5889549jal.31.1542811289885;
 Wed, 21 Nov 2018 06:41:29 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Nov 2018 15:41:17 +0100
Message-ID: <CAP8UFD2Pm2oCftn2K2xGWPg1AZODBNhhqp8-UC5uFBR711OnJw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 45
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Slavica <slawica92@hotmail.com>, slavicadj.ip2018@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 45th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2018/11/21/edition-45/

Thanks a lot to the contributors: Elijah Newren, Luca Milanesio,
Derrick Stolee and Johannes Schindelin!

Enjoy,
Christian, Jakub, Markus and Gabriel.
