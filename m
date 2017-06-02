Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4BF20D11
	for <e@80x24.org>; Fri,  2 Jun 2017 04:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbdFBELg (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 00:11:36 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35940 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdFBELf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 00:11:35 -0400
Received: by mail-qk0-f173.google.com with SMTP id p66so35211457qkf.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 21:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TnEnbagFCbI6OaCYrNqBV4QovMzy2HZ8ZzhcwHuihsE=;
        b=I2ug0xRpFQQCKUac1Upft78Kjqjmq1sq+0HUl33yLi4lU68eux5XStnVYPGl+dJRa4
         bT7IOguUK2F4opSM/t4ni0b9BlEzfyPdOLyc3RF4tmegdgZG0ogLXd580IIDRRCD/A7C
         ud56W0B2bPT4rVMVXWt1+Um9Si3A3ui5DuboiSHmpwfO1N2QIFJXNobPb/2okKlY+/1Z
         FECa2rhVDAIMRHU0NfZF7bloMG1zCymTvqpCgJ3RwGfqpCLBUXBDMI0oO/8PhOr7NjlQ
         oRyMqYLTaqXOcwGmipIkQoezSttaDpri9PrHnOvQQl4r5i7anqO83vfWQ9Y04ARJKiZj
         B6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TnEnbagFCbI6OaCYrNqBV4QovMzy2HZ8ZzhcwHuihsE=;
        b=CefhovMoiCF0K/67XpjMo4EZHqD34g8E5kRtADxByO5qenTjQE++thOGNfA6Dsn3Cj
         jMIJ0GDOFiL23pJreMFsNIN9rx/D2JsFWvK9wTuvlPVfsGZyCG81hEnI5JglRv2lkrO5
         BTGHNQlKIjFj8W84egKvi7TWqsMI2LVNMMT5lECjHkFYDbifhGMg0IdQHreyZtolo0eI
         L746j13iRy+iyUptzBreKqqXK9UqpbafPSfB6iEiVmMgVQMDiv9TvSaDja11BlhhzxPK
         9ekTi33J5zPZ8cltVkosCAo0mHSHgpDsE1ZrYTRI2Lpy0xIqiTEfmvAqR6GJXLObBf8q
         gX8g==
X-Gm-Message-State: AODbwcDP03HJ0eeTmj8sA+bsAsHwn3PIw/Bpios55VZDwg82u99Nn9hx
        hBNc+vPc8rW/28de6TX0sI389VrNpa4F
X-Received: by 10.55.105.2 with SMTP id e2mr5642263qkc.48.1496376694612; Thu,
 01 Jun 2017 21:11:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.50.164 with HTTP; Thu, 1 Jun 2017 21:11:34 -0700 (PDT)
From:   Pulkit Goyal <7895pulkit@gmail.com>
Date:   Fri, 2 Jun 2017 09:41:34 +0530
Message-ID: <CAJ-kjL-Y+x-ZROnNm+Ray54hwxfkA6K6uxYoUVQpa3NmrzbEMg@mail.gmail.com>
Subject: Incorrect Diff!
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey folks!

I was working on a Django project when I got the following diff which
is very much confusing.

The diff is pasted at https://bpaste.net/show/c2cb00728ff0.

As you can see on bpaste that in line number 9,10 I have changed
"class activationview" to "class activateuser", but in line number 14
the diff is again showing me "class activationview". Maybe Git is
trying to be smart here, but the diff is wrong and I was confused.

This is to let you know I faced this problem and to ask if this is
already fixed.

Regards

Pulkit Goyal
