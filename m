Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E77202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdCOUso (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:48:44 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35030 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdCOUsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:48:43 -0400
Received: by mail-pg0-f54.google.com with SMTP id b129so14304507pgc.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rG6wNNii4WzCqo7pYcnn/otQirjOKMN57TaCqVcrzSE=;
        b=gT6CNiPJwiHYHOoYgKn634fhs3eeOCvGKBtBLF7c5uWDPAZhMRaV/pcPa7TbAcWjNQ
         aPDGOdD3/0GaIwelV70WQIs7VzHRWImtq4ibHWwnH3cWwWCl+w0sEt+KTnWYLgi+kyA8
         FtFu9Ky9xWvWe//a2YJA0583Pxhpnxs4MM4BVz7aIQYzmDh7K1BQPe31+lxSOF91HQoB
         f0Hr8LUtoqLtJ9TzCLZk8zV/LelKAYjYzxPZ9f0E8uq+TFfDYUrETy3T2VPiyPh6dzD1
         fccGndwQQWZ9OSlNw22PbKNOU4gCOTcl1/x+VnvjMLONi+R0vn+6CHcMiDVHiAuVSgIH
         fwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rG6wNNii4WzCqo7pYcnn/otQirjOKMN57TaCqVcrzSE=;
        b=JhYtU7XbKj6hQi/LeK/gTsqwaoVMXyIvLVehQoG4etKcURpknsShJXg/KJvwGKuMQx
         Ux+cQZq7RvNqudxv9oybXMx6Nud0jbg+xIjOj1Gwu9+JFYpGPkrWb2J9SRrYJ9HcBgqY
         U4lACJaKrBEc1gQSYJ8vkrXLZqgReWZrE6Ethw2RqO5PhdOCYp3jyolfYIuGCkyeP33F
         KD7+rt3NILA8ZQ3RRDaWKs3xE201+NqKyWiFgdTlnaIrG4jxE1uh5lyzQx8NJgbL20r3
         FC2BAONJX4IdIBlIACEd1+APfpPiF6qGd+rnExwZAazJmj7NI8eM6nVLwCDINRNygVOn
         ULZw==
X-Gm-Message-State: AFeK/H3rKeFAtPudWaq4qocgLdQpIw7sHX5JedE62OycQV7wOpA3e62OnrYxnpt+/3SYT/xGmOH4ORdUAoQ9XNxx
X-Received: by 10.98.44.15 with SMTP id s15mr5935745pfs.161.1489610922379;
 Wed, 15 Mar 2017 13:48:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 13:48:41 -0700 (PDT)
In-Reply-To: <20170315204324.9875-1-me@vtolstov.org>
References: <CAGZ79kbLr=aSu-g83obmj3XCMMYbuody6Q_FreCmQcqpyX+_rQ@mail.gmail.com>
 <20170315204324.9875-1-me@vtolstov.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 13:48:41 -0700
Message-ID: <CAGZ79kZU555GyMNkuED2efep9oYAag_FJ7ETRPH2tvipLO9K4Q@mail.gmail.com>
Subject: Re: [GSoC] Discussion of "Submodule related work" project
To:     Valery Tolstov <me@vtolstov.org>
Cc:     Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 1:43 PM, Valery Tolstov <me@vtolstov.org> wrote:
> I have a thought. At the moment when submodule command is already translated
> to C, possibly we want to rename submodule--helper.c, and maybe hide
> some of it's functions from subcommands list. Is there any examples of
> similar situation that already happened before?

I would keep the submodule--helper around as it is
and maybe even promote it to be a "plumbing" command.
Currently it is just an undocumented, internal command.

Once all commands in git-submodule.sh are translated to C
(when they all look similar to "git submodule init", which
is just a relay in the shell script), then we can make a full grown
builtin/submodule.c that calls the functions of the submodule--helper
directly in C.

Stefan
