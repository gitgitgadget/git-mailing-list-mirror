Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5DE21F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 22:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbeKLIkH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 03:40:07 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33269 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731599AbeKLIkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 03:40:07 -0500
Received: by mail-wr1-f50.google.com with SMTP id u9-v6so7344218wrr.0
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=dgjU4UC7kzkGWg8S1ly5PowQCHB0ddTyg1oFwYdYNKI=;
        b=XHPJKEI3ZVY9nkBL9898OsqTP5zFe6G707bf2Zw08EfQZ7qR0jE2fpqftNAfYdn8s7
         XnTyyH9zgIY8SHfY6s6UwnXVPbTyjPWZTnz7TBaF3uLgYCTWlUPjOHcGwUdQyGnA5YKI
         W/VTbN0uheUWoIfOSINtCarqKzHQCzUpGPuDcmTdf5iiH8GqRcHvaUKbIPE/1DY/ANjZ
         93EeNh0mZAYlaGsFcmBOGn7+0jZV47+nX92uZoGnp2e1CcnAJqYbPnKqxBwwNXdKpDjZ
         uZEmnh47QRh7e1oFezPjYEmtzTqJBYGLgmcNDhqjSZ2qM4eTAT2R+swgR98WHQXIQWm4
         Vafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=dgjU4UC7kzkGWg8S1ly5PowQCHB0ddTyg1oFwYdYNKI=;
        b=Qtg3oez/Iu1VN8FzMkv8/Lupv6HNe+ChfbthNSaobUFTEWf66UP7DIYDVMica637hg
         oODt3GomWfZhTs8ndhDN3hdC14ZRscbw0TXsw5FhCJCv4JX1wk9htKxqcNWI10J3i55d
         Cq+OT1hVd3s0KHpYiJA4LNFtV91JiSr0HwEfjCeHGENXVjPzDQP/vFaDvGI8L8M/UrN0
         A8lg3cwGSB1iN+TzD4u4zY47hYSHZBSTTYJr96mnJoMB0YF4Fc+M+sCF0KAC307irD1c
         Nz+OCz8os2ztIBaPQ6mvin10flzZfe6fP4HQwQeVWXsoiOqYOlEHrVQv3lFMCClcmMTH
         7kqQ==
X-Gm-Message-State: AGRZ1gKF9/fnWQeayiLNPyI7oWIz6zdm4wqx0pJ1Ox3jfdRQHIwvp6A6
        YZAPalQLcERLvLkCwa4vz1ZH4ucK
X-Google-Smtp-Source: AJdET5fvMA3oXglJbCDT5jIL5FY0Kq090ddKMFdZCbvCvgFI/u9+C/pFb1MDaeCTXu9KFbizDr3P7A==
X-Received: by 2002:a5d:6050:: with SMTP id j16-v6mr15108380wrt.301.1541976602529;
        Sun, 11 Nov 2018 14:50:02 -0800 (PST)
Received: from [192.168.0.15] ([78.193.202.142])
        by smtp.gmail.com with ESMTPSA id x194-v6sm27999072wmd.41.2018.11.11.14.50.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 14:50:01 -0800 (PST)
From:   Martin Delille <martin.delille@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Add issue management within git
Message-Id: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com>
Date:   Sun, 11 Nov 2018 23:50:00 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This would be awesome to handle issue directly with git:
Having an offline version of the issues synced to the gitlab/github =
issues.
A lot of work is done on the issues and it is lost when migrating from =
one service to the other.
Beside we don=E2=80=99t always have a good internet connection.
There is already a kind of integration between commit message fixing =
issue automatically when merged in the master branch (with =E2=80=9Cfix =
#143=E2=80=99).

Kind regards,

Martin

