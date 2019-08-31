Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E2F1F461
	for <e@80x24.org>; Sat, 31 Aug 2019 08:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfHaH6P (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 03:58:15 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35355 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHaH6P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 03:58:15 -0400
Received: by mail-ed1-f47.google.com with SMTP id t50so10613862edd.2
        for <git@vger.kernel.org>; Sat, 31 Aug 2019 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDM7xNE8DoBiPx603uCjLvlbXePP5SwDnJgTt03eQ+0=;
        b=nt9FoLGojq7PDJ/stoz7lMt97sXeHmQkVAeoSPDTa6gO4CNFRz/7kQEbwba/jiEOOW
         +L8mhpVJ+rnJn1iiWlii7p6wu9OZov1V0J2y+wowaned4YIe+78uHxfLtlH3UsA2jXB3
         2AyB2sH47JptVALcuGpbQZ7pAQfTyxpv46bAm4FCOU6/9+6EMRKsb+bhrr+JH6wCo0NP
         hpLcg/46vn4bfVO6Z/IJhxu90TKoKFsD5uqgGNtUcFw8pS3S+8YCd76mK2ZyKNzN4twn
         uHfxtnXQwWcAhpIgNq87BwQ5qH54cI2YYNOBA/pgqxjH5wTGxQy74YcZhO1q4+zRCYSV
         NQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDM7xNE8DoBiPx603uCjLvlbXePP5SwDnJgTt03eQ+0=;
        b=bDMc4/n2X9Q8XQDt7CoG1sXwsDjZ679aPlQxt76ZU9ZzfqHvG6/n5wJxWXzqUlY8tB
         k8VaOiU5OPgm3tTKmTmgCUsweWRwwmKNHb68BKbsYPrAB2ZS6B51ire6ZT015YccjTzq
         fJGfFWRt/Nngpvue7fynTFDGIA4dHi6VKyphKgkNQtUXgeYEHaQR9cMUMs3R3+ka+4Cw
         O2fkyt7S++oBFo4AwjLR9nOZmD/NIefqZ3AGvBAiJpeZFE63iY6OgcxzgjOsz8gXk5e+
         OfPm0ZPqukNq3ON497mGI+b7x5bQZ8XHzFWUqnYWq9m+TUT9J8sX6ycDczCwaBZ0/47k
         yeoA==
X-Gm-Message-State: APjAAAVPfVGaWzHXqJrCzXd8nAri2tJI82TMRdffHF1cImenj5cUO2Fc
        rlrLcZvI6UIx2Ne2A/eYs9Cq3diHqDDOKzsm83k=
X-Google-Smtp-Source: APXvYqwZt1LQFS71YRUfqZlsbIqQ3M1qF5au4cZ4ctec89M6iZ/MVoDcfiA7rBPfV1me6n0Ri1YEY/WEZHECMS+Mu9I=
X-Received: by 2002:a05:6402:759:: with SMTP id p25mr19626728edy.119.1567238293110;
 Sat, 31 Aug 2019 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190827051756.GA12795@sigill.intra.peff.net>
In-Reply-To: <20190827051756.GA12795@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 31 Aug 2019 09:58:02 +0200
Message-ID: <CAP8UFD31Pp9XMDpaNfYP9ph_W0LV43sXvSvppXDjrTSp89S7ZQ@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 7:17 AM Jeff King <peff@peff.net> wrote:
>
> Do we have interested mentors for the next round of Outreachy?

I am interested to co-mentor.

> The deadline for Git to apply to the program is September 5th. The
> deadline for mentors to have submitted project descriptions is September
> 24th. Intern applications would start on October 1st.
>
> If there are mentors who want to participate, I can handle the project
> application and can start asking around for funding.

That would be really nice, thank you!
