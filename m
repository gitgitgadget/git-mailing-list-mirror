Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306EAC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEA120722
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kABIUXY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgGAKj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:39:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:39721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgGAKj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593599949;
        bh=qohE4dpFsX+yUH29jkULzXwrTQxAjxb27sbm4WDhtUM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kABIUXY+XsdlbYN5Z/RcuQjY6u4fVjeGh/TKn1Ltmfz4TbuG/PN3XUp+nSWgmKYo6
         jCYUKZSRMYQXJexqfrszDpLQtkcvVb6wDDqhCh9uCXlWZmj5YsY87n/TN18JOlc0pp
         OkvnJqL7OAejVvUS2rB2lY+UuDI1azisJwJ2qydA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1izIT508qE-00sdYQ; Wed, 01
 Jul 2020 12:39:09 +0200
Date:   Wed, 1 Jul 2020 12:39:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4 1/9] fmt-merge-msg: stop treating `master` specially
In-Reply-To: <20200630150533.GF20303@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2007011237330.56@tvgsbejvaqbjf.bet>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <pull.656.v4.git.1593009996.gitgitgadget@gmail.com> <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1593009996.git.gitgitgadget@gmail.com> <20200629162003.GD20303@danh.dev>
 <nycvar.QRO.7.76.6.2006291520220.56@tvgsbejvaqbjf.bet> <20200630150533.GF20303@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-439506614-1593599949=:56"
X-Provags-ID: V03:K1:pz4PMVogn/7f3D0gXMunT4RI50LD3EaBPIQzgtTKOSz5V05z491
 AY5VLKjMPhLnSL/tus5KP6xEgmM2tnXb1VLufjYmb/zvix8FYyvp/lH9PSNjBtA7OmycgRv
 I6LluN0Qy/uHkAvli+4vzXWM8Xgdhdaj9SnCLYeLCY7z565noST+AsdtlFZl6nkOIqcp+Ha
 KXuMmed1ZjHnT9pazNprQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vBjYCTjzgtA=:oF/741H/aWnelNXNInv3Rl
 Gc2rblUPmM/o2H9Ykufl0s4M1D7O1UbE5CgEkFSXnC5aWORhN+QVlq+lQjxxXxBMY0mbF8ige
 jRUFqIM1bBagZEj02f3XJPHfdvtBGdOBVmjj6i7UOvcemNIOYMp6Bxk0XCcChXv+IWWKy5SOl
 hY5hDlcpazvYj4PuJsVeLu1gBWKI97wdkkDKDw+BAcKAKTdvGa+zso71Ub04L8IJbu0dKyUZz
 hblnWfSILH8lhoJkMLtWlGRdwuBCGsZu0uReBvFluvL+GmMzd9I/AShQywZSHNVNKSjwDYQpJ
 qh8jv0jpxcLBOwVkeccfyhYZDNkRqjXXF2L0wMbnLnFoeO+NyAq2fAA0m5zA4/G6xMavaPS4V
 p/EezR1DscnFMm874xBzP4w+i2Dx3g6N1U4HpzMpCojIk6usbSAW9Su2jUuuusfmFq0NiVPeE
 OkeibNIPeD5m69NrbhKYwmKBQUZhsQ5o2zNyjSCmiAdKWB5lnjF3NStR8/43dgkj4c0zZ+qAu
 BgsSxPMKdNIrISbRoipKzZ1gakhcZuqlLZZlsv0MKlDX7JA4iDyZmzvnMpOwBK4fImJeSmRwF
 MCfvdynKCOQo4WDc8x/Npw4mtoBVEuh7QGLYvds33lrDoO0iOKsDB/+V4CBs02GU7Z14MvqkV
 Pjcix67HDtHoVdFXcnQB9dgcfySRlxSdtcs7+Ctx9oBwxdQ7AcyQDf15dJp5F2nsTle1IduTC
 r/dstqWWGHe81RJ9/aiY7VrnLiFPWnreWMg1frnL5//b1ffND/CXmr0Sy6WtyUUvsHQE+U1MO
 3OCGV5Hoopul4XMp16o5oEpett3Gi+3o+ycxl8yLljtCAL2IJovLiquTUTHswHSqXJIwyK0AW
 KG61ELAj0ywqcrXnu/3D26X+SWQqaYPMbq/XpP2a/JUPwmTdEaqr5jSwuL6vYDkt+Du/C9koy
 tDsJtln1AKDcHvdwDFFIjvaJRbqfoa9eLGCeRHuXDXuY15+UaLIXi/YzHoZ5jT8T8GoyBg/eR
 5KgKPQH7CsjqrI0G5H/b2bfn8c7Wt0rmFR1Oe/uU6F9WJUbI390JxmYsxAQMsiaeYuw4fUwaP
 70nwPj74cumaAjndcRxXpA6DObbuS1ebebLjaVLyOM0TqZZ2hVmtp25OT9kR/w3//s0/+Nzfw
 gd5uNrQoTeC8ZO4np3i2HTfX1zUokSXk0c8jLM40v9P2Gv89PdebOUgOG6JwzgqkGMamcY6FS
 HKkSa3/knJRV2vB00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-439506614-1593599949=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Tue, 30 Jun 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2020-06-29 15:27:44+0200, Johannes Schindelin <Johannes.Schindelin@gm=
