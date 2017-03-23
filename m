Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039D61FC19
	for <e@80x24.org>; Thu, 23 Mar 2017 10:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbdCWKP4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 06:15:56 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36809 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbdCWKPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 06:15:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id g70so16273777lfh.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VayNNAt8ngJoqN1TbZKWzWWXHp3A65etU44WSKpThyA=;
        b=SgUvw2zAL4JO5+Z+g5Pm5PwQPuccby6pM6aQUjXPqdvTK7IVnkyCV1zIapUSlnmUvX
         LGxmPsAEQg2zhoTEZMs57zW+2EyEmqmxT9JjNZ4YOS1qLjrLSHdsb30Zlf3fkbTuQg4+
         0d9e7eF/TtX6GZnxGsS1jJSh4HQg5jaeePp8eJ4Hi3BWwNDn5trC5pTyJEUyVdVNioZe
         CpEloMhJU0AGIWGBlEv/bb8vyNjUspakqTLU/5HVjqBvFh7iBIGr1R9RkIiE38o+3uFO
         nY1iDKJUXd29fb9+WOHebcJ8oMgOwFPT4EAy0YqxC78AB+EweMmRmOJwRfBrcp7kpNsz
         y7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VayNNAt8ngJoqN1TbZKWzWWXHp3A65etU44WSKpThyA=;
        b=AXMVbiDD8mkcz8kJxg3Mipx7K1UO3ptBPeMdooHSj7+eaLdTsvVY7gdcgxvXQKI1yX
         z3Bo8oR+YEbLPe6LRmHxG+3EUYE6Kicrf/IirMS1so/55HDqbrOCNkLx554PR4LQ1wkR
         iBh6itEZeRYg9ChGCGFjRpWyjRIE1a7SqwjrfT5Jq5c7IE3k0+7gU2VLlJYG9/Akdorw
         SreJO3cBxvZ1TGlTwp/5ML6wGmIIQZ5+Vij/8HDNsOplgWYIanXp9w4IlQgHWTtCg8cu
         18y95E21g34lg7zhYup2cxmkjeg/u+s0uURCgn+XooXcDp24dvlrjvpDZAGiArVnT0h1
         nXIg==
X-Gm-Message-State: AFeK/H0e5+s4IJDSGL1NWnSAEF/Jc0mGuq9k8Nt80CCrnyf8VfjMYPpiYv/Kh0gmd4OiK23MXT+DPFjkJEdw+A==
X-Received: by 10.25.196.21 with SMTP id u21mr969604lff.81.1490264152923; Thu,
 23 Mar 2017 03:15:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 23 Mar 2017 03:15:52 -0700 (PDT)
In-Reply-To: <20170313065148.10707-1-pc44800@gmail.com>
References: <58c63e10.5585620a.a224d.11cd@mx.google.com> <20170313065148.10707-1-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Mar 2017 11:15:52 +0100
Message-ID: <CAP8UFD3xOMbXgH5JATS7-cK_d0YA7Mvkk-ZpLh8sn-KYNm3wxg@mail.gmail.com>
Subject: Re: [PATCH v3] t2027: avoid using pipes
To:     Prathamesh <pc44800@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jon Loeliger <jdl@jdl.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please add something like [GSoC] in the subject so that it is easy for
us to find GSoC related patches.

On Mon, Mar 13, 2017 at 7:51 AM, Prathamesh <pc44800@gmail.com> wrote:
> Whenever a git command is present in the upstream of a pipe, its failure
> gets masked by piping and hence it should be avoided for testing the
> upstream git command. By writing out the output of the git command to
> a file, we can test the exit codes of both the commands as a failure exit

Maybe: s/the commands/commands/

> code in any command is able to stop the && chain.

Maybe: s/is able to/will/

> Signed-off-by: Prathamesh <pc44800@gmail.com>
> ---
> Changed sendemail.name configuration of the .gitconfig file with a single
> name,

About that, please note that in Documentation/SubmittingPatches there is:

"Also notice that a real name is used in the Signed-off-by: line. Please
don't hide your real name."

So my opinion on this is that it would be better with your full name
instead of just one of your names.

> and also included the leftover files of each test to be removed by
> test_when_finished if the test is passed successfully.

Ok.

You could also here tell us (again) that it is your GSoC microproject.
It would help if we are searching microproject related patches.

>  t/t2027-worktree-list.sh | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Otherwise it looks good to me.
