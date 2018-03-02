Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270D31F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946063AbeCBKXY (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:23:24 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:43958 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426303AbeCBKXV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:23:21 -0500
Received: by mail-qt0-f181.google.com with SMTP id d26so11252936qtk.10
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ww4OtJzyUh9axxoDAyQsIZFJAuzDNYnO6WnGnEbVmxA=;
        b=RJNuV4qjR+aLHLgH2Zg2se6t4g8Aonh4t9YuyFZA8Stl6ULJ/H0Oy6KQ5y9MUxTg5v
         P28Liz8X/FvzzJh/I8uh6TvaBuwLJEDpqZAVP+lrm0gABWxB9sN2sDW9YvF8kkQUkY2P
         gUs8bLsA7qw8jhdo0QUe6o+35K9zknjsOJ+uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ww4OtJzyUh9axxoDAyQsIZFJAuzDNYnO6WnGnEbVmxA=;
        b=jFq1eI4qY2XkRefPbhDGCvsrku/YpGND9sR/yKVsfk6fqWhgUM8SRwqNd5aUgLGuEh
         xNLfcMfUaGPzOPZQZWBz+N7D5mjCSqYQnEdziXcIuV0OMtQMQZHWhHbLoD0h8oZ/ye4W
         b7SQvRMf76aU4cRs568vG6HwyntKq26W8WmmAgXl/3lFtwBPbkxg6JWjxHuh3KtM5yfz
         oiYjuY8IsARsk+gImIvHwd688e1Jy1LNF+YmRcEfmuDK4t4IXEUM8Jugsgfy0UHDFlhT
         +LPCow3pPmGl3IcIl1/LOmxb8TU84iCenJII0RaPVplEEIWYr6Ulke0OkZqb4lThlnhr
         icXQ==
X-Gm-Message-State: AElRT7G95n3BG3O5/0VdHDayEZyAc4stbGn13wr0QwFaNqCsbB2LdwNz
        zVuVo2JQ+OoyHnnrWJE6ChlzPbskvPAIcmP1rz8exQ==
X-Google-Smtp-Source: AG47ELtkDMwgfSeOdrYcctri51b/E9SStqx8D2LMGqRvucluZlzXLLMvg8SlcxfwoU+zlszLTrdRob6rZ3wXNhhIl6E=
X-Received: by 10.200.44.114 with SMTP id e47mr7570426qta.59.1519986200764;
 Fri, 02 Mar 2018 02:23:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.36.141 with HTTP; Fri, 2 Mar 2018 02:23:20 -0800 (PST)
In-Reply-To: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
References: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 2 Mar 2018 10:23:20 +0000
Message-ID: <CAE5ih7_ooDMqVtTMoQ70s5XCkncr04HY0JkqSp1UmKQeG81oaA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 March 2018 at 22:20, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> --------------------------------------------------
> [New Topics]
>
>
> * ld/p4-unshelve (2018-02-22) 1 commit
>  - git-p4: add unshelve command
>
>  "git p4" learned to "unshelve" shelved commit from P4.
>
>  Will merge to 'next'.

The unshelve change should be left off next for now.

The problem with it is that it can't easily find a sensible consistent
point prior to the shelved changelist to generate the diff from (P4
has no concept of a tree revision). So you can end up "unshelving" and
pickup not only the shelved changelist, but also a bunch of
intervening changes (or the effect of some missing changelists). That
can be quite surprising.

This is actually pretty close to the behaviour of P4 unshelve itself,
which does somewhat the same thing. From the p4 manual page:

https://www.perforce.com/perforce/doc.current/manuals/cmdref/Content/CmdRef=
/p4_unshelve.html

   " Unshelving copies the shelved files into the user=E2=80=99s workspace =
as
they existed when they were shelved. (For example, a file open for
edit when shelved will also be open for edit in the unshelving user=E2=80=
=99s
workspace.)"

There's a better change which I posted which adds a "git p4
format-change" command which uses the diffs from Perforce. I think
that has a better chance of working properly. I had some review
comments which I need to take, after which it could be a candidate for
next.

It _might_ though be possible to resurrect the unshelve code by doing
something like extracting the previous versions  of the files (which
is kind of doable) and then constructing a temporary branch in git to
do the comparison against. Sounds pretty nasty though.

Thanks
Luke
