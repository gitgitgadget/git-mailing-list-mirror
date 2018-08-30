Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DED31F404
	for <e@80x24.org>; Thu, 30 Aug 2018 00:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbeH3EX7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 00:23:59 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40984 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeH3EX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 00:23:58 -0400
Received: by mail-wr1-f54.google.com with SMTP id z96-v6so6388719wrb.8
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 17:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=E70zGqi0LTZxJHshMv5SDnnHMjlaTvEvVRdiDXfRGnM=;
        b=fEGrP0lCaDohbojQa7Fu5UsBKZlNIVhKX2Gxz1gSa3HRnv1GJpfx0SYcMrBC0u1oaW
         /I47ctgHhNv+1wyVtnbL+p74mLbY+mhonAp8OgO3gm53G48mFHbWRBt3aVuTt9O+coTO
         9RE/I6QPnAsIAq3wy5qfGx+TEpgBgyUoVW25Rc2ykzU/rACjxeSztwGOH9Lbl02G2mXH
         JeUi9RXPXvYm4ONjt0pkuTUh76OctdWC46DY/qvgzFTdW4QDF2fkvtHzlnV4/DrUYGCt
         JbzrtxrwG4BFgSlybg0uDjhI2qgPxVJZ0bE4hb2M38uy+zX7of7EgSy6N9aHBQJ7roTx
         eS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E70zGqi0LTZxJHshMv5SDnnHMjlaTvEvVRdiDXfRGnM=;
        b=q69QcVsTXZAKis4XotlgDR0meTPVdZ4/vmeyIvboaHP+9NnMtxzQ6YYObxTN2UsK5s
         fjGl/iCJSFwbz4so2kfWTLTaPuwvSW1LxLzHnpd7BYjyvYd3JLxXw4w7uhqsLm2n5Oyu
         iDgfbzeAy30AS5hyc6FXku7ZaQKjXXmoPMlppw6T5VGjK4azDHmsBJUqJRfa1SESJzuJ
         YkxnDP5ksdD9E4iBgpxoPrSLJnEBXub2I/a0eJr2anm0tHZ29HQqQNOeswgiUU7gLwPE
         G/I2w9WfqBtJcmcxhfMfFpJsMo8LH91fX9l7IYE8EmmP2HuFykI5dE3JNCbVXHYwC18D
         fvlg==
X-Gm-Message-State: APzg51D7djLQ9N6Urmq939j150nXzkSLvtobcxVPOGFz4J4yvmDEcHHh
        MvPwMys+EYPyDM/YbP/kEIY7kEw9QanbKSf/hJfqC88=
X-Google-Smtp-Source: ANB0VdbOiuNhjNIWwfi+q+J0yh/RDB9IAHtU6vbAu+ADVTKQz92C0o/RmWNjVbI75vH82eSP4PUhd6sP0eRvU+NKE9o=
X-Received: by 2002:adf:824f:: with SMTP id 73-v6mr5876101wrb.130.1535588672505;
 Wed, 29 Aug 2018 17:24:32 -0700 (PDT)
MIME-Version: 1.0
From:   Piers Titus van der Torren <pierstitus@gmail.com>
Date:   Thu, 30 Aug 2018 02:24:20 +0200
Message-ID: <CAJmvCd1BwPNgZM+g7c6An-EESMHDOSGQe7RjkAAz36eNY3fvGA@mail.gmail.com>
Subject: improved diff tool
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git people,
I've created a diff algorithm that focuses on creating readable diffs,
see https://github.com/pierstitus/klondiff

The git integration as an external diff command works quite well,
though it would be nice to integrate it deeper in git, and also in
git-gui and gitk. Any way to use ext-diff from the gui tools?

Is there interest to incorporate this algorithm in the main git
codebase? And if so, any hints on how to proceed?

Piers
