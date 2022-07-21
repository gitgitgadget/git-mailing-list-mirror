Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F3CCA489
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiGUTQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiGUTQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:16:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3D2BB
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:15:54 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o1so2049407qkg.9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=pARWb+STPdUSmWCizw92/cSY5ORhJCLhzFFugTmPrY4=;
        b=hwlG2bNwXikXp8kKpyF5h7AHmYvJCxGR5y5iLo+rrvhFkm3etvblCUujbroqjNvE2y
         NkyAqtBFwn4j7l18DKzjH9zuhYy05EOlvm99qsUCl0QPkfv74Fq5M011iX7KovjzuY4o
         J/wsY0lP5zo0UcU6qaSRey49RqztJ1VHMip70WWhSOvy9IyFnVBPejaW3XZZRTDsOFJ3
         Yz/8MZvaZyVaQOMFVZ7WSDojTEsVe2LrZz45fSuKgZlNJSxIlrBWbuhAse+W/n7B7pEO
         Ar1qdlPXyeXhKWmVyx4l34WHk+mQB5yC0G0FIhLq3TkXQKZ2SrK2eI922ok4WFQy9jCh
         OziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=pARWb+STPdUSmWCizw92/cSY5ORhJCLhzFFugTmPrY4=;
        b=qNm4NbXzfEKFoG4UYR7h2bLRwGGDhziFzschO8XKttZ1asDFOASIxls343Dfb4mbeD
         cs6t3N+EYrqtlVrTgKFc+27x2vxEoI0oDBpGxhtvgXFRHA5Eviklz7aZqKKE8zvns4Kt
         H9UHZPQ/Byg/YnHwF8Y21UE+5LhTE001WMq864mZdlyaNzy8CTI9thjna1Mc9eKCLV8E
         aERiABv4i7xc92rCWVlSXtgnJeF8rlCB70wyXuLrP1oMvBE2yPVBPf4YgI9jh2/KdRHF
         KIBwmbDQgmoV81VeGvsuooZ4VrEn5TElAfAkw5P/pnus6ZsgFl1g5pKj5/oH4bR9pJDX
         xNwQ==
X-Gm-Message-State: AJIora8VvvzFnGCOYbPRx6DM2ojp8gwE/mEEn4DjdFWQoa8dodPyuS/g
        hyjkZAGKVOw/pKxQd3er1tmW14KOfnKWKg==
X-Google-Smtp-Source: AGRyM1vlRcZKS1FGFVr8FykZrvNRoNGIDdyGYomML9oS3hepNs05aUjDaxCfOJK9VWHm2AM6ZOJhBg==
X-Received: by 2002:a37:8245:0:b0:6b5:9078:267 with SMTP id e66-20020a378245000000b006b590780267mr28623079qkd.684.1658430953034;
        Thu, 21 Jul 2022 12:15:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x7-20020a05620a258700b006a65c58db99sm2120069qko.64.2022.07.21.12.15.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:15:52 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:15:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge 2022 Registration & Schedule
Message-ID: <Ytml52E1Qe7FeV44@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

The Git Merge 2022 speakers, schedule, and ticket registration are all
live. The main details are:

  When: September 14th and 15th
  Where: Morgan Manufacturing (401 N Morgan), Chicago, Illinois, USA
  What: Workshops on the 14th, main conference on the 15th

and the website is up at: https://git-merge.com.

The website has links to:

  - Speaker biographies
  - (Tentative) schedule for the main conference day
  - Registration information

Like before, if you are interested in coming to the Contributor's
Summit, more details are in [1].

I encourage you to read [1] as well as [2], but the most important piece
of info is that you should register for the Contributor's Summit
separately, and that that ticket is good for both the Contributor's
Summit and main conference, so no need to register twice.

If you have any questions, please feel free to respond here, or
off-list. I am tremendously excited about this event, and I can't wait
to see everybody in Chicago soon!

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YtRqU5rAOsLw5s03@nand.local/
[2]: https://lore.kernel.org/git/YqjEAEPYEJMUx8Wu@nand.local/
