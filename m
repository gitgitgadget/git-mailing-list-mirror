Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D8A1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbdFSUtT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:49:19 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35642 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdFSUtS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:49:18 -0400
Received: by mail-pg0-f44.google.com with SMTP id 132so19562665pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pESpduLcHNxHZJQ5Dgvdu/mTmiR3OyatFqaBP2JWc6s=;
        b=B7Xi/lvGQZZ14DiR0WefYjD26PoYhHw8jmeyXktZt5Gs5Z62ZKiI+5S9FTUmh3iC/E
         jpNMx6p522oeqX0RobKRM2SCuT5ZyTAL5+dJpPAZ0SYAtWYi+AiAfc3wJAviSB8qhIVM
         6QCOpC5s4d7DEMLQ/yf5G6hrY1y43m5fX5PHvStRbUqIxl+zMhKk8HXNJ+t21IXSGgtH
         fd2d/SaQETfOcKGa5Wg3B8Ogbd/07JiJIcSfKP/+O7aVbJFN7SJW3vLEyrxwUcpmePCD
         FWcRi1rk+DW1E9BEWxfOkayHFWvUk4L+IEnpYL4hwIg5WIbW7AK9JMkdYQi1HQHwA3ib
         vXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pESpduLcHNxHZJQ5Dgvdu/mTmiR3OyatFqaBP2JWc6s=;
        b=XOtc4ylIVhGb8IdQcehX8NbC8C7C78Ntd5bjgtQicho3+FqOkuvhuOcMcmCGTOV/9E
         nYCPEcmE97+eWaXuFM4mdWWh7HiQCUUK0zVGY4o+vk6xIieQXpV088aNQ3eT+xXcG+j7
         0F6PClH1b0OqzeMyOjEZNZ25h1Nqp9oxE5D9EL57IxPoQQMWFd95+2BXahwGhJsnqpNm
         +bCDGVH4rysGABajd0diIRgYuM7T6P70+nLxnETE2wQekbhOUezuFTQh0TueOWxVdu3n
         mLvsgKn6ALwJmkYi9+NacNQj+MrlCyE30uIlutj4fuxwRqX1UDNWxSLBB3+QgyJyNRXf
         nD7w==
X-Gm-Message-State: AKS2vOwaOXbIruCMBI/u2/knTNOjwZZt5Z8IgZd8NL3LMfqTOOqupki/
        0N3ecFo71UBxbw==
X-Received: by 10.84.231.15 with SMTP id f15mr32231201plk.131.1497905357195;
        Mon, 19 Jun 2017 13:49:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id e2sm23572874pfg.36.2017.06.19.13.49.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 13:49:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Better usability of stash refs
References: <CAHd499C8x_zWJyRNXO-410gxudk897-okJaA3uOPYr38QNHjpA@mail.gmail.com>
Date:   Mon, 19 Jun 2017 13:49:15 -0700
In-Reply-To: <CAHd499C8x_zWJyRNXO-410gxudk897-okJaA3uOPYr38QNHjpA@mail.gmail.com>
        (Robert Dailey's message of "Mon, 19 Jun 2017 15:32:54 -0500")
Message-ID: <xmqqd19zsnxw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> To drop a stash, I have to do this (example):
>
> $ git stash drop stash@{3}
>
> Using the full "stash@{N}" seems superfluous since the documentation
> states it must be a stash in the first place. It would make more sense
> (and be quicker to type) to do:
>
> $ git stash drop 3
>
> Is there a trick I can use to make this shorthand possible? I thought
> about creating a "s" script for "stash" that intercepted the
> parameters for only a couple of stash sub-commands and created the
> ref, but that seems a lot of work.
>
> Any productivity tips here? Thanks in advance.

Isn't that already the case?

git-stash.sh::drop_stash gives "$@" to assert_stash_ref, which in
turn calls is_stash_ref, which in turn calls is_stash_like, and this
callchain eventually cals into parse_flags_and_rev.  Which has this
bit (may be hard to read because it is incorrectly indented):

	case "$1" in
		*[!0-9]*)
			:
		;;
		*)
			set -- "${ref_stash}@{$1}"
		;;
	esac

	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
		reference="$1"
		die "$(eval_gettext "\$reference is not a valid reference")"
	}

