Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B817C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A366610CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhJUL6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:58:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:45161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhJUL6R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817360;
        bh=RrIaipzplHXT8qq+x+oXD2qTRAlkXHe8TjQVQWzD1rk=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=Mg4/FA577VzjwRj+oPjNHf+YfB08yefKSr31w7XMkhP51KQY0ef7kMGwZwzn7gVLP
         cSRB6jYJq0hzFHwHBfidCejhnCTOb78UGLOZaCyiCvy3hILTEJ8FTFhPYbW8dG3d94
         Z+fPD7btAj7JiUc0jnJ4cLknHvTC/zMNF+OJKCuw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1mGfoV0zhH-00UeW3 for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:56:00 +0200
Date:   Thu, 21 Oct 2021 13:55:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] SHA-256 Updates
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211147250.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-140266036-1634815969=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211355380.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:gqQ1VoNwVo9Ycnd2NWVkqNz1jIRgOe24IzpxIOehAhbvSM9f7CI
 IZMHf4f1wi476JApdiRxAxE0ViTRIbwhxMDxKxy6/x4h0ye5uWyOOUcTknCtrY3vVVjmydD
 rneyvEogQRm3ZBoqZBRBitsOlrgy+QD3YJta3idBe71sapYXLPDX4T2RapJNSz7Gv6sL7GY
 /a2x1XxOa/5s6zpM3SUqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fef/juDtG7Q=:D8Kv5dogdU8tC3Pzznvm7g
 4jh0nWu73R3cXXz/+vGsnRVLUXMlNc3Vrnr+kLXU57I/2WJhhzeSF0Y3rLWGfYe18aRhwNtON
 AsW+pvycx1oBp7OHDvyvrQITKkFsJce+nzzzjvYekIlcUqGLra0TGrSMpZ6vDsl3urlqctJ8i
 OhTqgG8Z3esa1MC/Ah8U1vFtbxy+lGmd1R72qBEeJaCPgJ+xeaUbFnY17oWGAg0bTWahYeMBk
 3YaBIykHA020EICVKgZ8Wu7WFBAUGqq/fqAEije+vq2OFMX3yOnJd6P/rwBc+sZfKqZ0p8Z53
 W2iD+kfJHA3CkKcsBsOhD092sXykhSLAn8PRjFynvz88Btb99sp/nzDEs3Oswf3FloVjW3gEa
 tXyKcVESRQWxXi4KSQzkH6kEzu7qbdTVda6E+3qIrutT3Zw3xvxCOG2WVfsWm/Ucf9+5+BVeb
 ABjn5GFwNWJ+LOyrpyXSxpw7OPQK4X+2Yb5mJKLuYyDyemcTVUx7kKGNkx7Gt0KrAIxlAr1lt
 CcHF2thMEm9I0QwTZJUmsP4vksNWqkEp6SqBGSlVMB1u+b01PAT30b9QC/n8ZFXKoP/ZKyNMB
 UP7/NThmqRviiYbNoTRDB59OxCBo7fguzwrxjOpkM5GZUSge9b07ITVJ94K7qSS/TeeYRJISp
 v6eWs4UW9EVn8Ma+m6q7FyY2PAhvAeWoMl8eJLXY7cuV70yfV3xUh1v4vlBxlu2Pk+WF1P4yd
 0cPT8zHCmSTggtqwrhTty+J1DWCgDnYLlJ76yIR8lj4THWPkJ3trWTmOUsjOOqkGBHagRsR7F
 xtPEsSV+S03yGHIYAETbKuiVzP9JaM92/4nk+R4L5p/UQFsnlt877wLEdPuhP3D7b+EY70Ivi
 QM+j1MDxhH6AQcH08jow9L2RSUzGMRZzNWB0u9AF9t8GWLfiFIiuKyfpzlVYQMLmW1A7ViAHc
 fNmySE3uFEHlAWRTwRslk0tov/qrzDekzxW0KjJkBX8EFTKfPQ4wINkpRQcE8i1SpwDIf7hOB
 u8RN5fUWq2jU5D1weKe2VA8P9SDNrRyveFLTAYFYgJQ5sbxiJwA0uhOiM3Vz3Yc1tnI7ORuhv
 lSJQWpU9YUuGvA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-140266036-1634815969=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211355381.56@tvgsbejvaqbjf.bet>

This session was led by brian m. carlson. Supporting cast: Jonathan
"jrnieder" Nieder, Derrick Stolee, Johannes "Dscho" Schindelin, Toon
Claes, and =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.

