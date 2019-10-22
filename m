Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7BD11F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbfJVXXt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:23:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:39067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfJVXXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571786619;
        bh=z5A9TTRc+Dqwriw2RN4KqP8XYK/dEgUqmj6LYW2emA8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TyTRqvt1cJr3owGnKOOmCMnoEAW4dqu7/iy1uQOxi6npboVDdcLorcDSs/XGuf+p2
         ff8UWElDToSIPzCkCghLu3YmF9c1nKv3kKGDNeLj2z229uSBCv6oyZEVAndc146+yZ
         uJgCznVchToErDNMboOZn/dLDrierMAk2UxHoF9g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1hopCp1i84-00h9BA; Wed, 23
 Oct 2019 01:23:39 +0200
Date:   Wed, 23 Oct 2019 01:23:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] ci(osx): use new location of the `perforce`
 cask
In-Reply-To: <20191018105143.GY29845@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1910222120090.46@tvgsbejvaqbjf.bet>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com> <pull.400.v2.git.1571316454.gitgitgadget@gmail.com> <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com> <20191018105143.GY29845@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-104843895-1571786621=:46"
X-Provags-ID: V03:K1:tAP8Iwqb49baCzlx9F8HzxmUUafaEvmFvYxuIAZF6QjpsMLZSuu
 eW7GOwC6KtajEHV4Rf2TcBXXxOQwjVWVA2Z2kYvdbo0FnWOqgnEQ6fR4/QOFy5e+LZIYHX8
 kIPBJinQsW6U2amDQRBCgOciM4W998xz7xOaQh9NI292170bKeFVT9bg+DqPEeTZS4++Y9S
 BVqRC7Vs0vJXdSvKmffCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RoemOYV1UCI=:Wi+6L9mc4jsNyJNm23eHV4
 NDPBs1P993wlmo+ft/VCBM3yJIhoeI8tRsoyqJffea9SoKH70BOBgwPuDgz7M5Uz8gm1RCIPS
 yWzk6AkHAl0VrWEQEWqvJLTf4GIkovQiH6RFlpBmtLEAbJwFtacxqUJR/oiTGly0mizSEIZ43
 bXeziGYNQFVL/dtOAlP5ZVhVvsHnkxErjolb0LETXRTfRmR8NUm5syDRrosdrMmb3GR780vtC
 g2nPWYDX9lBxr4LeejQJ7t+a3OVYwryaY1w0BAV0DJWkvUkqOw3XNn9buBPmsqpZetQ45MRvi
 DwRzGaDOW4eqW/pbl1Ug90eHjeEj3WUOmvquhXD2shUALtiOBN95f1/mCh8BS0XsCMa9LvctJ
 O+1YnaX9FrqI0NL2JexyUD9tIADGU1ke9/0pH2bNfayl1+8CbEnKK5Ywm+c5JfFuUXCmlp0Vk
 yh/oCvdPZhRB6oWK4tOwHjw1kfxwX7C6EbiLD+poFAbzscZhxQs6nXiL1osI7+55xlRPWSevy
 Q7Zx6K4drbDy9bvPho5xlIwj35nY/QFFWwi3x98JnAQJCHv/wlio2LeJ/VJZfNqZMCfy0zxc+
 xrxCJgWgKgpGRUXtEeUjshL/2p6EyVp6S96LSfgLsL6HyMhFGCI1y4kUXlrNyIOJ4BoUR7zs+
 sgi7yb0qgJT88TNOq99M0TNOaA6yBmY+riW7EtxnYFVn+F31JTHh1pCMUdSyI2unZIBBw6rbj
 5sbDJSFaHkXntGUAEfS5yz4KTM0k+CjG+Sp9IkjNwHJtrjBsxSwhv21P8ua0FDvvgGKpMMjsI
 Xu3l9VHk9PkNRLT0GyQ4OwlEKfvgXJrv+U9mqPiMuoFuIFBkzJCaC2BD15hzm4Wtn43FhHKDL
 BhttaiLRcuIUqTrOVKPfkCsY6V2GPPyO2M5PwbCVyId5lHgs1I5FLI/pYLNh2cYsGgSBkQVXe
 UDImLaB5ui5aP5+ckLyBnpsr/SSF/uUyCFaeg/jLzlwDAbXDV2jT4I9hAUmRNXdCzQHiQvwp5
 EGUY6/lO+8GClQuF1MFaXsLUrlxja1hMOTrjdxzVY32N/Sl6k8n5n1n3OvCamwRtUjs/b4191
 j3V1BBma1bS/0yjj78ABMatN8tZzE3F68WJjqtND4X5hWjA3tUecTHVkHPXOofXbFOPVUcx+3
 bnNiipyqXwbTUheYJEu+9QrSBi+CkswlNZetjjovKbQWq6AI+m5vP4/lH1UxfJGLycCzHQdgK
 /fLl84w/4XCcj/gHVMhki9gwl4+ik7GXtLdhr6g6OrjTSKTC7RJzrO/kcCcw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-104843895-1571786621=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 18 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Thu, Oct 17, 2019 at 12:47:33PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The CI builds are failing for Mac OS X due to a change in the
>
> s/CI/Azure Pipelines/
>
> Our Travis CI builds are fine.

For the moment ;-)

