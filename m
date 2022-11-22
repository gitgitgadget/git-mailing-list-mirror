Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BBBC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiKVSOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKVSOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:14:05 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BEE4E43A
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:14:04 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id g10so14422126plo.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvyModsgHc2Fj1g+3U2kny4sW6UWLs5G5x1fSA8IcQA=;
        b=mbOAeaUDF9cdz9CZNpX2jXFyPYt5zm9cSyUwClRFyV8DFT7llZKnjkDciJnUuFAyng
         McuDw0SSvknST5UX07CJwLUEiUdhB7JIDOSzCYWdyLwsUsCZ96MTaSI4At54heeGy/RG
         BRlCmhg7PCva6hOR3BV73sjtDnMzUWQr/oPM9Ni0xSmtiS2w5cJNSBA2wpw0TwcOAsDy
         z/CzzFxVmEzv1bKgUa4m3k2SghAXNbEgf2trWz8DS8tW4+DvCXycTgqCMkWKZhY711ms
         7eBgCFBjcYrMEcvS2nJ2cJNy6XBgXgKpzAQy8XnDpVbk646xVeLRoQfbu93y46+FpKb4
         5ugA==
X-Gm-Message-State: ANoB5plyw5A2MwQYV4ckUr7RWPVqC/O3qjbf6uFItombe+61KYXATjxM
        gf8qiWS3W8+sK4gU0LhAUA7wI3YQDvjglwyxcM4GfW9SqVs=
X-Google-Smtp-Source: AA0mqf7BzhKvQarc/MdbQYqnh7Uez7UnZEc+IEqaRpIjH/4ybxXgzAZ60gMIdK4ibldforhB0tgERYZfgim5Goq6wrw=
X-Received: by 2002:a17:90a:bf17:b0:213:587b:8a83 with SMTP id
 c23-20020a17090abf1700b00213587b8a83mr16274164pjs.22.1669140843838; Tue, 22
 Nov 2022 10:14:03 -0800 (PST)
MIME-Version: 1.0
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
 <CAPig+cQrXb-YUSzmfgJ2PRoiOP3goVACRCrX9C39kf3oDH+BHg@mail.gmail.com> <CANYNYEF+Gsas5s7u3rb3CQeFPL1MoCTweA4e3L90vCD0rPsNgg@mail.gmail.com>
In-Reply-To: <CANYNYEF+Gsas5s7u3rb3CQeFPL1MoCTweA4e3L90vCD0rPsNgg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 13:13:52 -0500
Message-ID: <CAPig+cS-BWJoWgo3UEk0X6fRjsysR0_23ppn9WX02Gy+ugVdOQ@mail.gmail.com>
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     Andreas Hasenack <andreas@canonical.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 1:04 PM Andreas Hasenack <andreas@canonical.com> wrote:
> On Tue, Nov 22, 2022 at 2:57 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > We would be happy to take a patch if you're interested in submitting
> > one. Otherwise, I can submit a patch to fix this case. Let me know
> > your preference.
>
> Can that be a simple PR in https://github.com/git/git/pulls?

The project doesn't take pull requests directly, but GitGitGadget[1]
will convert a pull request into a mailing list patch. It looks like
https://github.com/git/git/ is one of the repositories with which
GitGitGadget works, so presumably it should work. You could probably
come up with a well-written commit message by paraphrasing your bug
report.

[1]: https://gitgitgadget.github.io/
