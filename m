Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711112035F
	for <e@80x24.org>; Fri, 28 Oct 2016 15:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932955AbcJ1PBa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 11:01:30 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34069 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755992AbcJ1PB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 11:01:28 -0400
Received: by mail-ua0-f180.google.com with SMTP id 51so38733657uai.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=zyoTcgzR7VzDKGBKUFzKdP4XklNTUHjfCHshL8aWBww=;
        b=H1V+I54U2K0puQGGj3rU0PrX24e5qqg7k7pCQ0JdATWphKF4Xzk9vv2YSkd3RES3GZ
         W2nAKEO42InvP2pvxOD4IirOAHhaW5ihxq84c2iytd3AkhrN4AbT/mRhUZfmAlqaOEFz
         bDzFNWSwaVZdD6xs5KGTZi1nddEDe7kX9LZghXB3hZgyfU19LW2XERbSHO5e4C4xtx9Q
         QlC3Yaf/TEuhjl143oooFpVdMmrIQGN+iALKXpWDgrJeEeK+bldyHEtjo9Qqn7nzllu1
         HTAPjpSry6zDXRwjR9RZEN4lP+FmCsjdDGo66H1hXG3OmdD2bWi1F1/+q04GGWh5doXV
         CVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zyoTcgzR7VzDKGBKUFzKdP4XklNTUHjfCHshL8aWBww=;
        b=Ho3asgWKKszpjlnzBjODnJfFiTFdTeZ2K9a1h9pXVCZaPbthNcKvAJ0cJF61QK4UaI
         cydbPyRKG3m7lq1bMT698CMzJmrcoe/cTVN/HHJZQkhv72DmlMDMsx6/DdHNzH5TftqQ
         4xLnDcWBGq0DHj0NNCOySbKXLIjoc6R3pvqKppVWrGh5RYhTsdLeRoJhxsbjBt9ZNg5i
         UU9r0LMQbRwlBugLwcsMFyQrP+ggtX6Cw30svq9h2gjA4/vn1Zx+YghrbmO8SCYFyzWr
         q5A+NlyGXeaki+FOdRJdXGPEOMBgHy3olwfA2PVUo7jlBGJoxlyQyHQq1FAY7jhCoEf3
         sAXQ==
X-Gm-Message-State: ABUngvc03oAb38mTiJOZUx7YB7Ifp4Qm4bHcSC57z/xCukTw+AA7ZJdGRmv0nW7vcENlQswioeUI7DjIeIppxQ==
X-Received: by 10.159.41.225 with SMTP id s88mr12426760uas.137.1477666887186;
 Fri, 28 Oct 2016 08:01:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Fri, 28 Oct 2016 08:01:06 -0700 (PDT)
From:   Stefan Monov <logixoul@gmail.com>
Date:   Fri, 28 Oct 2016 18:01:06 +0300
Message-ID: <CAJtFkWs4qYCqnbJD+zCRCAW3teczb4CdvncvYoMN_VvthJGr=w@mail.gmail.com>
Subject: =?UTF-8?Q?Is_the_entire_working_copy_=E2=80=9Cat_one_branch=E2=80=9D=3F?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a very basic question but maybe I just don't know how to
phrase my query well enough to find an answer.

Let me begin with a SVN example. SVN doesn't have a "current branch"
as a property of a working copy, so I'll give the example with
revisions instead. Consider a working copy with the dirs `foo` and
`bar` in it. In SVN one can `update` foo to an earlier version, but
keep `bar` at `HEAD`.

Is it possible in an analogical git working copy to checkout one
branch in dir `foo` without changing the branch checked out in `bar`?

If not, why not?

TIA,
Stefan Monov
