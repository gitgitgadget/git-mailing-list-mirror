Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092DCC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A4364E77
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhBKH3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:29:48 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38767 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKH3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:29:47 -0500
Received: by mail-ed1-f46.google.com with SMTP id s11so5911757edd.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmNAphgyVt2k0asoK7ADgT2iUzoWHq/omM1FfSfBksc=;
        b=uejpc2ydZ0Nuoo4og4tKsor+mUKb5O3+NmfQVf3c0fktnkSEGQ901lFjogdfnJERgW
         EoUvcFc2RVG+zXWCHcesxK3mVzy8VN+PrsP/d3Vh6nvSI26CtNCZmFpkKoSPH2Ch/WQv
         nKgcuLsmfd4xkWkyq+GLNo2XJTtlbg+hZ+sAYyS6L9LvEpZZXLlVodRbVQa5iAk9dRnM
         29fq6TJLy4Anmh6P5jxq3HBkXOhJ5fG4xPVcrJobgn8nMv4N0ekFRCc/vTcXQwzFkxtS
         4soI2z+E7e6kMJP9vsm9ejKMOZn4yBobZezOeSXTr2FCpLmfrsFMYdfLBWzuEnqXgDU1
         inbg==
X-Gm-Message-State: AOAM532Dt+FqMG8X1/QT7Sbs5HIbdItnnJf4irTReMQSUmANxsZ/WGJy
        r2E3pRYEN8WQvZDxwxHQ7oWiIbPhGmXay8GZt/s=
X-Google-Smtp-Source: ABdhPJz5mxHa7VztSCVOAopgnaIQNQHaaFLOq4SR133Nhe2Nz3Lm3e+j5DitWJdaoltyZpgUc4sQptUZHNST7ZUBvTs=
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr6871331edt.221.1613028545362;
 Wed, 10 Feb 2021 23:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20210209173254.17712-1-shubhunic@gmail.com> <xmqqy2fwyhjy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2fwyhjy.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 Feb 2021 02:28:54 -0500
Message-ID: <CAPig+cSXi7Ct48gqkBVvBtOm6bMqDhPcxXeiK3ZytAitZXNT5Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Modernizing the t7001 test script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     shubham verma <shubhunic@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> shubham verma <shubhunic@gmail.com> writes:
> > In this patch series modernize the t7001 test script by changing the
> > style of its tests from an old one to the modern one and by cleaning
> > up the test script.
> >
> I would have used test_write_lines instead of here-doc in 9/10, but
> that is such a minor preference thing that it is not worth going
> back and replace.  Nothing else stood out during my cursory scan.

I read over the entire series and likewise didn't find anything to
comment on, thus consider it in good shape. For what it's worth,
consider this series:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
