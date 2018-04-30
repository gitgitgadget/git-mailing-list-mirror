Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C9E215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbeD3TyZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Apr 2018 15:54:25 -0400
Received: from ewa-mbsout-02.mbs.boeing.net ([130.76.20.195]:63271 "EHLO
        ewa-mbsout-02.mbs.boeing.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756162AbeD3TyX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Apr 2018 15:54:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by ewa-mbsout-02.mbs.boeing.net (8.14.4/8.14.4/DOWNSTREAM_MBSOUT) with SMTP id w3UJsLtD054813;
        Mon, 30 Apr 2018 12:54:22 -0700
Received: from XCH15-05-03.nw.nos.boeing.com (xch15-05-03.nw.nos.boeing.com [137.137.100.66])
        by ewa-mbsout-02.mbs.boeing.net (8.14.4/8.14.4/UPSTREAM_MBSOUT) with ESMTP id w3UJsHs1054777
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 30 Apr 2018 12:54:17 -0700
Received: from XCH15-05-02.nw.nos.boeing.com (2002:8989:643b::8989:643b) by
 XCH15-05-03.nw.nos.boeing.com (2002:8989:6442::8989:6442) with Microsoft SMTP
 Server (TLS) id 15.0.1365.1; Mon, 30 Apr 2018 12:54:17 -0700
Received: from XCH15-05-02.nw.nos.boeing.com ([137.137.100.59]) by
 XCH15-05-02.nw.nos.boeing.com ([137.137.100.59]) with mapi id 15.00.1365.000;
 Mon, 30 Apr 2018 12:54:16 -0700
From:   "Tang (US), Pik S" <Pik.S.Tang@boeing.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>
CC:     Jacob Keller <jacob.keller@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: RE: Branch deletion question / possible bug?
Thread-Topic: Branch deletion question / possible bug?
Thread-Index: AdPehldpPc+KUMHLSMmwYvYnxmB3kgAeSIQA//+48C6AAJp7AP/84VxA
Date:   Mon, 30 Apr 2018 19:54:16 +0000
Message-ID: <d7786ad6fd0e42c7ae789075076be6eb@XCH15-05-02.nw.nos.boeing.com>
References: <d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com>
 <CA+P7+xryOt_-vg7cpvqRapM7nWuhWXjhpUR1xi-5MY_RH5UwAQ@mail.gmail.com>
 <249C4D418B2B49B4AD5545B912FDA53D@PhilipOakley>
 <nycvar.QRO.7.76.6.1804281440570.79@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1804281440570.79@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.137.12.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thank you for all your replies.  I am on a case insensitive system (Windows 10) running git version 2.14.1.windows.1.  

While I can't comment on what the fix would be, it has been enlightening to learn a bit more about what's under the cover of git.  

TIL :)
Pik

-----Original Message-----
From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
Sent: Saturday, April 28, 2018 5:44 AM
To: Philip Oakley <philipoakley@iee.org>
Cc: Jacob Keller <jacob.keller@gmail.com>; Tang (US), Pik S <Pik.S.Tang@boeing.com>; Git List <git@vger.kernel.org>
Subject: Re: Branch deletion question / possible bug?

Hi,

On Sat, 28 Apr 2018, Philip Oakley wrote:

> From: "Jacob Keller" <jacob.keller@gmail.com>
> > On Fri, Apr 27, 2018 at 5:29 PM, Tang (US), Pik S 
> > <Pik.S.Tang@boeing.com>
> > wrote:
> > > Hi,
> > >
> > > I discovered that I was able to delete the feature branch I was 
> > > in, due to some fat fingering on my part and case insensitivity.  
> > > I never realized this could be done before.  A quick google search 
> > > did not give me a whole lot to work with...
> > >
> > > Steps to reproduce:
> > > 1. Create a feature branch, "editCss"
> > > 2. git checkout master
> > > 3. git checkout editCSS
> > > 4. git checkout editCss
> > > 5. git branch -d editCSS
> > >
> >
> > Are you running on a case-insensitive file system? What version of 
> > git? I thought I recalled seeing commits to help avoid creating 
> > branches of the same name with separate case when we know we're on a 
> > file system which is case-insensitive..
> >
> > > Normally, it should have been impossible for a user to delete the 
> > > branch they're on.  And the deletion left me in a weird state that 
> > > took a while to dig out of.
> > >
> > > I know this was a user error, but I was also wondering if this was a bug.
> >
> > If we have not yet done this, I think we should. Long term this 
> > would be fixed by using a separate format to store refs than the 
> > filesystem, which has a few projects being worked on but none have 
> > been put into a release.
> 
> Yes, this is an on-going problem on Windows and other case insentive 
> systems. At the moment the branch name becomes embedded as a file 
> name, so when Git requests details of a branch from the filesystem, it 
> can get a case insensitive equivalent. Meanwhile, internally Git is 
> checking for equality in a case sensitive [Linux] way with obvious 
> consequences such as this - The most obvious being when there is no 
> "*" current branch marker in the branch status list.
> 
> It's a bit tricky to fix (internally the name and the path are passed 
> down different call chains), and depends on how one expects the case 
> insensitivity to work - the kicker is when someone does an edit of the 
> name via the file system and expects Git to cope (i.e. devs knowing, 
> or think they know, too much detail ;-).
> 
> The refs can also get packed, so the "bad spelling" gets baked in.
> Ultimately it probably means that GfW and other systems will need  a 
> case sensitivity check when opening paths...

FWIW I outlined what I think is the best route to fix this for good:

https://github.com/git-for-windows/git/issues/1623#issuecomment-380085257

Essentially, I think we should teach Git the trick to check the spelling before calling lstat() in refs/files-backend.c.

To check the spelling, we would need an API to get the on-disk representation of a given path. On Windows, I know this call. On Linux, apparently canonicalize_file_name() might do the job, but that is a GNU libc extension, and won't help us on macOS.

Any ideas?

Ciao,
Dscho


