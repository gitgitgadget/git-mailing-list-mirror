Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12989C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 08:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiCEJAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 04:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiCEJAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 04:00:14 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204D506F1
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 00:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1646470757;
        bh=ffCZm+4PXyVq0i18F9UpKmwB+7/sO5ZYAmFjlDpzCI8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WN+1YgwFwau8ErieRAJIrzju4XOgWoIGJZ7IXDGCP0K2BPq1zF4fP6r9E9q2rpeVP
         wZH2R/2UBvHqK9NS+DXZIaXAXO0OkF+HP+cOrLysjlmn/zDrrsiDWn70iCIVPJyGmU
         KC7Nox6Jv3Ft9rKPXi4h5rjhtHCLLRbLPYVM7Vdo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5o3-1nHJZM1e2D-009JTX; Sat, 05
 Mar 2022 09:59:17 +0100
Date:   Sat, 5 Mar 2022 09:59:16 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 02/23] t7527: test FS event reporing on macOS WRT case
 and Unicode
Message-ID: <20220305085916.7rn6lhmbjkebrm5n@tb-raspi4>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
 <c7ee2394-cda0-a997-3b9d-fb8c3d65b312@github.com>
 <20220224173305.gbr2waw77xpuieub@tb-raspi4>
 <8a32ed13-ed53-3605-ca78-83dac2be1e28@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a32ed13-ed53-3605-ca78-83dac2be1e28@jeffhostetler.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:WwPqjYj4p8Gt0EOkPIZu5wvozCjK9rc1X9ZkDgw52Jd/8RRpE4w
 kanLSiebMdLX+WjJdc4uyDIhQklWBdhLk1K5wCYX6vv8cR/4k4Q6dvv93KWJjuD65tAHBqL
 qdYUl/BhU8PoETRMupp5NC1tsDfsPl94RqI4oEgeNZ8uQJso1hklnvnFVh27cU49VF4E6pU
 bLG2f2HYhtg/6HklgWWnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SOtiP9wOorE=:l2ysBDrZ8zj6L451C0SKr6
 VbSZX+CwpnAiNnrIPXN72++Oa+sJULXj8SFU869dGhWgjxSektcNOrAWnEDd+vZtgrbGxKKZf
 pIwcMO8bMrxnaj5giRCbm9xP66cSkfLoIICI2QZgtAfiG/Wjqc4a36p6sdtcdzzIC8MGF7SsG
 hF75WdYKFIy4J+xP6UiXLxmieMEhY0hpLmGjhIy0FQGH2w3TsstD4/sLVou7eGMCPb1L74wy6
 3rA4qxjS5UDoY79w5ly2e9ek2xMLfmdx3/vjonDih7BKtMxPgU/aCyCnT+k7CP2iGhOvgdzK6
 zl1ZU9OCdYe7uljefS4Wq+BYcaFYRWvThmkp0fK0YBvIhQHuFNCcGFEHyQ3obx3qWXGvBQD8T
 NztWE7jq42to/GW4lrLCXUhkDyrULqOznDligDPtOH+yVfl5IiBwAmCmf9bftkBN26blKQELh
 4HTGtChVAPzsfADRjo9MEk1NGpxqaws04GO+7pce+2d15Jrin3oc30t9QQsG6otHG8mNL0AzP
 U1QiVOK+kvSFzO9xtUa8mHc1TodlaVTtVOzdweqbpmZkMDbDejm6KdmaY9AA78REUtICpP6Mp
 EZYyqL7gxEgEQkSRZYFojz+n5xxzgMnyJtsP/h2H9VDCRuc2ZTWjJw30TCbMbuMZEFWXb/UGA
 KKqU4IKJU9FjSLHVTLtDRrfG/2pTM4otQAqeNwfAWrkHUg0wyi/6ucSxhdnL8KR7IP7ZzbPnB
 ci4L3ijFS8cKGUHmnCcVY4rZFANkyYXLEG33SEVdNLU3IF2nmKWDzBjBh91mbPPVl8idEX7vD
 dymiw1mmtWtQ1f+X5z9PzcMNagTGjdNhjf5hjgnq5pFSdDUJ9OysAJDzpHYvd/NOIZ2dJhSk2
 gX79dcag0R0ykNrQnUXZRRZMD5b5DxcXcIQ7hMXm8hy2iaRVIDtvQ5vbZMU7QiTkr2fN5NiX9
 dR87vQOwTHEp8FCixoOW2A0reDFaFbFjHIHt4yd8UnrtoRxEFtOGKDwC/aZUSTDWj5r+xrSD6
 gmmaQO+jTylmjDzTpUBTUyrf7JE1fP6OppILrmJvot+AcSLB1vzH6Jc6ax4kSHY97rmc3A9WP
 X+otHm2gAtotsc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 04, 2022 at 06:40:27PM -0500, Jeff Hostetler wrote:
