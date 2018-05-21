Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBCEE1F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeEURSP (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:18:15 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:42424 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbeEURSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uvZbLFSaytpf7uGl4KTKScH0OMPNwyTwiuOocKplI6Q=; b=XgiWAijpvwCyL2b6eOqYYuE23
        hTlNN8GyyDNsJyeI94mmmdRsz669Bi8Xw+GVgz8IqtJqaEfT3wds8re3qcEfasB/8CljcsUvTgBme
        nfI9Ee53vzF/teGNV/wqLHEuzr1WGSzqbQjREk3jSAK8jtX8V44bWPBRYSZH0pCfiLg5lVAtEJGAl
        oVPHDYEFdW8gK9RfjlgVgxRzMmb02GzYaRR+r+NbI1n3HTr7YUC0As2SY1SptCP/XQkWdSuCj8Rd5
        liCBK5TsCH0svsHMrOH2ltME26nLq+5C7vNVDGNRorgrHR9erhtgpYeCykgEzJFPdWhuPzNplL8A/
        sjZbw2zAg==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:52848 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKoRo-00GcT2-8i; Mon, 21 May 2018 13:18:13 -0400
Date:   Mon, 21 May 2018 13:16:41 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: issues(?) installing git-lfs via fedora "dnf" command
In-Reply-To: <20180521171405.GB10623@aiede.svl.corp.google.com>
Message-ID: <alpine.LFD.2.21.1805211315290.20433@localhost.localdomain>
References: <alpine.LFD.2.21.1805210625410.6679@localhost.localdomain> <20180521170353.GA10623@aiede.svl.corp.google.com> <alpine.LFD.2.21.1805211303260.19892@localhost.localdomain> <20180521171405.GB10623@aiede.svl.corp.google.com>
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

> Hi,
>
> Robert P. J. Day wrote:
> > On Mon, 21 May 2018, Jonathan Nieder wrote:
>
> >> The packager should be able to find out whether it's an issue in
> >> git-lfs upstream and report it to that project if it is.  Git-lfs is
> >> not part of git.git; it's a separate project:
> >> https://github.com/git-lfs/git-lfs/blob/master/CONTRIBUTING.md
> >> I believe they use github's issue tracker to track bugs.
> >
> >   it would *appear* that this is a combination of both a git issue,
> > and a red hat packaging issue:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1580357
> > https://github.com/git-lfs/git-lfs/issues/3013
>
> Can you clarify?  Neither of those bugs points to a git issue if I
> understand correctly.  They may be a git-lfs issue, though.

  sorry, i mistyped, i should have said a "git-lfs issue".

rday
