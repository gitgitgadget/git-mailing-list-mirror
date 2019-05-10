Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B701F45F
	for <e@80x24.org>; Fri, 10 May 2019 02:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfEJCZ6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 22:25:58 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:53146 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfEJCZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 22:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1557455259; bh=iZTzhm524+PFDSwD+kAY2o8ICCe8SSPhzikkGLlJ1L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hyPQbWtdMWOg8DWX6Lokg2z9Aove9Gr9kWny1ryb9/GdJNWLm2NFpgfPecHnOZbki
         irVejmrEbUtFDDG+BJ560bPQfJ2lFa4QE0gHWBlCDhu42sPomWUww/R/daCRHMeil0
         keg8EVyw8Zg9j7GgcNC4sATYYDNeik2g2lSYWuYs=
Date:   Thu, 9 May 2019 22:25:55 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: Remembering message IDs sent with git send-email
Message-ID: <20190510022554.GD1281@homura.localdomain>
References: <20190508231013.GA25216@homura.localdomain>
 <20190509001959.GB14000@google.com>
 <20190509165025.GA18342@homura.localdomain>
 <20190509185136.GC14000@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509185136.GC14000@google.com>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-05-09 11:51 AM, Emily Shaffer wrote:
> I'm still not sure I see the value of the extra header proposed here.
> I'd appreciate an explanation of how you think it would be used, Drew.

I'm not just thinking about your run of the mill mail reader, but also
mail readers which are aware of git and could use it to provide
git-specific features for browsing patchsets. Distinguishing it from the
mecahnism used for normal conversation allows us to have fewer
heuristics in such software.
