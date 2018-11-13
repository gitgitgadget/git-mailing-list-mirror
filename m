Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034FF1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 00:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeKMKfz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 05:35:55 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46041 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 05:35:55 -0500
Received: by mail-ed1-f47.google.com with SMTP id d39so5635252edb.12
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 16:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NYwAOyv2GvtnVSbsAomsOa8A9avb/A3ay9cUqKhxTEs=;
        b=HoM1yeXWBDHbvDgSyR6D2D2CSPZz32B+88datLkWgfQpA7oxPqQxr19s+DsZoSHAyP
         9xH01igrX7Ag1rTx77e4j8E2ZmZ5XbvOJB6IhkO924XSz8TerMcmE2laIjGocke27OXW
         2T0KnFCGqPuw5FKi7NYRMe0qydP0X0/Rz1UkguxM2/nktimH8C5h2reM3LbMXrnyyAl9
         5jEBnsEMjX8IZviyyJruQ4Xex9G/klEZtl3qJMKOrhjI29evSwUrayZO1V3DBzI7vHwf
         p66f1VoNc9HrDovYBMTAySc2kYtFVwY1Uh/El+eUuMy4pYW2aUAC0u8XfKtpZ+xxasRA
         9Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NYwAOyv2GvtnVSbsAomsOa8A9avb/A3ay9cUqKhxTEs=;
        b=snXQo6iFpbsYvQVCt+JbLAQ+6l13nyzSHO2pIq81DG+Yn+cIdG2wraFPxyZI5MucFy
         AYh4yt6sG8dZ5VPfCGcPz13pHszSWvjsHMLML76RHwxq6XrtSaDWcGppYGS2s3Jqj8Iz
         OedGFm7jVLhSiTX910YUyw0FpTwgJDzfBPb9JbiD6jX5I5c34VZU8S4uZcuWw43r2m9N
         7uIFVSKlUcn00yHGR7paMklaNjnnarIdQEp2DE/0AfZEZiNUs2geGwA5qMo1M3uQRB7r
         6Kx18JPJEO5EeDGB1SUTI0JT5153puTPiD1mwSNfCjgF2sfiBfQPIOMziuzxCRuNLf/c
         qcIA==
X-Gm-Message-State: AGRZ1gKIX1Bm+bJDs5XEeyPT2ukog9PFX3IQqTVCa2OE8CqQ6txLAGum
        YwjiXaBqnLQAIzv9MbROD7wb2V/dg2QYkhHKM1/wDEiWuxdm1A==
X-Google-Smtp-Source: AJdET5fwPfOdeTGVUXo7mpFqW30KFlc+8SDEVcx+oAFOUXhQ8rh3KOqKRPYAsFjcfuZQ3ERjgSrdp6VIs+KlXkMksqg=
X-Received: by 2002:a17:906:3da2:: with SMTP id y2-v6mr10851355ejh.160.1542069618213;
 Mon, 12 Nov 2018 16:40:18 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae-Bk5hxEsLuDi=MytzN-kBG0D4psLbc_1=B+=70D=JKCQ@mail.gmail.com>
 <20181112123058.GE3956@sigill.intra.peff.net>
In-Reply-To: <20181112123058.GE3956@sigill.intra.peff.net>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Tue, 13 Nov 2018 01:39:51 +0100
Message-ID: <CABUeae895z=UCr35VVUkMYz9nA7osVGSSCnMOUvEZRChtvz_vw@mail.gmail.com>
Subject: Re: Migration to Git LFS inflates repository multiple times
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 12 Nov 2018 at 13:31, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 12, 2018 at 12:47:42AM +0100, Mateusz Loskot wrote:
> >
> > TL;TR: Is this normal a repository migrated to Git LFS inflates multiple times
> > and how to deal with it?
>
> That does sound odd to me. People with more LFS experience can probably
> give you a better answers

FYI, I forwarded my question to https://github.com/git-lfs/git-lfs/issues/3374

> but one thought occurred to me: does LFS
> store backup copies of the original refs that it rewrites (similar to
> the way filter-branch stores refs/original)?

