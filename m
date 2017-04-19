Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5AB1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966541AbdDSRFP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 13:05:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33063 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967377AbdDSRFN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 13:05:13 -0400
Received: by mail-io0-f195.google.com with SMTP id k87so5199989ioi.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwuAREuUxaHXHzjaR/yCMlvR1AZUpCExkZ9SydfOAHo=;
        b=l1EJrQeZmepELP3I625O6DHV73iHTjPPjCOAK3NQh3DYDcF6j6w6+Vj7rzyhjSBZtw
         +rpxtKFi3VO4/UoDsbooE95F0JQo5ANxf079es02VfqpAZQLzk2hYVFdMcq7kRuXOyh2
         SxkvTlkhB/UXrr/Inv9v+Hb/m/PAZ7JW4cKZUqP5wlr/FNEu3NTVKtWSqH8gcZ//G33z
         txs4oB1YLjoeiR+ZYTTRUIc9AUpKPBe52o7fJvwzpTLxGUf3nbonoeaxezExbzGcTW7O
         gUyh33MNiq+XT38KFY0Ni5KFCXQOTIEsVEOk7Z/oTSAuUddNN/anba9big2th+ebYpKy
         0s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwuAREuUxaHXHzjaR/yCMlvR1AZUpCExkZ9SydfOAHo=;
        b=cxKO5zRxSMeo6XVaU7B2Vz9Q9gr/hFrmucK0kL0iCG5HMbVdF7FebGsBYpQj6IYWvf
         tRU6sAMci6XvGL5XA/RvylLJ95i3Qx3yhL/eQ6ZnZ2nT3MG+jvBYZEC9ItcEOuZWs//i
         aqDZKZkUO/IZ3hGwrYp6juydJvG/zk+dWf6QTg6bdcDfkkLO8h6JU/1HglcFcfuep6kP
         Sr8ylVCSLOIW7j5NMy5HoX8uqTYYjwQkYmO/ivU+MeqbzdTQ41kRERlrJxFYJnZ2YiZZ
         3mY17Jlndj1cGS3jtYpqynSE4OhLupbbN5+ZPJDRLH1fzaSY46dGR7krpPnIXKtQGHAb
         m4KQ==
X-Gm-Message-State: AN3rC/6aAZ1wn6LQZdKAC3gBw46Elxh/d+FMmd5HO2c6gKFsCUYD4x9l
        aXH52ePHqCyjP9SFbLs=
X-Received: by 10.99.127.26 with SMTP id a26mr3926301pgd.196.1492621511890;
        Wed, 19 Apr 2017 10:05:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:91e8:10dc:2476:b71b])
        by smtp.gmail.com with ESMTPSA id e5sm5685900pga.13.2017.04.19.10.05.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 10:05:11 -0700 (PDT)
Date:   Wed, 19 Apr 2017 10:05:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [bug?] docs in Documentation/technical/ do not seem to be
 distributed
Message-ID: <20170419170509.GC28740@aiede.svl.corp.google.com>
References: <CAJZjrdWNQFkWwAO_hmHMzVGNNMfynxsvbWufGvRWX8bZD19Epw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZjrdWNQFkWwAO_hmHMzVGNNMfynxsvbWufGvRWX8bZD19Epw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Samuel Lijin wrote:

> It's possible this may have nothing to do with the Git project itself
> because I have absolutely no idea how this is handled on the packaging
> side or, possibly, if this is actually intended.
>
> There are a couple of links floating around in the man pages pointing
> to pages in technical/, such as to technical/api-credentials.html in
> gitcredentials(7) [1]. On the website and man pages for Arch Linux and
> Ubuntu, this link is broken.

This sounds like a packaging bug in Arch Linux and Ubuntu.

That said, at least in Ubuntu, I am not able to reproduce it.  Do
you have the git-doc (or git-all, which depends on git-doc) package
installed?

Hope that helps,
Jonathan
