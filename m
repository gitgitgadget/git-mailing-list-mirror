Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C48D1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 23:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHDBkp (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 21:40:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37771 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHDBko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 21:40:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so8031325wmc.2
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZmfCW8uzemNJK4hB33sD/mE2qycjoxf0Y4mOkGS3sAs=;
        b=C2+dB2vxS6bOk1053jinWn+RfXLMKM8H0ps1kx4c7lJUobVGUrZ+ttirEOZNpdiaj8
         Ujr7ZgRquOQuuAzRiEouxHJGBJ6YYOy42Vxrs5hBBhe8GIMFP2hDCDOCkU1TrQEvy6Ri
         F8p5rTTLrBfDlyCIWLqjBxN58qSdNTsYuTR/ZMlvn1XntI0vl0FCf9fG7oraj9YXBJyx
         byp8J0dWH28q56RCtVQAfYchMp7qD38+hn86U89GBcGa+Q+TKe9liw9SB8D/wJL6dSNH
         KheYYun/8llT7XyQspc/9FkOMgZ75CTKni+Kr88g99wy0RHoM9XAH5QgljU9px+kh6Md
         SusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZmfCW8uzemNJK4hB33sD/mE2qycjoxf0Y4mOkGS3sAs=;
        b=nHP3Oxaexs/gIelYfgPvhlcbvLvEzu1dho1EMs4l/Vnf2Yfel/GDt5fvmnAmHMLXp0
         mOWpHcyC3EWJ874kQ5s+zbAckJVsRRH2Lk6H+glAXYW5/vgk3CF13KdPJa226q+FUZyq
         bebGQwjaIMGDDAY7zR1SY0/x/oomDc+5F10eaSCMk9zaVwMQ9U9/+rvOu3dkt82xUenf
         CeMjrZZgIZHbco6e4JP3D0EH385ywNnGOMIktDPKLina5oF/TztVdkSGsg4Wk+pyLdcX
         RpD+hX/zIxeZeQhGzIBUUuct2UXcDHxwTu/2QRCsFa9lJtOCHOCY9bn7I+uUwKlqM859
         WlFQ==
X-Gm-Message-State: AOUpUlGyJiFX/LbfNB/4tQT9hAlaTNztf24Yp0QxBJICkoeLwvk9bV17
        TsZJC2mFNPtbxgpb25o/Y3A=
X-Google-Smtp-Source: AAOMgpdYGLKJhC3wniNDFSr60Aa7fCfdlM0Sr4oxfL0SKmZfPrEHabonv2O6+F2hr67hQ6DUGcYUTQ==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr5830627wmd.18.1533339737557;
        Fri, 03 Aug 2018 16:42:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w3-v6sm6429515wrn.16.2018.08.03.16.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 16:42:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t3031: update test description to mention desired behavior
References: <20180803230923.25577-1-newren@gmail.com>
Date:   Fri, 03 Aug 2018 16:42:16 -0700
In-Reply-To: <20180803230923.25577-1-newren@gmail.com> (Elijah Newren's
        message of "Fri, 3 Aug 2018 16:09:23 -0700")
Message-ID: <xmqq8t5nuief.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This test description looks like it was written with the originally
> observed behavior ("causes segfault") rather than the desired and now
> current behavior ("does not cause segfault").  Fix it.

GOod.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t3031-merge-criscross.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3031-merge-criscross.sh b/t/t3031-merge-criscross.sh
> index e59b0a32d6..3824756a02 100755
> --- a/t/t3031-merge-criscross.sh
> +++ b/t/t3031-merge-criscross.sh
> @@ -88,7 +88,7 @@ test_expect_success 'setup repo with criss-cross history' '
>  	git branch G
>  '
>  
> -test_expect_success 'recursive merge between F and G, causes segfault' '
> +test_expect_success 'recursive merge between F and G does not cause segfault' '
>  	git merge F
>  '
