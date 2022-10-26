Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB62C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 04:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJZEjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 00:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJZEjN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 00:39:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D195E71
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 21:39:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o4so16154988wrq.6
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 21:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVx7n4HWGiUSUh+knhMhC+jcYz+tP9curFRcZf5roWM=;
        b=PGO2KPVBv4i4l7ohgLl/66pSnAiSw7q87DFdiRBn/pLtKQBNxJw5OfdADIr4q5xsWc
         WWY69Nj5gitU+VxDAb9jO5/xLxIh65muMJB2qKDAwK+OTjTVTLgkNdVum8zD6L1FJa8O
         XAOoh2me0G4cs1IFj+wJL+7VA9WCb0SPnBXUWfR3W6sRChYJZXDeQw8NA8lk3CAEk9xz
         +TRcZGMb+5jbaQMg43RdMzbYSsva5s5ZuTyCiNM64kULSnb8LiNEv5BHXVaGfEWqGqvz
         qxBYq+iwhgZfpsl5xJWwpKbStqBcxHAFUSsB+vagDWptjWZnEZxiTUkE3p0al9ttteUV
         7s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVx7n4HWGiUSUh+knhMhC+jcYz+tP9curFRcZf5roWM=;
        b=uZfTGEULD8cOVz3AxvOuKyGMSwCwefNd3p61Ri8x9gSbNVLcxRH7096RhMY1lIlF0b
         DFauIwy+MMTiTlHZGgvGccEJhePFXuaXJyDZSoG0HjIC5sVRe9Vr40A8BWghoUGNz1UI
         T5ZsfO1qkZssZVQZBq67rNLNoa0bND3SEsi8kKYm1NfEGO4Abo4r951jHU5kOm+okVlo
         VaEOaja0RDpkLBde8AKE/tKi9ftMd3MOE6s0JnXwbMOZg/6ECWnENzVNMJP+dQ1j4SCe
         a5A8hp1HYUwhq8dk1xIcUbMPSFF3yYyab6/b/IfQXF9uOrQSHx9Qvgzgg4rn8P7eEiE2
         p0Gw==
X-Gm-Message-State: ACrzQf11SUkU012dkb6WBU3gsDCE4RXhF5no8jGwQkch2aCOGN81Sg2I
        mhMfA20C/Qe0pe7y29NoqiY=
X-Google-Smtp-Source: AMsMyM4FkdNrxxdADl/qtQqYA8hhSeak4uusrQYAAuRVxQtC8l7w4kHL+QWIwj9kK10cAc2d+pKPAg==
X-Received: by 2002:adf:e5c3:0:b0:236:5092:7cfc with SMTP id a3-20020adfe5c3000000b0023650927cfcmr18081040wrn.285.1666759148483;
        Tue, 25 Oct 2022 21:39:08 -0700 (PDT)
Received: from penguin.lxd ([95.146.54.42])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003c6c5a5a651sm705314wmg.28.2022.10.25.21.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 21:39:07 -0700 (PDT)
From:   M Hickford <mirth.hickford@gmail.com>
To:     bagasdotme@gmail.com
Cc:     git@vger.kernel.org, mirth.hickford@gmail.com
Subject: Re: Thanks
Date:   Wed, 26 Oct 2022 05:39:05 +0100
Message-Id: <20221026043905.1654-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84143b0c-139b-63c5-519f-8d4a44254976@gmail.com>
References: <84143b0c-139b-63c5-519f-8d4a44254976@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > (first message using git send-email, hopefully I followed the instructions correctly)
>
> You messed up the thread (you broke it).

Curious. The thread overview "5+ messages" at https://lore.kernel.org/git/20221025015116.4730-1-mirth.hickford@gmail.com/#related looks okay to me. I followed the git send-email instructions setting the In-Reply-To header. I changed the subject -- maybe that confused some clients? Thanks for the tips.
