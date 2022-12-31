Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C6C4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiLaXXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 18:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaXXV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 18:23:21 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222665F7A
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 15:23:17 -0800 (PST)
Date:   Sat, 31 Dec 2022 23:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=164.ooo;
        s=protonmail; t=1672528994; x=1672788194;
        bh=odikeDdCJP8Xa1ZUHLLCadeC+tFLXe1Fg4Tpy8TT+VQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=f+75unxt5PwTwK4+zgCWVQEAroBzyTGRaVY5l9iypa86HkcHS7gjzNMgf9+/xNRBq
         TBNZHjFmG46KJH1WSlyIXXlHo0MzHT2sTG2wu1jdRN8csfF67aG4D0dlQ3qVCqg3vG
         20AvECdlDG0Pi2NWqzkBAnGTg86EG3ow12rWM8BtyI/oqrUJMtTp7cSOK2Ey4r2Lrs
         8e0OFcaljGsCa+rEjLByerqqNjJSreGelqgK4QKR0MhtcJYlwIMZ+Q22sPLGQtlNNT
         Bju3VcuhLjwLkTIidY2h0WykR14a9/uokoD40d/rdbCe6HW7V2q3Bqio7YFwnF7Yrl
         3Wgn39vfRK1OA==
To:     Theodore Ts'o <tytso@mit.edu>
From:   Filip Lipien <aaa@164.ooo>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
Message-ID: <HJUKdhucsV1Ec9xNrCRNQLPylBS-oxmEZZzqT48oYfzyQ7hWXT5Kg3R4aF4JuI2FvVz9rjR1pysm7Xx53GRogtR1zNzDvRbRSu0P2ce876A=@164.ooo>
In-Reply-To: <Y7CLVESLXqy1ZLCn@mit.edu>
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo> <Y7CLVESLXqy1ZLCn@mit.edu>
Feedback-ID: 62565958:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Incorrect. As of this writing, there are 146,090 quetions[1] tagged
> [git] on stackoverflow. Compare that to the 161,963 questions[2]
> tagged [windows], or the 2,084,537 questions[3] tagged [python].

Please remain on the topic. Read my initial sentence again. What has "tagge=
d" to do with related? And even if, the amount of 146,090 "tagged" question=
s is absolute madness. This is insane. Just look at the ratio in comparison=
 to Python, a programming language. It is crazy to assume that this is fine=
 and only proves my point. No, Git is not a complex programming language li=
ke Python, nor is it a Kernel API. It is supposed to be a user-facing tool =
made for humans.

The fact is, that Junio C Hamano is doing a terrible job as a product manag=
er. Because apparently, most users seem to have a problem with it. Why can =
this not be pointed out?

------- Original Message -------
On Saturday, December 31st, 2022 at 8:19 PM, Theodore Ts'o <tytso@mit.edu> =
wrote:


>=20
>=20
> On Sat, Dec 31, 2022 at 06:11:17PM +0000, Filip Lipien wrote:
>=20
> > There are more than one million questions on Stackoverflow related to t=
he usage of Git.
> > This is not normal.
>=20
>=20
> Incorrect. As of this writing, there are 146,090 quetions[1] tagged
> [git] on stackoverflow. Compare that to the 161,963 questions[2]
> tagged [windows], or the 2,084,537 questions[3] tagged [python].
>=20
> [1] https://stackoverflow.com/questions/tagged/git
> [2] https://stackoverflow.com/questions/tagged/windows
> [3] https://stackoverflow.com/questions/tagged/python
>=20
> The fact that there are a large number of questions in stackoverflow
> is more a measure of a tool's popularity than anything else. And if
> it's popular, it's probably because a large number of developers have
> found it to be useful.
>=20
> > Git is in its current state not a tool that's made for humans.
>=20
>=20
> It's made for developers like me, and last I checked, I'm human. :-)
> It may not be made for you, but that's OK; you don't have to use it.
>=20
> My personal opinion is that it has probably saved a net total of
> billions of dollars of developer time, for those who know how to use
> it.
>=20
> Best regards,
>=20
> - Ted
>=20
> P.S. I would commend to you Neal Stephenson's essay, "In the
> beginning was the command line". It was available for sale as a book,
> but as it was published a while back in 1999, it's since been made
> available for free download[4]. Unfortunately, because it was so
> popular, the resulting download traffic crashed his publisher's
> website, and it's no longer available there. The best place to get it
> is here[5].
>=20
> [4] https://www.nealstephenson.com/in-the-beginning-was-the-command-line.=
html
> [5] https://github.com/danielmkarlsson/library/blob/master/Neal Stephenso=
n - In the Beginning was the Command Line.pdf
>=20
> It's a short read; only 60 pages in the PDF. About midway through the
> essay, in section 11, there is a comparison made between Linux and the
> Hole Hawg, an industrial drill made by the Milwaukee Tool Company. If
> Linux is the Hole Hawg of Operating Systems, then perhaps git is the
> Hole Hawg of Source Code Management systems. If it's too much SCM for
> you; there's no shame --- you can always choose to use lesser SCM's
> for your own personal projects. :-)
