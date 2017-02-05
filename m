Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003801FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 23:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751939AbdBEXnH (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 18:43:07 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35290 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdBEXnH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 18:43:07 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so5526259pfa.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Uos89yKfT8gLcc+vvnumXLe3RmJjnQNJwtEndq4pBw0=;
        b=P/BZAbrWqwy0owizN/VruL5OjMtUYmhHJx/F2wL8/461rvPoDMXtjAfWfKP2VBSlkp
         dh6hsz+t9Cf06CBDbcCNa+kwW4IofAEBROgULt7GCLdFnwXRSKWBw35PEUv3LNxkHrw/
         q4pQtg4M4b8qKE/OOJGL4oZtLkJOeXdrccb8yXPcRfLCZVj6Grloh6pzl5GJNU2GhgH8
         RuUVP6C9/ZT2WoCPygtZvFsdtyHFQ7UTIbmoO3aP1X5wtthm1YFV2KMeLL/3gMpRYFZT
         wNO98HNBfEaJE45/pwSW30lRi7Y65htrP4YAXxD4HByRc9dvudrEDFoVBPzlcTPj+6Qt
         7QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Uos89yKfT8gLcc+vvnumXLe3RmJjnQNJwtEndq4pBw0=;
        b=dbM2RcbhhqOcu5FTHsGv8VFuNEv7AF5PopNghZKbYhA+EUmDIjbavyvFiUnq8tL8o2
         ml4NbykCSER6Ol3Ql9z8TjtqAGa2140x4YveryV3CUb+GOaQjTszLMAZ2h632W6ABbGo
         KTOQslnoRbpuTbGpHniZwMp2SxQTxfhoERLh8Y2pGdvH0tMS7fQE/WUmQCq34VdVezLE
         a7YWEsksjZOjfF3PAg0x1Xs/Frcf7rInyiB2Y1iyNJTycWneiOsp4VtzxJ8xWcy6+9OV
         Cja3eTJ+gZNLn47hUK5RYfXZISSqGJxXgGR3/vBPl9yon63zqG8C5VokcX8tB4iolcmW
         6Ngg==
X-Gm-Message-State: AIkVDXKEhViWGm4KZ/8T9kl6dZiAzU0qQ4FGp2D2HugLpd93eihT0NZ3dzqBuJWvDHf0LQ==
X-Received: by 10.99.108.74 with SMTP id h71mr9957930pgc.99.1486338186264;
        Sun, 05 Feb 2017 15:43:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:ac74:31b6:1bdf:d117])
        by smtp.gmail.com with ESMTPSA id b10sm84239465pga.21.2017.02.05.15.43.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 05 Feb 2017 15:43:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Breck <liam@networkimprov.net>
Cc:     git@vger.kernel.org
Subject: Re: In-body from headers ignored
References: <CAKvHMgQLKccm2LcL4LGhz0afVthaS2gvEcLtoHX2TcDnr1npbw@mail.gmail.com>
Date:   Sun, 05 Feb 2017 15:43:04 -0800
In-Reply-To: <CAKvHMgQLKccm2LcL4LGhz0afVthaS2gvEcLtoHX2TcDnr1npbw@mail.gmail.com>
        (Liam Breck's message of "Sun, 5 Feb 2017 13:45:39 -0800")
Message-ID: <xmqqa8a0431z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Breck <liam@networkimprov.net> writes:

> git format-patch & send-email generate the in-body From header.
>
> git am recognizes it.
>
> git commit & format-patch & send-email ignore it. (The latter two will
> add a new header above an extant one.) Is there a rationale for this?

I may be misunderstanding you, but I am guessing that you are
expecting

	$ GIT_AUTHOR_NAME="Liam Breck" GIT_AUTHOR_EMAIL='liam@n.net' \
	git commit -m 'The title of the patch

	From: Somebody Else <somebody@else.xz>
	Subject: The real title of the patch

	This is the (true) first line of the body of the message.'

to record a commit object that would give

	$ git cat-file commit HEAD
	tree ....
	parent ....
	author Somebody Else <somebody@else.xz> ....
	committer ...

	The real title of the patch

	This is the (true) first line of the body of the message.

and seeing that the real author is still you, the title is "The real
title of the patch", and the first paragraph of the body consists of
these two lines that begin with "From: and "Subject:".

This is very much deliberate.  "git commit" does not care if the
second paragraph in the body of the message resembles e-mail
headers, because it is a command that can be used by people who do
not even e-mail patches.

"git format-patch" and "git am" are all about passing the commit
between people over e-mail, and they know that the second paragraph
can have "From:", "Subject:" or "Date:" to override what "am"
obtains from the header lines of the e-mail that carried the
message, because the e-mail headers can be different (e.g. you may
be forwarding somebody else's e-mail but you may not be able to
forge the real "From:" line to your MUA/MTA) from what you really
want to use.  On the receiving end, "am" tells "mailinfo" program to
inspect the message body with "--inbody-headers" option.  After
"mailinfo" inspects the message, "am" invokes the underlying
machinery to actually make the commit (which corresponds to "git
commit"), but at that point the invoked "git commit" does not even
see these in-body header lines.  That is how division of labor
between these layers of the commands are structured.

