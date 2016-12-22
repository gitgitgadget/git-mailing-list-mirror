Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EF21FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 22:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966449AbcLVWin (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 17:38:43 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34508 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965603AbcLVWim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 17:38:42 -0500
Received: by mail-qk0-f179.google.com with SMTP id q68so128611703qki.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mh+FrOR8JkinHHxBn1Mi8QAgwOpqvtetk+fYjqcTdiE=;
        b=Qt/GWlHANIXI+qgQSuN5vG/aqd5NNp/lZOurJybhR8WXnWL/V20QDUKEBbg6OUsI6t
         J8Ta3IQOUPAihQM8SzhAo5oyAJW46YAP9wjtxCa47ofMenRRRzTqjLV/mRAwonnVwNSe
         tHriFR00Q36O86/5VvxyOjaFt/sFO8z4VhOYS9fmjZTTg3ZSKhvWgsSLd/Q3v2peZU0h
         a5urIKDAqckMwJCt1iThjAUUMjJxSHQGuGuUED96dGsJF+k6WCTIkM8cHwV3P55v5rn2
         ecWMDYn83FTAMvwNZRQGsL367Q9rP5tqkBVIpVCqzpYopkyc8/3c29PcfJimswgJiLFD
         Hkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mh+FrOR8JkinHHxBn1Mi8QAgwOpqvtetk+fYjqcTdiE=;
        b=jqWlMl4gffKvBASt0WcmMFaa4NfwbdAFhcn8UrfY2Z68OwcG1AO/tJrpYyGWqK7nrc
         Z3U8JvME+7vTdycnOxb2KolpUipyNbpGO+Nr5KTYYyKO/jpkqJrfLa/HyMWRKGm1PeAJ
         +ItITGdavpvcrK7jHzrU6MtnCvI5/+aELSxTEMMSORkZJCDVhsLSjJIkcZmu5eKLgbe+
         k5xwHBTqRmQJ5MhQvfU3NpvavEQytsAveV91bIps4EXixWmRdS414dRCmQdafbJkGSYQ
         XcEPWjnFQd/hXuuWnO9ZyyB6OfgX+ejAIrX7c1ws1lB0CsNNuDmGsPdRQXLynoL7NCS1
         ZyRw==
X-Gm-Message-State: AIkVDXKa5ZFeEuQVb0qcxkQWhQW0SiOQShY0LERNlL9ScM9w+a5XmTTSnjl1vyS8H5UoJDl7Zbyx1iSUVaE5MZIn
X-Received: by 10.55.105.129 with SMTP id e123mr13240135qkc.173.1482446321665;
 Thu, 22 Dec 2016 14:38:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 22 Dec 2016 14:38:41 -0800 (PST)
In-Reply-To: <6ff2c5a3-fe81-0bec-ad9a-d62bdb4a176f@gmail.com>
References: <6ff2c5a3-fe81-0bec-ad9a-d62bdb4a176f@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Dec 2016 14:38:41 -0800
Message-ID: <CAGZ79kbZ-+LFgDiwekXteTq6BWfLc1Ab_3FKW5VRSUh2Meb5Dg@mail.gmail.com>
Subject: Re: Feature request: git rebase --no-edit --continue
To:     Daniel Chumak <chumak.daniel.dev@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2016 at 2:35 PM, Daniel Chumak
<chumak.daniel.dev@gmail.com> wrote:
> Is there a reason why there is no '--no-edit' option for git rebase?

Nobody added it so far.

> I would
> like to use this option after editing a commit and continuing the current
> interactive rebase without having to change the commit message.
>

You're welcome to write a patch for it. :)

On the other hand you could just use
EDITOR=true git rebase --continue
