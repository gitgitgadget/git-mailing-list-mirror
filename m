Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE60E1F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeEURG3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:06:29 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:40528 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeEURG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9Z9UQSttJ0D7YRqPN+mwoMtfUW91OkBMvh+aBvE6MhY=; b=aMMq2FiF2ZBqjNpsYzzvJcWSd
        dQ+KAcFhgQhxuWGwoLcMoyGLpJm3ME4rpvJmfdaIys/CA6cldZTmVI9IR9ojzu0b2lpm0Z3Mem8Yr
        sr7azSflvoOCnyW99QsF6NNigJKyN+BGo81xo6qFBlzg7M3GK8BQLS5rNRO1gv2lshTEp7G18PAIP
        fRLYV3v/mlssgTuCC/Q3ZC1lGPkWKIdtmYAVwu9DtAlE1aXQRdopyvCk8akgPi332AO8RoM+eLD09
        vUpKXV5WVS1DjqSqZD/SDOOzcGEFcHRowsulv1eFVolmqxJNpcjL8cE6JOmBrBtUYxATRvFCkgQSB
        HcNO8lrBA==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:52516 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKoGP-00GZPw-SI; Mon, 21 May 2018 13:06:27 -0400
Date:   Mon, 21 May 2018 13:04:54 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: issues(?) installing git-lfs via fedora "dnf" command
In-Reply-To: <20180521170353.GA10623@aiede.svl.corp.google.com>
Message-ID: <alpine.LFD.2.21.1805211303260.19892@localhost.localdomain>
References: <alpine.LFD.2.21.1805210625410.6679@localhost.localdomain> <20180521170353.GA10623@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 21 May 2018, Jonathan Nieder wrote:

> Robert P. J. Day wrote:
>
> >   $ sudo dnf install git-lfs
> [...]
> >   Running transaction
> >     Preparing        :
> >     Installing       : git-lfs-2.4.0-1.fc28.x86_64
> >     Running scriptlet: git-lfs-2.4.0-1.fc28.x86_64
> >   Error: Failed to call git rev-parse --git-dir --show-toplevel: "fatal:
> >   not a git repository (or any of the parent directories): .git\n"
> [...]
> > is one supposed to be *in* a git repository when installing, because i
> > was in fact at the top level of my linux kernel source repo, so i'm
> > unclear on what that "Error" is trying to tell me. am i just being
> > clueless? is this something that i should submit as a fedora packaging
> > issue?
>
> Yes, this looks like something that should be reported as a Fedora
> packaging issue.
>
> The packager should be able to find out whether it's an issue in
> git-lfs upstream and report it to that project if it is.  Git-lfs is
> not part of git.git; it's a separate project:
> https://github.com/git-lfs/git-lfs/blob/master/CONTRIBUTING.md
> I believe they use github's issue tracker to track bugs.

  it would *appear* that this is a combination of both a git issue,
and a red hat packaging issue:

https://bugzilla.redhat.com/show_bug.cgi?id=1580357
https://github.com/git-lfs/git-lfs/issues/3013

rday
