Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46192C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5A024970
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgEDRSU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 4 May 2020 13:18:20 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34676 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgEDRST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 13:18:19 -0400
Received: by mail-wm1-f49.google.com with SMTP id v4so503721wme.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wz/sIxKj4N76rK7Qbgd/y2Gb9M5w58fYsq37wjhmZOQ=;
        b=fg3rhzITpJpGFxZkrjSIVfW5kLYR7jxrHkV+TsyBy2KcOX/YkkMjzbUuOiL32ZMmAQ
         vv5ib1D/KiDRhiayrG5A/FjAhjJtzi7Qh7m1LDVe2PDHuhRSB9y0ik6y9poFtmFW7iqm
         VfAJIOI50LhS0xtugHZhOFFR72z3TGJJBXnKJjDoDm0L8K95yy1kfsGMuaCQ4mLvi+o5
         a8lJbmddoxcihLvk9up1yMAPfKlMNL5jiHV9MKRzhgUPwg1wCDYThu/J1gZdE1lpMATr
         vScqOi0xvxuMgPoUnoIZjqVszoBXJwqHsSEhzNF6EYWJWZRkQZnwZCFQuCcLKJ471k6+
         HqJg==
X-Gm-Message-State: AGi0Pubos9c1UXy9rYMYGuPWh05rXogC+etM/Cvjp4y20XdpCs17EUB4
        9QYHuEOJNcidVRWiUCxA1IZve6V0g+cW9hg3rStET34j
X-Google-Smtp-Source: APiQypJ5hFo/muRcuyrasUE+NDJ01sfMw0+ror3ShnlZPrRh4JO4AFfH2VD3X4JAeRbhDVEjVvWZC5MIhnQEvaANfag=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr15333443wmi.53.1588612698100;
 Mon, 04 May 2020 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP>
In-Reply-To: <20200504165214.GF86805@Carlos-MBP>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 May 2020 13:18:06 -0400
Message-ID: <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 12:52 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> On Mon, May 04, 2020 at 03:03:01AM -0400, Jeffrey Walton wrote:
> > I'm building Git 2.26.2 from sources on a Mac-mini with OS X 10.12.6
> > and a PowerMac with OS X 10.5. Some of the t3902-quoted.sh tests are
> > failing.
> >
> > The Mac-Mini uses Bash 3.2.57(1)-release. The PowerMac uses 3.2.17(1)-release.
>
> if the problem is the bash version but you can build/install a newer one that
> doesn't have this problem [...]

My OS X 10.13.6 has Bash 3.2.57, as well, and I'm unable to reproduce
these failures, so it seems fairly unlikely that the problem Jeffrey
is seeing isn't tied to Bash.
