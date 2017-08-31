Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95BCF208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 13:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdHaNQq (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 09:16:46 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:38062 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdHaNQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 09:16:45 -0400
Received: by mail-qt0-f173.google.com with SMTP id w42so2640070qtg.5
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5RxPd9xoNWLLhJ7XnDdnayE5tuY4D8DXK6AFwwegUo8=;
        b=XNmECZfUBNPMe8E97dgmeipLUYJ1YNvRdbEGvOPbK6St3dgIsiEM4mRjFLp24FCMCy
         DjWVA84Q5TzlT5ViiwN7+h5IN2LruxOO7LYIZvdl2pfhjr5GDnutcnO6Fc4YhWQmriPh
         OLw3qH64v1lFMCVWj7JINTecj47KLjo2be1aRXu7HEwlB7rYXYDmYmubi25956Jqmq5H
         /0tYtZXz6f5NS0jHIEa9dsQk5ISoMfaGP4r8f3lA/SC96mYya0vsa2rFY+2SGSGDZcKR
         ksiFpGdXvjMM+PNytaBNKRZCy9mwxnz8CLaxsyIX+9cmv7On9Gq94CFt6bZ5KoZVglb2
         7OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5RxPd9xoNWLLhJ7XnDdnayE5tuY4D8DXK6AFwwegUo8=;
        b=lPanDI/el4cmU/+rvB03RaeZYjI+NOPunO77cqRPicFnrpnwor+1g1sguprSe76s5n
         y3RLgLAlp2Am9Pe5YmK2Y5gBmKKJ6QW9EGdGFVN2AY89V768WXw8eAzW/3s8FJ/4u6ym
         0vLTe/ezCkLoy0kZAJIBNZBJHEaZNe4wplOx5eiIuTcP2G6sQKHct3oXJc7w/QrzLCY3
         hYsa9a8ap7eumVTe5esshM29yqcvvyxAY5MeITRODP/1aprdKsEHy4E7ji4nRXes3DDx
         ZAeKLZzVhNiRHN4Sx0u//Fk23yW0l9Y4GkYOJemUL+m9cs2amlbGhLzs/91m13equ+3u
         12hA==
X-Gm-Message-State: AHYfb5hlazKlO5Ufp6bB2A59VHElKZI7mkNMHXeHTzOazSnUo5jskGYD
        e2SABUs6zDJPAQ==
X-Google-Smtp-Source: ADKCNb5bWGSMT/eKG6RvwLvFuHlUUHX11hVJgU6tSdsxN6IYznnv9Ssx8ukUDBQ3en8kLw2OhRM0jw==
X-Received: by 10.237.63.187 with SMTP id s56mr6611460qth.266.1504185405185;
        Thu, 31 Aug 2017 06:16:45 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id n3sm2466059qte.33.2017.08.31.06.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Aug 2017 06:16:44 -0700 (PDT)
Date:   Thu, 31 Aug 2017 09:16:44 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation: mention that `eol` can change the dirty
 status of paths
Message-ID: <20170831131644.GB22212@megas.kitware.com>
Reply-To: mathstuf@gmail.com
References: <20170822174918.GA1005@megas.kitware.com>
 <20170823211741.9633-1-mathstuf@gmail.com>
 <20170824055054.GA32617@tor.lan>
 <xmqqpobcpwst.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpobcpwst.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 14:31:30 -0700, Junio C Hamano wrote:
> Is this "always makes them dirty" or "may make them dirty depending
> on the situation"?  
> 
> If the latter, I'd prefer to see s/makes/may make/ here.

Yes, a coworker reported that some files slipped through this. New patch
incoming.

--Ben
