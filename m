Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C261F463
	for <e@80x24.org>; Fri, 20 Sep 2019 18:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405532AbfITSpO (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 14:45:14 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36248 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404617AbfITSpO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 14:45:14 -0400
Received: by mail-wr1-f52.google.com with SMTP id y19so7819596wrd.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FVaLC30OEQrOzFcwXqFkOLnxVqliXdQaAhVdKYb3+k4=;
        b=N6Do4PThsuE6MDfEb1oBBqVK8kimobm5x7kk1wPYZ4j4euyfk+abXWRc0Wv7sVYQNv
         RYHDE/zE7sbl9Y+bAaHSuxg15qRWC3CLvwQ74jWi8lZsi5ppfodDHMj73hyOVoHAVTRA
         /DmwLn6XZ69SSUIY+4Eua4SBGFWMFYmz4fkwG9BVf3h0KNwDM05rDIkj3SiI/QdJRobZ
         KIVJrHw9h2mmwYNHg7cqhETA/JVhLkqniugfUi5dskGQIRP+d3chlQ/Hb5NL7CiMjJHb
         7fHZUuzNQFgCMslyytcqfX9AOZ72v4+hzAiVOpI411Y4ix8mVhSAAA/32W3EJ4DYgN0B
         rG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FVaLC30OEQrOzFcwXqFkOLnxVqliXdQaAhVdKYb3+k4=;
        b=eaFzeknZbe1W3HL8pp7w7yn1nLSDKGgLq78XwQQuyHsfdMIfNiBJo8Npu2C2xTdy3t
         +CBNF/elNsdNUzMCBX0vzclktAu1OTmDHI66xL1V9d9R0gk/g1wDWgL+HCRYFGWlf9Ka
         bO2gWfz7fUfBvK6TeeJQccSK9oJ43VTwsBTxh95Vc1WXuQFS/8m4+cpFFsZuLzCFEy0b
         c+bgtK+DWO2+3y5Gj4ToI95PaoCefJYZEZsSOYpMxcdvm6ErOyjV/QWlthzjm/qoCMvm
         8laJtZUwsPssVYyHZsmE86ybnz40aSVPhHono4MFPPrgsodt52HfvtROH/1l6XGKVJuh
         zs3w==
X-Gm-Message-State: APjAAAWSK0Iabe5kTFFBbHnOHNt2TT3FwVGGdpmdj68PAfa1ulDsg8XD
        ejjopcKrfy0cN+fmMZqAovmHuQkE6cESmSOHguaQxOGRCkQ=
X-Google-Smtp-Source: APXvYqxyssnyjZigIIi5dUeWUa3vEINaKNfaL44ZFhYLBpAR19FFZo5VprAapoPyJZsMxPbL6HZOZ3fipfuMS0yGeGk=
X-Received: by 2002:adf:b3c1:: with SMTP id x1mr13762751wrd.33.1569005112524;
 Fri, 20 Sep 2019 11:45:12 -0700 (PDT)
MIME-Version: 1.0
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Fri, 20 Sep 2019 20:45:01 +0200
Message-ID: <CADMnYXDqj2AxXKRhHTfYaWonxi5_GC+6-zzALN4m6u+=fo+muQ@mail.gmail.com>
Subject: NOPATH: A Cannonically-First Git-Class
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Trailing delimiters are solved: /a/b/c = a/b/c///////, making it cash-burn.
This concept is called NOPATH, and a no-cash-burn-class is a
canonically-first Git-class.

Cheers,
Klaus Sembritzki
