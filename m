Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D62E1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbfJAQq0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 12:46:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36523 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388347AbfJAQqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 12:46:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so1520348pgk.3
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H8abqUkwueE6IpF46rkGUW4hbqDL4zQAJir/HGnUKS4=;
        b=kayKMYvfoLr2ftyBSD+wm3vkRCzFSmp3AT/pJm0XIU6GzZBCNetqMR3rcMOVpBCZBw
         jrLPkSXO4DDwyChh6dzA5SVRVemxQbFah9lxks8Dis4Yvc5RjPJoke8TvcStp1321XPu
         qMIIy0K1phcIzZs+Z2ZH9FR8QhoI89SgWrHcf2qgcFpaoedCTvHxsTZg7G+dYhv0a5UF
         Gz9YZSxXjIxGF21iepwKgn2nVpk+4byis4fDtXmQHUIBmt5WIgLAwWX+JGitXD4Ny+E5
         cK6mspmQflzIzjASYTuvrYBo+Rj+aGKeG8DWw76bBoDXJ1Lbv9BWzi6Xqk/D1B9clzJm
         L+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H8abqUkwueE6IpF46rkGUW4hbqDL4zQAJir/HGnUKS4=;
        b=K2UbZhQBI9NvGg4n/Xo9aEWRAOCwsWHC5yxJnmJfjuZ9jog/aMJJ3isu/12g2FS0Hg
         5rVQA+ecw0I1yu09MWh/QB1fwtjzIbTfiuzAbu9JOpHu7hMBXwMV5pesP7aPRoRqltWU
         mAzPpCEQki95Jzmm7F7SoetRvMZImWPNFwVGQIF9cDnOk8MG9ugJfYLujjYkdTHDoQ0a
         H7nE+oXMG4g6deO7gI0jA9bkJh4qYTA/687FkoJCNmX+7X2aN3eriyLCee14IVtKtLqM
         51ccp9aP5E48WX7gTjU0hSkAmi4gm9e+iab8AWovSxpTMlACyTjm5glyemSqJQATqrCr
         24uA==
X-Gm-Message-State: APjAAAWA2wkDQ4U2vcZo4H6hnftDXmiBoLjC+JQTdHLAfT7soW095LsR
        BB3/5w4924m+TsbZnp00v6OvJRQw
X-Google-Smtp-Source: APXvYqxojdNLHrk/KdtSItQfyboPjx5pzDezMByc/QpTShuhwihjkC2+c7oG5qM46r4qQCUmEkX/6w==
X-Received: by 2002:a65:688a:: with SMTP id e10mr12239205pgt.221.1569948384147;
        Tue, 01 Oct 2019 09:46:24 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id h14sm15605462pfo.15.2019.10.01.09.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:46:22 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:46:21 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: update git-gui maintainer information
Message-ID: <20191001164621.GA1598@generichostname>
References: <20191001141435.21787-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001141435.21787-1-me@yadavpratyush.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Tue, Oct 01, 2019 at 07:44:35PM +0530, Pratyush Yadav wrote:
> Since I have taken over maintainership of git-gui, it is a good idea to
> point new contributors to my fork of the project, so they can see the
> latest version of the project.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

Junio's already made this change in 253bfe49bd (SubmittingPatches:
git-gui has a new maintainer, 2019-09-18) in his branch
'jc/git-gui-has-maintainer'. We can drop this change since it's
redundant.
