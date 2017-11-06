Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A12C20A10
	for <e@80x24.org>; Mon,  6 Nov 2017 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbdKFRun (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 12:50:43 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:48654 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdKFRum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 12:50:42 -0500
Received: by mail-qt0-f169.google.com with SMTP id f8so11981414qta.5
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tGEOl1Wo58pXpKVCpEohmpjm6NSeQb042rP/nJa8BCM=;
        b=aG9WIug5Rdt8pW+esjQ5UgEFU8VRkExq10+VdVE1u38Q4KZjxs+tW8BNV6J1A2I2PZ
         GCTV8l/+KGlaNscgxb7pIUnd4zQc6WtEZreFKCZE9CM5qbikFSotknI6L2WPHJcgxN+r
         1ph9eDAeMdRzRsNwRpExt6qyJeHjgvlErla/SeNcGhODZYq6Xaj+L2e8c7yabM2QokB4
         Gi+3z2CIxJDcEvn5PLCj1b/NgIsCLD641CT1E0jf2qOsLHUj0J3AR4xd3C7vVhjtMWA4
         fU1a1YhmfOLHmNcOKcTrBNDmLK7AKBcm6aOGED0wNQvh3tVHecS+sEeEpn85OBcJnu1x
         deHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tGEOl1Wo58pXpKVCpEohmpjm6NSeQb042rP/nJa8BCM=;
        b=QtGesFMXQbWaL1TkqnRJcGO0ypiuBPn3H1qTwACfPOxJmC9vg63+fedzYbN8FPIKyB
         kbOrEPoxd1bEiw0fiiarJLRx7JaJ9Kbwu7LwWDTAe/NVWD5AO5TeHXSeXq4Xbi+M7JPG
         23N8QnUtxjAsQ3Pb/61FHaCXR/VohJZRzABuJMXrBcxkowMC5jacGJg1Z2dJlTPG8m/2
         YXmp2R7N4Ake4BQ8h3/NTWmA6HnR3BqVF8uvQ57yF1unbOzpC05MUhdWPJDNfMlN7lpj
         PRWfhJ4yNlB7D7NZzdmtd6UpNZtruAKDWo6cVXqhBhzYCW/mSgkfO8/Q7R2Cz2YcLVFa
         UHLA==
X-Gm-Message-State: AMCzsaXevSDAf2SaH8WGmzJz4WpkeSc2UQkGoYFKtZnRKUjp7NKgo2no
        b06QGuOB/ceb0vMsQG9vDIarzqPU8H1SuXoXMAZyabCzEuc=
X-Google-Smtp-Source: ABhQp+Qd6YZ0WKM4xlclcAW9FWSdEgVk6txbrLUIhp3wMiYefZ6qRTSD2lE1Nu1hZVPh3K7Hhuwk/CvzZFoJL8UYMbE=
X-Received: by 10.200.40.146 with SMTP id i18mr23840176qti.79.1509990641778;
 Mon, 06 Nov 2017 09:50:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 6 Nov 2017 09:50:40 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711060733510.13383@localhost.localdomain>
References: <alpine.LFD.2.21.1711060733510.13383@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Nov 2017 09:50:40 -0800
Message-ID: <CAGZ79kZqRV2Sui5-XRcukZiucKzv+DvRr3x3-=dHaxB5ZC6LyQ@mail.gmail.com>
Subject: Re: benefits of "/" in branch names other than the obvious?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 5, 2017 at 9:36 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   another picky question ... are there any other benefits of
> supporting slashes in branch names other than the obvious ones i know
> about?
>
> 1) visually, let's you *imagine* a branch hierarchy, and
> 2) allows wildcarding on a full "component" basis
>
>   are there any other benefits of the above? thank you kindly.
>
> rday

Currently refs are stored either in .git/packed_refs,
or the refs are taken as a literal filename (refs/heads/master
is found in .git/refs/heads/master).

When stored as literal files on disk there are interesting implications:
* File System speed when there are *lots* of refs
  (a lot of files in one dir vs sharding or a tree like structure)
*  Directory/conflicts in the data model:
    What if you want to have a ref foo/bar as well as foo?
    This is not possible as 'foo' must be either a directory
    or a file. This spawns occasional issues such as
https://public-inbox.org/git/20171024082409.smwsd6pla64jjlua@sigill.intra.peff.net/
