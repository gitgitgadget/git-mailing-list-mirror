Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07011F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIOWBy (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 18:01:54 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43926 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeIOWBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 18:01:53 -0400
Received: by mail-io1-f42.google.com with SMTP id y10-v6so8373361ioa.10
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjIPWKoFx3dafq0RPR2/IS/4dWpp32r92WMYk76VWRM=;
        b=ZlidBcEKMsuCscrZucAehbBijL5WG4Cb1sVHn7OCPS39DoTSjFGwvNFwryvX8WMCoC
         /luYWsaRFLcxFi/g5vUOhvRUPsaK8HwP+evwTGFlkwuRYw4VSQRu68NhPura8UyvUxB8
         3Gi/a/pW8bOkxm4ovkqqcbLggpuXy5Cr+D36uGzHykDyuWxcbYh0xjtzl00e/94suqUJ
         d6VGq6CCISlcCvVeqT6zlcDIVDUgqaQHd7OvvxrrcQfF7HgyHnAWymV7UWsXo/eq0cvj
         HHs3mMgJDxFfoUMWAmlmCyzIkHKhn4nSsgyMZPEkHbI8IJLkQpoiGfDHnTKQxGPJ5Hsn
         N6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjIPWKoFx3dafq0RPR2/IS/4dWpp32r92WMYk76VWRM=;
        b=a+Zii8uxTs9i6n/gdZX6hLUSPPpFyWNC406fCqh7NFwWq9tYfHa76dM/HP2I8vZEJO
         T75z+VRe20Dh282LARb/iPjyBr0VjRrrydJOWuneDoY3LLLbJtr1WXBeVnt5b7VHMrkc
         ZsvJRqz/4YC+JgpTt7adxGdupoxgOS5AK1w7766kCwOazT19DQ5P6GVyEFe0Db8lWQbz
         HtEwk7TvTSh2GRyqK8sjzmzwIoNDv06WpTwAdlUbbi6EH3rhpMmX1mP2+TDHooNMdCO/
         OvjoJ8fYae8epe9Am6UxnQroboQ7HHFFCx/vAJ+2Y3KtTqTEYiwisi58I7z4aHTan68w
         gdZQ==
X-Gm-Message-State: APzg51C7jqIdLxfjlm1pm+lHDIhpnZ0UG3dMT8PYiNI3XS1AnhvLT5zR
        meJ9GR1yQR08b1gU6G6U44kkdg==
X-Google-Smtp-Source: ANB0VdYKL7lGV5lkS5PJJkLadiCK1fO3H+xz+1JuJvOw4Ugr4xOQdEYMMuUiW3kAVF9Mq0NXcunggA==
X-Received: by 2002:a6b:2985:: with SMTP id p127-v6mr13951096iop.95.1537029739118;
        Sat, 15 Sep 2018 09:42:19 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id y18-v6sm997155ita.29.2018.09.15.09.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:42:18 -0700 (PDT)
Date:   Sat, 15 Sep 2018 12:42:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Austin <john@astrangergravity.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: Git for games working group
Message-ID: <20180915164217.GB88932@syl>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <87bm8zlqrh.fsf@evledraar.gmail.com>
 <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 04:36:19PM -0700, John Austin wrote:
> > There's also the nascent "don't fetch all the blobs" work-in-progress
> > clone mode which might be of interest to you:
> > https://blog.github.com/2018-09-10-highlights-from-git-2-19/#partial-clones
>
> Yes! I've been pretty excited about this functionality. It drives a
> lot of GVFS/VFS for Git under the hood. I think it's a great solution
> to the repo-size issue.

Right, though this still subjects the remote copy to all of the
difficulty of packing large objects (though Christian's work to support
other object database implementations would go a long way to help this).

Thanks,
Taylor
