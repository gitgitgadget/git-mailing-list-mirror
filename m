Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430272095C
	for <e@80x24.org>; Sat, 18 Mar 2017 00:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdCRAGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 20:06:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34487 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdCRAGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 20:06:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so10114975pfb.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sooRgzDEq1jhNpBshez9bIk87NAkP0OfQKOJod/64wQ=;
        b=T51AawYwfmfQryIf6go92+WbuMbHf4kJDbzBwrqWgbRLN8QPBEHIlmcoQXa+LJ54hQ
         cB4w66LmSTw/sSPuNkZAJ9c9QLNH6WclR7kXK2/Se2WjVaBijsVqb1kImKfjto4ZBOyu
         Ah9LFIJNb2lenOZy3QlzRO6EmEBnvvaZhtcmz88lqdQ+IwfOxp9e8w5RTI7pZxJmkyU4
         p8qJbtfe6/zRweZrop11D7ejUoDqCLpziXnbOzm6PqRd7TfBrQCg90wgri3yyY7L9F5+
         NOkwS7LFT/DeRSVCLJl4t0Ew2AeSIvj7X54Y7z3i5krvhTVgv2VH6V2xFogyKrZctTpq
         Uhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sooRgzDEq1jhNpBshez9bIk87NAkP0OfQKOJod/64wQ=;
        b=GqtN7Tm9XtLa2AuFv1H25xUQ2ZM3XObv5wlsm1UjdjcHYed8yIC9ps9iR9CdiiHbBm
         G4813acTrdH2oGwN1LMeDn5XyMFccdjlUECihz5ZnRiOYp7yn8LozrlJaT/czICSNwug
         W0p6FC3RHoe9nqSBu+ep3CnqduQJ83vveKAOPPepIKAGh3YbWK9pJthEJbvxyrtsUIuR
         UcENlwNpkcXRLHA+YyswwRDxvbVbijOKNYlZoigk+JPCJ/3gOwEBIjs3sNHuzJD8ra5I
         7M8sBYf8OCXv3xJX4d0/ODGYbiibQ46QTSqtXbgPCgf7noJtGv1FCKVsxaakjI4ON7Xc
         zNwQ==
X-Gm-Message-State: AFeK/H02GbrYt/bBuc1BNIYxP4hBa47QeXZCy1EkLyALW7BV1t7AtT0f6CgExjzADnnV7A==
X-Received: by 10.84.217.68 with SMTP id e4mr22455996plj.99.1489791334937;
        Fri, 17 Mar 2017 15:55:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id 80sm18726883pfy.67.2017.03.17.15.55.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:55:34 -0700 (PDT)
Date:   Fri, 17 Mar 2017 15:55:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees
 on the file system
Message-ID: <20170317225532.GR26789@aiede.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317225110.13417-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> If I recall correctly, "worktree" is the feature/command, and
> "working tree" is an instance in the file system, even when you only
> have one working tree.

I'm not sure I agree with this distinction.  "worktree" is just a
short name for "working tree".

Unfortunately gitglossary(7) doesn't make this clear at all --- it
uses the term worktree a few times (and appears to mean "working tree"
when it does --- e.g.

	Pathspecs are used on the command line of [...] and many other
	commands to limit the scope of operations to some subset of
	the tree or worktree.

) but never defines it.

[...]
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -58,10 +58,10 @@ as if `-b $(basename <path>)` was specified.
>  
>  list::
>  
> -List details of each worktree.  The main worktree is listed first, followed by
> -each of the linked worktrees.  The output details include if the worktree is
> -bare, the revision currently checked out, and the branch currently checked out
> -(or 'detached HEAD' if none).
> +List details of each working tree.  The main working tree is listed first,
> +followed by each of the linked working trees.  The output details include if
> +the working tree is bare, the revision currently checked out, and the branch
> +currently checked out (or 'detached HEAD' if none).

The patch itself looks good.

Thanks,
Jonathan