>
>
> On 2/24/22 12:33 PM, Torsten =3D?unknown-8bit?Q?B=3DC3=3DB6gershausen?=
=3D wrote:
> > On Thu, Feb 24, 2022 at 09:52:28AM -0500, Derrick Stolee wrote:
> > > On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> > > > From: Jeff Hostetler <jeffhost@microsoft.com>
> > > >
> > > > Confirm that macOS FS events are reported with a normalized spelli=
ng.
> > > >
> > > > APFS (and/or HFS+) is case-insensitive.  This means that case-inde=
pendent
> >
> > This is not true, strictly speaking.
> > You can format a disk with "case sensitive" or "case-insenstive, case =
preserving".
> > Both APFS and HFS+  can be formated that way.
> > The default, which is what you get when you get a new machine,
> > is "case-insenstive, case preserving".
> > And I assume, that more 99% of all disks are formated that way.
> > The "core.ignorecase" is used in the same way as it is used under NTFS=
,
> > FAT or all other case-insenstive file systems.
> > (and even ext4 can be formated case-insensitive these days.)
> >
> > An interesting article can be found here:
> > https://lwn.net/Articles/784041/
> >
> > And to be technically correct, I think that even NTFS can be
> > "configured to be case insensitive in an empty directory".
> >
> > In that sense, I would like to avoid this statement, which
> > file system is case insensitive, and which is not.
> > Git assumes that after probing the FS in "git init" we have
> > a valid configuration in core.ignorecase.
>
> You're right. I was incorrectly glossing over the differences
> between APFS and HFS+ -- and conflating case and nfc/nfd
> issues.
>
> [...]
> > >
> > > > NEEDSWORK: I was only able to test case.  It would be nice to add =
tests
> > >
> > > "I was only able test the APFS case."?
>
> I'm going to completely redo this commit in the next version.
> I now have both APFS and HFS+ partitions on my machine and
> can compare the differences in behaviors and will have a new
> set of tests to cover this.
>
> > >
> > > > that use different Unicode spellings/normalizations and understand=
 the
> > > > differences between APFS and HFS+ in this area.  We should confirm=
 that
> > > > the spelling of the workdir paths that the daemon sends to clients=
 are
> > > > always properly normalized.
> > >
> > > Are there any macOS experts out there who can help us find the answe=
rs
> > > to these questions?
> >
> > There is a difference between HFS+ and APFS.
> > HFS+  is "unicode decomposing" when you call readdir() - file names
> > are stored decomposed on disk once created.
> > However, opening  file in precompsed form succeds.
> > In that sense I would strongly suspect, that any monitors are "sending=
"
> > the decomposed form (on HFS+).
> >
> > APFS does not manipulate file names in that way, it is
> > "unicode normalization preserving and ignoring".
>
> It took a few hours of poking to figure out what Apple is doing,
> but yes on HFS+ they convert to NFD and use that as the on-disk
> format.  And they do collision detection as they always have in
> NFD-space.
>
> Whereas on APFS, they preserve the NFC/NFD as given when the file
> is created, but always do the same collision detection in NFD-space.
> The net result is similar, but subtlety different.

That depends what you mean with "net result".
What Git sees after calling precompose_utf8_readdir() with
core.precomposeunicode=3Dtrue ?


>
> FS Events from MacOS are sent using the on-disk format (NFD on HFS+
> and whichever on APFS) and my FSMonitor daemon is sending them to
> the client as received.
>
> I'm not sure whether or not the daemon should respect the
> `core.precompseUnicode` setting and when watching an HFS+
> volume do the NFD-->NFC conversion for the client.  I'm not
> sure whether that would be any more or less correct than just
> reporting the paths as received.  I'm going to leave this as a
> question for the future.

I think that I have a suggestion for an answer:
We still have HFS+ systems around, and we still have an NFD feature
in MacOs for USB sticks with FAT or SAMBA mounted network volumes.
Both return NFD in readdir().
Even if NFC is on disk for FAT or going over the wire for SAMBA.
Having a precompose() function in the FSMonitor would help to make
things consistent.
And the answer is yes.

>
>
> Thanks for all of your background information on this topic.
> Jeff
>

The pleasure is on my side.
Please feel free to cc me for the next round, so that I don't miss
to review them.
