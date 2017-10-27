Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457C71FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdJ0Pdk (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:33:40 -0400
Received: from mout.web.de ([212.227.15.4]:56339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbdJ0Pdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:33:39 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeScR-1doVgd3quN-00QCZ9; Fri, 27
 Oct 2017 17:33:36 +0200
Date:   Fri, 27 Oct 2017 17:33:36 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Adrian Kappel <atkappel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug Report] [includeIf] does not parse case insensitive -> case
 sensitive symlink gitdir
Message-ID: <20171027153336.GA26626@tor.lan>
References: <CAEm1wifEZ5CXH7N_cCJpXQN-1dWBRZ1OQ=bJH-X=kR15Bg0Sdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEm1wifEZ5CXH7N_cCJpXQN-1dWBRZ1OQ=bJH-X=kR15Bg0Sdw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:BRCHi+0timlWnwhbgapAZgseMqXLOSsziasJcVz7QmZld1MZLlr
 AzQuvsgESirgm44EjOL1OIyXtP56ScG6IaAi4ifn/HAu2odisisLPZHQX+l9kHvmExmTLMx
 WaSnjzxeP57Zf844t06F4u3YnD3fmoDUmArOYCYP7ALbe0FtnamxfJSlTrWWrdxOGhKyWOw
 RdCHO3CmjBqZyUGaMre1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:al+S7cWQr0M=:aQn1vlAXBhGdLiWR9Pjrio
 5RkqHcNp7o5uen1ByJQ8Pq6P/TkH93RPuOLSsXP7AZBTEGPw870PNWskNaDlhU4zoxRVGLEh2
 pP2uzzDe1nxIEAtv4U7NGp/OKbYV/v80rRA4qf+MWV+UfNnAuVm3Twhekaxm5aWNyomuPQaju
 KbknY2nBhPWG+b+nuLdFtxfGe9h7xV2nbyVYK05Mg4FsqEr1BwklKszae8C1MkQb1MFrRLKRA
 32gYDLtE0mkhItduR/pE44Pu6InAoyq7Dy9OVb3QVu0kheH3Vt9FZ3YZflBXVJwJPjalkRLmD
 xlKcH/LOIqp+KHxHvcU6VWj2I/d5Zn8kJ3kL0yLNpUBUuPHPK6M8RTvvxaP/Zi2RgjurU832C
 xXsPo0ypmR7sODCxFDwGDXAwfvehw+Dl1nBPw7lLw9O1uR5I8y0ASd2oUexUiYp9EgxGkqOsM
 3iNIW/JbQPZqr5uU938VBwE8FKUyDDRZxmQd/zT+GNly+5CKwFyOu+ZO70469Ki7+ewEbZw6T
 Dh5QhEppaBn11j9hBFwM5j+Jb55AUbLiHf3xKa87pzqhUeUuj1MMeA9Pa1XHqJMUH3/g+fgf7
 au8DNGZY7MBY/o1o8D/2b2ATd7gQjWtaM8W2CNwEXLGPb8V5KBxx4XfTZkhFzPMBt9WJIj5My
 vNSZ6RZTeXNjYyGkMXNMeqL5lWduNWXV+ygyuOzJiOORPCHf+nXbVU28+NMJOv46t47i98l8h
 CjYDPt6M8tIUv3qbOLwyx/fbjRTYFxdTR7SCdjFlQTkSdzTDaS+RDXKCA9UQVC+RDFE8va8Nw
 hmjx00kpl6bhUSKEDmFp9QvnDZnvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 27, 2017 at 09:55:58AM -0400, Adrian Kappel wrote:
> Hello all, not sure if the issue I've come across is a known bug or
> addressable, but wanted to report it just in-case.

Thanks for the detailed description - my question is inline

> 
> 
> ** Summary
> ------------------------------------------------------------------
> Using the [includeIf] configuration statement with a symlink'd gitdir
> will not work if the symlink is on a case insensitive volume and the
> location it references is on a case sensitive volume.
> 
> ** Steps to reproduce
> ------------------------------------------------------------------
> 1. Create symlink (case insensitive -> case sensitive):
> /Users/usera/dev -> /Volumes/CaseSensitive/dev
> 2. Create two files: .gitignore and .gitignore-work, both stored in
> /Users/usera/
> 
> .gitconfig
> -------------
> [user]
>   name = First Last
> 
>   [includeIf "gitdir:~/dev/work"]
>     path = .gitconfig-work
> 
> .gitconfig-work
> --------------------
> [user]
>   email = email@address.com
> 
> 3. cd into a subfolder of ~/dev/work that has been git initialized.
> Let's say ~/dev/work/repo
> 4. Run git config --includes user.email
> 5. See that nothing is output from the command
> 6. Update the [includeIf] statement in .gitconfig to be the real
> location i.e. "gitdir:/Volumes/CaseSensitive/dev/work/repo"

Didn't you set it up pointing do the real location ?
That is what is written above:
> 1. Create symlink (case insensitive -> case sensitive):
> /Users/usera/dev -> /Volumes/CaseSensitive/dev

(I suspect that people use something like this:
 /Users/usera/dev -> /Volumes/casesensitive/dev
 And in this case it would be the file system which says
 casesensitive != CaseSensitive and Git can't do much about it)

> 7. Rerun the command from [4]
> 8. See that email@address.com is output from the command
> 
> ** Other variations that were not tested
> ------------------------------------------------------------------
> - symlink on case sensitive volume referencing a location on a case
> insensitive volume
> 
> ** Environment Information
> ------------------------------------------------------------------
> git --version: 2.14.1
> OS: macOS Sierra 10.12.6
> 
> 
> If a fix is not feasible or likely to be implemented, I would
> recommend that we update the git site's documentation to reflect this
> gotcha. After verification of course.
> 
> Best,
> Adrian Kappel
> akappel <https://github.com/akappel/>
