Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C8C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 12:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiA0MHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 07:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiA0MHF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 07:07:05 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D360C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 04:07:05 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id l68so8170347ybl.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 04:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=bqLaCJpQ5kqHgDqN426UQXD+iokO9Jq2q4VC4MRr7mc=;
        b=MJR/GKh1mcv31y9nIsGxTEf8JrTUc+c0XCKzksP3uslp5w0USljhUBS/2YA5zNw+1r
         3y76OaxMAwxubDS/zyJ7yyhNTMO509H0Wssg/Gpa4RpY0Cb5h9waLXgpSXgc8xjDib0r
         Fwa0UvpxdbctZiUcoptzcT7/UgMIA4OfYNI16aSlZdpWGd+/gH+9YUh9i/vfVLwU2URL
         4GulJKhXpuMoBz8wGLPEdoSVvqqC+UqBYc6TgQsYF7t66qe5QO3cvXTCXs3EDOY2Llbe
         kCQh20RqeRlyctePckKMWKSLMK+z6rMs8YjCQuWa41wZ6Lk1PR6lXwhLnUpxA96eajWs
         IIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bqLaCJpQ5kqHgDqN426UQXD+iokO9Jq2q4VC4MRr7mc=;
        b=LHmN/F15SGGW4PGZ9xcLrQNcVtybFJ9uM1QZoVqLU4gXE7G24ttC1XpdpY+1q3smgH
         JZ1PDuh2jXSNVpAOfH0UV8CNk65qZvhl+FkCdazDdyCQ2nZWg9n58UUXHT9GXUb8F4Ui
         nA+jD7a2/fPzhB6yFFCgw+3uJT4AqzBIuHAs50TaLVVX4KRCb5nISZOYaSmsk/uboqfa
         hshogxCx2xaGXCG3O+eES7jRX56XbJOM3T4uAKOB64aQL+Puykv8QOSNwRJSzFstwb/l
         4GShah5ZziQOtDw0p9yhcRtEjZ2T+amEryq9YVguMfqwfetTR7kR0rHVs/w7AktnaeLn
         jOcQ==
X-Gm-Message-State: AOAM533xN2bvYYLrHTwcbsvRHVondzif/gx4kXeYssrF2BKAI2QzSdX8
        +cJG7jMQZaBylpucSb2MwJ3yHUXYSLGpWd53H2wBrzoWnJI3fw==
X-Google-Smtp-Source: ABdhPJyWm1arRIr91m3kVwwPYtyR7qGs6Vdq/5EIrxMXlrg5ISyLfE55n3nCprjFp5F3xUwJvsBXaJbkaolY8TTRzdY=
X-Received: by 2002:a25:b00c:: with SMTP id q12mr5210889ybf.27.1643285224300;
 Thu, 27 Jan 2022 04:07:04 -0800 (PST)
MIME-Version: 1.0
From:   Mirco Babin <mirco.babin@gmail.com>
Date:   Thu, 27 Jan 2022 13:06:53 +0100
Message-ID: <CAFgk54=iKT=vjkDT8-QF15LE3B-6BVCWUK5d5_J4SmYPLNuB1w@mail.gmail.com>
Subject: Git-Gui: Can the "push" button optionally be removed/disabled/hidden ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Gui maintainers,

Is it possible to remove/hide/disable the push button via a
commandline parameter ? And if not currently possible, could such
functionality please be added ?

I have created an issue #73 -
https://github.com/prati0100/git-gui/issues/73 with extensive
information. But after reading the documentation on github it seems
this mailinglist should be used.

Kind Regards,
Mirco Babin
