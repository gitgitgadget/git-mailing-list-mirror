Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC778C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 17:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbiFNRXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbiFNRXR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 13:23:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87615703
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 10:23:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu17so6595845qtb.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=w5Yr7pqFwPNBtnpef64nPjsa+JdSohluwiYxLcjqsps=;
        b=OZtIrSLCb6ZKFVuOZih9hkxVuV/NxV41LnVHN7ckldznWnY4p45R3xsaBflri3gIxb
         wI+u9dKPfwHXGomq1FfOJ02NGsPY/GR6QGDYvdyRSO3jYZsj6t1T6qg0bFZ7rmsW3I4x
         +G9sLtnW0rjdKIOxOEgbYFOIL6oIie/Z8zrJVziQLyWaOXhiHmLpOQzhIxMtAEUqx5Hc
         DcTHO0BJCJ2/XoPvgOrnNON+ZXk8YFQM6TcXjBjrIFELTsu4OaKW8As8TIIDnuh5LypI
         I0pWPvIq9aCEZnuymeXwMoOw6GwwBDOR1/cL6IS5oS8jEfD8zYsinMAJgrNcXfDDtAF/
         9wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=w5Yr7pqFwPNBtnpef64nPjsa+JdSohluwiYxLcjqsps=;
        b=lM/82NsyT3Bfm1Jz+Y5nlhGrMgNMVumY2dPFiBxUdYn7m1Z/e0DwbbA9MQqJG3FoJb
         7KuSbAAHPt3VrTO5ZaViMo7xMQZmpzDU8h+lFSEOAtx/gfWLcWIitcppwFcJm+dTYVto
         x+PUzaAErbCt47Fmj9gyk/YhyRDBcys6wzDykUE2VBT0iHTfL67Hx+R3vaS6Hc5lWLga
         ikE1hKzLCPmAnlWPgUf48gSqvYfhvMHPIFlnlzpNK1uxkGg42hva1OZ0vraEi2ckODVX
         YPADewTVbrf2Gsgw69ldujbIpKVcHld+y8C+kygQ9uILIXzFbp1zBJLDOGhgqNAW1tYs
         TwhA==
X-Gm-Message-State: AOAM530CuP9HhZ/GXb/KbIgC8PybcVzzhU4EIkcLiEDRPuYuHsOl5MOw
        /RT5m17JeFdOV/XFUqh9EFb7Z7mD3KSuCHgo
X-Google-Smtp-Source: ABdhPJzuuE2Yo34z5jDrwV2d3fB4FfpsKC2IORpvJKJjcC+S0qd+Neor5tCLvjhFFjdjRrYqXTL9lA==
X-Received: by 2002:a05:622a:4f:b0:305:2678:714b with SMTP id y15-20020a05622a004f00b003052678714bmr5076094qtw.143.1655227394573;
        Tue, 14 Jun 2022 10:23:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a404700b006a740bb8578sm9968133qko.83.2022.06.14.10.23.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:23:13 -0700 (PDT)
Date:   Tue, 14 Jun 2022 13:23:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge 2022, September 14-15, 2022, Chicago
Message-ID: <YqjEAEPYEJMUx8Wu@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git Merge 2022 is happening on September 14th and 15th in Chicago, IL.
The Contributor's Summit will be on the 14th. Here are the details for
the main conference:

  When: September 14th and 15th
  Where: Morgan Manufacturing (401 N Morgan), Chicago, Illinois, USA
  What: Workshops on the 14th, main conference on the 15th

In addition to the workshop day on the 14th, GitHub will also be
providing space to host a Contributor's Summit offsite. The details for
that are:

  When: September 14th
  Where: Convene (131 S Dearborn) Chicago, Illinois, USA
  What: Contributor's Summit
  Who: All contributors to Git or related projects in the Git ecosystem
       are invited; if you're not sure if you qualify, please ask!

This email is just to announce the date so people can start planning for
the main conference and Contributor's Summit. The main webpage is below,
and has all of the details:

  https://git-merge.com

Registration for the event is still being set up, but I'm told that it
should be live in the next couple of days. I'll reply to this email when
I have some more details.

In the meantime, the CFP site is up and running. If you have any
interest in giving a talk, please consider submitting a proposal here:

  https://sessionize.com/git-merge-2022

Note that this year we're going back to having the Contributor's Summit
take place the day before the conference. For the Contributor's Summit,
the plan is to have an A/V setup for folks to join remotely where travel
isn't possible.  I'll provide details on that as we get closer to the
actual event.

If you'd like to come but need financial assistance with travel costs,
please reach out to the Git PLC at <git@sfconservancy.org>. We'll
collect requests and try to make decisions and notify people by
mid-July, which would hopefully still leave time for making travel
arrangements.

Other than that, please be thinking about (and feel free to discuss in
this thread) topics you'd like to discuss, or any general thoughts on
the format, venue setup, etc.

Thanks,
Taylor
