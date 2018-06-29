Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603881F516
	for <e@80x24.org>; Fri, 29 Jun 2018 17:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933688AbeF2RnP (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 13:43:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33441 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932999AbeF2RnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 13:43:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id k7-v6so6093039wrq.0
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=89fHG2G6ms/mQYAG56v9SR06w4a/MtMEzdIq+7VmywQ=;
        b=M9VYWgn9BbFdXuyPWcXvSgCq+Ax3OBbv3rL3Tj6DGwkboOvEEwZD6LQewnypWDIT25
         c+OUEm//3uyLj1eOSSI+L/pKJOr2MIE+RKCKi5zz0yoxrOcYfmqMtjhvwg7Zq6u3ppBo
         5Thxl0LFZqXmg4GyxueoCcBpaFCd4ljdBYUXB4kCViCRLxJoKE72fF5PiQS9f+1j2LVs
         yHqZhtt647TbrbBOZYVP+2/FeVmc/a/Y1ip8NxM2rP1kWIDdXYwCGqkqAoigMObyKaXf
         vtIFT/qiDxsrJzfyax/XaX1bljX6NM1plD0N4yBnW0GrJEMWhzxXRhK3yHfvFAaY0R++
         +LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=89fHG2G6ms/mQYAG56v9SR06w4a/MtMEzdIq+7VmywQ=;
        b=bhTAvX4ItT8ANv/N+IDq3fXLFTUIfjSuCWa7Q65AX9R1jTRY45XqXTIdQjQ3fYz+T7
         IkpENEitc0IMs79IH0H1dq11sKD6DbJAY+n9uRAeonUE4wZ3CI2hZI5DGxFxQPjxDPka
         MoOpH3ddqTSlGNkgV2M/ANblKAw0hFeQIgbFHQWLFZGC8EnvybvkUnQXAD9k5rXHa9yA
         +q9HaFNd6HbXCLJyTn0Df1y+9/K3DmMcQqWqiA+8FSUVbyjGYe/KRu1Btf89jIXgeTUz
         iOR+aIu1bhQzwMlKzwFg2TganIYhd4Uu+Q6fNXnMVHi8PwBuqS3x3v1MvmuQET+cvhl5
         QPFA==
X-Gm-Message-State: APt69E3Ad9wKZtzApI+p8fRtHy+bdE59cVrVjic4Dm3RthBXn8y42xmq
        PVeRLBruvDs7VMfh84PQpFc=
X-Google-Smtp-Source: AAOMgpcZrVVRtDmVmM7e/wHVQwlxZaRULMauy5juruPHO/UyxpjSOiZrn7BlfcYshLPSqLE1G55MqA==
X-Received: by 2002:adf:8f2e:: with SMTP id p43-v6mr10704272wrb.193.1530294193060;
        Fri, 29 Jun 2018 10:43:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l130-v6sm115481wmg.30.2018.06.29.10.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 10:43:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] .mailmap: merge different spellings of names
References: <20180629021050.187887-1-sbeller@google.com>
Date:   Fri, 29 Jun 2018 10:43:12 -0700
In-Reply-To: <20180629021050.187887-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 28 Jun 2018 19:10:48 -0700")
Message-ID: <xmqqd0w9v68f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is a continuation of 94b410bba86 (.mailmap: Map email
> addresses to names, 2013-07-12), merging names that are
> spelled differently but have the same author email to the
> same person.
>
> Most spellings differed in accents or the order of names.

Thanks.  This one is sensible.
