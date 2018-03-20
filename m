Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DEA1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeCTQHz (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:07:55 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35746 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTQHy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:07:54 -0400
Received: by mail-wr0-f172.google.com with SMTP id 80so1180832wrb.2
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=y+ZvYqgWZaI8xT1CIGe4GddF2+L3zuCkGZuAI22VYho=;
        b=Cx3FODYnNI9JeO583fFCN2K/xYQtqcbmvuXfWVR/79XSuCnyoTg6q6Vx+uyZwtSlGT
         GiWb7Q6/dp/O905NNR+dCRniCWJ+I3YaharJv0qr6sxhfArHqrf6NGIUC3+VC80UWYpL
         MvN4M0nTdvzjQh4R88MPHdRZnbuoKe3dXb6pOnfSa7I127Y2OIMnIUQpsGbJRpB4jcE6
         ViD/6Gr9IgSn3ZTkw8Y9m/Cy2Eha9aUtE+g3DmfuvGEbbOSlSzngrCb8ytNpDQ3Zh/cE
         teAX9nx88IsBkG2FzmmCmmd6bZZ1R5TZ2eK5e9wE5+ldbIcscg38mSaxUSQ9VzK/MqsE
         w8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y+ZvYqgWZaI8xT1CIGe4GddF2+L3zuCkGZuAI22VYho=;
        b=PYd/9jQPcQ0Gf/Yk3pJgEdnEHreLz7T/WZILK2GN6y7zZMUz+KtJVX40CYtgFWruuM
         ahEB8sEJTUg0Ei07DpEZekvH1m+/TMpqRo9o50q4N5EPyzsnbrFRwy6t9xo+MgqLaaOF
         xPyqIye9ohRa/ZHiMF56nhz1bxFrgZuI6Gu8lBx6Q2nYVR21cJVCOBtEWAPvY8/N93HR
         ZBimBe0gNwbo/RVyhP4RbhGj/XOJ02L0r+SOFULKPUo7tjJw9SScdwkTCzs6M5FNO8B5
         IYaq1fccIHx3CvaSOSQl7+WA1cUJwjIsW7WbLZtgCz2nRGaZfVZhgoP4C1N5XEXUYZG9
         36xQ==
X-Gm-Message-State: AElRT7HTCb2n2p6ePagCP7pUJtYer7PDDWNlM6Nc7zgSXqqcu3JaSF26
        rNyX3T3LjvLfinul4UK743N2qdswTxEUSEhVkCw=
X-Google-Smtp-Source: AG47ELtx3dBxRF89KOyz34FH+nZGJnLKMF4i+j3zgdYfJWHYppaXysZzx1K9vapRh/nlfpUupCAI+3Q3lXsjDJ0+73I=
X-Received: by 10.223.177.213 with SMTP id r21mr7892636wra.89.1521562073422;
 Tue, 20 Mar 2018 09:07:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.157.205 with HTTP; Tue, 20 Mar 2018 09:07:52 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 20 Mar 2018 19:07:52 +0300
Message-ID: <CAL21Bm=bpOYTwL3EjFxuFKuDnOuNPEsB-bTb9dPG1NVY8eXn-w@mail.gmail.com>
Subject: [PATCH v4 0/5] ref-filter: remove die() calls from formatting logic
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only commit messages were updated since last review (there was no
comments about the code).

Thank you!
Olga
