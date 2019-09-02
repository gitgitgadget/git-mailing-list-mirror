Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A411F461
	for <e@80x24.org>; Mon,  2 Sep 2019 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfIBI2x (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 04:28:53 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:39188 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfIBI2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 04:28:52 -0400
Received: by mail-io1-f52.google.com with SMTP id d25so25050299iob.6
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6rXJ6ZW6D1MfN2p+psAPbrYAA0WW3tx9L14Iz6+FXps=;
        b=Me+dgVM+79qgpsF1Tz1xs3EXO07qzZArY2rZ4zoIWhR0B4IfNplMOpjLoE1fbt/wXd
         nut25kvICaKHyv1Vg7pJCrigYNoxYcCb3lenHLnalyGQuE/m7aa6Xy/yyqeHe3eoLGBs
         BBkhuRq5JBrjxAiOq9tmuWF2JXqxpKKe02MlwJj2HW+oyIXYf3bct+mjStFvVxgQY9dw
         bGy724TuMUG4tk4AxODX9tQCik1U8hDb0z+St8+8rdN7fW+uDbAzLOt0sgIQp/QRVIrX
         91QY0dU6bpZ6djD2E3YLFImlDYpPRnioN7Jh5yBESxeYj9gcpeazdQiOniZBhZ1dDcuQ
         Fh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6rXJ6ZW6D1MfN2p+psAPbrYAA0WW3tx9L14Iz6+FXps=;
        b=Y33NMDfaSXQe6yKq0cXkXCa11Nv6vWxbIaN0eWOTfLUWnqieMCdRk5BURz+8/rLAim
         x0bQyzlTLlQ+WrOZRdRvMDGtpz0APzmgno3DoPFQjvoDPZNjSlcP23LQTPud/e3i+FUM
         s6XQXPmt0rZ3UNHvbCUC/yCRW/6hm8pIf5VXDtY5zBXBmlVnLkuxpL/1cw0d0QCPGc0D
         oMmez799O0SMbNAkb1GcRvlOe5HwyUPRVDnAPP9hBKzwuEFZ4x5Yadt6blIRDObrpGc0
         jvJ5Iqigzjl5F6mBfk8R0Wv+hM7wy0ElbLPbZEgIg9fhR2LAAEM+3nIyz78E2HG80wpe
         oN2g==
X-Gm-Message-State: APjAAAXb+cXnTg7jN75LFLTu1dMS5QD9LAFWexMPyBspFj9plKQXWSg1
        3VgWAlHnuYSMxAS5gEa3zlb7pb3nrEGXYgirKn/XFkgj
X-Google-Smtp-Source: APXvYqyzoPQY3Zobmqu/lvRpbbFptYMTPtIxbbNZEISRHuTdz61kLJY2JnOxjoj3Q+PG+YwKsCfLjZstPjUyC7/icrI=
X-Received: by 2002:a05:6638:a19:: with SMTP id 25mr12967685jan.27.1567412931657;
 Mon, 02 Sep 2019 01:28:51 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?RmNvLiBKZXPDunMgR29uesOhbGV6IE1hdGE=?= <chuspb@gmail.com>
Date:   Mon, 2 Sep 2019 10:28:40 +0200
Message-ID: <CA+9STnLEZzcoErBzrq_dMuorXRMCnMgAVOVN-Un8aGnP-CaRCA@mail.gmail.com>
Subject: git-svn clone for tags created from branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I am trying to migrate from SVN to GIT. I have a custom layout. The
thing is that a have several tags created from branches of trunk. But
the code of those branches can not be merged into trunk. When using
"git-svn" branches are migrated with no problem, but not the tags
created from those branches. Do you know to solve it?

Please, note that changing the svn repo structure or branches is not an opt=
ion.

Regards.

--=20
Francisco Gonz=C3=A1lez.
