Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02AFB203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 17:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbcGXRUE (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 13:20:04 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35125 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbcGXRUD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2016 13:20:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id f65so110165392wmi.0
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 10:20:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wv3aZhRR8OtVwNoBUmqD1MkfAqpsipGZyIB11y7sSKc=;
        b=o8DR6i08zBz64ZzzIxEwXFx7odJFXlUQsE2O+ShX926SpHDrL2HWffhLJkPniVw2zV
         wxM5JMMi6EhlDXAjin9LsEjEwb0QX+KYV07yNCVvB8m+gXEl+wUJJLvb0qFMVPe2AKug
         xIpIePn7rakckdQSYNpL+L+HI71kGMWtAnssFPRlh6N9+94zTQO5ExkJvh9460/rmrif
         im/0yCZYAQxY6X8V8CrqD6wfZAYQdxJkSJldXFWchEZofg+Ou5uZbOp9X3bzjFb0KJZD
         iR/lk8gCclUlHqreO+HI7ishE9jGqoMd2jQuoTtKVdziV0ggL0zdjtqdjDp8EmwDpa31
         A4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wv3aZhRR8OtVwNoBUmqD1MkfAqpsipGZyIB11y7sSKc=;
        b=eI8WEQNxTqKB/HdlXMF8x17fEgkIwKm7GMZU4lCx5zcQxbteEUHzsF830kLII5IqFz
         QzycVvngTNsS+gqasz1JwQZKMwTxR2x1nPgxpD4+5533gqi4eWycTSIpwr/ExyfR4Chl
         0jC29OWVyEZwuqXRiKB7VerlOztyBkRqCBp/JKI03pvjSbEniGhElnFTRCjNa9csBnmf
         u9Ew8RvGuqPPAYUBDJNw053bVCIc3bfoeGmcEZeHu4jmbnkEqJgPT4lFbUKBm5cxAsE5
         dFFykbazzMWbFiPmLCmrygHJOsxdzr0KyhParg9vM+KGrcXjG31dxGaNLnsrP/sJJouI
         ERrw==
X-Gm-Message-State: AEkoouuCns121FdL0hWYKJnL8IgYEJBCyBS3CDoi5tFUXt5NiXSi3lTw2Lzlq5FRxfxLVpYfoZdmyWiwpC9zuQ==
X-Received: by 10.194.144.114 with SMTP id sl18mr11505825wjb.123.1469380800880;
 Sun, 24 Jul 2016 10:20:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Sun, 24 Jul 2016 10:19:21 -0700 (PDT)
In-Reply-To: <6f7eea6b-2446-5740-cbec-141d71a33ea1@gmail.com>
References: <nn1euf$h6q$1@ger.gmane.org> <579483B7.4090508@gmail.com> <6f7eea6b-2446-5740-cbec-141d71a33ea1@gmail.com>
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Sun, 24 Jul 2016 19:19:21 +0200
Message-ID: <CANQwDwcy_AXTmG02ynNanNvoNVnK+t3uxf5r1J5tHn1hxaZ9kg@mail.gmail.com>
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Jon Forrest <jonf@captricity.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Re-added git mailing list

On 24 July 2016 at 17:57, Jon Forrest <jonf@captricity.com> wrote:
> On 7/24/2016 2:00 AM, Jakub Narębski wrote:
>
>> I have not checked the book itself; it would be nice if it were
>> hosted somewhere, even if using GitHub Pages (per-project or
>> per-user).
>
> Do you mean in some format other than pdf and html?
> What's wrong with sharing on Google drive?

As far as I can see you cannot view it online (without downloading).

>> Could you change the description of the repository, and perhaps
>> adjust the README so that it says that it is Pro Git Reedited?
>
> Good idea. I'll do that.

Good.

>> Have you tried submitting changes upstream?
>
>
> Yes, but they're not interested because most of my
> changes are very subjective. I have submitted a couple
> of obvious minor errors, which do appear in the upstream
> version.

Ah. Could you tell me the summary of those changes?

-- 
Jakub Narebski
