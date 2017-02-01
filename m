Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D87D1FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 06:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdBAGgO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 01:36:14 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35473 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBAGgN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 01:36:13 -0500
Received: by mail-pg0-f68.google.com with SMTP id 204so33258177pge.2
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 22:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tgfp31CN4lAnTTPaTUJZx6DsmxtDUCCPvtCadu4tk3w=;
        b=aE5Aw3IRwS7vbcygD4ovSzPeiMsdsuxMOgzIzvyTNf967e51088mEu6fNMYssF4Zzr
         Bdo2YkBck5s/PCUdp54F7qxyeEGpIibg5hs+TG41hC2vX5i0HgWpM4i0fN5VZNo4vOV0
         5R6747OQ38edEQZHHa5VDepUIpwNG9L9QcSuKK1YJR0D2Oqo811zhNEBEam60dQzWpCB
         0csjxIwqzjFE0vRYiz95j+p10OxuSb5jPUkL2Pptd5uNzrAmDLNEP2b6KGPjTUnxibC0
         +kO0yY/K/l8iskPjvQlkgYZJA24cHbPOIi7c0fLdzH85opjHX+3odKr1fphHw734ogRe
         Hrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tgfp31CN4lAnTTPaTUJZx6DsmxtDUCCPvtCadu4tk3w=;
        b=ACtwnErctJVGrJOvfClLanj8Su///kWQhtFzbt35mhCoox80VPb1Afu0H94kG1eHZN
         lYXLdqfoafqAsoi/MJ74vw0C37yEYwk1k4wa9Ycx4xfuAp0i7sM9Zm+TvrCLWB3dsliy
         Xfk/pVLMQ97clEXEgeiNEVE6wOkznYlMfedc2uSpbkpiz+8qxbJfmEZHcC/jwnOR/h0d
         ldU0s1DJdBafKkQwybR49reJCQby4dRiITx7PnYoP1imnZB6ujf0DtUvq8udfZgh9341
         mAetHhNUHEVwAO+1Rs88lRROGHN48ckkoswmuEyrXDk5uo+p0OPmzq7hHhkvGCV0o/Du
         acAw==
X-Gm-Message-State: AIkVDXKBv9Z6vB+LzxEXBCEysIK3RXS0tqeIJwvT8Mf7SCTnlXE2MzSammY/DqRx13dfeg==
X-Received: by 10.98.44.10 with SMTP id s10mr1563495pfs.161.1485930972448;
        Tue, 31 Jan 2017 22:36:12 -0800 (PST)
Received: from [192.168.1.101] ([64.201.108.45])
        by smtp.gmail.com with ESMTPSA id r17sm46322769pgg.19.2017.01.31.22.36.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 22:36:11 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [git-users] More on that "merge branch checkout" problem -- cannot abort/go back?
From:   Michael <keybounce@gmail.com>
In-Reply-To: <B621FC58-AA73-4D88-B5E5-575BC1A6F0EE@gmail.com>
Date:   Tue, 31 Jan 2017 22:36:04 -0800
Cc:     git-users@googlegroups.com,
        Konstantin Khomoutov <flatworm@users.sourceforge.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <35A4AE26-0CDB-448E-BA93-08A53425CE80@gmail.com>
References: <B5AC010A-3195-403D-93DF-37CA143559C8@gmail.com> <20170130103225.bf16ac0181794cf28a918321@domain007.com> <B621FC58-AA73-4D88-B5E5-575BC1A6F0EE@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is going to the main git list. I had an issue with a git gui =
checkin, where I did a checkin of selected lines (no problem), then =
tried to switch branches and check in the rest.

Things broke.

I attempted to get help on the git users list, but was unable to.

To recap what happened:
1. I started on develop.
2. I made a feature branch.
3. I did some stuff. About half would be checked in on the feature =
branch, and about half on a "code cleanup" branch.
4. One hunk in the diff was a close comment (for the code cleanup) and =
then a bunch of new stuff (For the feature).
5. I used git gui to select what portions I wanted to check in.
6. In the past, using git gui to check in some lines of a hunk in one =
commit, and the other lines in a succeeding commit _on the same branch_ =
did not give me trouble. But this time, I was switching branches in =
between.
7. Git checkout complained about my changes being overwritten. git =
checkout -m did "work", but complained about a merge conflict.
8. There was no way to switch back -- there was no merge to abort, and =
no way to recover the previous state.

What I don't understand is:
1. Why is there no way to abort a merge checkout, and
2. Why was it that I could check in a portion of a hunk in git gui, but =
then not switch without a conflict? I'm not asking why there was a =
conflict as reported by diff -- I checked in the bottom half of a hunk, =
and kept "not checked in" the top half, so the context lines would not =
match. I'm asking more like, why wasn't git able to tell that the other =
part of the hunk was already checked in, and what I wanted to keep here =
was the stuff that was not checked in -- the "live git diff" which only =
showed the close comment in that part of the diff.=20

