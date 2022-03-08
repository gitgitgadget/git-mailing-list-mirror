Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ED5C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 16:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348346AbiCHQhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbiCHQhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 11:37:14 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6EE50E0B
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 08:36:18 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id k7so14405350ilo.8
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 08:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUuM19UDYeSDbLgwn8OmqhEvEG3JfikMCQqcJcnrw7Y=;
        b=vtEUzbnoZY1qpEdZmjzBr6JD9UL0LDb/dLrZjCf02tmDY1Q4W+wRkvArCVbGqwJGWK
         JLzmBvV3hnO43ziNSoENy8TFQFmqDdc0e1dgT4xf4h3fSURoq0JHSo+D9jO5raZsIf62
         odIaZ14RG4E7fieRgdOIN9ijg3ee3tMF2rTIxhJvGodnujT9M5IB7nr4Q5IpZIeCmOns
         ou3ZYMkxnyG1hcYOaXI2/zsWtr3+19zlsKJZa5rth30fh7T6BQVNZYeqavYCyqzIFThj
         OEivbItJs3HcpfPs/TtnyR7dR37bKrrmnc3WKUeENuP4eAWYcVeggXzsuBgLCp9sPUVI
         QYvw==
X-Gm-Message-State: AOAM531RS6b9+BhsgIZ9I7nU2t1KDh5zoRuPAA2xKgAAaFbHAQLpeAL3
        vvINDN/M1mZIw2NCMT0WowSzsQNHTqcP+QR0rNKl+gFPnxE=
X-Google-Smtp-Source: ABdhPJw+NYozr4LScAhyzCW0nSwKwEtMY5dRnCU/wepZMgz+4b7xL3XhFeC1xaK7GQ0lKcho7dk9Fy3Tn5lA5gVt2RA=
X-Received: by 2002:a05:6e02:1a2f:b0:2c6:41e7:3dc7 with SMTP id
 g15-20020a056e021a2f00b002c641e73dc7mr9516743ile.49.1646757377351; Tue, 08
 Mar 2022 08:36:17 -0800 (PST)
MIME-Version: 1.0
References: <DBAP191MB1308984738C90410C8B4C61782089@DBAP191MB1308.EURP191.PROD.OUTLOOK.COM>
 <07ce01d83229$e80e9f70$b82bde50$@nexbridge.com>
In-Reply-To: <07ce01d83229$e80e9f70$b82bde50$@nexbridge.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 8 Mar 2022 17:35:41 +0100
Message-ID: <CA+JQ7M-V-Mv6ZQr102yke4Cmu48v8xcDkfb8d98-w=qhMTtVCw@mail.gmail.com>
Subject: Re: Git - Git flow assistance
To:     rsbecker@nexbridge.com
Cc:     Firas REGAYEG <fregayeg@iga-tunisie.com>, git@vger.kernel.org,
        Imed ZARROUK <izarrouk@iga-tunisie.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Firas,

> I have an issue with git flow command and need some help please
It sounds like you are looking for advice pertaining to git-flow,

As far as I recall, this unfortunately has nothing to do with the git
project and this may not be the ideal place to ask.
You may find more helpful advice by asking on Stackoverflow
https://stackoverflow.com/questions/tagged/git-flow

> Now when I'm using the command it asks me to enter feature branches prefix with a suggestion "feature/", is there a way to use variables in the name of the branch?
Haven't used git-flow but I think the point of the prefix is to be "fixed".
I understand your question to be making this vary depending on user.
My guess is this won't work with git-flow.

Taking a step back, this sounds like an XY problem.
Can you share more about how you'd like to use git and branches?

/Erik
