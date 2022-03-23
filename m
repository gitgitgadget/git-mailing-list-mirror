Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02EAC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 13:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiCWNe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiCWNe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 09:34:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240175C2C
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:32:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id bp39so1102675qtb.6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tx8L5ai4wsPuHmFCoYQBTzTCiFZ5L9S+2OXZ9iFxV1A=;
        b=hpinfUXqMrlmi+WVwfaupYOFpwf13Iz8rmdmCHt+N3rxKAHcEPMM/epCRpQOg6XRRM
         S0u/rH0QFAuWysxgPRNAGLuld/8NsNWTmyMyNhd28rgM6rcdaBSlIlc+vPzS1R2BZ7Or
         k3PrHf2mTAk3x9eDFFF49ThNRf2uZqH5IdiA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tx8L5ai4wsPuHmFCoYQBTzTCiFZ5L9S+2OXZ9iFxV1A=;
        b=h3L0lMBGDZUE7n9Henl7m3iFaUtCfksmS4HINxEHZYQkVAv8UZos1P9NtPXB0KVtFo
         /BFdPmm5B7L4veo6DjIByeKmYMcbBPMZX0eXnqbxCB9u12QbqbZv6YA2fOvqTPxuWOgr
         OF31/GHiB9j8Gk8l9SFOYtWWbjY6iINgz0difCtoGrvTbXfuQCO/p2UNfHfQ6PMHbvd1
         s7OqJ3s6cDIyBNr9sM9/PaOmTGyob+rThC0G9yRjUmcivBepPp4pqdids/t1Jo7BjQBW
         dDaB1db2coSZg0SfFhBdzyJK9R0Gj+g7FY3Lo5sIA/ht0qrJ329Sr2jgs9qkIj5Rs71S
         ACOg==
X-Gm-Message-State: AOAM531cSsB3KgiTQFuilXLt33JjcJH8isBzDIGv80i4w5ogwGqdQlva
        8gEodPgEyqymZHWeA0Y/YbNuVxsMLk+4Mg==
X-Google-Smtp-Source: ABdhPJxnuHi5v6f5PZ2jufARnMWfLEM30apIvcPKp2McEehqTy2DUtF9kha+G4kxW0ZA54FryZ3LZQ==
X-Received: by 2002:ac8:7ee3:0:b0:2e1:a508:c500 with SMTP id r3-20020ac87ee3000000b002e1a508c500mr23788019qtc.117.1648042375364;
        Wed, 23 Mar 2022 06:32:55 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id m3-20020a05622a118300b002e1beed4908sm55217qtk.3.2022.03.23.06.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:32:54 -0700 (PDT)
Date:   Wed, 23 Mar 2022 09:32:53 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: lei + thunderbird recipe
Message-ID: <20220323133253.55i4sy5fs2zy5ocj@meerkat.local>
References: <6cdeed25-9964-909d-376d-024e1385840c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cdeed25-9964-909d-376d-024e1385840c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 07:55:34PM +0700, Bagas Sanjaya wrote:
> This thread is inspired by Ævar's recipe [1] and Josef Bacik's recipe
> [2].
> 
> As I know that GMail have issues regarding delayed ML message delivery,
> I go trying to use lei to fetch ML messages into Thunderbird.
> 
> After installing public-inbox (I have to build from public-inbox.org
> sources because there isn't yet official Debian/Ubuntu packages), I
> begin fetching Git ML messages up until 18 days ago (within
> public-inbox sources directory):
> 
> 	lei q -o "mboxrd:mbox/git.mbox" -I https://lore.kernel.org/git
> 	-t 'a:git@vger.kernel.org AND rt:18.days.ago..'

If you are a Thunderbird user, you can also just access
nntp://nntp.lore.kernel.org/org.kernel.vger.git much to the same effect.

Lei is best suited when you're doing complex search queries across multiple
lists.

Best regards,
-Konstantin

