Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9B31F42D
	for <e@80x24.org>; Mon, 28 May 2018 13:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162952AbeE1N7M (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 09:59:12 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:43107 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162842AbeE1N7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 09:59:08 -0400
Received: by mail-pg0-f51.google.com with SMTP id p8-v6so5315561pgq.10
        for <git@vger.kernel.org>; Mon, 28 May 2018 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LwUkGxdVHiC7u88XpQ/+UmPclfUNQxW65FgztvrJV/8=;
        b=WmCEX8xHUKcGUlEkKYNz99Sactip92zEEXfWS83K3r+oZP5SbNXthsHJCBnoTgxWQG
         BYWaIhp280PFJIlsl2jiiC+3RQ2foVeOyQRVkYlasKwZqy4hV1lZseSEPqkp4nrWBLC+
         kk+WEw3aCJgXoQEEi87LY1D99Gprk/04n63y+2+APpD1M7RYwaVbh5W1m6W7x08yMWPh
         Ei6Wq/PHlH9bGzhpeEdowFpv8Ex7ApF0GjtQFJl1Xnk0V1Qb0n88QYj/ZRPA2I1Um7f0
         sb1un+R3zkUiCTN+l61cgb0qlQrQV6PAK2j0ZAn4pNArnC8eU9qAwdKycGPrj3iS1KZ5
         K9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LwUkGxdVHiC7u88XpQ/+UmPclfUNQxW65FgztvrJV/8=;
        b=clgUBGbjI0DPGFQ8oEg3Xcmyz7sqY4h9v0GzCh4rnKvc26GKCTQKcoVwtSgUVRwPpt
         CPt9atT9WKA3Mb86CiDbG3gYkl2a7yB4tv++2qAKj9otL88fv2Y5ss7n9XAFB8zOETKd
         jAMkhXpCKXYxdD7hPZ62StkfMf2bthRiEAMQHs4CI9Jnv6YQEmxaekKeD2Ud/Y9H71sz
         7qI0QkMvIh7NK5GfJs14Adi2uxusVavY15XkgXjCraHnAp0sxhdQVeYAFGjPIBEFI1TL
         aDhqg9zgILhcZJOOcC4KDxbdBhEbgJHrTT56U9mNw/7NtcuT/PGKdWmqz6y6HjJvWBBD
         woMg==
X-Gm-Message-State: ALKqPwffR6bo5tZVdmjegdCutURAWb9ID4aYFQPwN0zeXzIYvAy0hgtT
        HG5AZyVdXraWQHiISQB03+g0G5PV
X-Google-Smtp-Source: AB8JxZrIPMHqOd/qTOsFeHhC2lnnenn6XZhOROHIuG0HXXDHR4I6HMVtsJdGFrzoLjd4kyU87txsuA==
X-Received: by 2002:a62:e53:: with SMTP id w80-v6mr13776781pfi.236.1527515947535;
        Mon, 28 May 2018 06:59:07 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([45.121.222.5])
        by smtp.gmail.com with ESMTPSA id u16-v6sm63441471pfl.39.2018.05.28.06.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 06:59:06 -0700 (PDT)
Date:   Mon, 28 May 2018 19:29:02 +0530
From:   Sitaram Chamarty <sitaramc@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why does builtin/init-db.c mention
 "/etc/core-git/templates/hooks/update"?
Message-ID: <20180528135902.GA362@sita-lt.atc.tcs.com>
References: <alpine.LFD.2.21.1805280920100.12022@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805280920100.12022@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 09:27:18AM -0400, Robert P. J. Day wrote:

[snipped the rest because I really don't know]

>   more to the point, is that actually what the "update" hook does? i
> just looked at the shipped sample, "update.sample", and it seems to be
> related to tags:
> 
>   #!/bin/sh
>   #
>   # An example hook script to block unannotated tags from entering.

no that's just a sample.  An update hook can do pretty much
anything, and if it exits with 0 status code, the actual update
succeeds.  If it exists with any non-zero exit code, the update
will fail.

This is (usually) the basis for a lot of checks that people may
want, from commit message format to access control at the ref
(branch/tag) level for write operations.
