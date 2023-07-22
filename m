Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83401EB64DA
	for <git@archiver.kernel.org>; Sat, 22 Jul 2023 12:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGVMeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jul 2023 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVMef (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2023 08:34:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869BEE71
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 05:34:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3145fcecef6so692073f8f.0
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690029272; x=1690634072;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWYUd/Hd7XKTL+VVhSAwbKfzXGn/M58IQcXpZ1AtopM=;
        b=FRw0lXE5l79osOzurAXvFt6DApLfzuA71swobuzg5VwmN7RGhk3bIzAGpNepglGzcp
         zbw6Wl35X2OckydBfODGIh6HMKKuZpVzlNfvgbGAqYeJCsDMoo4/4b5T+y8F37KkohrF
         6ZexhMwu1dqWguIEOxXjK04haK3n7Guwa1NgX/JSTfKV0X/Wi8WmBBhbcRCR2l4zGnmz
         BL/EwxHmD4Db1IK1ZceV/YyraWKvqpV3T1QMvs5GUt9m8jnIDEkLvREgue8ZJJ7WCh3G
         6P+AvlJ8TFD6cCwQiuaA+f0bIl3WSex+lwdePObTG8pa0jlbVFrZIfvN8TCkrj0itdS8
         4CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690029272; x=1690634072;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWYUd/Hd7XKTL+VVhSAwbKfzXGn/M58IQcXpZ1AtopM=;
        b=V+N8AJYyA37sERzqzB8aY7Ia+dFGyUBcukTnyvlyf0iOR+PH4QewItBpuXXgiOMLeM
         MCzrHnF5zAOhj9BUyVRSYoptEtn4ScnpEavnCxoYNgow4Rob/9hpD/Loecl2BqG5UM9s
         EJQr3FdQomQbNylN7cXVwHj+hAJK21eoq+8umgqTFg4ZcVodGfaAkDb+btmW001B3zbz
         bxx35IIEXoqeVGRq/pnFeRWjBwypc+Qiw5ibgB4dM0k4Obax/8QAhGtxYButq+KzD/b6
         TEkfGBk1sUC+yDQQiqmfHg6FDqi3vuLWBtPKiKEUsGC4m9GrQheW1NjNf1VpzhpuxKQo
         rWHw==
X-Gm-Message-State: ABy/qLZuMqnemqi2Vrhwpr/kvJNm5JXeV4LqG7jfPHW2fwWnzy2qEoID
        KpLyMdmzdsxAJyM9t4eVbDYsyo38SRH5AuFte/qSPEunUMg=
X-Google-Smtp-Source: APBJJlEzS1IS2G4G3BmrrlNorF+u2Ff1LM5ZB1HppyO2l4wcE+ZF2PsKZ19lWpAPi+zpumaPx90aAjy1wc79dnYAQlM=
X-Received: by 2002:adf:df84:0:b0:313:efbd:bf6 with SMTP id
 z4-20020adfdf84000000b00313efbd0bf6mr3706515wrl.2.1690029272534; Sat, 22 Jul
 2023 05:34:32 -0700 (PDT)
MIME-Version: 1.0
From:   Sumit Kumar Verma <sumitkumarvrm559@gmail.com>
Date:   Sat, 22 Jul 2023 18:04:21 +0530
Message-ID: <CADYe-LV_SGCTGsQnKKZQG2Thb974fvGgAJTcTTmDA1fmk04gTA@mail.gmail.com>
Subject: Bug : Repeatedly asked for choosing github account
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git team,

I have installed git and connected it with github account. But
whenever I try to take pull or fetch the repository, I am repeatedly
asked for choosing github account. This is affecting my productivity.
I tried reinstalling git and vscode but its not working.
OS : Windows 22H2 build 19045.3208
git version 2.41.0.windows.3
VS code: 1.80.1

Please help.
