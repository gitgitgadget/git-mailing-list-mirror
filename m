Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01EA1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 18:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdEPStq (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 14:49:46 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33435 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdEPStp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 14:49:45 -0400
Received: by mail-io0-f179.google.com with SMTP id p24so99586747ioi.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q01Smo10XQTuURT++evoKwRNPCSHcVW5KUeeDytXbX4=;
        b=TwWyinGobNTe6l2rK85mruR8syLpLkCpgrZte47A13boSyNjPKeMfQ39F0RKEyw7+r
         plPo7TpWGobae0QBTZQnyITe6PL0W+mEOfqnp1KQy6GHGmXxgVbGZu5MPv3wIqpJVLuP
         sPgzzrj0i47Rayp9roZok5GMDKnOYs+j6vHfkNBmi8ooav75AgOT5M6sGWy6jirNcbk/
         /8gGS0qeYDbXdvDF6uuDXWGHorsJyMRiYB/UFL4oAwc/ZbaQGwfL2DWxX9IxdlbbH2BB
         48VfRgnUYUYZTpIkrcs9FYcyZWlEAiNlIl6JZiUAL48Ad+RM4xzfTR/38xxHB65StgoK
         zwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q01Smo10XQTuURT++evoKwRNPCSHcVW5KUeeDytXbX4=;
        b=bw58GrxdaJPd67Ae9jqs4kBZd2gR4VYIk3NvBBF6IFWRlA5E/Rp2CZ8vTcr5323d+K
         tCArfAHgD6LN3xuoepu0KmJ/84C3w8ugDLBnpWWRVpabw2TkevnNkWLI6wq++G2cRYUp
         qzWx29lhyRlzH9t8geCRJVqP+LmJOSggZMbWCQIIqR9AtQhCSZPNfP43zoSKyCRyPT0k
         jmWpBC3dm9Doef7jhsaTOeYY3ud5lhHU/5n1Pq301zdSlOmWx7ldT8RcGI5bFpR4iE1u
         tset2cZbZ84VP6tVNnuisToEtJbzTlNeaFj0MIg3cUKooyEs6KObFE0NL/8pHQ7f5JSg
         hrIg==
X-Gm-Message-State: AODbwcCRIKgq6UChKsNmMT17Ad8IAvy/mkmN4r5lcm1ndXRnNPdxHotL
        JgVDyKUeatmlBMbH1R+rp8AxdAwe7w==
X-Received: by 10.107.195.70 with SMTP id t67mr3519052iof.17.1494960584940;
 Tue, 16 May 2017 11:49:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Tue, 16 May 2017 11:49:04 -0700 (PDT)
In-Reply-To: <83801c20-96e6-7f9c-1e0e-2d46e32dc5f6@gmail.com>
References: <83801c20-96e6-7f9c-1e0e-2d46e32dc5f6@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 16 May 2017 14:49:04 -0400
Message-ID: <CAJZjrdVg=Fqp0nd0h7r1MY3FK_WE1RENbZPs+AY2Th7ZrDBJjA@mail.gmail.com>
Subject: Re: error using `git mergetool --tool=meld`
To:     Matthew Groth <mgroth49@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can you try `git config mergetool.meld.hasOutput true` and see if that
fixes the issue?