To clarify #2: The three versions in the conflict file were "nothing" =
(the old develop that had none of these changes), "what was checked in" =
(the feature branch), and "everything"; what I wanted was "everything - =
what was checked in" (which is what git diff reported before I switched =
branches).

On 2017-01-30, at 5:45 PM, Michael <keybounce@gmail.com> wrote:

>=20
> On 2017-01-29, at 11:32 PM, Konstantin Khomoutov =
<flatworm@users.sourceforge.net> wrote:
>=20
>> On Sun, 29 Jan 2017 11:07:34 -0800
>> Michael <keybounce@gmail.com> wrote:
>>=20
>>> So since my attempt to switch branches with the "merge" flag (-m)
>>> gave me an error, I thought I'd try to go back.
>>>=20
>>> keybounceMBP:Finite-Fluids michael$ git merge --abort
>>> fatal: There is no merge to abort (MERGE_HEAD missing).
>>> keybounceMBP:Finite-Fluids michael$ git status
>>> On branch cleanup
>>> Unmerged paths:
>>> (use "git reset HEAD <file>..." to unstage)
>>> (use "git add <file>..." to mark resolution)
>>>=20
>>>       both modified:
>>> src/main/java/com/mcfht/realisticfluids/fluids/BlockFiniteFluid.java
>>>=20
>>> Changes not staged for commit:
>>> (use "git add <file>..." to update what will be committed)
>>> (use "git checkout -- <file>..." to discard changes in working
>>> directory)
>>>=20
>>>       modified:
>>> src/main/java/com/mcfht/realisticfluids/FluidData.java modified:
>>> =
src/main/java/com/mcfht/realisticfluids/commands/CommandEnableFlow.java
>>> modified:
>>> src/main/java/com/mcfht/realisticfluids/fluids/BlockFiniteLava.java
>>>=20
>>> no changes added to commit (use "git add" and/or "git commit -a")
>>>=20
>>> I'm not saying this is necessarily wrong (the other branch does have
>>> everything, and I'm on a branch where I could just commit all these
>>> changes now, and worry about fixing it later; no data would be =
lost),
>>> but I do think that it breaks the user's reasonable beliefs about
>>> what the system does -- including the ability of a version control
>>> system to roll back to a prior state (which in this case it cannot =
--
>>> or if it can, I don't know how.)
>>=20
>> To cite the documentation:
>>=20
>> | -m, --merge
>> |    When switching branches, if you have local modifications to
>> | one or more files that are different between the current branch and
>> | the branch to which you are switching, the command refuses to =
switch
>> | branches in order to preserve your modifications in context. =
However,
>> | with this option, a three-way merge between the current branch, =
your
>> | working tree contents, and the new branch is done, and you will be =
on
>> | the new branch.
>> |
>> |    When a merge conflict happens, the index entries for conflicting
>> | paths are left unmerged, and you need to resolve the conflicts and
>> | mark the resolved paths with git add (or git rm if the merge should
>> | result in deletion of the path).
>> |
>> | When checking out paths from the index, this option lets you =
recreate
>> | the conflicted merge in the specified paths.
>>=20
>> So I'd say your best bet is to run
>>=20
>> git checkout --ours path/in/conflict
>>=20
>> on conflicting paths.
>>=20
>> As to your idea, I find it to be sensible but in fact you did not
>> attempt true merge, and hence asking for aborting it is dubious.
>>=20
>> Maybe `git checkout --abort` would have more sense?  But then the
>> question is: what state should it roll your back to?  Should it =
revert
>> switching on a new branch as well?
>>=20
>> Please consider bringing this question on the main Git list to =
solicit
>> insight of those with mad Git skillz. ;-)
>=20
> I still don't understand "--ours" or "--theirs" on checkout.
>=20
> I also am not sure that any of them are what I want. The three =
"versions" at the merge hunk were:
> 1. Nothing (this was the previous 'develop' branch tip)
> 2. The stuff that was added in the checkin on the other branch (this =
was the previous 'feature' branch tip)
> 3. Everything, the close comment AND the stuff added (this was the =
whole conflicted hunk)
>=20
> What I needed was basically "whole hunk - stuff checked in on =
feature". And since the file had other things that merged in just fine =
(an open comment earlier up), neither version (ours or theirs) could be =
the right version, even if I could restrict it to just the conflicted =
hunk.
>=20
> Where should it roll back to? Where I was before. There's a ref (I =
think it's MERGE_HEAD) created to allow you to abort a merge back to =
where you were, so why not a CHECKOUT_HEAD (or, if it's doing a 3-way =
merge, why not record the full merge information?)

---
Entertaining minecraft videos
http://YouTube.com/keybounce

