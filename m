Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC79C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 06:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbjDZG2U convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 26 Apr 2023 02:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbjDZG2S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 02:28:18 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A62D53
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 23:27:42 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f0b299d739so7265761cf.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 23:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682490389; x=1685082389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72w28gtv17AE3wiRqBDaF6AfBLOwrT7zqTNlGUhVH9g=;
        b=N72GDhL6A32ThanJZTupZ+pDJyg8qTZTQw9fDregp3Ts8ihXZV5IqgKrin80szta6z
         Wl8+nGrLfV+i6lRdrC+OujF6u3Gu78r8azh+kmlJErB0uPeSiABtG5+PAWVQd2qUJXGW
         Ga3v1pHfGwl/kH8rcQyq2pUSSN0tz88oBZ3Wsv0W56U+8w693fTWeIH1tt530MFl+YNC
         6V67yov85NpuRmo4CzwPDg5vmGsRWIauL7F7c+o1GcNUaXW6ccTmkBnjXlH7GkveozF0
         uMTppHPmZbsiyoJtSqDBY11btkGVVSVMERYkLrXZKh+77lCAEEKUDhpvK0VwM7fZ7L2l
         wo8A==
X-Gm-Message-State: AAQBX9fFGatK+14hoUDeHH4sYeBt4aYRSTwXt/JsA/cazBnHewVTunDP
        PENROAEy1nPUfQILg2pryCQ0HyN2k/vO9ugPoaEcEezDOtQ=
X-Google-Smtp-Source: AKy350ZGIOzTwi67n8wJ6FELGdHfe9oHoWGhDvxYb/n2EZBrCTSgVFvEk41nAr/xjkyXt19uCzOhYmC/3Iyf94dBkA4=
X-Received: by 2002:a05:622a:1310:b0:3ef:5bfc:de92 with SMTP id
 v16-20020a05622a131000b003ef5bfcde92mr29561947qtk.55.1682490388768; Tue, 25
 Apr 2023 23:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <87h6t3rxod.fsf@mailfence.com>
In-Reply-To: <87h6t3rxod.fsf@mailfence.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 26 Apr 2023 08:25:52 +0200
Message-ID: <CA+JQ7M-jjzWFg-fV=zm1TLPibFZZyRz4-uojyUa9vwjRcf47Sw@mail.gmail.com>
Subject: Re: With git+ssh deprecated, how can multiple git identities be managed?
To:     ParetoOptimalDev <pareto.optimal@mailfence.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 8:11 AM ParetoOptimalDev
<pareto.optimal@mailfence.com> wrote:
>
> Then I could use it like `git clone
> git+ssh://paretooptimal-work/some-work/codebase.git` or
> `git+ssh://paretooptimal-personal/some-personal/codebase.git`
> respectively.

Maybe I can't see the forest for the trees but why can't you use
  ssh://paretooptimal-work/some-work/codebase.git
  ssh://paretooptimal-personal/some-personal/codebase.git
instead?
