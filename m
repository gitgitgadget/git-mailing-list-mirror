Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42ECB1F406
	for <e@80x24.org>; Thu, 10 May 2018 20:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEJUJp (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 16:09:45 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34483 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbeEJUJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 16:09:43 -0400
Received: by mail-io0-f180.google.com with SMTP id p124-v6so4488371iod.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxP7UGls69GzfkZQm+rlDAnuxItCbfAUg9MAyedEFUo=;
        b=H7wY9AYJzALA6OvM0YT9V+6oAZNIDvPWuI5XqNHrjsW8+61Nq2BzYzKdztyzSZRCK9
         8aWaXb4k5onFsgi0kIcXOwswetrIvnI81p6tyNor/m65A3nsWrYT4Oq3dXHJBprZZopB
         4qx9xVgCxB1l3yfmD2NXFgtbo9nkAqSZmZlh64tldYZz6/X65sY0EjUEDZSx6Rd4WIVr
         43n1K3MI2QoU8Ci34J/MEws70n+Iayi8Pguyi2pulsYk+YvbnxI3IpUsv3okSoNfFaeM
         EP52ueNJEvNxzC0OGSKF3aw6Ou23vb9zxHDj9JIJBbCYybofIPluSkKubZ9SPyzWLNWM
         0kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxP7UGls69GzfkZQm+rlDAnuxItCbfAUg9MAyedEFUo=;
        b=b2Q7T6jNIA0zErB3AZDMsOKNYEhKLglvnBEP7a2nJ1+wZdi/kMCVg5iAe/m+96XWDS
         skw2KicfG/Fm183YCP9aA8GuM45RllgJgGuHOnIh9wAn9F3HfPaq2c1eEYvLlu776hzl
         D/5gT+L0EEe9gZGY6Q38xgm4fmDHY7MHGcWdrW1f71cpa2B9sKcqKu/ZqxVOmO5BQ5Ot
         LNu2l9Sh4cxZUMz53koBJGTtfFHmL0WidG9w876o36zoT3vE0R7y+xChW9wOzLQfyvlO
         YeGju9S4wlPI0zQySLAYVJG9PfELpznRXdNrQ1YxMq2Wws0N4AxeeKwExhxIOHbCvuMx
         GFlw==
X-Gm-Message-State: ALKqPwdANgBxDl77B8I/2cAYUh3JCBdCHyOYz3BzRuqHzSH1KH8pqQ/z
        lXOB9EIqyX7o8mEsV3no+gB3ZQBtBYxSa4KXYi71gQ==
X-Google-Smtp-Source: AB8JxZoYhCIplhR01dj84gA0+e8OxpU0kDoGo0ie9Q7I70n2Fc4z9uQKPle4jW3+xHqov4g3of56qnt6OWK6xP5FJn4=
X-Received: by 2002:a6b:4e0c:: with SMTP id c12-v6mr2988339iob.49.1525982982955;
 Thu, 10 May 2018 13:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKsGxtUpu66fj=puTxioTwCrint+U83a3R-DPhx5gXKF8Phm3A@mail.gmail.com>
In-Reply-To: <CAKsGxtUpu66fj=puTxioTwCrint+U83a3R-DPhx5gXKF8Phm3A@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 10 May 2018 20:09:32 +0000
Message-ID: <CAGyf7-E3-0SiqweoX-uLotwcCcy5MSxG6Zh+DRo6zQPKqTQQpA@mail.gmail.com>
Subject: Re: Git case-sensitivity bug
To:     miliways@gmail.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Cliff,

On Thu, May 10, 2018 at 12:46 PM Cliff <miliways@gmail.com> wrote:

> I believe I have discovered a bug with git tools.

> If you create a git branch, you can refer to that branch with
> case-insensitive alterations and it will track as the same branch.

This comes up on the list fairly often on the list. The most recent thread
is here:
https://public-inbox.org/git/d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com/

The replies to that thread explain the behavior, why it does what it does,
and why it hasn't been changed yet. It happens on case-insensitive macOS
filesystems and on NTFS on Windows.

Hope this helps!
Bryan Turner
