Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B407C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 17:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiBXRiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiBXRit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 12:38:49 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 09:38:16 PST
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A018FAED
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1645724294;
        bh=voTM41chKoGwAP/mzQHYEDq6m+k+NpW4tyQDB6fBCwQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qHGpq0lN/8kFXPoaGZ7L4TGDh5lx1ufe1lEnFRzgeSs16EFP9tLseAwOxrHnyEIPk
         rncKxoI8LKdbffpnkt83OloIaEkz/nXgZ9Z5RbbOA8Kgajj0F2HPXoQyJanbaVhyMN
         gH5h6nLrgvHVD0bjU/SsHgxYFxfzDFCmK2mLqkKM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1nYKcM2fu4-00B2Xm; Thu, 24
 Feb 2022 18:33:06 +0100
Date:   Thu, 24 Feb 2022 18:33:06 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 02/23] t7527: test FS event reporing on macOS WRT case
 and Unicode
Message-ID: <20220224173305.gbr2waw77xpuieub@tb-raspi4>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
 <c7ee2394-cda0-a997-3b9d-fb8c3d65b312@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ee2394-cda0-a997-3b9d-fb8c3d65b312@github.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:TiaCKdcZmxh9CnIlCvnYjvMtZpm+QNsKhqkBVSzWK7bqydXqpHD
 e3hONeoPRqURJMi1XH01lE0YEYbcBS6Yk3ies0w3vecDjtEgZOwV7A6J8MCqV+l1KJ7T3RY
 j7Riihr9HICLnHgVNqNl5NbWlx+MRYwT4X7TCaMdmGMT54/7i4+rXM8ZFPV3BijVb68EBNJ
 ujWqzibynx4nHGVYkbIwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u6JEbRsjIfc=:tnA3pGOJTxoYXgGd+n+h3W
 hAhw8MSqrCkBLkjjX+CCJQW1VUmkzcI2BmTIGFCYBGPEzztu+EQEtTsRzvHtvoMmIFGPs6zI8
 rHVjLA1EifbW+EYcanJyekYP7omSQRGLaA1PdALGpQ+8cSaDYaxAApDt6hksOrfWVDgvoHj83
 UxJYf5rNbuROKd2r6xcXIshX8UytLn/utO5GGifAofygJeoQN48RWL0Z/5Zcm1BHRQFwcYAeL
 23XSSksPw2QhFDz/QoCO0HY1a9DLOTvkUmp4S6NGTe66VbKPadAtJSE8Zlhlvwc/dGeVP6Sj4
 TYN0hSKXuG6Wsk3Bq/tPUFdQJv9EKNtSi666cwyRdhwUGOvtC6ZPsOB6ImHtMVKeXkG9YCtUl
 IPyHwkwJsA25xg9ys0NuopGnk/K3udyDoPd0YToEsHWltDbX51AtJ3BtH8YumXKUIFwNMbf2C
 lJd6edcuxtsQqjdcUffeHqCuwSYOJyyXzzgZg7GGobUEe9VsPv+bcjm3m51Y0TKwquuH/q8Zn
 sA25J6kToTpZHzUjW0Rl4Mbk2/dtJnUC2NiZyReBnsgrlU5BNqVZ1BqhQxlMmDNGChjNGpo+J
 bBMS0Xot+xkwEfP42ynm/dCayMjSR5rIapn2LCqloWcyWsv5g1i2SVemQUH/BzKLS674ndTuD
 7frpcaU0R+BCA8WNFDjtB5XFfhogOGuMKsChbHE7pFQZ/yMuWrvet/aD+8XOr0BdvIaJyIoOx
 I2CdxaGgy+V6PiRI2oNC9o1g1WfE0M9+hZvpodPsB7KkbsAo9eGbD0+MxIStCx+v3gUVP+WEb
 jZUMiBBN8Sf0IZfaxxUkTzDSyNgvSa/xwRrM6sbNGL/N8VdgTF6JevB7AUDgydY2x9F1lJMfQ
 dDwMRhKqXJ40thQ5IJ1p/qIpoPpArf22jkmc9bnHDsM79JYZGuY0rtUv0hKdM3lyrHpwpsr76
 tLYN4ekNMhM5CJMM4R3P5+5d8V002EqdkCHNpbR8OLLQc8adRElRhYkrxKoA/emJJRoKc1I7T
 D6eQ5m/+QcPW8CtpP4MZ9XCJh055ocfw6mHFfa/JVJy/Ugep2WgFQP1VPsoCs3Uvpuet5wRvQ
 36lD1ezqF9Ork0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 09:52:28AM -0500, Derrick Stolee wrote:
> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Confirm that macOS FS events are reported with a normalized spelling.
> >
> > APFS (and/or HFS+) is case-insensitive.  This means that case-independ=
ent

This is not true, strictly speaking.
You can format a disk with "case sensitive" or "case-insenstive, case pres=
erving".
Both APFS and HFS+  can be formated that way.
The default, which is what you get when you get a new machine,
is "case-insenstive, case preserving".
And I assume, that more 99% of all disks are formated that way.
The "core.ignorecase" is used in the same way as it is used under NTFS,
FAT or all other case-insenstive file systems.
(and even ext4 can be formated case-insensitive these days.)

An interesting article can be found here:
https://lwn.net/Articles/784041/

And to be technically correct, I think that even NTFS can be
"configured to be case insensitive in an empty directory".

In that sense, I would like to avoid this statement, which
file system is case insensitive, and which is not.
Git assumes that after probing the FS in "git init" we have
a valid configuration in core.ignorecase.

> > lookups ( [ -d .git ] and [ -d .GIT ] ) should both succeed.  But that
> > doesn't tell us how FS events are reported if we try "rm -rf .git" ver=
sus
> > "rm -rf .GIT".  Are the events reported using the on-disk spelling of =
the
> > pathname or in the spelling used by the command.
>
> Was this last sentence supposed to be a question?
>
> > NEEDSWORK: I was only able to test case.  It would be nice to add test=
s
>
> "I was only able test the APFS case."?
>
> > that use different Unicode spellings/normalizations and understand the
> > differences between APFS and HFS+ in this area.  We should confirm tha=
t
> > the spelling of the workdir paths that the daemon sends to clients are
> > always properly normalized.
>
> Are there any macOS experts out there who can help us find the answers
> to these questions?

There is a difference between HFS+ and APFS.
HFS+  is "unicode decomposing" when you call readdir() - file names
are stored decomposed on disk once created.
However, opening  file in precompsed form succeds.
In that sense I would strongly suspect, that any monitors are "sending"
the decomposed form (on HFS+).

APFS does not manipulate file names in that way, it is
"unicode normalization preserving and ignoring".


>
> > +# Confirm that MacOS hides all of the Unicode normalization and/or
> > +# case folding from the FS events.  That is, are the pathnames in the
> > +# FS events reported using the spelling on the disk or in the spellin=
g
> > +# used by the other process.
> > +#
> > +# Note that we assume that the filesystem is set to case insensitive.
> > +#
> > +# NEEDSWORK: APFS handles Unicode and Unicode normalization
> > +# differently than HFS+.  I only have an APFS partition, so
> > +# more testing here would be helpful.

I have an older system and may be able to help, (but am busy this week)
> > +#
> > +
> > +# Rename .git using alternate spelling and confirm that the daemon
> > +# sees the event using the correct spelling and shutdown.
> > +test_expect_success UTF8_NFD_TO_NFC 'MacOS event spelling (rename .GI=
T)' '

Isn't this precondition is the wrong one and CASE_INSENSITIVE_FS is a bett=
er one ?

[snip]

I diddn't follow you series, but if there is a need to test under MacOS wi=
th HFS+,
feel free to cc me in the next round
