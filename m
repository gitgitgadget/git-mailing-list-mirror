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
	by dcvr.yhbt.net (Postfix) with ESMTP id 292C51F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfJVX2Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:28:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:48087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfJVX2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571786897;
        bh=JlHKZNUOC/lZho+7mKK/MOnG3s8HZqSeCYxaTpMaOA8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XoSAucYtEBNoxiiyJhzDNMW+HfI4Zsr4hkrO2U1qVnxok19Zha8kjJndMPpsdzObF
         rrkwc33QiXP6XPY9EzRCX1Kf7SSghKkWTa1m/+Qnu9jge8gM1OiAw0c9u8/Mq4fWNh
         lqj5zqjHnicafBt2JMJNlXdBTXHDNQ1fy7Hnkqc0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1hlWtl1fj6-00bbuU; Wed, 23
 Oct 2019 01:28:17 +0200
Date:   Wed, 23 Oct 2019 01:28:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] ci(osx): use new location of the `perforce`
 cask
In-Reply-To: <xmqqeez6n8j7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910230123540.46@tvgsbejvaqbjf.bet>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com> <pull.400.v2.git.1571316454.gitgitgadget@gmail.com> <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com> <20191018105143.GY29845@szeder.dev>
 <xmqqeez6n8j7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1209363107-1571786899=:46"
X-Provags-ID: V03:K1:NgP8a6FTZBZdO93obvy1t0UGx91u9w2NJDI+a99EJD+57u2+FAb
 opBOhK5HSTOkRpNLUoYnVaLRvAaL0LlKCnvrFbu1WguVGIaDS+Fc+6ew6ZID+oo/IGfLymb
 TZ/beJaWRXIjV5Pdef9Y4NYijloNBJOGn1E1g6Wk8UDGZvmNoFcGTsHaQbNM46To6RA5SPC
 vQ8dP6FWKQrW46EbSIpLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pQkO/B44wqk=:E9uthlgjwynpgUp34bnX/P
 hA6y6tMN1TCf2vo36knXr39uyhiogOgCIq0eeP9faChvfN/7KC5mC6/Le5NE9OL1IxMYgGKlF
 MxkuWBdqp9n/9ynljVbKXUvHDLrYcU+zvoSj9BlBD0qGeN0udyLYcvTdo1jdwUDMjoovStiOZ
 CCWGQ/uK28sBKcgId2yciRRph7NwlpDyHPJ6TLAhLSkxwzWp2gbwf8bu43kCQKwLYFkby/xsZ
 u+9cN/X4C8S0t21qNBoXE2Fc30FQURNNGLp6knOUeWuHO7O8wGTLCTRwi+yCrnApSDKrpQ7Pz
 kXJ04iQbWvW9CnfhdCXJ8CM5TYPAkvr9kNgVp4F/CmapBf7Ze8WgxFstMwwpAlMPCNHVABtui
 QOzuX4jfzKgriFulwwklN+Y5yrnf/0wamaOtJhCm8lqI3i7Dez6cqITzfrNOZzHBaUeNbompC
 5Wu6yVC6AMTuewQkdu+fnwrM95jto38vxU2AICXZl1lbftuGMIWrOuTKfjLQKHIIkI8xYNa4v
 jbALSKHkPazeQsmuKgWixZlmiejiik/kSJeYT34T8f0Y21wZZlzKr87gYY0E97mafB2pqacue
 q4ZRQ8anE8fEOg/03x5fuzORfgsIlJ1Kmo3yj52IS9+Dpp0tAMF7axEjctgZHFizEolq/UD9a
 f0l2LHderseMa2kpw8rTci2fI+/akGwC54eNkfXJw5gSZu3MXcedxSXCiZ37CO0AS5f1Kr8kO
 ywCYB52xiPB3hk1gl6ET2Ln572AvpY99LE8VdrG4Lch/rPUjlCNyUynZD+pZsQzGxP0gC2onn
 8yzcW0XU37h9vyOHODqdekGZ4VnCYN+R52MNZaawfVfD2OfC2UICwb1lu1p2JR5tQfXTXq3nn
 PHfFnqzOtlHU6uUh+7nitzR+efPYywgj1TZ4P311t5eNQhYj/fz331+Tey96GQtBrtTZ8b4pr
 rJ+9L16alhzk5VyKcwirZQhlZswik/32wP9Un8h+RI9cQcJowwso0FarMX2ehunMvgyJnnnci
 GDP5x+laG1503j2JbKGww/7h3EdyvjmFyeixrx4lCIZxZ3jzFJN+XTudDQdgn6pA+QqTOUjJE
 jdP4Fyn9hvcaHJiBOPd+HGbz53DugNulCA8GOCTsgUCB6l6EqGGx6JUZlsQENPnDEI+zzp+xl
 FnZtFb8SIp6nsvR8NnULI2PT9sZgaDJoilZCTXSKqmQbGDnyyL+y7YZ8mqJTj9718q3efYNwM
 dg3inQkoPycQGhInkKdWcWii0DCfGLthH3FDBeGxT49+Nc1gwA8rYMN8mMSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1209363107-1571786899=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 21 Oct 2019, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > On Thu, Oct 17, 2019 at 12:47:33PM +0000, Johannes Schindelin via GitG=
