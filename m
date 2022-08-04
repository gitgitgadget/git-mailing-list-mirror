Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31872C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 15:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiHDP55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiHDP5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 11:57:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E995A154
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 08:57:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kb8so100614ejc.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=tDqKLNqh792b0XkijLkMYPoCiChWRA1XtXGLhoSBqPY=;
        b=pEItcDB6UpBbfzCqEYPbq/jLnN2FmbDWpfM05wNkHXYLxx9ZEaAyoZPEm+8vP0ySZd
         NzZJNGZnUet3bBtVPztGbuXG03AH8YelbY8P+0E8V0N+nHYFNWKD7KFd63rAHzp12q92
         8nukIrue6e9JpXvhHHfvzCPSr0L2MHBc+oGOIRajM+U214snQdGLrz3Wpg+dKCwU+JGC
         iJ+KEQ/g/BJWmpxVck45rVeEqHSDg8MLKVNRI8y6LHYuuN7hXj4hcN48yrW82RmoUFgv
         Mz+ltFZ3V/KYEUFUesT8DhOlU+IcZPJ5ij44vATb8z7+PShxL/OebIKpoxa2hC19e8o0
         GTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=tDqKLNqh792b0XkijLkMYPoCiChWRA1XtXGLhoSBqPY=;
        b=NDYGf7BgC0xISP4/ZTJV69aXDo6Tk1bRCWNA5Pwpdm4zeTdkOn+en2qsB45vdlp/x3
         jwRZi/+vCGogP/2JQohoM2Nck0Hx+kxZz3MJB1w7kKlT6ceVHllei+UWM5v+k/Oi7qDi
         nwdMrMxfzuVgboZn/T60eahFSisqe3rWyfgf9Ya5ZUpfDMEJtyQ6LRKXUkHyrfbRN8Cd
         qRbhTP0GmCPZAcBNUoa8RNG3W7gNJ8I4defeme0MYFwxmS2936VrdZaJqamIq8+ZFVPa
         G4zkdEmgilvLUal/ZgSooSN8VWe4K6NCd249T3tJy93CEXyzhoHCiBOjnscLzL5/1wP2
         LrvQ==
X-Gm-Message-State: ACgBeo0U2yNcpdTwit7k5IbXTmp1WHelGzHkIy6IZLO1WRBZEKsJSovk
        l7G6zGV2KvjLostxaLW+cSX4zrPWjPOhiip5+LOAIyWQ
X-Google-Smtp-Source: AA6agR6E6b5hvLH/NMrcIYH3KLgeVkpMm68sdCxja3aDt/q6/Jqe5VOAvSqOiIDBEQn2h09DUCUvN4MZf+6guWPmT2s=
X-Received: by 2002:a17:907:1629:b0:730:7ad7:24f2 with SMTP id
 hb41-20020a170907162900b007307ad724f2mr1958005ejc.261.1659628671211; Thu, 04
 Aug 2022 08:57:51 -0700 (PDT)
MIME-Version: 1.0
From:   Eric D <eric.decosta@gmail.com>
Date:   Thu, 4 Aug 2022 11:57:40 -0400
Message-ID: <CAMxJVdH6_CAhe1ToJnFB55dQAJd81HD0vUDgZ_1Ub=9QKJbHjg@mail.gmail.com>
Subject: mail from mathworks.com domain is rejected
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I and a colleague of mine have been unable to send email to this list
from our work accounts; the mail server always responds with the
following:

git@vger.kernel.org
23.128.96.18
Remote Server returned '554 5.7.1 <23.128.96.18 #5.7.1 smtp; 553 5.7.1
Hello [23.128.96.19], for your MAIL FROM address
<edecosta@mathworks.com> policy analysis reported: Your address is not
liked source for email>'

Can this be corrected? Is there any additional information that I can provide?

-Eric
