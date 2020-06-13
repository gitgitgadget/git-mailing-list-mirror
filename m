Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018D5C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBEB2078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 20:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgFMUkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:40:00 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33192 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgFMUjz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 16:39:55 -0400
Received: by mail-ed1-f53.google.com with SMTP id o26so8806925edq.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 13:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7yz53zIAWaJzYBbR+NucmCXHyyWO/cejuIIFiFkpWE=;
        b=JcTDmomTc8aTbj2NwPhrpYMapu5ZzN5ofT8Yvz+ix1VMlnodo9rTsWklpugsulNUCM
         R6lw1gRRSEMk62Gs4NU6Wbjp7OhI1RAQJCJSuYhSRyPtq3elN4v4voPN2M/bJVuJJ4Ns
         bLJORh0ZxSjq5LVcVhxn8iCRdwt7lLKoqBzZafWfzW5LJHcaJHLHWxX/fYhZvsVmOR3Z
         wPWUwSZ4wsIk4p0FYyVZB5oHIRnomGSeZ2tO8QhauW2GbEQRoImtIeFDVADE3sDBJtUq
         6q3cFJwHJ8jNbpNMCf/0eA6uRdKkIuP0XFa9GqW5J5aJm9VZNnzg3iBd+U2yefHKvDAD
         lEZA==
X-Gm-Message-State: AOAM530C7Z0hjU+yrgquk0CzEHstd29hafM5fe4cJ5u7qA3EiFlw3n5X
        N7joWhdESlWCyH8pAqKG6T1Ci/U5Jr0oRtayKN8OR4lg
X-Google-Smtp-Source: ABdhPJz1OqONZu5WSI0WcXFW4rIzA1I0ce4L/H+HjQXFmG02hsvEAX6C++faWOv+ARXAHX/Dw+LapLHGNQ7ngXm6muU=
X-Received: by 2002:aa7:cd16:: with SMTP id b22mr17625686edw.308.1592080793775;
 Sat, 13 Jun 2020 13:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAP3FiOUrx07agv+27buatCzWPLdxNBh4wLiWLs8XrpWU-V3=Ww@mail.gmail.com>
In-Reply-To: <CAP3FiOUrx07agv+27buatCzWPLdxNBh4wLiWLs8XrpWU-V3=Ww@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 13 Jun 2020 13:39:43 -0700
Message-ID: <CAPc5daUOAZNGrfd8y6GS=HgGpfH=mqArB56bPKeFPCb3Uo1+5w@mail.gmail.com>
Subject: Re: About renaming git default branch name from "master" to "main" or equivalent
To:     Trivikram Kamat <trivikram.kamat@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is the git community considering renaming the default branch from
> "master" to "main" or equivalent in git?

Our list archive is available at https://lore.kernel.org/git/ and you
can read what
community considered.

You may want to start from these places:

https://lore.kernel.org/git/bef39243-806f-7c4a-c3d1-f3500ec377be@iee.email/T/#t
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006111610000.56@tvgsbejvaqbjf.bet/T/#t