itGadget wrote:
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> The CI builds are failing for Mac OS X due to a change in the
> >
> > s/CI/Azure Pipelines/
> >
> > Our Travis CI builds are fine.
> >
> >> location of the perforce cask. The command outputs the following
> >> error:
> >>
> >>     + brew install caskroom/cask/perforce
> >>     Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
> >>
> >> So let's try to call `brew cask install perforce` first (which is wha=
t
> >> that error message suggests, in a most round-about way).
> >>
> >> The "caskroom" way was added in 672f51cb (travis-ci:
> >> fix Perforce install on macOS, 2017-01-22) and the justification
> >> is that the call "brew cask install perforce" can fail due to a check=
sum
> >> mismatch: the recipe simply downloads the official Perforce distro, a=
nd
> >> whenever that is updated, the recipe needs to be updated, too.
> >
> > This paragraph is wrong, it mixes up things too much.
> >
> > Prior to 672f51cb we used to install the 'perforce' _package_ with
> > 'brew install perforce' (note: no 'cask' in there).  The justification
> > for 672f51cb was that the command 'brew install perforce' simply
> > stopped working, after Homebrew folks decided that it's better to move
> > the 'perforce' package to a "cask".  It was _their_ justification for
> > this move that 'brew install perforce' "can fail due to a checksum
> > mismatch ...", and casks can be installed without checksum
> > verification.  And indeed, both 'brew cask install perforce' and 'brew
> > install caskroom/cask/perforce' printed something along the lines of:
> >
> >   =3D=3D> No checksum defined for Cask perforce, skipping verification
> >
> > It's unclear to me why 672f51cb used 'brew install
> > caskroom/cask/perforce' instead of 'brew cask install perforce'.  It
> > appears (by running both commands on old Travis CI macOS images) that
> > both commands worked all the same already back then.
> >
> > Anyway, as the error message at the top of the log message shows,
> > 'brew install caskroom/cask/perforce' has stopped working recently,
> > but 'brew cask install perforce' still does, so let's use that.
> >
> > Note that on Travis CI we explicitly specify which macOS image to use,
> > and nowadays we don't run 'brew update' during the build process [1],
> > so both commands work in our builds there.
> > ...
> > Now, let's take a step back.
> >
> > All 'brew cask install perforce' really does is ...
> > ... in fact, that's what we have been doing in some of our Linux jobs
> > since the very beginning, so basically only the download URL has to be
> > adjusted.
>
> This is already in 'next' X-<; reverting a merge is cheap but I
> prefer to do so when we already have a replacement.

I force-pushed (see https://github.com/gitgitgadget/git/pull/400), and
once Stolee approves, he will submit v3. This will only change the
commit message, though, as I disagree that hard-coding the URL would be
an improvement: the nice thing about a package management system is that
the user does not need to know the details (or need to know if the
details change, like, ever).

Ciao,
Dscho

>
> Thanks for taking a closer look.
>

--8323328-1209363107-1571786899=:46--
