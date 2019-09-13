Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7E11F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfIMUDX (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:03:23 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54630 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMUDX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:03:23 -0400
Received: by mail-qt1-f202.google.com with SMTP id c13so32730416qtp.21
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AzSw2MqD7zIe2/5v+036wxK4Tw4sBvHtpLrOoeAc4M8=;
        b=TQdD6E8zAk9MPzDV3D5wENmTj7PmE+IW+Kos2BwUHP+D4b2PIT6GCtWmmtyZKogJL6
         fkMS2pjdzYHz2XIkNOXvyMicvx+o8FgVW8bksPSyXrXS840ABnXJDGJggFRr8sDt6vgV
         e5MeQiEjTKWoKns+/mQEP9t1IwNmuGHid88To6TZxKWKUjeWgWD12Z9v3iwWSErZ8zZ9
         aE+x6+4jIWOb0anegIm3DpATUqzlHL2P5cKkajJezWfaGj3IMG49tSfseydFGEvLF9G/
         t+koyvyHnNxGnj44LTGbfv0mbebjfLSOav0CGpML2VLUXdLCFUyighM1aVuPcGICqk8a
         T3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AzSw2MqD7zIe2/5v+036wxK4Tw4sBvHtpLrOoeAc4M8=;
        b=t1Hd5S8ZmYBsMrLsL6SwTb7FSif+7KpomPkzKqlzusuLsBlUz+TOhPOlmiCvFkKD5C
         AXxWnvQ2KrcCu09sv/G2NulYfGkN7tWiepoRbicMIjiekMPuHdGAEthKWt/+P8EqtOxC
         Zk2Avw2/WMyXLkd2sqqDD647HjJW1gFTc4CmOetCHi7CWDIzL6ZYm5DExDOjwjbSgGNb
         FwsLQNmh8EJ2Uj0opS2L71H696anXIZas+I/EzJP64dYKXqaYMndEGFJVGwcxxKp7yU0
         Iq6E+D/HNHWq/NHv2899D6/FQilW+zbw2bf+ZO3D5SvXRnLnr4+BGVRGay/LcpkYUO5q
         1++A==
X-Gm-Message-State: APjAAAUP2EXABw11eEdTTO2QYu2wJj2MswvsTAxFI2wjaw6awlmKwV7/
        TMIhkfKswT7sidQVuQS6Ambh16h1UZu0g2x25fLv
X-Google-Smtp-Source: APXvYqwfxf8fT+0FetZSRQBl9gLgdcqFp/o7pIwqAwa71WdwfSE3bDAdXVqxYSOMCAZdWT7fVfx6NvoCfTXsHKkWWLfq
X-Received: by 2002:a0c:98b8:: with SMTP id f53mr27819480qvd.157.1568405001652;
 Fri, 13 Sep 2019 13:03:21 -0700 (PDT)
Date:   Fri, 13 Sep 2019 13:03:17 -0700
In-Reply-To: <20190827051756.GA12795@sigill.intra.peff.net>
Message-Id: <20190913200317.68440-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190827051756.GA12795@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: Re: Git in Outreachy December 2019?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Do we have interested mentors for the next round of Outreachy?
> 
> The deadline for Git to apply to the program is September 5th. The
> deadline for mentors to have submitted project descriptions is September
> 24th. Intern applications would start on October 1st.
> 
> If there are mentors who want to participate, I can handle the project
> application and can start asking around for funding.

I probably should have replied earlier, but if Git has applied to the
program, feel free to include me as a mentor.

There was a discussion about mentors/co-mentors possibly working in a
part of a codebase that they are not familiar with [1] - firstly, I
think that's possible and even likely for most of us. :-) If any
question arises, maybe it would be sufficient for the mentors to just
help formulate the question (or pose the question themselves) to the
mailing list. If "[Outreachy]" appears in the subject, I'll make it a
higher priority for myself to answer those.

[1] https://public-inbox.org/git/20190907063958.GB28860@sigill.intra.peff.net/
