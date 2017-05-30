Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45DC20D0A
	for <e@80x24.org>; Tue, 30 May 2017 04:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdE3E3L (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 00:29:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36252 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdE3E3K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 00:29:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so15088777pfb.3
        for <git@vger.kernel.org>; Mon, 29 May 2017 21:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KZMLx0wn4ikGO1IvTO9KcbxhUbek69kURuz8WUtcmgk=;
        b=smFZGbC5ourjXWhDU9t3Ev+1jzXg+ouEX4ycYg9xdkzKzeMibBsUF37oOBpr2kDZf9
         c1R9DjVks43D++elyrfhQ/uWEq9wO1bOZj2gpJISKWCB3nfnTFmSHxWIPWxBLtqpK+8I
         yxNVRA0jO37kvHRYLeL7rAuA0CdyiqAmBF1ONBYhM5hrsUk+XrAnN4xBjzGWHCuLjTuI
         8j1uiptUesBg7pE8rEdOh2t3uqT3lln3D3PpQLVn2Ayopjxxqw+4SBCAEn0jsptoscR8
         QYKZtugZN7wzHuKgUmXU5lrtA5r6gcpB2U3m/vNsnKd3rI2OvSPLuLwlz4+QcBhXwHPq
         CXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KZMLx0wn4ikGO1IvTO9KcbxhUbek69kURuz8WUtcmgk=;
        b=HvKRv03SRlUzjAQWhzOd6Qr3oBTFBIb7HSo4yQb5/87/Ph6DoUmzLds31s4ZDyo27g
         w+Ioi+4KTd4tdz8tu5w02wyXxtuQO/rin/jwnJYH3pUfbW3FU2Eg9fo6sZcRtaaB4BpP
         OtXWtGLTJPk5RuwcBH9cM6a1U/+h3Uhj6BEwD3HN7Uc0RBp+M93kMWjWwIAdU0dzl7kf
         L+WUtDZRdwyHMWtA4lY437aKj7p+dT+HT27l4fLnLIOyvLemiXOwVa8FXpmm+z5WQOod
         7oHmW/DSLO3T13qLBSEtxu/uj9XN+Pq266LPTzKnYcRvhPy7ZpiQbFJFHW/rPy6J3Z9J
         dzXQ==
X-Gm-Message-State: AODbwcA/yXbtYGQM08z+XnZ+RzBT1joqGp9rfSVkE7Z9kvNo0XgzA7Ki
        YfX8ZqlMzHQU1A==
X-Received: by 10.98.2.85 with SMTP id 82mr21020458pfc.52.1496118550195;
        Mon, 29 May 2017 21:29:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id j17sm19787381pfk.23.2017.05.29.21.29.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 21:29:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: Add completions for git config commit
References: <20170528121325.4033-1-rikard.falkeborn@gmail.com>
Date:   Tue, 30 May 2017 13:29:08 +0900
In-Reply-To: <20170528121325.4033-1-rikard.falkeborn@gmail.com> (Rikard
        Falkeborn's message of "Sun, 28 May 2017 14:13:25 +0200")
Message-ID: <xmqqwp8zc6i3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will queue; thanks.
