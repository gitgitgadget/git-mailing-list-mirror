Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E6C20188
	for <e@80x24.org>; Mon,  8 May 2017 05:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbdEHF3L (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 01:29:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33516 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdEHF3K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 01:29:10 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so9040344pgc.0
        for <git@vger.kernel.org>; Sun, 07 May 2017 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NH4C1a83Of5QFwyFMnMq55dvTp3cFKRwLFUwHv7xpHM=;
        b=lJG++cj7NIYV4adD9w3gPKBRw7+xrxdYy6d11nDEktkU2BgbppyCdqMK3jh8sbZd5R
         mCm/iXSK12sH36XA9F9DUbnC+8wwZ864B9TYAlnVWFVobYV7jkD50bn45k5rlzeXs/sb
         fGCOg8oZ38dRhJgSC6baSvzF3XvSvEMwpvpFfDIJ1P4rB2zBGwZq9M8g1wrYXb5tULdw
         3sbabJZ1d6ooBpmUruwraJ7QcwEYIjxxc7jH+fx22c+LPtpE9jOoZeu7tGUMPFVNEmh4
         SO7KxqwOYJPAeyhheXN9p6x9JQocAR7j3DngLTMTefH9n1sJL70v/TQiuGmMBlx513sq
         +YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NH4C1a83Of5QFwyFMnMq55dvTp3cFKRwLFUwHv7xpHM=;
        b=b47faXJI+BUYNIKw3DSuaBeJ+PmWX9cyMSascxkLeyllOjKaP0c1/3pxLFQ58YBMKS
         XJSh6+z+SBwn8pcaGEYMl5urOU98mdG4pO12ajsWtP3/VNKkIQZ/934EOIpcQAGV2Z+Y
         c6ooHHzHkJt/klGzcwQG0+J8nbcqI9z8pTsMLfUQ+XcnYs8BjGmnsl/Z0jt62Dv0wxED
         laTFjSOUAFLh2QyvIef/Jk41eVfrptwrc/u4ODRvJ/spwmN+DA4HV8PlYdWGMqNu9IvI
         V0rU8bN3k7jeoepr3aZAFLGKNHcwWCg/BOC/f1gkLOD/0gZ7l38Dn7G7hGLnOQmBDYeW
         WzCA==
X-Gm-Message-State: AN3rC/5S+3q+obyEj4L/Zc0BE6KMSqXXN6Zzh3OoZxbjHkBrst1OBcuq
        SDsZwH09cMKi3rcD3R8=
X-Received: by 10.84.233.131 with SMTP id l3mr44985370plk.18.1494221349799;
        Sun, 07 May 2017 22:29:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id t198sm17165114pgc.33.2017.05.07.22.29.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 22:29:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t4051: mark supporting files as requiring LF-only line endings
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <cover.1493891336.git.johannes.schindelin@gmx.de>
        <f648bb03c7fe3945042480f05b9ac229350412b3.1493891336.git.johannes.schindelin@gmx.de>
Date:   Mon, 08 May 2017 14:29:08 +0900
In-Reply-To: <f648bb03c7fe3945042480f05b9ac229350412b3.1493891336.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 4 May 2017 11:50:57 +0200
        (CEST)")
Message-ID: <xmqqefvz9asb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The test t4051-diff-function-context.sh passes on Linux when
> core.autocrlf=true even without marking its support files as LF-only,
> but they fail when core.autocrlf=true in Git for Windows' SDK.
>
> The reason is that `grep ... >file.c.new` will keep CR/LF line endings
> on Linux (obviously treating CRs as if they were regular characters),
> but will be converted to LF-only line endings with MSYS2's grep that is
> used in Git for Windows.

Ahem.  

I thought that according to your claim a UNIX tool like "grep" would
alway use LF endings?  ;-)

> As we do not want to validate the way the available `grep` works, let's
> just mark the input as LF-only and move on.

I agree with this conclusion; just like we do not want to worry
about how `grep` works when given CRLF files in this patch, we do
not want to worry about how other commands like `sh` works when
given CRLF files.  And that is consistent with the overall theme of
this series that marked *.sh, *.perl and other files with eol=lf
attribute.

The only question I still have with this series is about the
README/COPYING thing.  I _think_ it was my ancient mistake to use
the toplevel README and COPYING as test files, and that mistake was
corrected by somebody else earlier by having a frozen copy in
t/diff-lib/ and making tests use these files from that directory.
If we broke our tests to again use these files from outside
t/diff-lib/, then we would need to fix the tests not to do so.  And
if we are only looking at t/diff-lib/ copy, then I think it is more
consistent with the rest of this series to mark them with eol=lf
rather than passing them through "tr -d '\015'".

Thanks.

>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/.gitattributes b/t/.gitattributes
> index 3525ca43f30..bdd82cf31f7 100644
> --- a/t/.gitattributes
> +++ b/t/.gitattributes
> @@ -5,6 +5,7 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
>  /t4034/*/* eol=lf
>  /t4013/* eol=lf
>  /t4018/* eol=lf
> +/t4051/* eol=lf
>  /t4100/* eol=lf
>  /t4101/* eol=lf
>  /t4109/* eol=lf
