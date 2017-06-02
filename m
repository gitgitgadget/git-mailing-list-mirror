Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE32D20D11
	for <e@80x24.org>; Fri,  2 Jun 2017 04:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdFBEzW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 00:55:22 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34018 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdFBEzV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 00:55:21 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so46111189pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 21:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x2bWX2ryAEqri2/hQ0wuFCMbLPTvB+BORb6orLEm7TY=;
        b=feDVwAwMB5OSAWyI06HyPzML1+w/xr7J/bExF/990wbz9QT274uD7iuoyAaFxFl9to
         +unnx8ZO3gjyzrdI2bgEtUgR9Y/PDC6hubljb0jdpprYuaykW7c11GKYS7LQdiA1WOWG
         V3q1Tiyl87s2jISjHOxoB2PJ7zfe4hOQA4a+jA86MCedxc7Gv07x2AkrfN3Y/Q6ubiP7
         6eSU3qcpVlp++HESDMls2bO9TozQrJpQKxGwEudbz7jsuVohXTC/PJjLNhdKIopJLec6
         uH+/CvGy9r1sTaxX/GBVHzopOz4dyDrQPTmZLClKYJky39jKdXYR0gDIfeYS0TDnlII/
         sngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x2bWX2ryAEqri2/hQ0wuFCMbLPTvB+BORb6orLEm7TY=;
        b=HsHuojtJPQyQbOUIA57hnTqd/hYsOZ07s1+XTwve6UAjSoQZm/FEIyZcq/5MjiJr/n
         +SCSOUxcDCFq25owDG1PiAANiBWs4ImxR1LsrwMzQm4extTjYBDilMSVaBypC/obp9NA
         NztZvyfyZbV/Lb6DEG+qRTmcwSm/Ib8NataPR9nAG2YR2TyhXqVrxjbH1SocwGroanjq
         S4kq6Srk1ilG+vc9A633K3MOJ5m8JNaqBIim61KlX1Kq5IyxdDC60H+YcPcaLlFTSNqy
         8VXKRvkCCVZimbQG/XTUTagnclM6VA7xA1+9Ac1tuobro/dKb7AW/gbiagijJ+8q9Hvt
         l0pQ==
X-Gm-Message-State: AODbwcAc1TD6GiNaL+9JB+If+a+EV2GSqYJ2iguV9jrW4NJECDG3s6LG
        U0X/FovNP+1ZEw==
X-Received: by 10.99.55.88 with SMTP id g24mr5032719pgn.176.1496379321240;
        Thu, 01 Jun 2017 21:55:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id t30sm41329619pgo.63.2017.06.01.21.55.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 21:55:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pulkit Goyal <7895pulkit@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect Diff!
References: <CAJ-kjL-Y+x-ZROnNm+Ray54hwxfkA6K6uxYoUVQpa3NmrzbEMg@mail.gmail.com>
Date:   Fri, 02 Jun 2017 13:55:19 +0900
In-Reply-To: <CAJ-kjL-Y+x-ZROnNm+Ray54hwxfkA6K6uxYoUVQpa3NmrzbEMg@mail.gmail.com>
        (Pulkit Goyal's message of "Fri, 2 Jun 2017 09:41:34 +0530")
Message-ID: <xmqqinkfyonc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pulkit Goyal <7895pulkit@gmail.com> writes:

> I was working on a Django project when I got the following diff which
> is very much confusing.
>
> The diff is pasted at https://bpaste.net/show/c2cb00728ff0.
>
> As you can see on bpaste that in line number 9,10 I have changed
> "class activationview" to "class activateuser", but in line number 14
> the diff is again showing me "class activationview". Maybe Git is
> trying to be smart here, but the diff is wrong and I was confused.

I do not think Git is trying to be smart at all.  

The function context lines @@ .. @@ consistently is showing the name
in the preimage of the diff, no?  

The function/class header that appears in the preimage before the
hunk that begins at line 108 is activationview and that is shown
there.  So is the header on the hunk that begins at line 149.

So there is nothing remarkable in this patch as far as I can see.
