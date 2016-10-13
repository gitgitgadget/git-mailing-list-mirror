Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B76F1F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbcJMLNg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 07:13:36 -0400
Received: from mout-xforward.gmx.net ([82.165.159.12]:57259 "EHLO
        mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbcJMLNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 07:13:12 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LoVvG-1bERHO1rFi-00gbAN; Thu, 13 Oct 2016 13:11:52
 +0200
Date:   Thu, 13 Oct 2016 13:11:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject
 URL
In-Reply-To: <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610131255001.197091@virtualbox>
References: <20161010175611.1058-1-sbeller@google.com> <alpine.DEB.2.20.1610121501390.3492@virtualbox> <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+lNsKUbGdNQKie3AZmisQdT8F2g2UNVNV12e97/6jhM4j7REk53
 baaH1qTrRD2oK0/zVy3Fdema041INaBop57kOKuuF+o/N2O8ikT6e+MBT8Y0Oej8yBEr5Ps
 /RiN9Dc18Gs56xbNaossc7gCmSHCrz3sJI8+0arx/B6Tdi+X9L2PpRVjvohNdwHp5zyHT5B
 P3TmpHOY2D8euiB0qVxCw==
X-UI-Out-Filterresults: junk:10;V01:K0:RxOr13uQiiA=:f6R/CBRkn/N5VzkjPYHHKK8P
 D5M9Rf/zuLYmngrSU3u/71ct5xfzqljOlJ8v7Y1ceOfc5Q9gCXV0DAkJHqKXXVyNElIpFfgMB
 jkasn5VJ57Lscqfq46H3SpfECRiGZTUB7SvhF6NIHUDB+HbP7H6qU8keFvCBh6DXRar5SHX7J
 8FylpfywZlPOgV/EBNiQ1l9PIM506ZMQamXozLpHO4sq+1SAlAQorE0flARuah4IUVsyPKZzk
 RMY17Jz7U8SA8kOgznCnakLWt55ysj+yze4H6eSz4RioE67pcdo52RMaLtQxpSgN2OLdU1WQ2
 nfj7qn9fSw9eVcm13aaPCdeBEoFlu1AajNJz27V+Q1xFU9a8Kl90kVtkwprntYR5sAdcGqKI1
 TotCRUVK5eq+1sKmbRIFn3nF4GsVX3xDqfAoGQih2UY1NmHCZ/Owsr1Usi0MhXyyuaV542pQi
 X8s2DZAHF34dFmvzSgdoSwRB395jTZI9x0aFnBZ+BT2w1+cJnKUhnmVV63DbuHpgfT101ZjPe
 MxfQXg8nj78DG9LSok6JPw/mRr5njl6k7MbYCrCHD1J3ZISog5EwqZRXr97Ko4LakGsm+BzL2
 wHJMOEcPNAMXb0PEC3pgPfi3zbzg1UzsrgYuRM/htMQpc+6KMcdQo493PIF1qRoj33s8pCq8M
 LPGuZugNq6Atwl8erX4oTzXARbMH6mHKvyoOUrjDV1IQeTDeXTGcTC3FIirnyKaM1XZPe3wpT
 pqv5HWD7VrklB9vYOS3LQ3cFMyxoMdLvgUUvZNT7XJ3H/k9V4/2xP67aHofSU3OOmWL/mCMGn
 pQigJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 12 Oct 2016, Stefan Beller wrote:

> On Wed, Oct 12, 2016 at 6:30 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 10 Oct 2016, Stefan Beller wrote:
> >
> >> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> >> index 444ec06..a7841a5 100644
> >> --- a/builtin/submodule--helper.c
> >> +++ b/builtin/submodule--helper.c
> >> @@ -95,6 +95,8 @@ static int chop_last_dir(char **remoteurl, int is_relative)
> >>   * NEEDSWORK: This works incorrectly on the domain and protocol part.
> >>   * remote_url      url              outcome          expectation
> >>   * http://a.com/b  ../c             http://a.com/c   as is
> >> + * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
> >> + *                                                   ignore trailing slash in url
> >>   * http://a.com/b  ../../c          http://c         error out
> >>   * http://a.com/b  ../../../c       http:/c          error out
> >>   * http://a.com/b  ../../../../c    http:c           error out
> >> @@ -113,8 +115,8 @@ static char *relative_url(const char *remote_url,
> >>       struct strbuf sb = STRBUF_INIT;
> >>       size_t len = strlen(remoteurl);
> >>
> >> -     if (is_dir_sep(remoteurl[len]))
> >> -             remoteurl[len] = '\0';
> >> +     if (is_dir_sep(remoteurl[len-1]))
> >> +             remoteurl[len-1] = '\0';
> >>
> >>       if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
> >>               is_relative = 0;
> >> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> >> index bf2deee..82b98f8 100755
> >> --- a/t/t0060-path-utils.sh
> >> +++ b/t/t0060-path-utils.sh
> >> @@ -319,6 +319,7 @@ test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
> >>  test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
> >>
> >>  test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
> >> +test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
> >>  test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../foo/submodule"
> >>  test_submodule_relative_url "(null)" "../foo/submodule" "../submodule" "../foo/submodule"
> >>  test_submodule_relative_url "(null)" "../foo" "../submodule" "../submodule"
> >
> > I see that this already made it to `next`. I saw that because it breaks
> > the build of Git for Windows (this was not noticed earlier because other
> > compile failures prevented the tests from running), as now the test cases
> > 173 and 177 of t0060 fail (*not* the newly introduced 163).
> >
> > Here is the output with -v -x:
> >
> > -- snip --
> > [...]
> > expecting success:
> >                 actual=$(git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' '../.') &&
> >                 test "$actual" = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'
> >
> > +++ git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' ../.
> > ++ actual=C:/git-sdk-64/usr/src/git/wip/t/.
> > ++ test C:/git-sdk-64/usr/src/git/wip/t/. = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'
> 
> So this wipes away one dir too much in a test that doesn't end with a
> dir separator

The problem is not *that* simple. You see, on Windows, there are no Unixy
paths (I used to say POSIX but that is not correct, if you think of VMS
paths looking quite a bit different from what Git expects). To appease
Git's assumption about the exact form of paths, the Bash (actually, the
POSIX emulation layer called MSYS2) converts paths of the form
/c/Windows/system32/drivers/etc/hosts to
C:/Windows/system32/drivers/etc/hosts.

Please note that paths that are already in the latter form are not
touched.

And note also that URLs (actually, anything matching "^[A-Za-z]+://") are
*also* not converted.

The paths that *are* converted can also be of the form /etc/passwd, in
which case the path is prefixed with the Windows directory in which whose
usr/bin/ subdirectory the MSYS2 runtime lives.

In that latter case, i.e. Unixy paths being converted to Windows ones, the
very special case of a trailing "/." is truncated to "/" (IIRC there are
some Windows programs that do not take well to "." referring to a
directory, but my memory on that is flakey).

> (In Windows that is '/' and '\' only, no dots?)

Most Windows functions handle forward slashes just fine. Certainly all
functions involved in the code path in question.

> > One very, very ugly workaround for this newly-introduced breakage would be
> > this:
> >
> > -- snip --
> > diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> > index 82b98f8..abd82e9 100755
> > --- a/t/t0060-path-utils.sh
> > +++ b/t/t0060-path-utils.sh
> > @@ -328,11 +328,11 @@ test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
> >  test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
> >  test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
> >  test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
> > -test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
> > +test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."
> >  test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
> >  test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/repo"
> >  test_submodule_relative_url "(null)" "$PWD" "./ " "$(pwd)/ "
> > -test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/submodule"
> > +test_submodule_relative_url "(null)" "$(pwd)/." "../submodule" "$(pwd)/submodule"
> >  test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "$(pwd)/submodule"
> >  test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
> >  test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
> > -- snap --
> >
> > The reasons this is ugly: we specifically test for *Unixy* paths when we
> > use $PWD, as opposed to *Windowsy* paths when using $(pwd). We do this to
> > ensure a certain level of confidence that running things such as
> >
> >         git clone --recurse-submodules /z/project/.
> >
> > work. And now that does not work anymore.
> 
> After a while of thinking how I could fix it, it occurs to me, I could
> claim the removal of the dot as a defect in the Windows path handling. ;)

Not *quite*. It is not Windows' path handling. It is MSYS2's path
handling, and they must have had good reasons to introduce it. They do not
strip trailing dots just for fun.

> But that doesn't help users.

Exactly.

> Would it be possible to mark the last dir separator special once the
> trailing dot is removed? (i.e. put a \ there, and in this patch we
> only check for /)
> Sounds hacky to me, though.

We could claim that cloning recursively from absolute, Unixy paths is not
supported on Windows.

Given that it still works with relative paths and with absolute Windows
paths and with URLs, I would claim that this is a fair trade-off.

In which case the ugly patch quoted above may be the best way forward.

> > So where to go from here?
> 
> So IIUC this patch fixed a bug in Git and introduced a very similar bug
> in Git for Windows?

Yep. Even if it fixed the very same bug on Windows, too, as the trailing
dot is kept for URLs and absolute Windows paths.

> I have no expertise on how to deal with these path issues, but it sounds
> like this dot-stripping is done too early, i.e. you'd want to first let
> the Git part handle the URL concatenation and stuff and only at the end
> when it comes to using the path it should get the Windows treatment?

Git has no chance to fix this, as the Git executable (thanks to *not*
using the POSIX emulation layer) gets handed a Windows path without the
trailing dot when called from the Bash.

The same, obviously, goes for `git submodule-helper`: it is not using the
POSIX emulation layer, and therefore that layer converts the paths before
executing said subcommand.

And we cannot easily change the behavior of the MSYS2 runtime, as that
would affect too many other users, most likely breaking the use case that
required the stripping of the trailing dot in the first place.

So I fear that we have to live with the fact that the bug you fixed just
hid a bug on Windows, and that we have to either skip the tests or change
them in the way I proposed.

Or we change the tests to work on a URL instead of a Unixy path.

Opinions?

Ciao,
Dscho
