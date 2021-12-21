Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D02C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhLUOo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:44:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5633C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:44:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so24396893edd.8
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pdkwMoymtWqqFLDw3hsZGYc+71DJ6LssudRhxdehL70=;
        b=j/kg9EQ78koAg8vWg//mzvnXoCNaLdnWIEeUrFIEcLJKUXb/tyrJZumUzqwLwkg5zb
         kQBHzwZj4dvDwiAFwAvrGrL7OCE/9d0LmOrN8JZZUr8d9qe5nl3KwFBI/Ih5lHvX6+XV
         XzBtQJ0rEocGUrfP5gA/KBf/olZFYQeu5QKVw7/1GknQD/1vK8xLZ6tkToZZkwEuKp99
         GnN9Bxf9utkMHVIjYjfWggI7RW/A78jgIqwZk02gVwz8qGp3pHZF420v6n0kTq/FtqAa
         43a5TKZivTFKVRlc0p9Edyrt6tfWwNvAhfAwF0hZyt0wrYwMAIj0E+R3F0SpuShyl4+S
         vp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pdkwMoymtWqqFLDw3hsZGYc+71DJ6LssudRhxdehL70=;
        b=S0jHWAT7v00B2eeq3j5rfDKvWp4GAAMkVz8bzN8kMPGLUcHQHLOphrT+/yy6DOrJX/
         Um/vTwsYTc1UgIUN+NvkXr4bnww6mE8pTgBAsfMyVRm5kckxeoqcHToAorv3jMfMsxxe
         6cEj0Yqf1zEw/VTLu7W+5yOgiVHC+GWYCmftJv9+A9Y4QOH9bejUeXWhHE3mfAyc6CAh
         J+C7W/4oD2BL9h+TKxwGkrAuLux/tN+uLbNMyaQSNYt+PeKyI+iWcUiP8ajEB+4sT+cs
         lZgnmJBR8DFXEnzEInoevFUgMiQGb2zqKpPvFhJUWcxvSmi4AVagSnvugunbz7NKgjoN
         k9PQ==
X-Gm-Message-State: AOAM530LAboF650RJ5HldKi4MUQX8JxtEOJmawLlT0yT5eDOaX3SbKyT
        YDDZsjDcjVJZ6VWmjgm1O0b2d0hGE66rYpO2ET+RthvKKtc=
X-Google-Smtp-Source: ABdhPJyNXbu+Kiy1js+EOQq2JwcxGSVz9jc98JedmklVNDDSsh3AqyhOv/T61w2FexIC2dMF/qscfuswdFtNEr98ky0=
X-Received: by 2002:a17:907:9493:: with SMTP id dm19mr3024266ejc.161.1640097894131;
 Tue, 21 Dec 2021 06:44:54 -0800 (PST)
MIME-Version: 1.0
From:   "?????? ??????" <nekadek457@gmail.com>
Date:   Tue, 21 Dec 2021 22:44:43 +0800
Message-ID: <CAM+a_NM=xTCrNPCjpP49T8d6hPFD26d+Cu06fiSq4TiZB=DzYw@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it possible to always GPG-sign commits created by rebase operations
by default without having to specify the -S flag?


Note: I don't like revealing my real name. Please call me Lemuria.
