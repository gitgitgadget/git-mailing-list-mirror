Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F631F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfD2WGO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:06:14 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:32935 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfD2WGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:06:13 -0400
Received: by mail-it1-f180.google.com with SMTP id v8so1096726itf.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TdLc4q7mgOl1LutkHGZ/Al+E7MrzyUQzQNhc7yIrZoU=;
        b=LLxt8qrYpC5TciXYgk/ln9/nl2ITs25dGE5vqiW0CTJZreIt9WgXOkMRTRjYSPl6Xb
         m5oUwOYBsnHGwiXMpmi2H0cOYbafQpUY0gNKOnNVUk8yLC1O8s/i1Wta1uOl/7r0uFIy
         jptjH8DnyrWetQSs1Hy+GuoBMflVQM9jr+KEGbRnpFdikqa6FWfA8W2G3XMHTvpOa6b6
         YK6YPOuWOUNBFxuXz5blVuLSBm9x2RC+5N7E+NPeWv42S/Z3wAtGmlGpTTFqK678eq7t
         a8UEvcmtn4tia+FymRoTlXbtD3mOPgshTAhsD5qB9XdNxHcXTfb213BJk+ZiF/olxdpG
         fDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TdLc4q7mgOl1LutkHGZ/Al+E7MrzyUQzQNhc7yIrZoU=;
        b=YG+OfiP1HDOiA8D9lD04Afr0DJIzRA5rjoSxvzG1bJteLvrtdctXyiP03HmSpxDjk5
         mDF6QxqJGO1rajCNxz2I/gcBiMR7kM306vci2Tbal+OP45OmuD+oIRiXnkCZyakkLNK+
         igned6ges5lLHPEEsh1cRsk7hRpJEOnktx2qr/cUULomc2ZDoPxPRN3lnvnTVu8eGXKh
         VBB+7JHJ+NtwCZnpb55j7bTJjlN0ZkKn8um76sQVhmShu0Ls9dbzqB5vKwQTdsYCkYF4
         bYcmApQ7u0dbke05nZl6bOYHcKf1JJRUXKeZSdEZ5XHxJ1UGMeICNchLXk+TIht7NO7O
         eCxw==
X-Gm-Message-State: APjAAAW1Gw39IKhNCqwjIa0IHBdYp279CjwvQrTFTn94PDHqPpmv+oaM
        7Tsgon0uAGJUcIcIFmQAefh2TLhgsPkb51fVpCWlNg6/5bw=
X-Google-Smtp-Source: APXvYqz39RRxIfRQ6YFry6nDPjz88BN9rbGzipbbD7ag9T4ArMFPIBh7FQaAHz3aATq6ML93oOu5DOYu1kP0TpvdznQ=
X-Received: by 2002:a24:6292:: with SMTP id d140mr1094009itc.12.1556575572540;
 Mon, 29 Apr 2019 15:06:12 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Tue, 30 Apr 2019 06:06:01 +0800
Message-ID: <CAKO26Ms3iN3UMV+ans-Gpv=0XVLkP8BkqWKCstbr_DdqB1HqbQ@mail.gmail.com>
Subject: Do I need to create an issue before submitting a patch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I submitted a patch on 2019/4/23 with the title "[PATCH] status: add
an empty line when there is no hint". However, it didn't get any
review. Should I create an issue somewhere before submitting it? What
should I do to get my patch reviewed? Thanks.

Best,
John Lin