I don't think I see any backup refs (see below for full list).
But, I may be misunderstanding what they are, how to look for them.

> history. Which might mean storing those large blobs both as Git objects
> (for the old history) and in an LFS cache directory (for the new
> history).

Yes, it makes sense.

> And the right next step is probably to delete those backup refs, and
> then "git gc --prune=now". Hmm, actually thinking about it, reflogs
> could be making the old history reachable, too.
>
> Try looking at the output of "git for-each-ref" and seeing if there are
> any backup refs.

I see. Here is the list (long!) of all I found:

proj.git (BARE:master) $ git for-each-ref
c718eadcf8d09d68c385f0a9355a2c871474fb43 commit refs/heads/1.0
daa75889053b70515179e334cbe3fe6fc7873ff3 commit refs/heads/1.1
cb70db292c1f0c62170d05ffa8dad3c87a6f8ebd commit refs/heads/2.0
f1597e80fcea16bec96dc43f7ab706616126305b commit refs/heads/3.0
1d9e4813ae2fdc5c2b52f7115facda9059b009dc commit refs/heads/master
f41edf37e9a4120bc5d5d66b29d110d403b8db9b commit
refs/svn/attic/tags/1.0.1006/6674
850166b21f27447c6b503bb753c454ccedcea8ef commit refs/svn/attic/tags/1.0.216/1291
8a24407f2df0ea7a401fbc08b387387538912642 commit refs/svn/attic/tags/1.0.252/1543
771d81b0756d6ff7d73779ed79f49a607bffb80e commit refs/svn/attic/tags/1.0.299/1883
10925d0fe0de090d4de109fd6403b86d014d6a21 commit refs/svn/attic/tags/1.0.342/2288
ca8dc7b243d002ac6b27f219a6172d36e7885ac1 commit refs/svn/attic/tags/1.0.391/2470
79ebabed25d31dfa34ad68e58fa9327f71928df1 commit refs/svn/attic/tags/1.0.433/2657
d3ed45804843c5aa153810b7494e2c7c0b842c82 commit refs/svn/attic/tags/1.0.450/2724
088af5dbb225cb8dfbeafb5b63158234f4e4017d commit refs/svn/attic/tags/1.0.502/2967
5da8598ed98a5a6610108d67849955da14f9d5b8 commit refs/svn/attic/tags/1.0.546/3212
c3463397337f9f6e5f9d8e64cd79c013fd798bc8 commit refs/svn/attic/tags/1.0.615/3470
673b2f93fda830cc8f28d436abead5fd54baa361 commit refs/svn/attic/tags/1.0.657/3704
247cf24b90afd39f4f5dd7a27cf6b74483215285 commit refs/svn/attic/tags/1.0.662/3725
e2a1609bb6b15ee767565ca0ff152eae3f72a76b commit refs/svn/attic/tags/1.0.673/3820
48033fb9046b1ee60ad9b73073e9185c31ee4568 commit refs/svn/attic/tags/1.0.742/4325
d7b566a275209d0aebba39c7a4028c9dcfb8a468 commit
refs/svn/attic/tags/1.1.1141/13525
80f922becfc406420d2f14543e6da684f7377504 commit
refs/svn/attic/tags/1.1.1535/16534
252481191cacdef0e77eb6ec02c98b07fca7bc77 commit
refs/svn/attic/tags/1.1.1582/16435
601f072d559b664c101d89f3445ed3d00f4ef5dd commit
refs/svn/attic/tags/1.1.939/12077
417fb23d71cab30e2c6218faed6f86021b67ca25 commit
refs/svn/attic/tags/2.0.1156/21143
5539fbbe0078b782af02d46e0c1abc86ce3d5902 commit refs/svn/map
c718eadcf8d09d68c385f0a9355a2c871474fb43 commit refs/svn/root/branches/1.0
daa75889053b70515179e334cbe3fe6fc7873ff3 commit refs/svn/root/branches/1.1
cb70db292c1f0c62170d05ffa8dad3c87a6f8ebd commit refs/svn/root/branches/2.0
f1597e80fcea16bec96dc43f7ab706616126305b commit refs/svn/root/branches/3.0
e946e96ce2b37a771769196027ae87b8f24181e0 commit refs/svn/root/tags/1.0.1058
06928f42664384bd5e24c115f9c23acc2fd949da commit refs/svn/root/tags/1.0.1240
9f059337974aa195386c5f3ee21957551624aa27 commit refs/svn/root/tags/1.0.1653
db98d68f93d2e9127ab766d3bbe6c933ec169d29 commit refs/svn/root/tags/1.0.764
20ad69c6b94bc8b73b613b5c21d367f22f423501 commit refs/svn/root/tags/1.1.1163
458be535d7f0bc512e800759759e86a211a418b6 commit refs/svn/root/tags/1.1.1290
df045ab97bee94e8cfe72b70802b837719899587 commit refs/svn/root/tags/1.1.1556
cd8ce83868016a0854c0f3cf1b23ea68a32674a2 commit refs/svn/root/tags/1.1.1706
fcd0801b93f48bd46b276ccb82678a70f11fc3ca commit refs/svn/root/tags/1.1.1809
5df0902cfe973b0a041409ec2e8d2314f2b8031e commit refs/svn/root/tags/1.1.2368
c9a06b4f43bab77ed283fe2736ab5c865e03026e commit refs/svn/root/tags/1.1.2417
32e505f8c4deadb73c63bd20a598481cd164541d commit refs/svn/root/tags/1.1.947
ef9c3667ec419bcb6d5eb5b9dbacb1cff0b1051e commit refs/svn/root/tags/2.0.1187
a1a6a5bedb8949eb91f3509929edb9efa9ad2875 commit refs/svn/root/tags/2.0.1198
33a8f49da311caecdb5521759251bbcb78e3bff2 commit refs/svn/root/tags/2.0.1338
63e59278131281858296b56f4ef5dd91c332941a commit refs/svn/root/tags/2.0.1481
d23a1c662f772a7fc0d23a07794b57cfd9eff064 commit refs/svn/root/tags/2.0.1835
c53e2cc4660a9e3121dff33c28c1383766fda39b commit refs/svn/root/tags/2.0.2148
c7e0293ec09fee809fba707054cd1fd8fe492664 commit refs/svn/root/tags/2.0.2580
1d9e4813ae2fdc5c2b52f7115facda9059b009dc commit refs/svn/root/trunk
e946e96ce2b37a771769196027ae87b8f24181e0 commit refs/tags/1.0.1058
06928f42664384bd5e24c115f9c23acc2fd949da commit refs/tags/1.0.1240
9f059337974aa195386c5f3ee21957551624aa27 commit refs/tags/1.0.1653
db98d68f93d2e9127ab766d3bbe6c933ec169d29 commit refs/tags/1.0.764
20ad69c6b94bc8b73b613b5c21d367f22f423501 commit refs/tags/1.1.1163
458be535d7f0bc512e800759759e86a211a418b6 commit refs/tags/1.1.1290
df045ab97bee94e8cfe72b70802b837719899587 commit refs/tags/1.1.1556
cd8ce83868016a0854c0f3cf1b23ea68a32674a2 commit refs/tags/1.1.1706
fcd0801b93f48bd46b276ccb82678a70f11fc3ca commit refs/tags/1.1.1809
5df0902cfe973b0a041409ec2e8d2314f2b8031e commit refs/tags/1.1.2368
c9a06b4f43bab77ed283fe2736ab5c865e03026e commit refs/tags/1.1.2417
32e505f8c4deadb73c63bd20a598481cd164541d commit refs/tags/1.1.947
ef9c3667ec419bcb6d5eb5b9dbacb1cff0b1051e commit refs/tags/2.0.1187
a1a6a5bedb8949eb91f3509929edb9efa9ad2875 commit refs/tags/2.0.1198
33a8f49da311caecdb5521759251bbcb78e3bff2 commit refs/tags/2.0.1338
63e59278131281858296b56f4ef5dd91c332941a commit refs/tags/2.0.1481
d23a1c662f772a7fc0d23a07794b57cfd9eff064 commit refs/tags/2.0.1835
c53e2cc4660a9e3121dff33c28c1383766fda39b commit refs/tags/2.0.2148
c7e0293ec09fee809fba707054cd1fd8fe492664 commit refs/tags/2.0.2580

