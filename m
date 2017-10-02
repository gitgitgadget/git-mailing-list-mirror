Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2208020281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdJBXKD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:10:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34798 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdJBXKC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:10:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id g65so7087622pfe.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2lfbCLWnlN7wOf8UxfyzMG0MC+uj+QDSCcfjKzqSgc=;
        b=i6+n5OFWGWeQR3ODkEAHn/XwfjkRx1zkS9s/yhCeZoFxLXVvGjkOhqOa2qgaKXWjvN
         tYMPK5JcVOi9XN+nWDX/KmvRb21guIzUgkkct9pQM+/Fxs41bFbVj/H8AGQBMo142TJk
         o+GyJO2FM4N3UmqjY6f6zp73bNkUs/KBva4HV+Prplr9SEK4jbGJhNL+L00ID1i1z0WN
         P/uLbCPfc6pznt5tlJAYuy2NZZoF/iqsNEKLK5p4uQ6Fez9uEFjCW5BoX4l/vVTMSUc0
         SaVY00EkalZL6D26296o+JrtUX03XjJMt9ElGdhzjXjGmAhzxva8iWxzVkobbTW8TzAY
         M/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2lfbCLWnlN7wOf8UxfyzMG0MC+uj+QDSCcfjKzqSgc=;
        b=nthj933hLVmgSslMLn/JGFEZpORUxmWiGlPRTaliCgsw8OH9eAbqtY5gjAHVK8b1/Y
         H/XQh/5y3B6c21x+0lfgZEf2VYc5EHYT9LJEwXw80Mz41Ma6CCRswQ9XGmkn3cRhLmj5
         DqgK/NXrRajHZe95MK58hgZaZhXFLeyX1wQ4ovC9qBf3ZVdFUzcw18yJQbgNKesgcMOX
         ztMdytUAi2o1EdSTFCzqr2AOehKTnxjmtxgRFB6hpUUU1moT/FNHhoRudNhVOOx7AXqw
         qpaqyxLD9ZFYkPgH4+DjqsMTCWVyG62WbkkzQWar/0SahbM2AwhKxUmF6qHN2oWpbEtv
         36zQ==
X-Gm-Message-State: AMCzsaXCh1iaRudC5TuIO2e6FpEMZgKTDWD2L0iYgb5ZFRh8jQpfuQnt
        +kSCEQV1ExHDCrtiQHQcIPc=
X-Google-Smtp-Source: AOwi7QC2fQj425yJ6cL4X7B7MuIuHXwdeG8NDOUdXJu+XIxFoS5oWUjYAloKv0brCA+Q/+GAgjR07w==
X-Received: by 10.98.104.67 with SMTP id d64mr987567pfc.230.1506985801467;
        Mon, 02 Oct 2017 16:10:01 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c1fd:a9ac:f156:8142])
        by smtp.gmail.com with ESMTPSA id x26sm196620pfh.95.2017.10.02.16.10.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 16:10:01 -0700 (PDT)
Date:   Mon, 2 Oct 2017 16:09:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Bedhanger <bedhanger@gmx.de>
Cc:     git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] PR msg: capitalise "Git" to make it a proper noun
Message-ID: <20171002230959.GU19555@aiede.mtv.corp.google.com>
References: <20171002225636.Horde.mXj_gBTKz-CxnFKzUqiNDA1@bedhanger.strangled.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002225636.Horde.mXj_gBTKz-CxnFKzUqiNDA1@bedhanger.strangled.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for working to improve Git!

Bedhanger wrote:

> Subject: [PATCH] PR msg: capitalise "Git" to make it a proper noun

nit: What is a PR msg?  Looking with "git log git-request-pull.sh",
I see that previous patches called the subsystem request-pull, so
this could be

	request-pull: capitalise "Git" to make it a proper noun

> Of the many ways to spell the three-letter word, the variant "Git"
> should be used when referring to a repository in a description; or, in
> general, when it is used as a proper noun.
>
> We thus change the pull-request template message so that it reads
>
>    "...in the Git repository at:"
>
> Besides, this brings us in line with the documentation, see
> Documentation/howto/using-signed-tag-in-pull-request.txt
>
> Signed-off-by: bedhanger <bedhanger@gmx.de>

Please use your full name in the Signed-off-by line.  See
Documentation/SubmittingPatches section "(5) Certify your work" for
why we ask for this.

> ---
>  git-request-pull.sh     | 2 +-
>  t/t5150-request-pull.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

The patch itself looks good, and I like the change it makes to the
email generated by git request-pull.  Looking forward to seeing what
other changes you come up with in the future.

Thanks and hope that helps,
Jonathan
