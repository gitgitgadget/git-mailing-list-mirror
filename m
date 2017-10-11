Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247831FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdJKSJI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:09:08 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:56558 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdJKSJH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:09:07 -0400
Received: by mail-qt0-f179.google.com with SMTP id z28so5366254qtz.13
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dBAMmvZ0lvRriovEBQzuIdBvMbqf04WblgzXkyIy9l0=;
        b=bJJzhuJ+e9R1++r1yUnVPjpg0/MvGiwKU3kk7owInJmAFb46l2KlLc5gJ31A4+DT4E
         G5YQ5JaShArgnCv8kfKwqeJSXYwbGL57U9nsLMbJm+MpXIaKe7+rxnmgLLj1ijZrLjbm
         Q94GYXWlU9LKrZJmJj+qsobwm7QCIRDVfiwTeIKnDsytKn8cszSmYKfYd6MDf6xwFQ1D
         JUIn4poVyosxpB0b749/rxNgXK9BusXqAK/ap34Ua3G4VX1Tidn84KfwzvYG4/oJdNQK
         6BfQbrHkRTMgVRLxYaS6YsUga9IAxeQaH5jHLtJUFGrZaPeH3oe48EKuIRs0NeOUs6Ba
         SS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dBAMmvZ0lvRriovEBQzuIdBvMbqf04WblgzXkyIy9l0=;
        b=pyhMseLiSrP+GftrO2jOo2JoMkfjge7a7dmoViBGvN6twgwSgq8voPH+f01hTdgW/X
         TyA2X2XUtPi3fnIqREm1WE0SpLNY9g091CWPVR+PEmFCT3Jj4pazH7+ePExDo1CqeJnP
         goK4VFQH8wZ93lsDJqqMVZODIR0rjR+2YfnRm9MP1SPoX+POXNhCfBjykClM8Lsas9X7
         S/AfrlJaYSBHUPHy0kbeQjw4XwqWGMYhWjfNerGvEfvxBPe1N5aXUBKi432R4aUZ5dpI
         /ap3XM95E0y7nfAAXecx/eEiqwiFdhQQJoLlsh3SSV76GVpZKkyuuBMHtq92bm7ZIt6o
         uTJw==
X-Gm-Message-State: AMCzsaX2wTPikGeMpavzP075QiEA8ZkMn8EKgWXDAdqaKRlC0l63jf6U
        FE97VJC/RfuhXhT2DnGRaIvxmqmhta6kNbIptfsurrom0Lc=
X-Google-Smtp-Source: AOwi7QCH/2VtInr0YhC80q2pxTnXAOTlZpCg9jKlXCKuWHFTPvSgRAfkzKjfV7geH4NODo7cpyixY+ZHgRlVwUbf5xw=
X-Received: by 10.55.18.165 with SMTP id 37mr740255qks.352.1507745346294; Wed,
 11 Oct 2017 11:09:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Wed, 11 Oct 2017 11:09:05 -0700 (PDT)
In-Reply-To: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Oct 2017 11:09:05 -0700
Message-ID: <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Max Rothman <max.r.rothman@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 7:47 AM, Max Rothman <max.r.rothman@gmail.com> wrote:
> I recently noticed that in the git-completion script, there's
> completion for --decorate={full,yes,no} for git log and family, but
> not for --no-decorate. Is that intentional? If not, I *think* I see
> how it could be added.
>
> Thanks,
> Max

Using git-blame, I found af4e9e8c87 (completion: update am, commit, and log,
2009-10-07) as well as af16bdaa3f (completion: fix and update 'git log
--decorate='
options, 2015-05-01), both of their commit messages do not discuss leaving out
--no-decorate intentionally.

If you give --no-<TAB> you'd get more than just the completion to --no-decorate,
but all the negated options, I would assume?

So maybe that is why no one added the negated options, yet?

Thanks,
Stefan
