Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C56C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiCAJ0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCAJ0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:26:07 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5849C87
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:25:27 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id f2so12095653ilq.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+qu3dKD6o4kDmHZjJ1AwLE6CDMB0BX7OIWm9BDZKrY=;
        b=Nci8v+WGCNuyBv+sfsH8vGSm5qaUYBr7LD1MCplRAUKgo8K5LYXcRZS1LXr+IfZpt+
         zCfJw6dhy6m5B3rpk3yMTtjJ8GjAz5kW2fgspr+X1RD4FCBX4lAx1AlNqxbjPyWcK3D8
         N7pBWUBITVK9TRRa8t7VSSN17z1SSHIbylZ64wVkyAqAzizcADgR+za36VH7mBwHfEs0
         +nq5etUR8j8XmhTByTUViPi6JdpkO1H2nWHICVwsN6oFcrTDUqE5DDR5Tbg+XBVl0ZRU
         v23tn5EpnrdMfjoWTUhcPFbskTXzpch8Rpegfhs2DgtVk3UHKgi9ZEFolMsF59GAePSm
         p6dw==
X-Gm-Message-State: AOAM533ZXfCzQRgdkwEEnubkFya8TNXWRj7UghmGGqtHVXVDoFlc2zCv
        o5U7tM61NUXK5ElzF1HelGoH8A0dEf+mPWySHjdzT/i0hAI=
X-Google-Smtp-Source: ABdhPJyIdr4X9f9sg4fgBzUGekkobGBnQbXDfqg4iVMyB81Ey2oAz22IQkPOi27yhAiyoVyltL4z9G3t6REpF6OZces=
X-Received: by 2002:a05:6e02:2168:b0:2c1:a436:d18c with SMTP id
 s8-20020a056e02216800b002c1a436d18cmr21534794ilv.49.1646126726827; Tue, 01
 Mar 2022 01:25:26 -0800 (PST)
MIME-Version: 1.0
References: <YhPiqlM81XCjNWpk@ugly>
In-Reply-To: <YhPiqlM81XCjNWpk@ugly>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 1 Mar 2022 10:24:50 +0100
Message-ID: <CA+JQ7M-+kq1MTh+DG+HCmXkpsF5Esm_0V=4=2_DS2_ZYdjP2+g@mail.gmail.com>
Subject: Re: rewinding interactive rebases
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 1:21 AM Oswald Buddenhagen
<oswald.buddenhagen@gmx.de> wrote:
> did you mean to answer only privately?

No, mea culpa :(

> On Mon, Feb 28, 2022 at 10:32:16PM +0100, Erik Cervin Edin wrote:
> >What's the connection to the original thread [...]?
> >
> that depends on what you want to interpret into the original thread,
> given that a bunch of use cases and solutions were mentioned. my
> solution is actually functionally identical to one of the later
> subthreads, as i found after the fact.

Sorry but it's a long thread and at least I am unsure which parts you
are referring to and how your script fits into that.

> >Maybe you could explain it a bit in the context of the problem.
> >
> there really isn't much to it. the git log + git reset are the essence.
> just run it in the middle of an interactive rebase to see yourself.

Could you elaborate on the intended/usual flow here?
Rebase => Get conflict => Fix conflict => run the script => ..??
