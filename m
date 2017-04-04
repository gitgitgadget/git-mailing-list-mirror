Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C38620964
	for <e@80x24.org>; Tue,  4 Apr 2017 21:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754884AbdDDVvw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 17:51:52 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33677 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbdDDVvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 17:51:51 -0400
Received: by mail-pg0-f48.google.com with SMTP id x125so164176984pgb.0
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrIbkc6mcXGRJbXMdjovWVE6Bjg30tNn0IW4YdS5Mb4=;
        b=Men3eB9KCl+8IBHVPvwAA4QhFGCmlMPcKj+j1v9a7ytRkz03ppJp5Ev4sB1sqV2i8Z
         keiT3kHYMnKz38oCW0o4eb/vSJkGkgg/xZTt0ToBpymC0Rx3v+liDYh/kjUeshta17Q3
         0wDcY0plYj5zHjmq7oHaOuikyGSVL8ZRLsrjRK9VxTQwxQ7p0MLy9t157U7pha+ZtNSp
         ins/cMTMKHOZKCb3W/Z4lTF1YPiG8N1ST2uM/7JjBGvDhlp5K/ejV5KwcBa/dTTXdBY4
         Lr8UasKtQ/khy5/LIss+DtsyXMb7lZ/OyhGhorKg+VuflQ8DpwvqyybxZFMxEIGBIF9F
         Tocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrIbkc6mcXGRJbXMdjovWVE6Bjg30tNn0IW4YdS5Mb4=;
        b=XHkUssC0osT2milbQNNUfIov9xUyS7+Y0zUlDkvWwfxj9a9JHb3VC6vmjUJ3fQugof
         HVS3HsHiKVy3t+Hd8lhcYZszLg582ulHJAwcHr9NgS/eRXS3XIeptY1gb2y6fFOkzvsa
         udAPEiIXBHcrU99zFg+6Gz0VTUSaG0UOWUJqb2034ilsfuUhH5yeiUp+WOMCD5C2IEN4
         5BCS+3SrkzKqKw3QRQGFNsnUj0TC+94DL5botsYv4bQnhHHrcer/sf8E2W7YtCBTvKsn
         +ogNNBMuYRMXctgfsmUwHlhnGFlkThOa6GgNyFKE7CSTIIHRZ3rs1YftRQurenYSbl7W
         iK8w==
X-Gm-Message-State: AFeK/H0w6hHtzO9Z5SBUA9Q3j7fKjpz1GG60hsgVT3M26PEKS0/lWNs96HnOluGYp3xpaIKSFxWegsP+tZxSYP0J
X-Received: by 10.84.136.34 with SMTP id 31mr31572032plk.52.1491342710542;
 Tue, 04 Apr 2017 14:51:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 4 Apr 2017 14:51:50 -0700 (PDT)
In-Reply-To: <xmqqk27791ws.fsf@gitster.mtv.corp.google.com>
References: <xmqqk27791ws.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Apr 2017 14:51:50 -0700
Message-ID: <CAGZ79kZfX8zStFVDJsV=1KXh4G4K1rQ=8TTkE1w8JQq-=NcJ0g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2017, #12; Wed, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/submodule-short-status (2017-03-27) 7 commits
>  - submodule.c: correctly handle nested submodules in is_submodule_modified
>  - short status: improve reporting for submodule changes
>  - submodule.c: stricter checking for submodules in is_submodule_modified
>  - submodule.c: port is_submodule_modified to use porcelain 2
>  - submodule.c: convert is_submodule_modified to use strbuf_getwholeline
>  - submodule.c: factor out early loop termination in is_submodule_modified
>  - submodule.c: use argv_array in is_submodule_modified
>
>  The output from "git status --short" has been extended to show
>  various kinds of dirtyness in submodules differently; instead of to
>  "M" for modified, 'm' and '?' can be shown to signal changes only
>  to the working tree of the submodule but not the commit that is
>  checked out.
>
>  Waiting for further comments.
>  The endgame looked mostly OK.

The last comments were by Jonathan and you agreeing this is a superb series. ;)
http://public-inbox.org/git/20170329231308.GZ31294@aiede.mtv.corp.google.com/
