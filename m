Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18621FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbdBNXfM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 18:35:12 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35237 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdBNXfL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 18:35:11 -0500
Received: by mail-it0-f66.google.com with SMTP id 203so7950354ith.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EsRvXo8nOjDWvvxgRFXGnxPYqkwMAy3WNh4jiU0Ntsk=;
        b=uJ8zhr5Z+/mLl5ah2qrirJRAHb1ljRmdroKDu2EtjADmkuBZwQvLAtUNEsjf5Gjkcr
         j0Xa1ATexEyLNJAJ4ZnslMEO03lVas8Ds18oRTaJlF6KouxbYvk8FGi8Il2YGeUszNs+
         q6VUpTyiZr7ovOqzO19pQY7BLp5uAt0OrcxO2TSDbrY+hOJslipdZaZtbYQT8aNf53RD
         /gEGduF7OvmoKddDjo5/F9XAbjuJ5p5DietRJGaF04M/sda5Q9nBKyUFUxIrQK9Ar1ZC
         VXeu4doACZHNc2LJF6erbIIgvJa7eRYzVvwhaJFn2Fa6/i9RSNSqt0S/OrQpakV3AeP3
         4tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EsRvXo8nOjDWvvxgRFXGnxPYqkwMAy3WNh4jiU0Ntsk=;
        b=Tov7W20amODi54M1pBJPNk1w0PCc2a+3Qk/0qcjsaxtZN75SqfvbuAkSx1lxTS+/w2
         G+931KjgVdpa578rBWKTGklbnZLfLfu7R6BPdD3MXY/Afdm6leF2blJ94MACUslYAvgM
         w47TLCmp++pkR4uvfrE3r42nPTdV8G/loanBx51sR+u24dsA8UqCLu+uHF5RJcRVliHh
         1L9zw2gesf5aO1BI8RHqNbgIkRbJqNUW997aKEZvUaFWiB6tsij6sPdYN20eaW1M+JFe
         G8Lrxc8e5cuRWjawmLF49BjF+cuc4YWJZAa7nDYCgXrCO+CLRs9t/vd7p3KfNRIL1H+g
         /Ijw==
X-Gm-Message-State: AMke39kw3uyHyrVynxHcD+PaXViI/VdFtKdAXw2Aaqc945hS7atPTkLCf4EyLR8bfIXsKA==
X-Received: by 10.99.110.74 with SMTP id j71mr34865648pgc.134.1487115310255;
        Tue, 14 Feb 2017 15:35:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id s3sm3192385pgn.55.2017.02.14.15.35.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 15:35:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
        <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702142150220.3496@virtualbox>
        <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
        <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley>
Date:   Tue, 14 Feb 2017 15:35:08 -0800
In-Reply-To: <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley> (Philip Oakley's
        message of "Tue, 14 Feb 2017 23:27:00 -0000")
Message-ID: <xmqqshng5osz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> There are also a few ideas at the SO answers:
> http://stackoverflow.com/a/5652323/717355

I vaguely recall that I saw somebody said the same "mark tips of
topics as good" on the list and answered with why it does not quite
work, though.
