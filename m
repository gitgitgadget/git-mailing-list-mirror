Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D66C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E0B23884
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 17:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAIRZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 12:25:07 -0500
Received: from mout.web.de ([212.227.15.3]:43149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbhAIRZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 12:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1610212982;
        bh=yMaASub+HdpUS1IkdYpnu7s9PKftRY+7KU6g8pouD/k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HTxU00jVCbHt6LRaoQYu2fKup354XrxqhGr9RMWpp/2kCkBXTUecapCJJZgcuel3I
         7ZWFeL/lhZranCn/AAsGwINuLg+o4M7vmM68c3t/zpf4L/tvpIn6rjC6WaHhhsuCv0
         Ntma9TTVy+wLE8jnIKJU2yEvySRF9WQxgiFIEJCA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LudLU-1jyS5W2sCm-00znl3; Sat, 09
 Jan 2021 18:23:02 +0100
Date:   Sat, 9 Jan 2021 18:23:01 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Daniel Troger <random_n0body@icloud.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
Message-ID: <20210109172301.qkxxeeqnyrr6nyc5@tb-raspi4>
References: <7B64BC13-CB54-43CE-8C01-D45E25591E2A@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7B64BC13-CB54-43CE-8C01-D45E25591E2A@icloud.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:wRa36rLgpQRmoCKRrNC7eejnmcq8MKCdyZWgp/HLeuQiYsz9ZWf
 B4dgBi0IeWS8/s0xp+okPCxjDHmV9bpW0H8kOQQ/X9H67g8ODsi5/Zc5zh18OgOhaiI355E
 PeGfuX2jWwLcIH/EhDffFBim8RS+fLH/V1zI18008mdrUE77S+ZGnoIkoyrSJga13aeePZ9
 waoz2VcOJUE49fyglm6sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XMuT0pSvnaU=:mtfDp/+BDLfwzo4olUAc+5
 auLllh8yYLLytYugLm5zTrPnfxfH5i5WLA6l9DV0i/W3kxZjn+YFsKy9qJiLBf1LuMxPPuofs
 I6JB+Xlcaw6aABj4DmYTX6Sl8SMWyVCqxcbum7CwYmoVoFrL3Gf82cDNqiZnzmBgrVVToWVMF
 eIlgGt+gIFxT25kxNwUaByjl4bCKd56nn4tolsZF4sbYAqdZcLIf8Gx4WdCUA9c9pmpTY9/Gd
 F+fEiedTA9j9fvAPcfXEfDQFiZ1shmKcW4Bt0R3VS8CSTSjzfO8fRdq/XfvB30UNGOgcQ87wS
 +8Lwdb0shr2NuG0kQude7mBx3oqqLFOhDAne5LRKfaRc2+zmaJBEgYQszlbXpG3aw4MasMrO3
 LwOBNgT161AalgQUfRbZ+W2GFN5NGxOSNKojNuqSUTaci+2W4qQKLMuIOUkfWyCD6tOM72AWL
 dTli3ir+lXlkpTSpfe1YLnYAZ7ESHF/kgfoXFYaaoLGNfXezm4i50bxlUXSIPg/m+NG+98AVl
 +H3EXndy09Z40Vcc4GRGvg7wVM3BYeNf5SfIQSrzwHX8VKdtOpQF2G26teey37vlAtgSb2unl
 ZbvHLJTkO5bjGL3VUktDxYp/bvO13A1JyGZKuu/JqgH0RthohxDn2sWxYBYMIx/xEqEsZd8Jc
 7Mu3W+ltZsDdwsphwEbYfAMNEgRfhrJtZ8Rc2iZFjn5b9b2In3jueBZzSYIrRS79OAFU/Y+Dl
 W5plaKYkYbNIrMq3xj0yzW7EfYu9xqTuOjZTqEyyHKpcJ2zGTLjpkLF4CzOZNPNjzlk2/EYW6
 2t9dAf1Mfj39ez5C29WuzL8X6e/1fwj0+N2jINf9QVvlsTmILLKVG1750jIBA79e3YwgTtwVh
 sik8u35x5GyPXz1jJR3g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 08:56:08PM +0100, Daniel Troger wrote:
> > That did the trick, the test case is now reproducible here.
>
> > It seems as if there could be a patch in a couple of days, but no prom=
ises.
>
> That's great news, thank you all very much!

Hej Daniel,
Not sure if I can keep my promise, please see below.

> I was already afraid at first it was some weird macOS filesystem bug onl=
y happening on high sierra
> and earlier which was never going to be fixed.

I haven't heard about anything special about Mac OS High Sierra.
If there are strange things, please let us know.

(And I still womder, how did you mange to create the "decomposed version o=
f =E5" ?
 Mac OS itself doesn't decompose the "=E5", in opposite to "=E4" or "=F6".
 It creates a name for a file in decomposed form for "=E4", "=F6" and a lo=
t of other
 characters/code points, but not for "=E5".
 It does, however, treat the pre- and de-composed form of "=E5" equivilent=
)

>
> In the meantime I have managed to add "both directories" to git (with gi=
t add paulbr*).
> It's funny, now one directory shows up twice when viewing my repo on git=
lab.
>
> And this is the message I get when cloning:
> warning: the following paths have collided (e.g. case-sensitive paths
> on a case-insensitive filesystem) and only one from the same
> colliding group is in the working tree:
>   '[...]/paulbrunng=E5rd-springyard/main.ts'
>   '[...]/paulbrunng=E5rd-springyard/main.ts'
>
> What will happen with the two folders in the git repo after the patch?
>

Now, that is another question.

First of all, I would recommend to "remove" one of the folders from Git,
because all files are tracked twice in Git, but "shadowed" by the file sys=
tem.



To clean up the repo, you can do like this, explained in a dummy repo:

#One file (that is all we have) is tracked twice:
user@mac:/tmp/AAA> git ls-files
"paulbrunnga\314\212rd-springyard/horse"
"paulbrunng\303\245rd-springyard/horse"

# Remove all files from Git, but keep them on disk:
user@mac:/tmp/AAA> git rm -rf --cached .
rm 'paulbrunng=E5rd-springyard/horse'
rm 'paulbrunng=E5rd-springyard/horse'

# Re-add one version, the precomposed:
user@mac:/tmp/AAA> git add .
user@mac:/tmp/AAA> git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
          deleted:    "paulbrunnga\314\212rd-springyard/horse"

user@mac:/tmp/AAA> git ls-files
"paulbrunng\303\245rd-springyard/horse"

#Not shown:
git commit -m "Remove duplicate directory"

####################

Now back to a potential patch:
That will take some time.
I digged some hours into the stuff, add lots of debug traces,
patches and stuff, and now we need a cleanup and get it into a better
shape to be acceptable.

All the best
