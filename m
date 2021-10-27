Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73408C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EF060F56
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhJ0Onm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:43:42 -0400
Received: from mout.web.de ([212.227.17.11]:42559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237794AbhJ0Onm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635345672;
        bh=wKx0qoqEYAj3+5GlWR43GTKcmhfdtM87rdY6NuRsXzU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZcjApzrG1cFl0y5wiZiX5OIYQE1slH73V4TYsDxFibs/77XZRQ27IWG7dSdAJIfsc
         VGe94B42G2EY/6W3RhRs8SR7jlAPg9zEaHDw5sbdWqBZgd++ZRdZY/edqJFPzXyvyl
         FcPoIFXZGL8M587BWJpfSqq/LtTtdYKBDt/ahG+4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUlDP-1mExvy3Jg1-00QRs9; Wed, 27
 Oct 2021 16:41:11 +0200
Date:   Wed, 27 Oct 2021 16:41:11 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Daniel Marschall <info@daniel-marschall.de>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: git-svn bug: Output git directory has uncommitted changes
Message-ID: <20211027144111.y43o4qdp3pjp6xsh@tb-raspi4>
References: <77aacb3b44523223c7647bdae1702a31@daniel-marschall.de>
 <20211025094139.GA22377@dcvr>
 <20211026151442.65rndwsleyitxvvg@tb-raspi4>
 <5be6fa92074fb40f3167901d203941bc@daniel-marschall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5be6fa92074fb40f3167901d203941bc@daniel-marschall.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:HXW1HLUtUnzGfRS01PXm7FjgiGvQgoKG7j+QWPsjRw0T/oCJ7Rq
 M6iAvxEHbRP1vsSjQ9qYQUhytyOuydSVyWxg627ZJnll+q5zRRyXquC4hFi8sAIv8S6386I
 WziyCFeG5Gyqc4SNizL/WIUEsrV6qY3dk4sIHyK6O6XKDAWVzaMIRLDvjnttpUy1BcvbCBk
 WmCFgT8YYYmRixh6mzsxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IvinpN+ndok=:N9k9NS5DtWGKJoIX8CDHs1
 iSyzi1eFPKmejxucHkUAYDLF4IeNvhjPD9YX2jtwykTjx242IputHij38PZxuX5pe+A/UK2VO
 hh+8wEg+8u67x4SFFJh9MZtDemDh6mCCJsWNjzqboeprgkEQ2kQ76Buft8MiPbzzFhVuJHxJp
 w7cigmO8KBygwZtdbu4p7v9qPWVM6OulHETz59v4K+EHdzAwEA629vTcLYEXCikBLNfSFW868
 QB1wYKPP8a1If86lJTSa4IlnCCY4qf9yXAsbNgDv3dQT4OU8j/MSABMsbzTAy3From40Pv5fz
 sTyBVOX34QhowXlpN6TfLVP/vY1xK3fUHLiIWFwlb1+AqWS0hnWdFT86f+fB2J4v5f9BX7Rww
 9mM1pkzYUS45fNYCJ0izQ5lG/4YG8Bj2lLG4lnID8WQ4RUgZH1ipWHg06NZp3pUiwq0PEM2Fi
 IwpXUbMFoiwiTfhBHIaPtv4zsJ6AChMFc+BX6QdZ6JO88KooKU8GZesHGsXrMVqrNeVvxRX2W
 K1vIpfcYonbf7R8qULx0Wf0PcJ6foAsTTamWFj9xoiZ0XAqzfBQQE+cHfbbSnFKtBtcKv1wF6
 9KkhR2XPClIFh/nhd3KyS5XbjIboI4STfn3f+w7unTOY02jbnhVGP1h3rH64hoy0kY/zSTzmU
 k2LKYY6bbAFnkJf0L3uaai/tAa64uz/Qkzshi2P3QfzxEVEr5YtOk+zLDtA6JiHkEmQrDGVYJ
 FXd4XxqO9JNDilSsdm79JypdKYUQGKJ3l0TQF5fy6AclwpICCdrN4rGFAjx4TxpkLjriMkZe0
 Pvi3Wf7wrmi5DrWNCBoHfNL/Lv6BpGw+6OHT1+KtjBHfAph9sAiOwHyeDhQprFhnId/PGcPP1
 CoRExD4WzaCI2WNWmuJa/pUA+z+ew8RlPVf2/N0GFc2PAfBRvTIwdFEK/FfsYSqxFAZyFu45C
 NDF4uNSF2+9izuk2DcIuf+rm35qFkNkaqqJ16VrPISzkpKG435aI0YLxSX9DkAbtKhSHq8GTR
 OkWxiibEfL5AWW6clyJGtOevyLaw5N/AYU/zJWMa5PFt/GUdC8fTTqJmy2ouhJVKcA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 09:30:39PM +0200, Daniel Marschall wrote:
> Am 26.10.2021 17:14, schrieb Torsten B=F6gershausen:
> > On Mon, Oct 25, 2021 at 09:41:39AM +0000, Eric Wong wrote:
> > > Daniel Marschall <info@daniel-marschall.de> wrote:
> > > > Hello,
> > > >
> > > > I have found following bug in the latest version of git-svn . I ha=
ve this
> > > > issue with the old version shipped in Debian stable, as well as wi=
th the
> > > > latest version built from source.
> > > >
> > > >
> > > > What did you do before the bug happened? (Steps to reproduce your =
issue)
> > > >
> > > > Extract the following SVN repository to GIT:
> > > > https://svn.viathinksoft.com/svn/filter_foundry/
> > > > The bug ONLY happens with this single SVN repository. All other SV=
N
> > > > repositories from my server work perfectly.
> > > >
> > > > $ PERL5LIB=3Dperl/ ./git-svn --authors-file=3D"../../authors.txt" =
clone
> > > > --trunk=3D"trunk" "https://svn.viathinksoft.com/svn/filter_foundry=
/" "_test"
> > > > $ cd _test
> > > > $ git status
> > > >
> > > > What did you expect to happen? (Expected behavior)
> > > >
> > > > git status should show that nothing needs to be commited.
> > > >
> > > > What happened instead? (Actual behavior)
> > > >
> > > > You get a long list of files which need to be committed. The list =
is
> > > > sometimes longer and sometimes shorter. So, the behavior is not
> > > > deterministic. I have the feeling that the list often contains all=
 files in
> > > > the repo.
> > >
> > > It seems like a CRLF vs LF vs CR issue; not something I'm
> > > familiar with (not even in a git-only environment).
> > >
> > > Running `git diff --ignore-space-change` says there aren't
> > > non-space changes.
> > >
> > > The presence of a .gitattributes file in the repo could be
> > > confusing things, maybe, just a guess, I don't know...
> > >
> > > Being a *nix-only person, I've never mucked with eol=3D attributes
> > > at all.  Maybe somebody else experienced with such issues can
> > > chime in; but eol stuff seems like a minefield of complexity I
> > > don't ever want to step into :x
> > >
> > > > Anything else you want to add:
> > > >
> > > > This SVN repository was cloned from a foreign server to my own ser=
ver, and
> > > > then continued there. I think this SVN repository has some specifi=
c
> > > > properties that cause the bugs.
> > >
> > > It's been a while since I've looked at SVN stuff.  From what I
> > > remember, git-svn doesn't check the CRLF property on the SVN side.
> >
> > Good point, Eric
> >
> > After cloning the repo with git-svn, we can say that:
> > The .gitattributes file is in conflict with the files commited under G=
it
> > Run
> > git ls-files --eol
> > to see what is going on
> > [lots of output]
> >
> > To give a simpler example, run it on only one file,
> > which is changed in my clone:
> >
> > git ls-files --eol telegraphics_common/tt/wind.c
> > i/crlf  w/crlf  attr/text eol=3Dcrlf telegraphics_common/tt/wind.c
> >
> > And what does this mean ?
> > The file has CRLF in the index, CRLF in the working tree and "text"
> > These settings are conflicting.
> > The easiest solution may be to replace
> > "text" with "text=3Dauto"
> > in .gitattributes
> >
> > And, while looking at .gitignore: the "eol=3Dcr" is not supported unde=
r
> > Git:
> > *.afs text eol=3Dcr
> > (But Git does not complain)
>
> Thank you for your replies.
>
> I don't have much experience with .gitattributes, so I am not sure if I =
did
> everything correctly.
>
> What I had in mind was the following:
> I have files in my SVN repository which are CRLF, and some files are LF.
> I wanted to tell GIT which line ending the files should have
> so that they will have the exact same line endings after the repo is che=
cked
> out. I think text=3Dauto will also do this, maybe I should try that.
>
> The "AFS" files are very special, though. Due to compatibility reasons, =
they
> must be in the ancient Macintosh format (CR) otherwise the program won't
> work. Do I need to state "eol=3Dcr" then? Or will GIT automatically use =
the
> same line endings as in the files which I have added to SVN?

Git will not change files with CR as line ending:
When there is neither a LF nor CRLF; then the file is "not text".

git ls-files --eol  | grep "^i/-text"

Will list png, afs and some other.
You can remove the eol=3Dcr (it doesn't do anything useful, and it is just=
 confusing)

Better would be:
*.afs -text
or
*.afs binary

I leave it to the reader, to find out what the difference is.

>
> Thank you for your help!

Happy to help
