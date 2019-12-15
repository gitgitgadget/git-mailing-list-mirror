Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF0C2D0CD
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCA12253D
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="k2fKUWIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfLOFd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55395 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfLOFd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 47bCjy2wQMz9sPc; Sun, 15 Dec 2019 16:33:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1576388006; bh=OWpdYyU0HeuDuQHK+lKnttgF1NPC2N10Qd0WLJ3ymCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2fKUWIEBi8zr4cLeyaeCTvQqyST6dWM9629905+60V3SHYt2rtX3gqce2jG0LX2m
         7xp/w30F/jPjbfSOjMq864wBnkua9nbRj+tx68RuoxRa/HmywN2VpUvYj0vXDg/tZY
         Kkql7U/Di3uJeGKc4UpJMBaQMWptaEPE94RPvONJy1ukLI20DwyTyfHHIxNlbDSeIf
         qu9rNPKnoezoXMu6G5dBUxZxW8JsdibwFPoj83Xn8RYxevdOogeTTsIr8WZxM2bgNe
         HbbV7848N9ix/56Cgc5VIBA6eqX16PdNqlA4TeDpoqF8p7htn9yWTk4rX58DWTwQ83
         BHlrYHUWHy9kg==
Date:   Sun, 15 Dec 2019 15:36:07 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 2/2] gitk: rename "commit summary" to "commit
 reference"
Message-ID: <20191215043607.GC12512@blackberry>
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
 <cover.1576197846.git.liu.denton@gmail.com>
 <8691ed2b84f7ee6b7c12d04d57a541bf22660333.1576197846.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8691ed2b84f7ee6b7c12d04d57a541bf22660333.1576197846.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 04:44:50PM -0800, Denton Liu wrote:
> From: Beat Bolli <dev+git@drbeat.li>
> 
> Now that the commit reference format has a canonical name, let's use this
> name in gitk's UI and implementation.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> [dl: based the patch on gitk's tree]
> Signed-off-by: Denton Liu <liu.denton@gmail.com>

Thanks, patch applied.

Paul.
