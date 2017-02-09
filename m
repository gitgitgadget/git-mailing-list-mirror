Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1386D1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbdBIOLg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 09:11:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34125 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbdBIOLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 09:11:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so3079137wmi.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 06:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3i48WPzlVTlIj9VMsfKl4Cn9aYKz+eT48SOjXmvSqWU=;
        b=REN+mCINaefT3yJ4sYr3+lcVUovHz2DCmubGGBC590iz8dFvv6fLNJoBe+khz9LERb
         ZIDqcTJ5CnI3p5j+8AWymDyW7toxOcDpNfemfEGnUJUnngVcfo3G30ska/d2Xl/32MWT
         43MC7/H2aFz6o2+GIAlRyaDAEbrTQ20C17nzbZW+Fz/R6HO4tKKuWxWoxnjlLqqqyC+2
         yye7pQBfd8R2Qufg+Nv2iRnEQaWMhGpidtxAvAghmoejFLGfCGrtUnVoSZcJ6lZhDeG7
         cqrLGIxoD3Bg5P7x9Jna/9R9yjkwWRv+oN7DNfnsFjT4k63fVJkiU+TTA56Q1F1TWWf9
         uPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3i48WPzlVTlIj9VMsfKl4Cn9aYKz+eT48SOjXmvSqWU=;
        b=eQ27+0fP6VxC/+/KteTv0R/nPwobalfcpPDW3QTirXL10VYlWJVreIENj05ftNh6tg
         XhQKDShUu71b3a6lO5s9CgBHbfBY6/ewqAKPU52teePOZt85mTWBmiOPzaXKGFJLrnKh
         2WXq2Z5IxGHsT7CI7ZCl/7AHO6nO2oRGG6WkoW5487CQYALB7RyoBHmmPvQsoDbELylh
         qDkkaW+sDk/yqjK074Bl3O6CFYkoIfNpM8gwkvKDqoDfdcCrj7TMnyGJusM7P7aLgqBy
         FbNoUwuG8sn6lgfP7ud73vZXVz08vNn6WYhVWRsihk0aBQSeY/DA3dWJu7gZyjfmk2cr
         ZuYQ==
X-Gm-Message-State: AMke39klBbIbw7INGi57k77DYL2J4zmUxY2z9GH+AtJgkvc60a2kCVqLU7omsOWWy9oZLg==
X-Received: by 10.28.145.210 with SMTP id t201mr21391213wmd.42.1486649490548;
        Thu, 09 Feb 2017 06:11:30 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e14sm9071969wmd.14.2017.02.09.06.11.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 06:11:29 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Cross-referencing the Git mailing list archive with their corresponding commits in `pu`
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwpd316f7.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 9 Feb 2017 15:11:28 +0100
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3F7E4C9E-593E-4FC5-B820-E6A0CDEB7476@gmail.com>
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox> <xmqqwpd316f7.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Feb 2017, at 20:10, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> So I thought maybe the From: line (from the body, if available, otherwise
>> from the header) in conjunction with the "Date:" header would work.
> 
> FYI, I use a post-applypatch hook to populate refs/notes/amlog notes
> tree when I queue a new patch; I am not sure how well the notes in
> it are preserved across rebases, but it could be a good starting
> point.  The notes tree is mirrored at git://github.com/git/gitster
> repository.
> 
> E.g.
> 
> $ git show --notes=amlog --stat

That's super useful! Thanks for the pointer!
Wouldn't it make sense to push these notes to github.com/git/git ?

- Lars
