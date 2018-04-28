Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4125E1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 12:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeD1Mnm (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 08:43:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:57847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933450AbeD1Mnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 08:43:41 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZzY9-1eVsJ41zBN-00liwo; Sat, 28
 Apr 2018 14:43:32 +0200
Date:   Sat, 28 Apr 2018 14:43:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.org>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        "Tang (US), Pik S" <Pik.S.Tang@boeing.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Branch deletion question / possible bug?
In-Reply-To: <249C4D418B2B49B4AD5545B912FDA53D@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804281440570.79@tvgsbejvaqbjf.bet>
References: <d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com> <CA+P7+xryOt_-vg7cpvqRapM7nWuhWXjhpUR1xi-5MY_RH5UwAQ@mail.gmail.com> <249C4D418B2B49B4AD5545B912FDA53D@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DrYsoVookUvUutszez4QufzLiSqOATZJKp9rX7Mx/Lo1ZZ9WNX0
 tlTlZYOpyDVan0k83ZnB545H1J9GoPcuHZyU9wJMlr33ipHlTdeq3yO0lK7Lg4LJY6TSovK
 EM+djYcsU27g7STbOUxDkPHGHvdtKptfg/skxjTuJiw6jGRKmuqPtb3RYGWeOWtKV2GtJx7
 FYAToKtIPWTJ/WiVRehsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v4n092jX9F4=:qMdttrfuWskXPrDh7DleUE
 749Ybyqtth6ckYjlLirVPOPwNgDqN+fkt+O9P6PaM0AGYOZzKI57r9H8qcJCTfxv/hgGzaiMp
 wx1kElrzF9+RR4vBBaQbyeIA0YCsKJdP+3valVW0pMC8ZF/ZfzbwMafGh+gokFtZpudVO160K
 r1pArqHdMu39shh4wyKtxZzwn9sDI0fNKfXIHGoIhbH/AaE76aq8ohJsJKznbsfTevB2go0+t
 v07TRr84dahUOpS0eWQGh83x2HHtxgyPNE1x8R9ymu1VJW3VBJVXNDZwkYApJty/6kxbJAkKz
 qE1Iumk93/kyKZgSPDR3btR/u/xHekbovB+zKg8T9D9oe7OQS8XU0ZzBxUM9JyfxbtpmrC789
 Y6kcZ1U+jgfAK5ndSwgcYtKcZzmJePZwjajjAlN73OuXg29a5ecj10oIcjOBod0O7A1cFhJiT
 OHQJAyCtzFwBZRwmRPaM+IP7X9W+tjXfBa+oiZRyimvAj6VO5H7MyZht3HlXg7ivmtuMIhO/6
 7h4brCLu+cnwZ7qZ7/E3+rbRceq/1NCXARgpzb6oAX30tNaXGjo+pHCvGSWx1UJ8TGo4/XbmY
 IpkOH1+J7Hp6S7h4qq340MhWMWH2j5Y75Qs7/bysThq5b3ug0Lagach6wxL7g+IS9NSGiLdL7
 MUlELHQznYGK5LFufDQsbt6H1cJAWiAXOVYVUNlv7vqn0gXJ3Hea3raeK1CUfoO3tpXUi0vJ9
 mE2Bn6H9iYad20dkWtPGBa5U0JsTBKTxRaf8LmrtrptJiuuR91A8d3TctXJ5lWVMJC69wl1uE
 Wwuyk3d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 28 Apr 2018, Philip Oakley wrote:

> From: "Jacob Keller" <jacob.keller@gmail.com>
> > On Fri, Apr 27, 2018 at 5:29 PM, Tang (US), Pik S <Pik.S.Tang@boeing.com>
> > wrote:
> > > Hi,
> > >
> > > I discovered that I was able to delete the feature branch I was in, due
> > > to some fat fingering on my part and case insensitivity.  I never
> > > realized this could be done before.  A quick google search did not give
> > > me a whole lot to work with...
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
> > > Normally, it should have been impossible for a user to delete the branch
> > > they're on.  And the deletion left me in a weird state that took a while
> > > to dig out of.
> > >
> > > I know this was a user error, but I was also wondering if this was a bug.
> >
> > If we have not yet done this, I think we should. Long term this would
> > be fixed by using a separate format to store refs than the filesystem,
> > which has a few projects being worked on but none have been put into a
> > release.
> 
> Yes, this is an on-going problem on Windows and other case insentive
> systems. At the moment the branch name becomes embedded as a file name, so
> when Git requests details of a branch from the filesystem, it can get a case
> insensitive equivalent. Meanwhile, internally Git is checking for equality
> in a case sensitive [Linux] way with obvious consequences such as this - The
> most obvious being when there is no "*" current branch marker in the branch
> status list.
> 
> It's a bit tricky to fix (internally the name and the path are passed down
> different call chains), and depends on how one expects the case
> insensitivity to work - the kicker is when someone does an edit of the name
> via the file system and expects Git to cope (i.e. devs knowing, or think
> they know, too much detail ;-).
> 
> The refs can also get packed, so the "bad spelling" gets baked in.
> Ultimately it probably means that GfW and other systems will need  a case
> sensitivity check when opening paths...

FWIW I outlined what I think is the best route to fix this for good:

https://github.com/git-for-windows/git/issues/1623#issuecomment-380085257

Essentially, I think we should teach Git the trick to check the spelling
before calling lstat() in refs/files-backend.c.

To check the spelling, we would need an API to get the on-disk
representation of a given path. On Windows, I know this call. On Linux,
apparently canonicalize_file_name() might do the job, but that is a GNU
libc extension, and won't help us on macOS.

Any ideas?

Ciao,
Dscho
