Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBCC1F51C
	for <e@80x24.org>; Wed, 23 May 2018 03:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeEWDQl (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 23:16:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44113 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753717AbeEWDQk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 23:16:40 -0400
Received: by mail-wr0-f196.google.com with SMTP id y15-v6so23644500wrg.11
        for <git@vger.kernel.org>; Tue, 22 May 2018 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pyzv0Um9iPiLkib3dAEt8hcGS3NXbStw/b0XnZ1QhU0=;
        b=Ii/ao1Fm1y4jNrKrji6vmQ0dQzETTJ/qa9q6CCzEu+dyoImP/zIR9vDCKqwXgsCFgu
         IzJW8MfT0aveGoAoeGLsGlxlPKldqVXY5P2Tx8V2y64pN6VgumkcMb/FIvJNF6ms+YXN
         zcKCD2cUQ0eypPQMvFRzrlvgvrQ8dEEKIUuzdTMO7CwfaA84QQWvMHkxOFoCsezSB6uD
         an8DH2BMwmpJJEhcZkfJpk7zA207tp3AwX2zpnrqmZuWTxXDtPVbZ7KEXosISnMTYkQL
         J8eAga3cnYkwc1Vi2GRRHFx9m858upDo3hWxgD+r4YkEyFukDhtZ0/CDWFJadQa1MSkT
         FLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pyzv0Um9iPiLkib3dAEt8hcGS3NXbStw/b0XnZ1QhU0=;
        b=tCXMv323FCXyowm4Y67pD6IgPp15TTBZamGihW2x8YvcbDB7KIk+r8bSG9RnQLLBRb
         zX5hU+TuDr2NHmIaP9HY8hXVDBRJe0/osJ61EexQjG3VV7wfC+yoGRYKCMAAIkuR5tIa
         n/LQaBk65Ug1RRfn/IDC6ZXisoZS0ucYxGtQho8nX5aCLbqR07Tb+cTqX+cL9VZ3Op49
         NxLoGN6/wjP9VCDdM0r4roNQyinAg9f2xFAMNsZeFeforY5GyqsueYGKSKyF/AW3hHxU
         pO9PnUrvT1flWH+xIv05F8Ba25vQDj+gC/pxNDYvX4l1mM4EXO+3kFjMJFjyfTi8CMcF
         Wu1A==
X-Gm-Message-State: ALKqPweMZNfh7L/q52KSSXC68he3bMag1+qp6gehQHMps5ylBi1ktbpV
        FNv43qKnlEOt2R8g6ndzabGWbrel
X-Google-Smtp-Source: AB8JxZrooaYzxN68UwnEdQJ1FoueKj948tR67dGXeVC1w27HOt+AcZuLZrlZo4vwPAm3/IyYuilo4A==
X-Received: by 2002:adf:d0d0:: with SMTP id z16-v6mr777920wrh.152.1527045399572;
        Tue, 22 May 2018 20:16:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x81-v6sm22607988wrb.23.2018.05.22.20.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 20:16:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick =?utf-8?Q?L=C3=BChne?= <patrick@luehne.de>
Cc:     git@vger.kernel.org
Subject: Re: Officially supported Git versions
References: <b5856696-bfcf-173a-49ac-6aa6989316d3@luehne.de>
Date:   Wed, 23 May 2018 12:16:38 +0900
In-Reply-To: <b5856696-bfcf-173a-49ac-6aa6989316d3@luehne.de> ("Patrick
        =?utf-8?Q?L=C3=BChne=22's?= message of "Tue, 22 May 2018 19:20:01 +0200")
Message-ID: <xmqq8t8bvz6x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Lühne <patrick@luehne.de> writes:

> Is there an official list of the Git versions that are still actively
> supported?

Depends on your definition of "official".  Distro with lts may patch
older maintenance tracks longer than the upstream releases do, and
as far as the normal end-users are concerned, Distro packaged
binaries are as "offcial" as they get, probably more "official" than
what comes from the upstream and then built from the source.

I however do not think distro folks advertise which maintenance
tracks they backport the patches here on this mailing list.

As to the "upstream", usually 'maint' track gets all fixes, and
probably one or two older maintenance tracks tend to get security
fixes as well.  Beyond that horizon, it's pretty much "as time
permits" basis.

