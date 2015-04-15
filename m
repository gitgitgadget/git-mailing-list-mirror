From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Git + SFC Status Update
Date: Wed, 15 Apr 2015 08:55:05 -0700
Message-ID: <CAD0k6qRCiNnO-7nXmOeWSH=f_Sd=yHqXmkgaz_5nev1FDbVHPQ@mail.gmail.com>
References: <20150413115613.GA4589@peff.net> <CAD0k6qT9Sj4VQ+4PKvXmwwfuZHFoGXNmAMGxTiorx81E0U11xg@mail.gmail.com>
 <xmqq7fte33u8.fsf@gitster.dls.corp.google.com> <20150414235425.GA2179@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 17:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiPf3-0006xx-0w
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 17:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbbDOPz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 11:55:29 -0400
Received: from mail-vn0-f47.google.com ([209.85.216.47]:38668 "EHLO
	mail-vn0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbbDOPz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 11:55:27 -0400
Received: by vnbf1 with SMTP id f1so16703263vnb.5
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9hPcTtpySe++eZ8gNn3gc7MYnFtP59/sc/MJggyglmo=;
        b=lzeqZUucXKuEUCl6t1v+U+IHE+dK88PanWPDM6g5yosvHsCGxdiJVhkzzodXfAb3dz
         lqeSBnIeV9j2Np1rIil7UnsF7vWHrbM5ZAsvz9A4KCy0sFU5NQ8rv8BE5d0SD2oaEa0E
         gIzBjOL6oVxWwiIUu7yFc1s6Ms4Nymys7aGMevUJjwfS9/UwFWZ16+W2SLJQCgXWreNf
         B/l5zM8CAzdvzv/Cl9YwYybXu1z3j/6ghk8q91jJ317pGsVJwr+LTOkD0Fg2gWDms8Yt
         luM29xAM0Hse52lH3uqsQ7U64Au2qW9qV/BIbmWnYhdRSt1J8X1Gc6GQ6/7GqvkoHnoa
         sPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=9hPcTtpySe++eZ8gNn3gc7MYnFtP59/sc/MJggyglmo=;
        b=jYaJvXhlDS3VlYmEyWNCnBEED5XDMfC1OPOYHmq+BQBU7NNDdP6XjFd5sm7lnnQcI7
         R5fmK8HvCobMEyqdEp7ylYOI6xl6DWhbxTDcjIdOuroQ5hVTdymds4yLJy6rTGg1dEvw
         kFymcHMT5AwAgWh7uhwjxjrYf2xyokwPunXMeuaBOxoeXJJXRL4aB1w8jFlTMi39Gn4t
         HlS35kU8u/37FAxzDj/pQMNYJ0n34ghFHIGJ/SeNFEN/MnVsmTsBor1w/ynOBV8nvpGZ
         lABVq/Pgc+6CZfYHxh3b67UHcdcUyP9CtgIMpQmwFHqPewVo3xuXpiKwwLlD/UHJL3Xq
         BGxw==
X-Gm-Message-State: ALoCoQnpH4p8IHU+/X6AwzFTKuYAQAlj8Ls0vViIpFnnK70BKxm7PBVouhJRUQG8QPIPR/8KEOVt
X-Received: by 10.52.10.202 with SMTP id k10mr8019522vdb.44.1429113326233;
 Wed, 15 Apr 2015 08:55:26 -0700 (PDT)
Received: by 10.52.126.16 with HTTP; Wed, 15 Apr 2015 08:55:05 -0700 (PDT)
In-Reply-To: <20150414235425.GA2179@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267207>

On Tue, Apr 14, 2015 at 4:54 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 14, 2015 at 12:30:23PM -0700, Junio C Hamano wrote:
>
>> > If I recall correctly, Scott said onstage that some/all of the
>> > conference proceeds would be going directly into this fund. So this
>> > might need to be revised upward by 50-100% sometime soon :)
>>
>> I think you misheard it.  The above is money earmarked for Git at
>> SFC; the admission for GitMerge were going to SFC general fund
>> without earmarked for us, IIUC.
>
> Yeah, that's my understanding as well.

Ah, thanks for the clarification.

> -Peff