Notes:

 1.  Summarizing where we are with what merged:

     1. We have full SHA256 support \o/

     2. Some minor glitches, updated the docs to reflect that

     3. It works. 2.30 is a good state.

     4. None of the major forges support it yet but that will come

 2.  Interop between SHA256 repositories and SHA1 repositories

     1. Take each object we receive over the wire or create locally and gi=
ve it
        a sha1 value as well

     2. We have a giant loose object index that maps sha256-id and sha1-id
        values. Hashmap

     3. Will be changed to some tree to allow prefix mapping

     4. index-pack has to take two passes over the pack, because you can=
=E2=80=99t map
        a commit before you=E2=80=99ve mapped the tree it points to (or mo=
re generally
        can=E2=80=99t map an object before the objects it references)

     5. Fortunately blobs don=E2=80=99t point to any other objects so this=
 is
        relatively quick

 3.  Submodules are tricky

     1. They come from a different repository so we don=E2=80=99t have any=
thing to map
        to

     2. What I=E2=80=99m currently doing is requiring that the submodule b=
e present
        locally and storing the mapping separately in the superproject

     3. The mapping isn=E2=80=99t sent over the wire. That could create so=
me complexity
        around malicious histories

 4.  For the same reason we don=E2=80=99t have partial clone working

     1. Might require an on-disk format bump

     2. jrnieder: taking a step back, the hash verifies the full history v=
ia
        the Merkle tree property.

     3. However, with partial clone we already relax this: it is no longer
        verifiable, locally.

     4. Therefore, we place a lot of trust on the server.

     5. The server could tell us more information about the edge commits, =
e.g.
        SHA-1<->SHA-256 mapping

     6. Stolee: if I am sha256 client, that=E2=80=99s what I want, you kin=
d of decide
        up front what you want

     7. jrnieder: at $DAYJOB common partial clone scenario is triangular
        workflow

     8. Stolee: how likely are the multiple hosts not homogenous (all SHA-=
1, or
        all SHA-256)?

     9. brian: Valuable to be able to work in SHA256 and refer in input+ou=
tput
        to SHA-1. If someone refers to a SHA-1, you still want to be able =
to
        see what they=E2=80=99re referring to, to interact with other peop=
le, even
        though SHA-1 is insecure

 5.  Multi-pack index: doesn=E2=80=99t work, but won=E2=80=99t be hard to =
fix

 6.  We write signatures for both objects. When you =E2=80=9Cgit commit --=
gpg-sign=E2=80=9D, it
     can sign in both formats

     1. Verifies in current format

 7.  Timeframe for hosting providers moving to SHA256

     1. Dscho: should we have a multi provider meeting and coordinate that=
?
        Could be everyone waiting for others

     2. brian: cgit supports SHA256 already, allows self-hosting

     3. jrnieder: with interop, individuals can use SHA256 against servers=
 that
        only support SHA-1. Then that creates pressure for the servers to
        support SHA256 for performance reasons

     4. brian: interop doesn=E2=80=99t exist yet. If GitHub decides I work=
 on that for
        the next two months, I think I could do it. But requires the code
        getting written.

     5. Toon: we at gitlab have sha256 on our radar, but with a very low p=
rio
        https://gitlab.com/groups/gitlab-org/-/epics/794

 8.  jrnieder: Signing: very old Git versions won=E2=80=99t know to invali=
date them
     when I commit --amend. How old is =E2=80=9Cvery old=E2=80=9D?

     1. brian: somewhere between 2.20 and 2.28. In 2.20 started treating
        everything with =E2=80=9Cgpgsig=E2=80=9D at start as a potential s=
ignature.

     2. There were a couple of bugs I fixed in 2.30, working on signature
        interoperability. Tested with sha256.

     3. Updated the transition plan: in tags, the trailing signature is al=
ways
        the current signature, other ones go in the header.

 9.  Updating other hosting provider glue to support sha256

     1. jrnieder: e.g. GitHub API, UIs, =E2=80=A6. Is it hard, similar to =
the Git part,
        or a little easier?

     2. brian: hardest part is libgit2. Lots of hardcoded oids in its test=
suite

     3. Libraries tend to be the hardest piece --- e.g. Gerrit will need J=
Git
        updates

     4. Dscho: gitk also has some references to hardcoded 40-length

     5. =C3=86var: some patches on the mailing list for gitk and git-gui t=
o adapt
        them, from Carlos

     6. brian: hopefully the ecosystem learns from this experience and doe=
sn=E2=80=99t
        just hardcode 64 here :)

 10. Interop code only supports 2 algorithms. Hopefully finish this transi=
tion
     before we need the next one :)

--8323328-140266036-1634815969=:56--
