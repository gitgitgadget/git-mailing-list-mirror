Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFCA20248
	for <e@80x24.org>; Sun, 31 Mar 2019 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfCaSoe (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 14:44:34 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:44393 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfCaSod (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 14:44:33 -0400
Received: by mail-ua1-f51.google.com with SMTP id p13so2317536uaa.11
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=leCk8wsB9cdugU2S7IGaoBdvYtM/t1CX8/kZYgzNuXk=;
        b=AolTLIO1biafmOZl5YRXQiKJRkViyMoNrU9fhY72yrsFo2RDLHaHJAALV47c8iOsHp
         MUdI6ny3Z7mQ/Ui6SUrET/Sw7ryWOnjBh7CiVKbKcatg31IXl237htKD+7xS9XoXENaz
         2j35S2U0u9Gqvl1XTFtSQKzZBWRUjaByP8bxT6KV1uuSJbI5AGAXxpvHvCUC6SQneUX5
         35l8oQ3akUcHFa+KZkhBaKzkxU5ljJ3PXG6YujRgO39sjD33sWEv6rOEur5jpIvx3SDP
         z+TaTIQJscRNen29W/jUqJ5Q9uXFDZjutxN0O2al8JbLykjn5UyDg7Z0vTXCDfzE7+Xh
         jhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=leCk8wsB9cdugU2S7IGaoBdvYtM/t1CX8/kZYgzNuXk=;
        b=bCfrQBLKNUGwHfA7dMb9yMYITzC/U8BuTKH8bS5G3IKo7JnXgfTubwtjotKZ1v2mmS
         MkPKibmxP2EQIyAMLActaOo6OL9jRFyepmjh/39Jay+bSEM2OB4+hVWptUgMB0xvAMd6
         Q7fL8TPw5A81IUvozaGLiTzH4Rq69P28SAMg10eJs0oXds8UXoxwus6z2j5ucOQpopjH
         LXZHNPQs9EKz0R9OHBObcTCv7Jv3w90/FEh9lLx06Yy45oc5tj8Gl4Tdr5hUBZirWqtp
         JLuLlKtmA8Ru3nW2bh/U3UQaMD9z9SROnpeijU4JBORvgeVQICbIGsptv3ONMtSivehW
         5Vdw==
X-Gm-Message-State: APjAAAU6tuc9K89lcrp/CEuA2Z35e8rJPDWizQd19Ys/qSHVv/BOLArk
        EBzGAGyU5tvxTbsFPFmCVvZ9v690w8fZpNeVnSW97b7G
X-Google-Smtp-Source: APXvYqxqbXZhV/z+PowMjxR0hTGrtktnlbbD5sosn9aSom9sl/kiwqpDUXpkq7Y5BTJFAxxVqMz+qNUEpQn6pffoDIM=
X-Received: by 2002:ab0:28d6:: with SMTP id g22mr33675495uaq.75.1554057872543;
 Sun, 31 Mar 2019 11:44:32 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 31 Mar 2019 20:44:21 +0200
Message-ID: <CAODFU0qYB2L08jFfBjjRCPYuUSGG5+7XEaTWzZqDed3uxyXEEQ@mail.gmail.com>
Subject: git-gui: searching for a matching regular expression in file contents
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

git gui is missing a search functionality in the "Portions staged for
commit" windowpane.

Ctrl+F key combination currently has the same effect as the PageDown key.

git version 2.21.0

Sincerely
Jan