AFAIS, there are only ones related to SVN to Git translation, and Git natives.

> After deleting them (or confirming that there aren't),
> prune the reflogs with:
>
>   git reflog expire --expire-unreachable=now --all
>
> and then "git gc --prune=now".

Although there seem to be no backup refs in my repo, I decided to get
rid of all refs/svn/*

proj.git (BARE:master) $ du -sh
39G     .

proj.git (BARE:master) $ git for-each-ref --format="%(refname)"
refs/svn/ | xargs -n 1 git update-ref -d

proj.git (BARE:master) $ git for-each-ref
c718eadcf8d09d68c385f0a9355a2c871474fb43 commit refs/heads/1.0
daa75889053b70515179e334cbe3fe6fc7873ff3 commit refs/heads/1.1
cb70db292c1f0c62170d05ffa8dad3c87a6f8ebd commit refs/heads/2.0
f1597e80fcea16bec96dc43f7ab706616126305b commit refs/heads/3.0
1d9e4813ae2fdc5c2b52f7115facda9059b009dc commit refs/heads/master
e946e96ce2b37a771769196027ae87b8f24181e0 commit refs/tags/1.0.1058
06928f42664384bd5e24c115f9c23acc2fd949da commit refs/tags/1.0.1240
9f059337974aa195386c5f3ee21957551624aa27 commit refs/tags/1.0.1653
db98d68f93d2e9127ab766d3bbe6c933ec169d29 commit refs/tags/1.0.764
20ad69c6b94bc8b73b613b5c21d367f22f423501 commit refs/tags/1.1.1163
458be535d7f0bc512e800759759e86a211a418b6 commit refs/tags/1.1.1290
df045ab97bee94e8cfe72b70802b837719899587 commit refs/tags/1.1.1556
cd8ce83868016a0854c0f3cf1b23ea68a32674a2 commit refs/tags/1.1.1706
fcd0801b93f48bd46b276ccb82678a70f11fc3ca commit refs/tags/1.1.1809
5df0902cfe973b0a041409ec2e8d2314f2b8031e commit refs/tags/1.1.2368
c9a06b4f43bab77ed283fe2736ab5c865e03026e commit refs/tags/1.1.2417
32e505f8c4deadb73c63bd20a598481cd164541d commit refs/tags/1.1.947
ef9c3667ec419bcb6d5eb5b9dbacb1cff0b1051e commit refs/tags/2.0.1187
a1a6a5bedb8949eb91f3509929edb9efa9ad2875 commit refs/tags/2.0.1198
33a8f49da311caecdb5521759251bbcb78e3bff2 commit refs/tags/2.0.1338
63e59278131281858296b56f4ef5dd91c332941a commit refs/tags/2.0.1481
d23a1c662f772a7fc0d23a07794b57cfd9eff064 commit refs/tags/2.0.1835
c53e2cc4660a9e3121dff33c28c1383766fda39b commit refs/tags/2.0.2148
c7e0293ec09fee809fba707054cd1fd8fe492664 commit refs/tags/2.0.2580

proj.git (BARE:master) $ git reflog expire --expire-unreachable=now --all

proj.git (BARE:master) $ git gc --prune=now
Enumerating objects: 1315030, done.
Counting objects: 100% (1315030/1315030), done.
Delta compression using up to 48 threads
Compressing objects: 100% (809937/809937), done.
Writing objects: 100% (1315030/1315030), done.
Total 1315030 (delta 495565), reused 1314739 (delta 495312)
Checking connectivity: 1315030, done.

proj.git (BARE:master)
$ du -sh
38G     .

The size decrease, but not much.

Thanks for the ideas though.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
