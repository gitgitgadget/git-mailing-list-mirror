Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD74F20C11
	for <e@80x24.org>; Tue,  5 Dec 2017 11:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbdLELK1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 06:10:27 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36030 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbdLELK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 06:10:26 -0500
Received: by mail-it0-f68.google.com with SMTP id d16so612050itj.1
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ntv+e54S4vm+Ksl1IcMRDnho4Yo2A86N5Kd7IKU+k8E=;
        b=sQexbZIVX42uZMJJoYiwFMJZhmL/guVznTTcSAd4HeEnlfqkIycWH2a1PjG8bC2gxO
         gfYv9lLMG93646VkaqP2ydu8iW8q9D3EM9VeKchLpvqoaO19ywwAg4aLZdY63fq6qP6R
         fboqQ9wHp0nEuEvrCJQ2aPG6ayllYDQtwX7ask4t7h4lz6GqMdrsKBGepX874io6fSr3
         zFTb+LIXwO/CdX5XxikMi8QTVvdZQxuGmnJ+JmWCB/St4t0h5v9Z4o6mRczqz+RwSDFx
         pdJ4JJg6JocYUfDpmU2cZsZXhJG65GhI+XyIgIDbLcZWDHX+HHjmECRBXSZFCgWp4fXO
         YPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ntv+e54S4vm+Ksl1IcMRDnho4Yo2A86N5Kd7IKU+k8E=;
        b=grC+PJmWl0753JnRZsGUiXiMq1dA0T9KE2t8TV0DjN7hu+lNcwoG8/nsS5n5+OF+GH
         YUf94quq+YOy8OJHJrHLOSFQe0NAqLq5WkiaF0pH6yKgmJ5ULYlClo/IKqQZ3Bcz4D3L
         EZaxd6g8wgdxhR1D9oYYp+XPMCPepWnOBkWbv+pxkEZR59vutZ3dkId67hUVLazfW4fG
         igqSU4UabxM/0lBmpVhTvUJ3MTfT5zp5wALUKVf/Hb5fCkv2Ctf9ksEjXKVcIP3sXkVE
         AR2MTY5HBg2jzSLtxxc/m66RM1SRzS2FdcuHWPJzEYdrb64lAoJfNMyqdJlyfpMXUjCR
         MutA==
X-Gm-Message-State: AJaThX6f4BrjLZCqsVTivJ2XrobpcJ3IrbAskQf1+qEU0WduVVyKiewq
        y3Rxr5T49865R1ATy6eX6Pp2uwEaOiPG2fAUWhI=
X-Google-Smtp-Source: AGs4zMbaw1EAt8YdlUD+/+2udhKZh/HZV5R1x2xF6Oz+I2YDekdB/2Vf10meC1nI2zHJYZxk0Erk0EYbXGCPXL0ecb8=
X-Received: by 10.107.183.76 with SMTP id h73mr28303025iof.154.1512472225882;
 Tue, 05 Dec 2017 03:10:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Tue, 5 Dec 2017 03:10:05 -0800 (PST)
In-Reply-To: <BBE0F8C1-2B9E-42B6-AE47-90C8A62A4F84@gmail.com>
References: <20171204220228.GA29422@sigill.intra.peff.net> <20171204220700.GB18828@sigill.intra.peff.net>
 <BBE0F8C1-2B9E-42B6-AE47-90C8A62A4F84@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 5 Dec 2017 12:10:05 +0100
Message-ID: <CACBZZX63ZhOHXmgerpJHc+ri_-w=QUyOQ7feWHxyDwPhN8hnDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] progress: drop delay-threshold code
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        lars.schneider@autodesk.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 5, 2017 at 11:37 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 04 Dec 2017, at 23:07, Jeff King <peff@peff.net> wrote:
>>
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Since 180a9f2268 (provide a facility for "delayed" progress
>> reporting, 2007-04-20), the progress code has allowed
>> callers to skip showing progress if they have reached a
>> percentage-threshold of the total work before the delay
>> period passes.
>>
>> But since 8aade107dd (progress: simplify "delayed" progress
>> API, 2017-08-19), that parameter is not available to outside
>> callers (we always passed zero after that commit, though
>> that was corrected in the previous commit to "100%").
>>
>> Let's drop the threshold code, which never triggers in
>> any meaningful way.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I tweaked your patch slightly to clean up the now-simplified
>> conditional.
>
> Your first patch ("progress: set default delay threshold to 100%, not 0%")
> as well as the modifications to this one look good to me. Feel free
> to add my "Signed-off-by: Lars Schneider <larsxschneider@gmail.com>".
>
> Thanks,
> Lars
>
>
> PS: How do you generate the commit references "hash (first line, date)"?
> Git log pretty print?

$ git grep -A5 'Copy commit summary' Documentation/SubmittingPatches
Documentation/SubmittingPatches:151:The "Copy commit summary" command
of gitk can be used to obtain this
Documentation/SubmittingPatches-152-format, or this invocation of `git show`:
Documentation/SubmittingPatches-153-
Documentation/SubmittingPatches-154-....
Documentation/SubmittingPatches-155-    git show -s --date=short
--pretty='format:%h ("%s", %ad)' <commit>
