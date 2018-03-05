Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F5A1FAE2
	for <e@80x24.org>; Mon,  5 Mar 2018 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeCERwo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:52:44 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58176 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbeCERwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 12:52:43 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 681DD1F404;
        Mon,  5 Mar 2018 17:52:43 +0000 (UTC)
Date:   Mon, 5 Mar 2018 17:52:43 +0000
From:   Eric Wong <e@80x24.org>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] git-svn: search --authors-prog in PATH too
Message-ID: <20180305175243.GA10325@dcvr>
References: <20180304112237.19254-1-asheiduk@gmail.com>
 <CAPig+cQARx4eZFHyRpikHJYaz42NKq18fjt-=KYOX2GddDPNDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQARx4eZFHyRpikHJYaz42NKq18fjt-=KYOX2GddDPNDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Mar 4, 2018 at 6:22 AM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> > In 36db1eddf9 ("git-svn: add --authors-prog option", 2009-05-14) the path
> > to authors-prog was made absolute because git-svn changes the current
> > directoy in some situations. This makes sense if the program is part of
> 
> s/directoy/directory/
> 
> > the repository but prevents searching via $PATH.
> >
> > The old behaviour is still retained, but if the file does not exists, then
> > authors-prog is search in $PATH as any other command.
> 
> s/search/searched for/
> 
> > Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>

Thanks both, I've queued 1/2 up with Eric S's edits at svn/authors-prog.
I'm not yet convinced 2/2 is a good change, however.

The following changes since commit 7e31236f652ad9db221511eaf157ce0ef55585d6:

  Sixth batch for 2.17 (2018-02-28 13:39:24 -0800)

are available in the Git repository at:

  git://bogomips.org/git-svn.git svn/authors-prog

for you to fetch changes up to e99652c412701cf988770e5cfaa253712a39221a:

  git-svn: search --authors-prog in PATH too (2018-03-05 02:09:57 +0000)

----------------------------------------------------------------
Andreas Heiduk (1):
      git-svn: search --authors-prog in PATH too

 Documentation/git-svn.txt | 5 +++++
 git-svn.perl              | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)
