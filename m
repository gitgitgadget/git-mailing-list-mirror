Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0288CC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 03:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhLODwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 22:52:44 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:44343 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbhLODwo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 22:52:44 -0500
Date:   Wed, 15 Dec 2021 03:52:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639540360;
        bh=ZG4Nj5T9fbfWnbPFkdmgJxOnlCID3Hq2QcD44nUd5kE=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         From:To:Cc;
        b=V3Y6fpankKYHCc8lwjn7xua2qroFDdUdknMGp7ZvGVxMYdN6vFzSfnCFGQ4TzkvLd
         Hlr5ekuw+mzEdCPJZe23oVaMeADBm62F7EhoV1FLO6EqI2h6U46NzlsUkCpJq4wZxx
         T7yloHePj4wqdUnsWIWNL1QittV0YVQVISj16Qwh5KSFm7GbP9839DxeTlspbFV440
         EabL5qCrymhmML3UsxR0vorL6oUCZ4Y+oR1XSHoHNrKspqWQGnMRsxXky2ReyKF5E3
         Hb359EL/9X2RBhmLScFlmFuV3ZS8HYthziUSAMeBMHaSzZ1oPSeYLQx3Irj03jwPdP
         hw4ZK0QbY93JA==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim@protonmail.com>
Subject: Fw: Curiosity
Message-ID: <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
In-Reply-To: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sent this message to Junio Hamano kinda of forever ago, since then I have=
n't been able to address it or do anything about it really (I am personally=
 making a report on Git for the conclusion of my technician course so I can=
 get my certification, yada yada yada, couldn't get to it). These days I ha=
ve been reading Junio's responses on the git mailing list archive (https://=
marc.info/?l=3Dgit or rather https://marc.info/?a=3D118086005800002&r=3D1&w=
=3D4) from May to now to see if Junio said anything. Junio didn't, but I di=
d read https://marc.info/?i=3Dxmqqpmudng5x.fsf%20()%20gitster%20!%20g and k=
inda of felt that was targeted at me, or people like me at least...

`:-)  - me sweating in exasperation.

Also since then, I may have improved on my confusing line of thought, so he=
re is the past message and my current version so to speak:

------- Second attempt --------

Since Git is almost used for everything at this point, is there any intent =
on providing better support for non textual file types? Why do I say this? =
Take this game mod which I follow as example -> https://github.com/Solarius=
Scorch/XComFiles <- whenever I clone it Git takes a significant forever amo=
unt of time to download 452 MB of files whose some part, from my perspectiv=
e, isn't being delta compressed like the text files are (since, whenever re=
ading a log of what changes were made, git creates and undoes modes for all=
 binary files, some of which only changed by a pixel from one colour to ano=
ther).

From my perspective it would be interesting to enhance the effectiveness/pe=
rformance of git for such files, since some projects are very heavy on mult=
imedia that isn't hard coded and those will eventually come around to using=
 git. From a personal perspective: I pretend to create an open source game =
and track it with git, however it concerns me whether or not it might take =
forever for users to clone the repo once a few versions of a singular file =
of, perhaps, some Gigabytes in size aren't stored and compressed efficientl=
y and instead all the versions are stored in full, totalling some Terabytes=
 in storage for a few of such files.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
Wednesday, 27, May, 2021, 22:12, Jo=C3=A3o Victor Bonfim <JoaoVictorBonfim@=
protonmail.com> wrote:

> I am assuming you are the Git maintainer, therefore the message, otherwis=
e, forgive me.
> Considering the ubiquity of Git as a versioning system and my internal qu=
eries about the future of software development, specially game development,=
 is there any intent on providing support for non textual file types? What =
do I mean is that binary files, from my perspective as a user, are tracked =
in full rather than partially, which I mean is that the files are discarded=
 and replaced if they are altered when, instead, they could have the differ=
entiation between files tracked. Of course this would require several chang=
es to Git so it can interpret images and so on, but I think that it could b=
e good for software development that requires extensive multimedia use and,=
 therefore, may require that better tracking for such material is made avai=
lable.
>
> Do you understand where I want to get to?
>
> Graciously yours, Jo=C3=A3o Victor Bonfim.
