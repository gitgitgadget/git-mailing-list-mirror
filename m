Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9621BC433EF
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiGQUAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQUAX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 16:00:23 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B1FB05
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 13:00:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id d17so7556072qvs.0
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=bC3j7Kcsm5CKBCTt+DmoDTQySqUhDd/KHzyNE3vdRnM=;
        b=s7hqRt+o+jjeM85046ucgvn6vsmfpasZEoLLSS8IbiYR9RqIuwlWB349IzksQkfzM/
         69/K1O7FC3/aBHY1DkYC/Tg5aek6FBWved+tIMfLpyGEBRSnqExNRWbh2p8Z6Xah9dtm
         3B+a23KE1GZw+VXDLAR8vryn/sfMqD8ukMQOXlD73s0C689nwiUGdZSy/GJx0HjQlujp
         LtQcnr3d42j8VxR24jiIOzeYnyGz87JKUYU+9whbfpcLT0tXpMhB8x/bAjQww/UEHCWy
         Me8Y+LKK5Z6Rqib0j/FpTQsjMbvbgtOI+6UwYRImM2WqSYbGsJerRWfQcK0JKevH7R+3
         uP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=bC3j7Kcsm5CKBCTt+DmoDTQySqUhDd/KHzyNE3vdRnM=;
        b=TVXm3Zh+X2rAVqnWxBXbNmGo8F7638rECklcSktDo6l8iOBnqXK1n662B6POctf0cU
         y7lMLujafDUGL2XZdOqMXRgqJ+X/byLJWVlUvm0KSsbkTqLNJsq0F9alBPFq4MbUuknG
         cxyAtO95vQ9DdQYxPvFZKc9SE3x3fAtSV8SvnKdb30UjsRHkWQQrfqhheZAantXWK2io
         Cf58Fs1y/K4qV5sQX301bofCE9TxeF8YH0e1Zk5To+N5tJyhI3n1r8lqvWMoJEPf9yXW
         u6z4cyvHccyHOLwaTn+aipi86abbXkhp7YQQWPClyei1pasbBQD9oszWqypBDAkRatAh
         2d9g==
X-Gm-Message-State: AJIora/igse6q0nfFVq4ytN5PbXhfC2y202OMHvTsLKrDDPEeIz43hpT
        w61TTBC8et4xtqmUlK7m5/EdgR4wgiZWzw==
X-Google-Smtp-Source: AGRyM1sylnq2pSam3n82Y05CxU320s5qGP4bfPiDcWvlt3YgL1c26etem2DuD87Wl70EKWusocAM3Q==
X-Received: by 2002:a05:6214:19eb:b0:472:fc8b:e071 with SMTP id q11-20020a05621419eb00b00472fc8be071mr19507838qvc.71.1658088020934;
        Sun, 17 Jul 2022 13:00:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006b5cefa8877sm7937547qkb.105.2022.07.17.13.00.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 13:00:20 -0700 (PDT)
Date:   Sun, 17 Jul 2022 16:00:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Contributor's Summit Registration, Sept 14, 2020, Chicago
Message-ID: <YtRqU5rAOsLw5s03@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Following up on my earlier announcement[1], I have some more details for
the Contributor Summit at Git Merge this year:

  When: September 14th, 12-5pm CDT (UTC-5)
  Where: Convene (131 S Dearborn) Chicago, Illinois, USA
  What: Contributor's Summit
  Who: All contributors to Git or related projects in the Git ecosystem
       are invited; if you're not sure if you qualify, please ask!

Registration is now open, though we haven't posted a link to it on the
site. If you'd like to register early, you can use the following link
below:

    https://www.eventbrite.com/e/git-merge-2022-tickets-386396170347

If you are planning on attending the Contributor's Summit, please send
me an email off-list for a special code to use when registering. This
covers both the Contributor's Summit and main registration, so don't
register twice :-).

As with previous years, you'll have the option of attending for free, or
paying the $125 conference fee (all of which goes to Software Freedom
Conservancy). Please indicate your preference when emailing me, since
there is a separate code for each.

If you need financial assistance with covering travel / lodging costs,
please reach out to the Git PLC at <git@sfconservancy.org> as soon as
possible.

A few other pieces of miscellanea:

  - We're still working out the exact details of an A/V setup for the
    Contributor's Summit, but the plan is (as in years past) to have
    some way for folks to be able to join remotely.

  - We'll have some sort of experts panel at the main conference. The
    exact format is TBD, but if you are interested in being on that
    panel, please let me know off-list.

  - We have a Google Spreadsheet that is being used to collect and vote
    on topics to discuss at the Contributor's Summit[2]. If you'd like a
    link to that, please also contact me off-list.

The main conference schedule and agenda should be up sometime this week
at the usual location below:

    https://git-merge.com

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YqjEAEPYEJMUx8Wu@nand.local/
[2]: https://lore.kernel.org/git/YtHuuE42bogVLOGn@nand.local/
