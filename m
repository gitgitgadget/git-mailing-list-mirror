Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22E21F859
	for <e@80x24.org>; Tue, 23 Aug 2016 05:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbcHWFyU (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 01:54:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51422 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbcHWFyT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 01:54:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D94251F859;
        Tue, 23 Aug 2016 05:54:18 +0000 (UTC)
Date:   Tue, 23 Aug 2016 05:54:18 +0000
From:   Eric Wong <e@80x24.org>
To:     Alfred Perlstein <alfred@freebsd.org>
Cc:     Lucian Smith <lucianoelsmitho@gmail.com>, git@vger.kernel.org
Subject: Re: git-svn bridge and line endings
Message-ID: <20160823055418.GA5990@whir>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
 <20160823030721.GA32181@starla>
 <5e17164f-f669-70c2-de78-25287ab59759@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e17164f-f669-70c2-de78-25287ab59759@freebsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alfred Perlstein <alfred@freebsd.org> wrote:
> I hadn't anticipated there be to translation between svn props and
> .gitattributes, it sounds a bit messy but possible, that said, is it
> not possible to commit .gitattribute files to the svn repo?  Even in
> FreeBSD land such small token files are permitted.

I'm not sure if an automatic translation is necessary or
desired (because of a corruption risk).

Perhaps Lucian can clarify the situation for his repo.

> As far as documenting svn-properties, most of the properties are
> used on the Subversion side either by subversion itself, or by
> scripts in the subversion repository.  Perhaps a blurb "see the
> subversion documentation and/or your local subversion
> administrator's guide for properties and their uses." would suffice?

Yes, perhaps with a workable example Lucian can use today with
any git v2.3.0 or later.

Thanks for the quick response!

> Opinions?  Happy to look into it.
