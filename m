Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD261F463
	for <e@80x24.org>; Wed, 25 Sep 2019 12:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbfIYMke (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:40:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIYMke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:40:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so5383351wmp.4
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HsBE9oharXvBLXLmVRHyELWHiAkwAmvMSkpZzzzBdpU=;
        b=nlkFq3hXzz/VODhLzh59xzvGLXFXaQeEpfs7BY1shXt5GWN2ymuUw3vEjlTDGbha9x
         EdjBoMP9bSwLbbsY9dIHi5m0H2N6fypHs6CwE71vZfXaIPi+xwdY0PtAVaAgZRMaaelr
         c0OQm3TCcIRrrc4Wb2577wiArs2jSrWFnG3MidY1s6FmKbJzuLZKGrTIhjOtSQh2iyRH
         NFeIz2PIhHSF3TVYSUPfh9t+DK36cJuuSN8tTlkTuewJEaRxZX4LrbSH+HOVjCqorWIX
         ZU7bxBXWS4RTak8vbUOnlMgAzIz90PIUAKXyscLU1IoZiZRr5OyMaeEujCxpimeG8p5Q
         hXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HsBE9oharXvBLXLmVRHyELWHiAkwAmvMSkpZzzzBdpU=;
        b=LIpZg2x8Uj1LqXBk8GdPlzN9iZ09neGjCrUTQsNqN05pdOlGcdjb7ke+rcjyR2+0pL
         mrc1flbI/B6pASAreOrD6i8qQ0OFVcCkVE0qLs7olPKlPtLdSV+E1ColgMIFZYHLznxZ
         TiixDgOVNpiTXNexJsR+2bw5mEapR0HaGSEeT7BacWIczJlNNpfP18T77SYmRW8lFNo6
         mIDcVrZV0tmOWJhrtJR07JQIcWxvvTxBDMkhUbo7zOwWcscBpePVXjPBm5Bc1VG/Ye6j
         7AtI8A2kAHZOuLKcYZ2IG/cPQ/Rmi5i46qvCrt+IhzOBBjEFrr6myhZEUSn+P+Aoxfuj
         uU6g==
X-Gm-Message-State: APjAAAV1gfYVvPbqqwb7NhtSD239QJ0r2gLp2jGeBgC3ztWRD0JliDxD
        fSuJnNP5MUc3eK9/N1QPFsdoRoWzKebpC2r/Mz/xBETX
X-Google-Smtp-Source: APXvYqzUp/xvt92UXpSERFrbG/6VsLHPG9fWYNSxpLhB0lm6znOnV9ub2YaQ+8B+4WnciFr/uj4dtp1R75nE3iH2XvM=
X-Received: by 2002:a1c:1fd3:: with SMTP id f202mr7539370wmf.18.1569415231652;
 Wed, 25 Sep 2019 05:40:31 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 Sep 2019 14:40:19 +0200
Message-ID: <CAP8UFD2bn+DcQkXiG1Mi=KDJwC9FP7F4cKRxHi8epnFqEF4nQA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 55
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        James Ramsay <james@jramsay.com.au>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Emily Shaffer <emilyshaffer@google.com>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 55th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/09/25/edition-55/

Thanks a lot to Emily Shaffer, James Ramsay, Pratik Karki and Thomas
Ferris who contributed this month!

Enjoy,
Christian, Jakub, Markus and Gabriel.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/399
