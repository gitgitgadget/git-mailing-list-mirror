Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18FFA1F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 13:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbdIFNxc (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 09:53:32 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33952 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754712AbdIFNxb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 09:53:31 -0400
Received: by mail-yw0-f175.google.com with SMTP id r85so6727277ywg.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=xE6ReU/G2UoTormynvQhQdjRYhdMdyiFY2JBKbfw3HY=;
        b=cY80DjNa9yH80lePr553SBjjlWiV7fwfXhbcHpufQ0Bj9EI1Jflylf10MnWevoDg89
         gpKy9GTQH1oJifZvEx02l+zI4V1mKPQRR6+moYuB+dywIbwl6Mby0TXuKb7qAFYWRcJi
         l2yo6jWGqqSnchvKLjBU7jEsKubTwF91DLh50Cq14Tsnma+vxlsA5I38E4CaY5dNa3YV
         BBIvb+B3XpiVHKyapPOLaKiM/VnW8oK5RZaBhVAgW3pkts6fSauCCoAdvxYe+6bi2SJ5
         QLVWWdz+ynF3xLkq5dIXgIB5ZVt57EmmseCw0hAcTu300Jsa5BBx87GUzqOaFRSr7lmL
         PzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=xE6ReU/G2UoTormynvQhQdjRYhdMdyiFY2JBKbfw3HY=;
        b=RspTfcRKV28p7TY4egDbMKgzF2JjU/teECgpJ44FrbeWxrn55uA2jVnA+kHQLNcjog
         m92FKCA6pqUMAj2i6r7rfyBMWVIlRRO59m3sfBp0f0cLKtBnlU8c6alHUSsYMgER1V8g
         Ot9lClDH5vFIbCDn6giBx/ToJ+cvY/DSc2BTdH3e1jxvEQMM259UTCWp7efgrAwBhZ9Y
         Jqa9HXBAo2vNWbpbYsZ8IzuHVyRvqy8Ke81UIYwlmmeXmQByeTlbILHxQjATmOs+NJxL
         x9DNzNQ1qdzUUrAnhCBvV7rPClJJv3Ha1lmP99/583qPPbOcw/qnfTlK7sDqjnKwhuLz
         FA0A==
X-Gm-Message-State: AHPjjUj2l1VzjVIJ7etJdx33cGmk2AIcBWf8do4Em49X2J5/jVvZcg2E
        TPHxLM7JYzmVPit459jW5nh6Vy4W2KlKdDo=
X-Google-Smtp-Source: ADKCNb6Jpbus6Zb2z2kVAFmytjCBrRQ93jzQdCb208QGLTN2ZOB9Tag4UJWXSeitElNBGYl8HAEvYNKaGEdTAF3Y/6g=
X-Received: by 10.129.114.10 with SMTP id n10mr2169928ywc.154.1504706010758;
 Wed, 06 Sep 2017 06:53:30 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.145.143 with HTTP; Wed, 6 Sep 2017 06:53:30 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 6 Sep 2017 08:53:30 -0500
X-Google-Sender-Auth: fDh5ypUtok2E4G2eAmbzQ-2_odM
Message-ID: <CAHd499AuoZ-89mpnVkMhxaDT44SRNT2xWE7sykcaP8n5xTRd-g@mail.gmail.com>
Subject: gitmodules below root directory
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gitmodules documentation[1] states that the .gitmodules file is at
the root. However, it would be nice if this could be supported in any
directory similar to how .gitignore works. Right now git-subrepo does
not support submodules inside of a subrepo[2] (I suspect subtrees
would have the same problem, but I did not verify). I think this is a
limitation of git, rather than subrepo itself. Perhaps there are
reasons why .gitmodules must be at the root, but I at least wanted to
point it out and see if this could be supported.

[1]: https://git-scm.com/docs/gitmodules
[2]: https://github.com/ingydotnet/git-subrepo/issues/262
