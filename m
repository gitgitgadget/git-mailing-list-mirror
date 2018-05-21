Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40811F51C
	for <e@80x24.org>; Mon, 21 May 2018 12:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeEUMOS (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 08:14:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:51127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbeEUMOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 08:14:14 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiHc7-1g6fmF0zyt-00nMWJ; Mon, 21
 May 2018 14:14:08 +0200
Date:   Mon, 21 May 2018 14:14:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Clemens Buchacher <drizzd@gmx.net>,
        Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 2/2] t9902-completion: exercise __git_complete_index_file()
 directly
In-Reply-To: <20180518141751.16350-3-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211340490.77@tvgsbejvaqbjf.bet>
References: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com> <20180518141751.16350-1-szeder.dev@gmail.com> <20180518141751.16350-3-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1262720431-1526904852=:77"
X-Provags-ID: V03:K1:QeGDumZmOg1t8/4jUXdZvJaGzZXh+rjFeTcjPp15/PDFtDPhl8/
 1/rzWLOwBvskHK6wQenDvucIA7jwOs5IEKmgZz/Bw1y0vBu6i15Hzd+pBEjBQGaSlXWYP7i
 GWcKWZamxXfHYvVu3/0LBmhybmJ83RdP7Bl4PTc4fbNKWRgnHb2UzRGIzPpk2VGbW3y8l5S
 aQMnoNEKSpxckrhxAE5Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v02M52kDXXE=:A59xyfPE+Lt9/+RjJWQOIi
 S8ASagTfkmZ1RQ7yPmRqzs2vzJqSsuIt9z1MXoboKh8hM5TrxaRQTO2HpNSk7LaDYEpcw7Ow1
 NM8WKhu4SWdVe19e4YXZQU1tTdxjU/R1iaWlfPx01P00+9+9bBbSvO8ODWpWwkG+cbfvS+NFy
 vw0pUmL4zEUMnozf4iUAZp3T/tRw3a7B0rdcA425vCqirvwvY7tfeZwS1hsgPdC1rX9QKs15b
 AcsCJzA7OszQYtOv8qQ5XMlbPSa1gf/XSXUV5CBzxeVNuieHVQZG9OjLowUyEzzD1ICc1gd4d
 /aNCHtPtgR9/TfP0tIqVWB7zPqyFjx+cGkF5R/aFpyEmbJjcYWFcExN0BOx+MUSbopShAmHH5
 Fh2i4Eh2dUoimX+l2w/V3SvMS/EcX/NBMlW/8sG3HEIhNgl7dZI8zt/+AqF9DmnywpRudrK4h
 xCu4yTVOwJQfo7yD0jjY1bY9RwHW6IzPxlGVlfWl7I3N/jMXnLn3vdxuATkijOal9WWU/FWOd
 AL6aSn6BFbYsWXuLp7WZFUx64CiAIXPkVC5AdLDG9Js3+RiOxJ9UO8eNdX7gNt8KdFh5lw2Ly
 gjpzeUw4vRRF4jCe/Lbs0hEaskQLcsd8kbrRWTUy3mBiyI9Q6sHkjS6ahbBDYRp9uE3V8fh0n
 FVfLw6z73CpCgTwQmWfvW7sXrZH5h+UGE/W8V0F9MnKNAkqySR8yw18B5HmkOxt6+0jbDJUXg
 sDVuX1qSwzv8yhaMjSnx0iuaL9C77HLKjqYHKfN/kj9iKZYhgjMMrnDL/C2oV1eDx4+9j35eg
 S8oEvE4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1262720431-1526904852=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Fri, 18 May 2018, SZEDER G=C3=A1bor wrote:

