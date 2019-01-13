Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0F3211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 07:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfAMHMB (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 02:12:01 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:44814 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfAMHMB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 02:12:01 -0500
Received: by mail-io1-f54.google.com with SMTP id r200so15349694iod.11
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 23:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=o9Dh9yln1yCp5ElE9JwcmtVbmnoliW31xJZiffmj3OA=;
        b=GpU89aCb+eb3E5W8omcIRZqI2UL7cNnPjl8DJiQaweJ9878X/M0d5XJpbqm10ZWJTP
         avULcNdyc0jvUmkxhnyioUv5wHRsKZbJirWf6Crf5GwFW1inBUZ0etZRIG3Kjlfdmby0
         5lm4D8h4h/QT0H0umlNcWMcPcMFoVCbsAdeKEIOce0RExyUKl/4daRFp1Z+tbhBl0DM5
         atea6u43zpMU2Hzqhkg+S+6BoCoFcUZUJoQsPdhs6XDn5CwthDFu2gmSt65lKfsDytbl
         VDLSxGp+Co1adfuxx4dbMabUvIoJBp6PO/Jjf85X7mLdlSYktvoqsLl3pCLZ/dgLEFVC
         GEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o9Dh9yln1yCp5ElE9JwcmtVbmnoliW31xJZiffmj3OA=;
        b=qyAhp44MQv8Bz8dQvNLEoxfjUgMSPQ37WXBTBKMdyapyd7iSJpK6uM0AnmFjKfnKZQ
         9+Xw+ECam0Fol1JW7iruYsI5mg9YYsy3vN3fKdjbOKb7cMkQrt3YZ8lJoGs7lSM1rdTV
         fQ0PIVSe6ZcglqIsF/hXjeWtvu2UhyAkfyWwE1xR4MWcyvaXe2ZKjmJUgFEe9+xMnjg6
         t2DBSyKB56hneT71bZoPXgIPoukzf+ZsCtWdHeJ3OEm8NYj1FcwQRFh15hpS4tw4doal
         ZUDfeF3gCQSMgZEFcZNBkPiSImARvs5FNl7bP6xJHcFVcvazb3Uy1O/ZjdujUbIAaYwk
         4X3A==
X-Gm-Message-State: AJcUukdpCHP5jqH/adJb22NKP9gZ6dntnHINmwyMo6YfWVDDftzBemHT
        EcZBHUxxzKE+3n0jXFBT3dprfNCgbbhQw54U9/FFcqxw
X-Google-Smtp-Source: ALg8bN5DB1dwBdmEjbCzIJ/OWsLGAcBPgOyzStenm8GeKfaDnZZKL79JNy/0SFftcfKnrzuKe/bmN+K7WvoSflq0QoI=
X-Received: by 2002:a6b:b28a:: with SMTP id b132mr13421622iof.256.1547363520313;
 Sat, 12 Jan 2019 23:12:00 -0800 (PST)
MIME-Version: 1.0
From:   Rob McDonald <rob.a.mcdonald@gmail.com>
Date:   Sat, 12 Jan 2019 23:11:47 -0800
Message-ID: <CAEppYpH5F4v=Lam22ebKA+QYH2A1nGd7wVSrs0V2DkazYwEFUg@mail.gmail.com>
Subject: git-gui child windows are still blank
To:     git@vger.kernel.org, kenn@eissq.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The release of Mac OS Mojave has broken git-gui such that it is unusable.

This issue was raised by Ken Sebesta back in November, but I can't
reply directly via gmail.  Message-ID:
CAABTFJPpmThrrwP6pb5gZ82fb8yKteLpDcXTCQS8p_7WZ0Ne5Q at mail dot gmail
dot com

The main window opens fine, but any child window (say when you press
'Push') is entirely blank.

I haven't been able to find any sign that work has progressed on this
-- has anyone made headway?

Rob
