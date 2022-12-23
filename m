Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F16FC4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 09:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLWJLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 04:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiLWJLV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 04:11:21 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E991736D50
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 01:11:20 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id 82so2994526pgc.0
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 01:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OLZ6fHwoOiNVsvFKd2+U1yyMp+a7kFDVlkpXwNGzMM=;
        b=Ge+7bi/+z7prNSMRwWHmGiwIGd4caXpaTHBUoRc+xbzTWe4oWt9XokqwDtaUnXDppo
         4TNxFE4+PUsmxQ84M4F77iEsV6G2wbVkU60qIZvBKU0okPf1mIaoc8WRrE/qFB6wjzUO
         PfpJJcK0gTkNbo7lFTC4lcccxYHJvTeUVgG2Ri+qtS4W9g/RQPkZeZeDLmfWGcPZhGS+
         F3h9vCsLzd2ZGQxaeWpOOOtmh6mgcGFRI8ccxB3Oj1nKT4MAoXHaxGOkgZdzJH+FXLuS
         cemfrWbIGX4bnoiNm5SsCtyugldTvNJt6m35MsxjX83G1mW0/2yikldhPbSN9aTnZmHu
         122w==
X-Gm-Message-State: AFqh2koKeu2y/iTvtVeA4Rz58r2kXkmlR1MFTbSOSI11Lzla/Rn0n05u
        5OsX6nVY2H3Z6tY9+4VClsFhk5xEaR8+XGU2060bizTpl9I=
X-Google-Smtp-Source: AMrXdXs4njMJMZvUWPwtKEI/SN2gs4Vhwzl7GB0IOJO4fePrCKktbKx9Pk2KFXFhx4amrPGpc2jSLRIUi06UYIKRv8M=
X-Received: by 2002:a63:131d:0:b0:492:703:3f03 with SMTP id
 i29-20020a63131d000000b0049207033f03mr688717pgl.403.1671786680103; Fri, 23
 Dec 2022 01:11:20 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh6xtw4uw.fsf@gitster.g> <b3e0db14-6c57-4188-7217-b38b5b0acdde@gmx.de>
 <xmqqcz8csz5k.fsf@gitster.g> <f4f8f704-2b87-9d4a-37e8-ac4d9dd995dd@gmx.de>
In-Reply-To: <f4f8f704-2b87-9d4a-37e8-ac4d9dd995dd@gmx.de>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 23 Dec 2022 18:11:08 +0900
Message-ID: <CAPc5daWvYANBvwc_zQh7FqR0Y-vJ4eP75LMigqc-4RjBW+Pnfw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2022, #06; Sun, 18)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Between 5th or 8th there is no difference in my vacation status, and
5th or 6th is a bit more convenient for me, avoiding the days too
close to my trans-Pacific flight.

On Fri, Dec 23, 2022 at 4:34 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Wed, 21 Dec 2022, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > Are there more regressions that would maybe merit a v2.39.1? How imminent
> > > do you think Git v2.39.1 is?
> >
> > As fewer eyes on the codebase and the list traffic toward the end of
> > the year, I was aiming for January 5th (even though officially I
> > would be on vacation around then til the week after).
>
> It's only vacation when one's not working. I am also on vacation during
> that week. How about releasing v2.39.1 after January 8th?
>
> Ciao,
> Johannes