> The tests added in 2f271cd9cf (t9902-completion: add tests
> demonstrating issues with quoted pathnames, 2018-05-08) and in
> 2ab6eab4fe (completion: improve handling quoted paths in 'git
> ls-files's output, 2018-03-28) have a few shortcomings:
>=20
>   - All these test use the 'test_completion' helper function, thus
>     they are exercising the whole completion machinery, although they
>     are only interested in how git-aware path completion, specifically
>     the __git_complete_index_file() function deals with unusual
>     characters in pathnames and on the command line.
>=20
>   - These tests can't satisfactorily test the case of pathnames
>     containing spaces, because 'test_completion' gets the words on the
>     command line as a single argument and it uses space as word
>     separator.
>=20
>   - Some of the tests are protected by different FUNNYNAMES_* prereqs
>     depending on whether they put backslashes and double quotes or
>     separator characters (FS, GS, RS, US) in pathnames, although a
>     filesystem not allowing one likely doesn't allow the others
>     either.
>=20
>   - One of the tests operates on paths containing '|' and '&'
>     characters without being protected by a FUNNYNAMES prereq, but
>     some filesystems (notably on Windows) don't allow these characters
>     in pathnames, either.
>=20
> Replace these tests with basically equivalent, more focused tests that
> call __git_complete_index_file() directly.  Since this function only
> looks at the current word to be completed, i.e. the $cur variable, we
> can easily include pathnames containing spaces in the tests, so use
> such pathnames instead of pathnames containing '|' and '&'.  Finally,
> use only a single FUNNYNAMES prereq for all kinds of special
> characters.

Makes sense.

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 955932174c..1b6d275254 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1209,6 +1209,124 @@ test_expect_success 'teardown after ref completio=
n' '
>  =09git remote remove other
>  '
> =20
> +
> +test_path_completion ()
> +{
> +=09test $# =3D 2 || error "bug in the test script: not 2 parameters to t=
est_path_completion"

Maybe shorten this to

=09test $# =3D 2 || error "BUG: test_path_completion requires 2 parameters"

in order to keep to the 80 columns/line limit?

> +
> +=09local cur=3D"$1" expected=3D"$2"

I thought `local` was a Bash-ism we tried to avoid in the test scripts.
But I guess this file is already littered with `local` keywords...

> +=09echo "$expected" >expected &&
> +=09(
> +=09=09# In the following tests calling this function we only
> +=09=09# care about how __git_complete_index_file() deals with
> +=09=09# unusual characters in path names.  By requesting only
> +=09=09# untracked files we dont have to bother adding any
> +=09=09# paths to the index in those tests.
> +=09=09__git_complete_index_file --others &&
> +=09=09print_comp
> +=09) &&
> +=09test_cmp expected out
> +}
> +
> +test_expect_success 'setup for path completion tests' '
> +=09mkdir simple-dir \
> +=09      "spaces in dir" \
> +=09      =C3=A1rv=C3=ADzt=C5=B1r=C5=91 &&
> +=09touch simple-dir/simple-file \
> +=09      "spaces in dir/spaces in file" \
> +=09      "=C3=A1rv=C3=ADzt=C5=B1r=C5=91/=D0=A1=D0=B0=D0=B9=D0=BD =D1=8F=
=D0=B2=D0=B0=D0=B0=D1=80=D0=B0=D0=B9" &&
> +=09if test_have_prereq !MINGW &&
> +=09   mkdir BS\\dir \
> +=09=09 '$'separators\034in\035dir'' &&
> +=09   touch BS\\dir/DQ\"file \
> +=09=09 '$'separators\034in\035dir/sep\036in\037file''
> +=09then
> +=09=09test_set_prereq FUNNYNAMES
> +=09else
> +=09=09rm -rf BS\\dir '$'separators\034in\035dir''
> +=09fi
> +'
> +
> +test_expect_success '__git_complete_index_file - simple' '
> +=09test_path_completion simple simple-dir &&  # Bash is supposed to
> +=09=09=09=09=09=09   # add the trailing /.
> +=09test_path_completion simple-dir/simple simple-dir/simple-file
> +'
> +
> +test_expect_success \
> +    '__git_complete_index_file - escaped characters on cmdline' '
> +=09test_path_completion spac "spaces in dir" &&  # Bash will turn this
> +=09=09=09=09=09=09      # into "spaces\ in\ dir"
> +=09test_path_completion "spaces\\ i" \
> +=09=09=09     "spaces in dir" &&
> +=09test_path_completion "spaces\\ in\\ dir/s" \
> +=09=09=09     "spaces in dir/spaces in file" &&
> +=09test_path_completion "spaces\\ in\\ dir/spaces\\ i" \
> +=09=09=09     "spaces in dir/spaces in file"
> +'
> +
> +test_expect_success \
> +    '__git_complete_index_file - quoted characters on cmdline' '
> +=09# Testing with an opening but without a corresponding closing
> +=09# double quote is important.
> +=09test_path_completion \"spac "spaces in dir" &&
> +=09test_path_completion "\"spaces i" \
> +=09=09=09     "spaces in dir" &&
> +=09test_path_completion "\"spaces in dir/s" \
> +=09=09=09     "spaces in dir/spaces in file" &&
> +=09test_path_completion "\"spaces in dir/spaces i" \
> +=09=09=09     "spaces in dir/spaces in file"
> +'
> +
> +test_expect_success '__git_complete_index_file - UTF-8 in ls-files outpu=
t' '
> +=09test_path_completion =C3=A1 =C3=A1rv=C3=ADzt=C5=B1r=C5=91 &&
> +=09test_path_completion =C3=A1rv=C3=ADzt=C5=B1r=C5=91/=D0=A1 "=C3=A1rv=
=C3=ADzt=C5=B1r=C5=91/=D0=A1=D0=B0=D0=B9=D0=BD =D1=8F=D0=B2=D0=B0=D0=B0=D1=
=80=D0=B0=D0=B9"
> +'
> +
> +test_expect_success FUNNYNAMES \
> +    '__git_complete_index_file - C-style escapes in ls-files output' '
> +=09test_path_completion BS \
> +=09=09=09     BS\\dir &&
> +=09test_path_completion BS\\\\d \
> +=09=09=09     BS\\dir &&
> +=09test_path_completion BS\\\\dir/DQ \
> +=09=09=09     BS\\dir/DQ\"file &&
> +=09test_path_completion BS\\\\dir/DQ\\\"f \
> +=09=09=09     BS\\dir/DQ\"file
> +'
> +
> +test_expect_success FUNNYNAMES \
> +    '__git_complete_index_file - \nnn-escaped characters in ls-files out=
put' '
> +=09test_path_completion sep '$'separators\034in\035dir'' &&
> +=09test_path_completion '$'separators\034i'' \
> +=09=09=09     '$'separators\034in\035dir'' &&
> +=09test_path_completion '$'separators\034in\035dir/sep'' \
> +=09=09=09     '$'separators\034in\035dir/sep\036in\037file'' &&
> +=09test_path_completion '$'separators\034in\035dir/sep\036i'' \
> +=09=09=09     '$'separators\034in\035dir/sep\036in\037file''
> +'
> +
> +test_expect_success FUNNYNAMES \
> +    '__git_complete_index_file - removing repeated quoted path component=
s' '
> +=09test_when_finished rm -r repeated-quoted &&
> +=09mkdir repeated-quoted &&      # A directory whose name in itself
> +=09=09=09=09      # would not be quoted ...
> +=09>repeated-quoted/0-file &&
> +=09>repeated-quoted/1\"file &&   # ... but here the file makes the
> +=09=09=09=09      # dirname quoted ...
> +=09>repeated-quoted/2-file &&
> +=09>repeated-quoted/3\"file &&   # ... and here, too.
> +
> +=09# Still, we shold only list the directory name only once.
> +=09test_path_completion repeated repeated-quoted
> +'
> +
> +test_expect_success 'teardown after path completion tests' '
> +=09rm -rf simple-dir "spaces in dir" =C3=A1rv=C3=ADzt=C5=B1r=C5=91 \
> +=09       BS\\dir '$'separators\034in\035dir''
> +'
> +
> +
>  test_expect_success '__git_get_config_variables' '
>  =09cat >expect <<-EOF &&
>  =09name-1
> @@ -1469,113 +1587,6 @@ test_expect_success 'complete files' '

It made it a bit awkward to review this patch that the code was
move-edited. In this case, I cannot blame exclusively the hostile review
environment that is an email reader, but also sadly, `git show --color-move=
d
7d314073488ae81b8f5cdecb4d00a78529fa7dc3` helped only *so* much
*almost-touches-thumb-with-first-finger*.

>  =09test_completion "git add mom" "momified"
>  '
> =20
> -# The next tests only care about how the completion script deals with
> -# unusual characters in path names.  By defining a custom completion
> -# function to list untracked files they won't be influenced by future
> -# changes of the completion functions of real git commands, and we
> -# don't have to bother with adding files to the index in these tests.

We should keep the corresponding new comment also outside the function, as
it talks about the following tests inside a twice-indented code comment
inside a subshell.

> -_git_test_path_comp ()
> -{
> -=09__git_complete_index_file --others
> -}

A new test case was inserted here, in the move-edited section:
'__git_complete_index_file - simple'.

> -
> -test_expect_success 'complete files - escaped characters on cmdline' '
> -=09test_when_finished "rm -rf \"New|Dir\"" &&
> -=09mkdir "New|Dir" &&
> -=09>"New|Dir/New&File.c" &&
> -
> -=09test_completion "git test-path-comp N" \
> -=09=09=09"New|Dir" &&=09# Bash will turn this into "New\|Dir/"
> -=09test_completion "git test-path-comp New\\|D" \
> -=09=09=09"New|Dir" &&
> -=09test_completion "git test-path-comp New\\|Dir/N" \
> -=09=09=09"New|Dir/New&File.c" &&=09# Bash will turn this into
> -=09=09=09=09=09=09# "New\|Dir/New\&File.c "
> -=09test_completion "git test-path-comp New\\|Dir/New\\&F" \
> -=09=09=09"New|Dir/New&File.c"
> -'

This corresponds to the new '__git_complete_index_file - escaped
characters on cmdline' test case, which looks different by necessity: it
avoids funny file names by using spaces in file names instead.

From=20what I can see, the new version is indeed equivalent to the old
version.

> -
> -test_expect_success 'complete files - quoted characters on cmdline' '
> -=09test_when_finished "rm -r \"New(Dir\"" &&
> -=09mkdir "New(Dir" &&
> -=09>"New(Dir/New)File.c" &&
> -
> -=09# Testing with an opening but without a corresponding closing
> -=09# double quote is important.
> -=09test_completion "git test-path-comp \"New(D" "New(Dir" &&
> -=09test_completion "git test-path-comp \"New(Dir/New)F" \
> -=09=09=09"New(Dir/New)File.c"
> -'

The move-edited code is essentially testing the same, and then two more
conditions: in addition to testing with a prefix without a space, it also
tests with prefixes with a space (when trying to complete "spaces in dir",
it should not matter whether we start writing "spac<TAB> or "spaces
i<TAB>.

Good.

> -
> -test_expect_success 'complete files - UTF-8 in ls-files output' '
> -=09test_when_finished "rm -r =C3=A1rv=C3=ADzt=C5=B1r=C5=91" &&
> -=09mkdir =C3=A1rv=C3=ADzt=C5=B1r=C5=91 &&
> -=09>"=C3=A1rv=C3=ADzt=C5=B1r=C5=91/=D0=A1=D0=B0=D0=B9=D0=BD =D1=8F=D0=B2=
=D0=B0=D0=B0=D1=80=D0=B0=D0=B9" &&
> -
> -=09test_completion "git test-path-comp =C3=A1" "=C3=A1rv=C3=ADzt=C5=B1r=
=C5=91" &&
> -=09test_completion "git test-path-comp =C3=A1rv=C3=ADzt=C5=B1r=C5=91/=D0=
=A1" \
> -=09=09=09"=C3=A1rv=C3=ADzt=C5=B1r=C5=91/=D0=A1=D0=B0=D0=B9=D0=BD =D1=8F=
=D0=B2=D0=B0=D0=B0=D1=80=D0=B0=D0=B9"
> -'

This one is identical to the move-edited code (modulo the
no-longer-necessary directory/file).

> -
> -# Testing with a path containing a backslash is important.
> -if test_have_prereq !MINGW &&
> -   mkdir 'New\Dir' 2>/dev/null &&
> -   touch 'New\Dir/New"File.c' 2>/dev/null
> -then
> -=09test_set_prereq FUNNYNAMES_BS_DQ
> -else
> -=09say "Your filesystem does not allow \\ and \" in filenames."
> -=09rm -rf 'New\Dir'
> -fi
> -test_expect_success FUNNYNAMES_BS_DQ \
> -    'complete files - C-style escapes in ls-files output' '
> -=09test_when_finished "rm -r \"New\\\\Dir\"" &&
> -
> -=09test_completion "git test-path-comp N" "New\\Dir" &&
> -=09test_completion "git test-path-comp New\\\\D" "New\\Dir" &&
> -=09test_completion "git test-path-comp New\\\\Dir/N" \
> -=09=09=09"New\\Dir/New\"File.c" &&
> -=09test_completion "git test-path-comp New\\\\Dir/New\\\"F" \
> -=09=09=09"New\\Dir/New\"File.c"
> -'

The move-edited code uses BS\dir instead of New\Dir.

> -
> -if test_have_prereq !MINGW &&
> -   mkdir $'New\034Special\035Dir' 2>/dev/null &&
> -   touch $'New\034Special\035Dir/New\036Special\037File' 2>/dev/null
> -then
> -=09test_set_prereq FUNNYNAMES_SEPARATORS
> -else
> -=09say 'Your filesystem does not allow special separator characters (FS,=
 GS, RS, US) in filenames.'
> -=09rm -rf $'New\034Special\035Dir'
> -fi
> -test_expect_success FUNNYNAMES_SEPARATORS \
> -    'complete files - \nnn-escaped control characters in ls-files output=
' '
> -=09test_when_finished "rm -r '$'New\034Special\035Dir''" &&
> -
> -=09# Note: these will be literal separator characters on the cmdline.
> -=09test_completion "git test-path-comp N" "'$'New\034Special\035Dir''" &=
&
> -=09test_completion "git test-path-comp '$'New\034S''" \
> -=09=09=09"'$'New\034Special\035Dir''" &&
> -=09test_completion "git test-path-comp '$'New\034Special\035Dir/''" \
> -=09=09=09"'$'New\034Special\035Dir/New\036Special\037File''" &&
> -=09test_completion "git test-path-comp '$'New\034Special\035Dir/New\036S=
''" \
> -=09=09=09"'$'New\034Special\035Dir/New\036Special\037File''"
> -'

The move-edited code uses the file name
`$separators<FS>in<GS>dir/sep<RS>in<US>file` instead of
`$New<FS>Special<GC>Dir/New<RS>Special<US>File`, but is otherwise
identical.

Too many differences for the --color-moved code to catch, though.

> -
> -test_expect_success FUNNYNAMES_BS_DQ \
> -    'complete files - removing repeated quoted path components' '
> -=09test_when_finished rm -rf NewDir &&
> -=09mkdir NewDir &&    # A dirname which in itself would not be quoted ..=
=2E
> -=09>NewDir/0-file &&
> -=09>NewDir/1\"file && # ... but here the file makes the dirname quoted .=
=2E.
> -=09>NewDir/2-file &&
> -=09>NewDir/3\"file && # ... and here, too.
> -
> -=09# Still, we should only list it once.
> -=09test_completion "git test-path-comp New" "NewDir"
> -'

The move-edited code uses `repeated` instead of `New` and
`repeated-quoted` instead of `NewDir`. I could not spot any other
differences.

Of course, `--color-moved` had no chance here, either.

> -
> -
>  test_expect_success "completion uses <cmd> completion for alias: !sh -c =
'git <cmd> ...'" '
>  =09test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
>  =09test_completion "git co m" <<-\EOF

The move-edited code needed to insert a cleanup step at the end, because
the new directories and files need to live for more than one test case
(therefore `test_when_finished` is out of the game).

Note to self: should we ever switch to a modern test framework that allows
parallelizing tests, then these test cases need to be marked up with
@Before and @After to create/delete those directories/files.

Even if it was hard to review, I think this patch is essentially good, at
least after fixing the typo pointed out by Eric and then shortening the
long line.

Thank you for keeping on the ball!
Dscho
--8323328-1262720431-1526904852=:77--