x.de> wrote:
> > > This change will also affect git-subtree test.
> >
> > Good point. The patch looks good. I wonder whether we should also addr=
ess
> > these:
> >
> > Documentation/git-rebase.txt:*   Merge branch 'report-a-bug'
> > Documentation/git-rebase.txt:* | Merge branch 'refactor-button'
> > Documentation/git-switch.txt:HEAD is now at 9fc9555312 Merge branch 'c=
c/shared-index-permbits'
> > Documentation/howto/using-signed-tag-in-pull-request.txt: Merge tag 'f=
rotz-for-xyzzy' of example.com:/git/froboz.git/
> > Documentation/howto/using-signed-tag-in-pull-request.txt:     Merge ta=
g 'frotz-for-xyzzy' of example.com:/git/froboz.git/
> > t/t7606-merge-custom.sh:*   (HEAD, master) Merge commit 'c3'
> >
> > The first three matches are in manual pages, the next two in technical
> > documentation, and the last one in a comment in one of the test script=
s.
> > So none of them are super critical, but maybe there are different
> > opinions?
>
> In _my very opinion_, I don't think it's that critical.
> We allow git merge --edit and git fmt-merge-msg -m.
> Someone may have configured their Git to remove branch name already.
> And some others may always remove the target branch manually.
> We probably don't want to introduce another master occurence.
> (For sideline watcher: Please not argue on this,
> I don't have any opinions about the word: master.)

True.

> If there're a consensus on changing those documentation,
> I won't mind to do that manual work ;)

I actually agree that it is not _really_ necessary.

> The test is a different story, since some (or most?) distro enable
> check (or test) phase for their build infrastructure.
> And, we shouldn't break their infrastructures.


Actually, the hit in t7606 is in the initial _comment_. So I highly doubt
that it would break any build infrastructure to leave it alone.

Ciao,
Dscho

> >
> > Ciao,
> > Dscho
> >
> > > We'll need this patch for subtree:
> > > ----------------8<-------------------
> > > From: =3D?UTF-8?q?=3DC4=3D90o=3DC3=3DA0n=3D20Tr=3DE1=3DBA=3DA7n=3D20=
C=3DC3=3DB4ng=3D20Danh?=3D
> > >  <congdanhqx@gmail.com>
> > > Date: Mon, 29 Jun 2020 22:56:37 +0700
> > > Subject: [PATCH] contrib: subtree: adjust test to change in fmt-merg=
e-msg
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=3DUTF-8
> > > Content-Transfer-Encoding: 8bit
> > >
> > > We're starting to stop treating `master' specially in fmt-merge-msg.
> > > Adjust the test to reflect that change.
> > >
> > > Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhq=
x@gmail.com>
> > > ---
> > >  contrib/subtree/t/t7900-subtree.sh | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/=
t7900-subtree.sh
> > > index 57ff4b25c1..53d7accf94 100755
> > > --- a/contrib/subtree/t/t7900-subtree.sh
> > > +++ b/contrib/subtree/t/t7900-subtree.sh
> > > @@ -196,7 +196,8 @@ test_expect_success 'merge new subproj history i=
nto sub dir/ with --prefix' '
> > >  		cd "$subtree_test_count" &&
> > >  		git fetch ./"sub proj" master &&
> > >  		git subtree merge --prefix=3D"sub dir" FETCH_HEAD &&
> > > -		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-=
parse FETCH_HEAD)'\''"
> > > +		check_equal "$(last_commit_message)" \
> > > +			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
> > >  	)
> > >  '
> > >
> > > @@ -273,7 +274,8 @@ test_expect_success 'merge new subproj history i=
nto subdir/ with a slash appende
> > >  		cd "$test_count" &&
> > >  		git fetch ./subproj master &&
> > >  		git subtree merge --prefix=3Dsubdir/ FETCH_HEAD &&
> > > -		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-=
parse FETCH_HEAD)'\''"
> > > +		check_equal "$(last_commit_message)" \
> > > +			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
> > >  	)
> > >  '
> > >
> > > --
> > > 2.27.0.111.gc72c7da667
> > > Danh
> > >
>
>
> --
> Danh
>

--8323328-439506614-1593599949=:56--
