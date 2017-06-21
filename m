Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5F220401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdFUTTF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:19:05 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35301 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFUTTE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:19:04 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so29631148pgc.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6+JFqP6LG1u1V3oyOqX8AKycdhayZ8F29v57BXPhgp0=;
        b=tha2vV3P/vBUQbdylyzbGtD1aRxG6vhrsdwSEmCqwbNrLvjoQKxB+4ubXsBoT+aK4x
         CLQ+cekLkUgErOgTbuOIaTSMElSPvIco1Mj0B30uUh2noqDxJbgRpIyQMlLWq0GUeFpH
         qlb6p4MqgROTI7Ix3BUuvaPOYBXIcPGYG1BWCrFc6GtKEQKhOPAbOySQjFU+gbdsQj59
         kVayF3yV3dPxjVwgTeFSx7fVvdVDGxVqv53aYUi7cZMEbc8f55I8NeYB5f/tFxx66Ql+
         zkU72ybcn/r1NthPth5YqtoYPVWad0OSAgQ65yq3t09PR4SIIrpC+pH3T+H7lZa+EpKu
         j8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6+JFqP6LG1u1V3oyOqX8AKycdhayZ8F29v57BXPhgp0=;
        b=XLas2DlAXhWaaULsEFJG9vWUpXyschyvl8OJJCc7H0WGT5ZdYGQfQjV0FMGnt8ZThu
         RziflDQh0JqT/29FOB6GNkHJcYGI/1KWcQiRi4b1uCUeeYMZUt5atYRHHWLfLVg0cp6o
         zYymLI61maR7eJ9/zmcBTYmowEaEN+6BpI6PT8Ta2iJssRorTLIGZgk/u7hSEKFHkRFD
         w4yFhXk6Jf4cL7/DJOvWRGf3ysigaGw7KkwTCcT0QxM6FDgYBAMmcLj1nLapbrmlhgLR
         PPQEfMTbv4n9K+nJ5ux8tYeQYIi1iRgMZpz5MlCX193sL3MsiXFLBvMZGJU6kIVZ8Ep6
         nW8Q==
X-Gm-Message-State: AKS2vOzrwAeDM5yCmca34s38d3F3yRRvB7QaH94uF279eLoAoOhwBxBu
        F6IwYtcIRqaj+g==
X-Received: by 10.99.125.72 with SMTP id m8mr38515599pgn.270.1498072743537;
        Wed, 21 Jun 2017 12:19:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id s18sm35517654pfg.44.2017.06.21.12.19.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 12:19:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCHv3] submodules: overhaul documentation
References: <20170621173756.4444-1-sbeller@google.com>
Date:   Wed, 21 Jun 2017 12:19:01 -0700
In-Reply-To: <20170621173756.4444-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 21 Jun 2017 10:37:56 -0700")
Message-ID: <xmqqinjpp2sa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +DESCRIPTION
> +-----------
> +
> +A submodule is another Git repository tracked inside a repository.
> +The tracked repository has its own history, which does not
> +interfere with the history of the current repository.

As a naive reader, I have/got no idea what it means to "interfere
(or not to interfere) with the history of the current repository."

> +It consists of a tracking subdirectory in the working directory,

Is a "tracking subdirectory" something special than an ordinary
subdirectory?  How does a naive reader who experiments with Git
tell between a tracking and an ordinary subdirectory?

Or did you mean just "a subdirectory" (which is used to house its
working tree)?  s/in the working directory/& of the superproject/ or
something like that may be needed to disambiguate between the two.

> +a `gitlink` object in the working tree and an entry in the

I am not sure how you two are defining "gitlink object" here, even
after reading the previous discussion.  You two are not referring to
an 'object' in the Git object database sense.  If you are referring
to the entry with mode 160000 that points at a commit object in the
index of the superproject, that is not "in the working tree" but in
the index.

> +`.gitmodules` file (see linkgit:gitmodules[5]) at the root of
> +the source tree and its git.

Again, as you are describing a submodule and superproject combo, you
need to clarify whose "root" you are referring to.  I guess this is
at the root of superproject's working tree?  I have no idea what you
wanted to say with "and its git".

I seriously doubt the value of introducing a random new word
"tracking subdirectory" without defining what it is in the glossary.
The word "tracking" is already overused and with loaded meaning in
Git, so even if we need a new word that differenciates a subdirectory
used for the submodule from other subdirectories superproject has,
we should find a different word (but I do not think we need such a
new word---just saying "submodule directory" should be enough).

> +The tracking subdirectory appears in the main repository's working
> +tree at the point where the submodules gitlink is tracked in the
> +tree.  It is empty when the submodule is not populated, otherwise
> +it contains the content of the submodule repository.

Hmph, "the content of" is probably a too dignified word to use
here.  A naive reader (like me) would think that "a copy of the
submodule repository" would appear at that subdirectory in the
superproject once the submodule is populated.

> +The main repository is often referred to as superproject.
> +
> +The gitlink contains the object name of a particular commit
> +of the submodule.
> +
> +The `.gitmodules` file establishes a relationship between the
> +path, which is where the gitlink is in the tree, and the logical
> +name, which is used for the location of the submodules git
> +directory. The `.gitmodules` file has the same syntax as the
> +$GIT_DIR/config file and the mapping of path to name
> +is done via setting `submodule.<name>.path = <path>`.

This is mapping of name to path, though ;-)

