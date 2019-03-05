Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969EC20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfCEMF1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:05:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35200 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:05:27 -0500
Received: by mail-io1-f65.google.com with SMTP id x4so6836763ion.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2NJSI95GroSMyP8qIXbhw/GTO6O+7LS5180oej1P/U=;
        b=K3ov+Grn9ey74TtcqdHSr7JdIuSIJQlZySYOiaTMs35l19g/r9ySh0AXIGkFgB6Zcl
         7K983xGosgpPLA1io6lC4vpjs5fNiBYdwb9Y2WVxSgo00YXZNxWqG7TGSN/Qg133+Wp+
         0l3cajx0Tx4OnIQv1EH7S9ypoVD57qhHVZFDzwP9P5rqJt+CM47p+j7Dy1TQPr442jX7
         F3GTtCyUlcIe8K2Vn/kqEGbc8Ft1KdCxrtqQUrrk7lNfKFB8kgb6cdgOvF4E0kDDVWsa
         FARj+pT79nsfiEGfoWP4gjdhltFUVozPPi+vw9+YSSi+65jXQp15NvTpmSjPvCK8QcTS
         MMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2NJSI95GroSMyP8qIXbhw/GTO6O+7LS5180oej1P/U=;
        b=FuvN3gozZtlzxaW8JelvTNngX+Uwj+0Hg5gBu2TYW+E0tTsno84qS/STw1ApJAxf++
         ILsSlfRjfI4SbV8xOc4sp55HF76TAWaumaX8mw4/1jNQKvBpCZPIZv/a2uKJ21w71YJi
         +iklfxB09UIbpc/KAkzs4y8hhCWy7aR9ziitqrvb5IfSm4cyxFLmeqW2/+ilAzAUjmx6
         JOFC8aHWdjq36DE1EYHOJHZhUeB/WtA41MRfb9qtgsg8T4P0dl/1Kti8YYd5yg4ynhan
         fgGQXsg9uRu4ax8ceYq0Pt7O9Ea2le94E/+GQQrLJccySl7eYJkigFYiz+HQA/FRG9G0
         vTIQ==
X-Gm-Message-State: APjAAAXMzHk6WXzGGpirb9Yf/Qo00gaNOQAOv6ogiymyqf0tdPLY4ARr
        BHZztX2Sx4aXul49PBt1kiTaN0+zsmARquHi9RaKNg==
X-Google-Smtp-Source: APXvYqwy1CwBHicoqpHTti0I3jEbyrLU0BEtiYU+q4HVbGSMdmAcG8BRT/zJLAps/hyT/3yQk//OWuCwoBNmJAjCvqE=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr10538250ioo.236.1551787526752;
 Tue, 05 Mar 2019 04:05:26 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 5 Mar 2019 19:04:59 +0700
Message-ID: <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 4:17 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi everyone,
>
> There are now ideas, micro-projects and organization application pages
> for GSoC 2019 on https://git.github.io/
>
> It would be nice to have a few more project ideas.

Not sure if it's too late now. Anyway this could be something fun to
do: support C-based tests in our test suite.

A while back I noticed some test running very long because it was
trying a lot of input combination. The actual logic is not much, but
because of the increasing number of test cases, overhead goes off the
roof. The last part is probably not true, but Windows port I think is
hit much harder than what I experience, and I think Dscho did complain
about it.

So what this project does is somehow allow people to write test cases
in C instead of shell. Imagine replacing t3070-wildmatch.sh with a
binary program t3070-wildmatch that behaves the same way. This test
framework needs to support the same basic feature set as test-lib.sh:
TAP output, test results summary, maybe -i and --valgrind... To
demonstrate that the test framework works, one of these long test
files should be rewritten in C. I'm sure there's one that is simple to
rewrite.

I'm pretty sure I had some fun with this idea and made some prototype
but I couldn't find it. If I do, I'll post the link here.
-- 
Duy
