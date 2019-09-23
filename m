Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65151F463
	for <e@80x24.org>; Mon, 23 Sep 2019 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440269AbfIWR6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 13:58:11 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38390 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438062AbfIWR6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 13:58:10 -0400
Received: by mail-pf1-f202.google.com with SMTP id o73so10640248pfg.5
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gMeXEYFcvAqqOvXTH3MMKv+mZG/zzysJ86vI1soNxVw=;
        b=j6Ir7kOwk4LOXSBBq+APJwJjPT8ZY1qMH0xuoIpA6AIhpql4lEMrt4Tz3xUyaXEWTc
         wSGstx9bf3Om5JyfrTYr1s5ggvXYk/6utcEgXbtyNiWkQ9pPF7r0qZw7kcjdOdSwgGUF
         OEu3qYBZpQzDpVwD/C2dchnAYV9G/yx9eSx1wekRiXHjHzH/K0eADKidKkX5tehaF81z
         chdrNiESBmCs+td3liDRrVN03JgNiGPhc7yqn6rMgnnpJWY/SLuC0TE4wPJ2/v94LDjd
         7AFQ/b9mEMvUJuUWFPAkOhsp7o6AiWJH8lH1rFdscMSBIMEpw0eoXPjS/iLuX2rZbSko
         PwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gMeXEYFcvAqqOvXTH3MMKv+mZG/zzysJ86vI1soNxVw=;
        b=OtcOXPzztkYxXGdqqpFLdpYpgRbwxSznM8zBnLdK0EP7DWoC8V5pPc19Xp2Vn82WGT
         VGEnTKBrtEfk3+x1gO6HomueykkV/L+dJJ3IYyzJrSwFsDtVKAvzu7esrk0NTMwGSiAx
         AZ6IesJdaRTFbJRcKpiFoCI0X3PFelhKN9UltylYaGJxDCoqg6pWb+QcjL3/LqizjTkU
         cJbbCxMNR3zhSk5h+KfXWpSUTdamYB0zk/5tluJgb3g8Tr7gilHQmjD8LzxvB/ecYJrQ
         rE84NrjH70VkwnBP7vuIVZazvalsHKaxXIPkYzX+oQ1Q3LS/pnfGA8ODr7J/oqSoU+9L
         QbXg==
X-Gm-Message-State: APjAAAUQXwEL2tGZ9m5+klPDKy+Kqigq6u7oaeteFOUPyssWnCAiAlPd
        /2kF3pYfs7i+6/PpEPpeXvEeJCN8y5zMCjOwQKEj
X-Google-Smtp-Source: APXvYqwwAfyvTzRCHoF0VxTrNi+6dgCBSM6V/ApA0qxi9YT87uL5uJnggMJvp6WV70qjae54Soyd+0DyFq30Ez9bdLwz
X-Received: by 2002:a65:400c:: with SMTP id f12mr1137394pgp.224.1569261488441;
 Mon, 23 Sep 2019 10:58:08 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:58:05 -0700
In-Reply-To: <CAP8UFD3NPYJr5PXLDyRD=qbEPft8E-HwtGUo_FxoG=q5jfY5Ng@mail.gmail.com>
Message-Id: <20190923175805.58457-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAP8UFD3NPYJr5PXLDyRD=qbEPft8E-HwtGUo_FxoG=q5jfY5Ng@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: Git in Outreachy December 2019?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     jonathantanmy@google.com, peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> No need for user-facing benefits. Refactoring or improving the code in
> other useful ways are very good subjects (as I already said in my
> reply to Emily and Dscho).

Thanks!

> I think this is really great, both the idea and the description! No
> need for more details.

Thanks! I've just submitted the project proposal - hopefully it will be
approved soon. In any case, it seems that project information can be
edited after submission.

There was a "How can applicants make a contribution to your project?"
question and a few questions about communication channels. I answered
them as best I could but if anyone has already answered them, it would
be great to just use the same answer everywhere. (I can't see all
project information of other projects since I haven't filled out a
"short initial application", but I don't think that applies to me.)
