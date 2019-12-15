Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D17CC2D0C8
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7292D2072B
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="QC67P8Jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfLOFd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfLOFd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 47bCjy1fZ8z9sPT; Sun, 15 Dec 2019 16:33:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1576388006; bh=rzRThoCzS3uHDQYOiG7IFZ8+YrWVm7lyBdmpwSw+UgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QC67P8JzKTzlfnU0IFO2ruG78SzG7gcdMLdGW2EeYE/7vBQHR7VyE6dlSs7K/ef0j
         07vyMNmMWuWkMxkgElwq1wPMjMR90BsP1NifzXZYESmhEj/6J15ah0NsDZ/u8OyXQh
         UQUrpQjzV+vAxfn/Gktqp4HRkYeIsT06z1iAyAUMjbtllEtsNEajLp0onPs2ID1jtG
         LVLkV6E/Iw8mQYxxoeePzs7OF0UTaOq7PJGlfr5uAobjM5XDrl/E5+pXrK+nzwBGh4
         ZJSL2bYhbTnnE5LF7lQfBgHOVOmPjDXDsp6cOnlMUf5fGlEyEPgXGFwkUl+4OLELLM
         ZBQCk5aBjRgnA==
Date:   Sun, 15 Dec 2019 15:29:31 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        kazuhiro kato <kazuhiro.kato@hotmail.co.jp>
Subject: Re: [PATCH] gitk: fix branch name encoding error on gitk
Message-ID: <20191215042931.GB12512@blackberry>
References: <20191207003203.9612-1-kato-k@ksysllc.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191207003203.9612-1-kato-k@ksysllc.co.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 07, 2019 at 12:32:25AM +0000, 加藤一博 wrote:
> From: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>
> 
> After "git checkout -b '漢字'" to create a branch with UTF-8
> character in it, "gitk" shows the branch name incorrectly, as it
> forgets to turn the bytes read from the "git show-ref" command
> into Unicode characters.
> 
> Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>

Thanks, applied.

Paul.