> > location of the perforce cask. The command outputs the following
> > error:
> >
> >     + brew install caskroom/cask/perforce
> >     Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
> >
> > So let's try to call `brew cask install perforce` first (which is what
> > that error message suggests, in a most round-about way).
> >
> > The "caskroom" way was added in 672f51cb (travis-ci:
> > fix Perforce install on macOS, 2017-01-22) and the justification
> > is that the call "brew cask install perforce" can fail due to a checks=
um
> > mismatch: the recipe simply downloads the official Perforce distro, an=
d
> > whenever that is updated, the recipe needs to be updated, too.
>
> This paragraph is wrong, it mixes up things too much.
>
> Prior to 672f51cb we used to install the 'perforce' _package_ with
> 'brew install perforce' (note: no 'cask' in there).  The justification
> for 672f51cb was that the command 'brew install perforce' simply
> stopped working, after Homebrew folks decided that it's better to move
> the 'perforce' package to a "cask".  It was _their_ justification for
> this move that 'brew install perforce' "can fail due to a checksum
> mismatch ...", and casks can be installed without checksum
> verification.  And indeed, both 'brew cask install perforce' and 'brew
> install caskroom/cask/perforce' printed something along the lines of:
>
>   =3D=3D> No checksum defined for Cask perforce, skipping verification
>
> It's unclear to me why 672f51cb used 'brew install
> caskroom/cask/perforce' instead of 'brew cask install perforce'.  It
> appears (by running both commands on old Travis CI macOS images) that
> both commands worked all the same already back then.
>
> Anyway, as the error message at the top of the log message shows,
> 'brew install caskroom/cask/perforce' has stopped working recently,
> but 'brew cask install perforce' still does, so let's use that.

If you don't mind, I am going to copy/edit these three paragraphs into
the commit message,

> Note that on Travis CI we explicitly specify which macOS image to use,
> and nowadays we don't run 'brew update' during the build process [1],
> so both commands work in our builds there.
>
> [1] f2f4715033 (ci: don't update Homebrew, 2019-07-03)
>
> > CI servers are typically fresh virtual machines, but not always. To
> > accommodate for that, let's try harder if `brew cask install perforce`
> > fails, by specifically pulling the latest `master` of the
> > `homebrew-cask` repository.
>
> Homebrew didn't record a checksum for Perforce versions r17.1, r17.2
> and r18.1, so installing those still works fine.  Our Travis CI images
> install r18.1.
>
> However, when Homebrew updated to Perforce r19.1, they included the
> checksum again for some reason (intentional or accidental; I didn't
> look why).  This worked fine for a while, until a couple of days ago
> Perforce updated the r19.1 binaries in place, breaking those
> checksums.
>
> If we were to still run 'brew update', then it would shortly fix the
> checksum mismatch.  But we don't run it, and we do not want to run it
> because it takes ages.  Falling back to pull from the 'homebrew-cask'
> repository could be a reasonable and quick workaround.

Okay, good.

> > This will still fail, of course, when `homebrew-cask` falls behind
> > Perforce's release schedule. But once it is updated, we can now simply
> > re-run the failed jobs and they will pick up that update.
>
> In our CI builds we don't at all care what the checksums of the
> Perforce binaries are, so I would really like to tell 'brew' to ignore
> any checksum mismatch when installing 'perforce'.  Alas, it appears
> that 'brew' has no public options to turn of or to ignore checksum
> verification.

Sad, yet true, that we indeed have no command-line option to say "you
know what, your checksum possibly mismatches, but we really don't care".

> Now, let's take a step back.
>
> All 'brew cask install perforce' really does is run 'curl' to download
> a tar.gz from the Perforce servers, verify its checksum, unpack it,
> and put the executables somewhere on $PATH.  That's not rocket
> science, we could easily do that ourselves; we don't even have to deal
> with a tar.gz, the 'p4' and 'p4d' binaries for mac are readily
> available for download at:
>
>   http://filehost.perforce.com/perforce/r19.1/bin.macosx1010x86_64/
>
> And, in fact, that's what we have been doing in some of our Linux jobs
> since the very beginning, so basically only the download URL has to be
> adjusted.

I'd rather not.

Just because there is no better way on Linux, and just because the
current `perforce` cask recipe happens to just download and unpack that
file does not mean that this won't change.

And if it changes, we will be a lot better off by using the provided
package.

As I wrote here:

> > As for updating `homebrew-cask`: the beginnings of automating this in
> > https://dev.azure.com/gitgitgadget/git/_build?definitionId=3D11&_a=3Ds=
ummary
> > will be finished once the next Perforce upgrade comes around.

I am quite willing to do my share to keep the Homebrew recipe for
`perforce` up to date. We'll all be better off that way.

Ciao,
Dscho

> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  ci/install-dependencies.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 85a9d6b15c..ce149ed39c 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -40,6 +40,11 @@ osx-clang|osx-gcc)
> >  	test -z "$BREW_INSTALL_PACKAGES" ||
> >  	brew install $BREW_INSTALL_PACKAGES
> >  	brew link --force gettext
> > +	brew cask install perforce || {
> > +		# Update the definitions and try again
> > +		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask p=
ull &&
> > +		brew cask install perforce
> > +	} ||
> >  	brew install caskroom/cask/perforce
> >  	case "$jobname" in
> >  	osx-gcc)
> > --
> > gitgitgadget
>

--8323328-104843895-1571786621=:46--
