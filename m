Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6071F453
	for <e@80x24.org>; Wed, 17 Oct 2018 02:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeJQKpo (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 06:45:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41388 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeJQKpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 06:45:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so12425735pfi.8
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 19:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ENByhEY4v9r+qSIai9AtfNuOWV6nvJTIf+cTlVZetts=;
        b=OMio+EIArztUWDRJJLDA/MoYxt/VkOvRgXa5nAP1CY2Zipzewtsu5hVBvPkfU1Et+u
         dUHLBJpEbaITnzFdS/WJsNW7Fi3agGNmtfW0+2wJv1/GHzk+5FAJME4Ick55jr6a/kG9
         ownr4Fe9M0BcuGh13FafrNFto9RpYA3J06D0dQddilonseVkQrJWGUbV/EGJYSlrBJs+
         7MWIeNaTn5QseuZcoTEFxJsS0W8IKhbnwuDD174eZ5+4VS+aWZ+Yr07Tx0upG1THMC+O
         dcoeTNtFdMOsJ0NiNc5W/ZxCyK/3GBgWUOH3Vp1qVQoAbBfrznw+jUs//47eEQ6CrDft
         6jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ENByhEY4v9r+qSIai9AtfNuOWV6nvJTIf+cTlVZetts=;
        b=Tgvqu9bC2lvhOZYvHmWX91i5OYklCC5TO1oNLfi/RyCnMQ+Rl4eXspKZdbII2vpynU
         m7zIqxqPCnRGvOD8n0wgQ1/H2q0z6sJBKm5B8KLuSNCRHwIjIebI7FqeZpRNSZvS7fDf
         rOZViLwKTfrpXT4a9G+49GhupxYIhgrghbO4oL6XmFh+tCqxMVtWiEK63FT5AgwgqoKO
         vLfv3GikEDJYOEBf+pclBGd/MhuymfvVzTElwfsMFSOXiflNZffel8xs2DmZDnmZ/9sb
         fCbDwt+yCzWAYdUc+m7IOmdbwtGS4L9CvWVf93iSn/oPEG2GkkV/7toOePLIL+QKV+1t
         0jug==
X-Gm-Message-State: ABuFfojAg8IMSDuhFGNgoXzVRIs0XcritvtsrpmplxXB1XSQHvlNXb0W
        xSXdbzjJrRQ8odo9njFSB+Y=
X-Google-Smtp-Source: ACcGV62WX9lnDguhvnido46FotqwGn+nly7TlSPXDJIck67QQyeptyumVzKzHcSue9RL8zL8NCdNgA==
X-Received: by 2002:a63:c5a:: with SMTP id 26-v6mr22720491pgm.372.1539744736155;
        Tue, 16 Oct 2018 19:52:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id m18-v6sm21120832pfk.149.2018.10.16.19.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 19:52:15 -0700 (PDT)
Date:   Tue, 16 Oct 2018 19:52:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] builtin/submodule--helper: remove debugging leftover
 tracing
Message-ID: <20181017025213.GB117170@aiede.svl.corp.google.com>
References: <20181016234550.216587-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016234550.216587-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> I noticed 74d4731da1 (submodule--helper: replace connect-gitdir-workingtree
> by ensure-core-worktree, 2018-08-13) had two leftover debugging statements
> when reading The coverage report [1]. Remove them.
>
> https://public-inbox.org/git/e30a9c05-87d8-1f2b-182c-6d6a5fefe43c@gmail.com/
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 2 --
>  1 file changed, 2 deletions(-)

Doh.  Glad you caught it!

Is there some reference for The Coverage Report other than the mailing
list?  E.g. I suspect a reference to

	make coverage-test
	make coverage-report

would be useful to readers finding this commit later.

> To be applied on (or squashed into the tip of)
>   sb/submodule-update-in-c

Looks like that's already in "master", so not a candidate for
squashing.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
