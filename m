Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B511FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 13:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932331AbcLNNGN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 08:06:13 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35916 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbcLNNGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 08:06:12 -0500
Received: by mail-qt0-f193.google.com with SMTP id n34so2578576qtb.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 05:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MfHJH0R6Zrr1O6IrLD6XRnm0dtPNePBdSsLMdGxjGXU=;
        b=na99iry66GsYyytvgM8g199msbIXQfzmuQ9edtaraADNbyCronKEguUKpjpi7GcU2z
         bgE01dKOJF2VtpVfrLIghZ6kzWhAscVl+sKABABcLqZ4X8OTAGn+d1p9cnwZFnI4JMbD
         eMGN9N8mgk889gddy0bvY0c/MV45iGuepIIJVgLN/sZV71pBFnrYWNVqCwzskpphoZ85
         ohGYKw+1xQGsqrVtaIwJa2pj4utHndPxbNg/mO0aIUJ1OU9a57YPzWubC2M6ciZge2e3
         ACgOkEOKCGlTYlJ2IUthjN7HqYjamqqxsBrHgWqHbmEKm9jhj+cad7eSo73XSpehEXsk
         uh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MfHJH0R6Zrr1O6IrLD6XRnm0dtPNePBdSsLMdGxjGXU=;
        b=XXJGk3vG86O7KXEh1sRRMh8jc4iJ7JfZ0rn4j/SMNbVY9KkzRw+vzh5Eon/Ln12pkB
         VJuljaj1Gcz7nQPkReI25oIaZeYqzJwYh+cSB5KjPERW7UgQMyhQ2sCawtDARYjLfBht
         0wiuljSA48dn2inlM2RCR5Bdu9VpsP0u1V+QfKmyKTuNjAJbrWieNdhkXjK6tDoYdVj7
         G+pkCI+VO9cv+rPKKSCwSOrRqEW4Y+mFZQ2cAkdS1NsyMoFJ+8PaI4lyklHJHqfD4AnE
         9bhlAZIEd1vSGbrMT6cVmTJ+utO7E/YBJqtdnEole5JvPT0FhpRd+0vLHZeW2QzZLTW4
         so7Q==
X-Gm-Message-State: AKaTC02HOHntoKHuupplx/VMi+q2Dx5Re/uOBvTKX99rUWvdeRIPoJa5hCIFY7bweXmt8EZ+vUgK8/5Y7qR+pQ==
X-Received: by 10.46.7.10 with SMTP id 10mr44731946ljh.60.1481720771322; Wed,
 14 Dec 2016 05:06:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Wed, 14 Dec 2016 05:06:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Dec 2016 14:06:10 +0100
Message-ID: <CAP8UFD2_m8QoKD4WVSPJdyEoKLGxdC+WOWy_D0zRA6TmAJZdxA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 22
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Aguilar <davvid@gmail.com>,
        Dun Peal <dunpealer@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 22nd edition of Git Rev News is now published:

https://git.github.io/rev_news/2016/12/14/edition-22/

Thanks a lot to all the contributors and helpers, especially David!

Enjoy,
Christian, Thomas, Jakub and Markus.
