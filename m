Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512571F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 04:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeGGEZo (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 00:25:44 -0400
Received: from imap.thunk.org ([74.207.234.97]:42194 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbeGGEZn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 00:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=opkMrG9/+9Ykf3za8xpLHZPj3pe56aXTrQb1Exl1Y60=; b=QQRatm9zx35YiIWtIVkws565zq
        FR27ig4hrrQTKc5hZbqcidJp2fQHSt8+OaHe1Wa08xINZVA+3o8vtRSjbZ+1yF7ELs2EnfPhiwxWK
        OUE9Q/UD0qCYyDiYV3T6owhxh85uo2iczrvzCQKF2Q2ZFXhJZ6gqxRD6YFjrMUHhBFeE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fbemt-00068E-Jt; Sat, 07 Jul 2018 04:25:35 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 674CF7A552B; Sat,  7 Jul 2018 00:25:34 -0400 (EDT)
Date:   Sat, 7 Jul 2018 00:25:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     frederik@ofb.net
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180707042534.GC3546@thunk.org>
References: <20180706213239.GA867@flurp.local>
 <20180706211828.GC6195@aiede.svl.corp.google.com>
 <20180706232147.GF6343@ofb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706232147.GF6343@ofb.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 06, 2018 at 04:21:47PM -0700, frederik@ofb.net wrote:
> I don't think that it's really important to find a "best" ordering for
> commands or glossary terms; it's more a matter of finding someone who
> is willing to take responsibility for choosing a reasonable ordering.
> Presumably the head maintainer of this project could delegate the task
> to a qualified volunteer, not a newbie like myself but not necessarily
> someone with expert knowledge either. It's too bad that a policy of
> not listing things alphabetically wasn't adopted from the beginning of
> this project, but I guess that's life.

That wasn't that portion of the man page, for better or for worse.  We
can debate whethher using a non-alphabetical order would be better or
worse for everyone; personally, I think the much better pointer is at
the very beginning of the git man page, which points people at "man
gittutorial" and "man giteveryday".

It seems to me that for your stated goal, "git everyday" has a good
list of commands that people should learn, complete with a proposed
workflow.

That's probably the biggest stumbling block of finding an ideal
ordering.  What's reasonable really depends on your workflow, and
there are many different workflows depending on what a particular
developer is trying to do.  Consider carpentry; for some use cases, a
screwdriver is an absolutely critical tool.  For others, they might
never use it, and instead almost exclusively join two pieces of woods
using mortise and tenon joint.  Others might use a butt joint, plus
glue and nails.  All of these different techniques can be used to make
a wooden box, and they all involve a very different set of tools.

Regards,

					- Ted
