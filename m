Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ADDD1F42D
	for <e@80x24.org>; Wed, 30 May 2018 16:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeE3QJS (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 12:09:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40995 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeE3QJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 12:09:12 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so11366557plb.8
        for <git@vger.kernel.org>; Wed, 30 May 2018 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oq2g0Yol+DVd72Zm2fe3/EEdZeWYe/wLmazyyZYa/CY=;
        b=CrBwdS1aidzwExm+i+OHduoeBSByaOFxTM+QFl46e0KY7O8jsdQdZwgzXhq/+ArGhS
         RtOFSU6cdG32L0A6htUtI/deDuROMMnbHYWz1Y50y7JHt3hLGukTzNWvuAm2bNUmlpLU
         mEV5dCJKLPXxmoflaAXIw4aukfNXcXCXadbJGN5iFFaoNknMh56HwVNGJ2ztCNKynUjq
         ZpM9o537gUiRbGJwj59d5R7dACScRxbTgr7Zy/3W8CFgEUFo1Vl+ziCpXGdZywfDOe2y
         SQY3DtPQS34Lpg8zVcwho9OlWQv+dmqv9TthiriOCeABxL63pTtDJ9ylMPYDTulSD8PW
         nZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oq2g0Yol+DVd72Zm2fe3/EEdZeWYe/wLmazyyZYa/CY=;
        b=PDi6pdbrhhNqf2+wKjlDc6VjdP/RsxT2fkO4wq5VxhhyBupYhfF9IbeKPN20e/dFaY
         yapbR6ra0tNKLe65Sos8a5ko/B9yeWlDLaXbP+tfN2TLXzfV39OglnPCkPM2r4Vylril
         grYOnQ8bMh+iJEhXrOxSTnXBTWXv0sgtjncTCxbebFcwpDg5ZiSyV+iZNLyf1sP363dR
         WFcwDK4mexRx2Az0iWfjeS7PRWkKBXpPlB/eFil49VmMwXlgL26pqnuNUkPN1ggQipWf
         EuH6Bu9F6KBO6/AaLdJ/fNp3E0L4jt2Fve3o1xADwPNRCcNzcYOAtlStexInmb2jndWz
         fdSQ==
X-Gm-Message-State: ALKqPwdSQJmtsueMcfBBdcf1I0108+oVC7HjsjUU3KFF4kGvJQTuBrpu
        C1Hdx8qBAIsoCTETAwyDyAD8sg==
X-Google-Smtp-Source: ADUXVKL80VKx5aDiHlG/CRLDANe+sfZrxOXGyGrA7/j5tTNLxX4A6SkDvo1CpBvP7tPSQzQtUbSeoQ==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr3476461pld.72.1527696551414;
        Wed, 30 May 2018 09:09:11 -0700 (PDT)
Received: from localhost ([205.175.106.99])
        by smtp.gmail.com with ESMTPSA id z83-v6sm72312576pfd.103.2018.05.30.09.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 09:09:09 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 30 May 2018 09:09:08 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
Message-ID: <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 03:38:09PM +0900, Junio C Hamano wrote:
> * tb/grep-column (2018-05-14) 7 commits
>  - contrib/git-jump/git-jump: jump to match column in addition to line
>  - grep.c: add configuration variables to show matched option
>  - builtin/grep.c: add '--column' option to 'git-grep(1)'
>  - grep.c: display column number of first match
>  - grep.[ch]: extend grep_opt to allow showing matched column
>  - grep.c: expose matched column in match_line()
>  - Documentation/config.txt: camel-case lineNumber for consistency
>  (this branch is used by tb/grep-only-matching.)
>
>  "git grep" learned the "--column" option that gives not just the
>  line number but the column number of the hit.

The last we spoke about this, we had decided on a "min-starting,
max-ending" semantics for deciding on the columnar offset for extended
patterns like --and, --or, and --not.

I have these patches mostly updated on my copy (available at
https://github.com/ttaylorr/git/compare/tb/grep-column) but am out of
the office for the next week, so I will polish and send these on June
8th.

> * tb/grep-only-matching (2018-05-14) 2 commits
>  - builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'
>  - grep.c: extract show_line_header()
>  (this branch uses tb/grep-column.)

This topic is done, but will be frustrating to merge after the changes
in tb/grep-column. I'll update this topic once tb/grep-column graduates
to master, that way they will both apply cleanly.


Thanks,
Taylor
