Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD4C1F790
	for <e@80x24.org>; Wed,  3 May 2017 01:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdECBtX (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 21:49:23 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:36449 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbdECBtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 21:49:22 -0400
Received: by mail-it0-f42.google.com with SMTP id o5so25539792ith.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6cAhi5MEJeMzRfkEzzCl/ESqHFZdkRMX7dyvzeO5yv8=;
        b=rnGRPVJBYP+fO3V3arCbetoefWeI/VUkrMsJleD8/1QNbdE0WXbIgvlO655EoEOLKv
         dpHxM765zi3+5sizvUNBdtaROAs0xW/1JCKW8h62/t33Ebhh7Tco9YLSpfvAq+Yu1BG2
         6hP4HtXmguT4w5CX3YbPC1o/8KhPsvXJhQKDPjYxSlDor72JK9i/wOO+oFSImrhl9RNS
         XkWqP9nEfSHfvSy7OrGGPNTRSNybruHNi8CUYGevaBG4eSTPZEzb8AnHOSbOMVUKr9PB
         +YNPvsR/se1mGQqV4/93jlFIqtvdDxo/Xv6708BjYZfTZvSZmVlbivchnlM1CMcMXNHL
         Nunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6cAhi5MEJeMzRfkEzzCl/ESqHFZdkRMX7dyvzeO5yv8=;
        b=OIbcglGuuEPYuTwq1GWc4gb4CN+Zz8R2fX3Agon+3rf1KA/V6umB0qzZLs6PSqzkOm
         AjkDhPHSNQr/WybjUrekwU82USKn24WePy4ycIWVw6DQWir60MuqwZJkEC5PMYamMr0S
         fND88PPUFftfhFm6QHa45pUPRU4J0OQwLyaPcLLjIForyJOyT0zyJ5vLe2Vy6dJ2XE9z
         nFho9OrmEYSe5dkmbs36epB2qJhczYLKFQN1xtz9AJlglT0GZR7yvy06O2kuUE9HwMj8
         JVGOw9KdbVJ8DjnQYMUGs3wjC7JK6w/ZgPLVmpz3+S36ojiQn80kpH118JuFCFD5FtmS
         2AzQ==
X-Gm-Message-State: AN3rC/7nr8J13fRNFPVPzjLEuuHAzjJJeR4QvVZed4TbldPLpFiuHIOz
        zprA3kmk6Ompr3xzXnId6GaqXuC5lwyox3k=
X-Received: by 10.36.34.135 with SMTP id o129mr15079360ito.70.1493776161084;
 Tue, 02 May 2017 18:49:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.36.9 with HTTP; Tue, 2 May 2017 18:49:20 -0700 (PDT)
In-Reply-To: <CAK6FQHcHxwCgzGFCnV_3wvX-sVvL8cHpZH11x6ffbzxUJTTGCQ@mail.gmail.com>
References: <CAK6FQHcHxwCgzGFCnV_3wvX-sVvL8cHpZH11x6ffbzxUJTTGCQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 2 May 2017 18:49:20 -0700
Message-ID: <CAGyf7-GfY7EEi80N-GjuZ4Pg7h1ooRNQ9YPvNayBZdFr8+kuEw@mail.gmail.com>
Subject: Re: Git checkout issue - deleting file without apparent reason
To:     Paul van Wichen <paul.vanwichen@cloudcheckr.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 6:33 PM, Paul van Wichen
<paul.vanwichen@cloudcheckr.com> wrote:
> Hi,
>
> We are having a strange issue that we haven't been able to pin down.
> Scenario: master branch and feature branch both have a specific file.
> 1. Master checked out.
> 2. git status show no changes / clean staging area.
> 3. Checkout feature branch .
> 4. git status show no changes / clean staging area.
> 5. Checkout master again.
> 6. git status shows that a file has been deleted (i.e. the file was
> removed from the file system and the staging area shows it as
> deleted).
>
> The file exists in both the feature branch and the master branch. As
> best as we can tell, the file is identical on both commits.
> The issue occurs on multiple platforms - tested on Windows and OS X.
> It only occurs for 1 specific file.
>
> Based on the activity of the file, nothing stands out as unusual.
>
> How we go about troubleshooting this and determining the cause?
>
> Thanks,
> Paul van Wichen.
