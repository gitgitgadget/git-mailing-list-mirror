From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] tests: Use skip_all=<reason> to skip tests
Date: Fri, 9 Jul 2010 19:14:10 +0000
Message-ID: <AANLkTilPkKI9KdEc84Zhh3Vn7_B7CYT3UDSkSv7JwGJG@mail.gmail.com>
References: <4C36ECDB.9090707@drmicha.warpmail.net>
	<1278675688-4702-1-git-send-email-avarab@gmail.com>
	<7v4og8mtpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 21:14:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXJ1q-0003MP-5T
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 21:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab0GITOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 15:14:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52758 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab0GITOL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 15:14:11 -0400
Received: by iwn7 with SMTP id 7so2510171iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AKPlDwpaM9SFloah8gjR1lqWUeGre9KzvFRIW923KAg=;
        b=NkR9CctIpXRhBnEHomLjStNXIWFbEGi3tKCAPDxEb8BtvhnwZS43rs8Pr9zMi/nN+I
         PguUt/1pDFX78OWPAF47JmzKXY8b26Z1Gu48hVxaerYcQek1kEVrYV7CwtIv56oNj8vE
         nnoQqHbjjJGBu1WEGdWVLfDJypvJPFWRA+VPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NCVZzxzuvk0ojvdgWKWMVryI/cs7GPiVfCjTH0+HSvEr8JpJWEMFFiECx/GaxX9s1y
         7dsutbEJqjvO1WGUPUPRmEoimz2n+vzEOWl/aMD4DfUjUX/kzFrSDPyYHwnuD9OTnqmn
         ncuz5G4ZPUoZnOiabmK9qvKMmXCEdiXBKSQlw=
Received: by 10.231.12.76 with SMTP id w12mr10073473ibw.87.1278702850988; Fri, 
	09 Jul 2010 12:14:10 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 9 Jul 2010 12:14:10 -0700 (PDT)
In-Reply-To: <7v4og8mtpd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150683>

On Fri, Jul 9, 2010 at 17:49, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> Change tests to skip with skip_all=3D<reason> + test_done, instead o=
f
>> using say <reason> + test_done.
>>
>> This is a follow-up to "tests: Skip tests in a way that makes sense
>> under TAP" (fadb5156e4). I missed these cases when preparing that
>> patch, hopefully this is all of them.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> ---
>>
>> On Fri, Jul 9, 2010 at 09:33, Michael J Gruber <git@drmicha.warpmail=
=2Enet> wrote:
>>> After trying out tests with prove (I like it!) I was just about to =
make
>>> a patch before I saw this...
>>
>> Great, good to know that you find the TAP support useful.
>>
>>> So, this does what it should, at least with my set of prerequisites=
=2E
>>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 08.07.20=
10 03:16:
>>>> Change tests to skip with skip_all=3D* + test_done instead of usin=
g say
>>>> + test_done.
>>>
>>> I didn't understand this at all at first, only after I was about to
>>> write that patch myself. Maybe 'with skip_all=3D"reason"' or
>>> 'skip_all=3D<reason>' etc.?
>>
>> Changed the subject + body of the patch to use <reason>
>
> That makes sense, but I am beginning to hate this skip_all business.

I'm not sure I like the interface either. It's just something that did
the job. But I do have some grand plans to make the test-lib.sh more
TAP-ish, including adding more advanced skip features.

> There is no "skip"-ness to what the variable does from the semantic p=
oint
> of view. =C2=A0In the context of test helper library whose service co=
nsists of
> counting the number of tests that succeeded, failed, and are known to=
 be
> still broken, one would expect that the word "skip" would mean it som=
ehow
> would help counting the tests that are prepared by the test author bu=
t
> were not run for some reason, but this variable is not about that (no=
te
> that I am not suggesting us to actually count and say "N tests skippe=
d").
> It is only about giving parting words at the end before the test scri=
pt
> exits.

The reason this variable exists is that there is a semantic
difference. The test-results/* aggregator that ships with Git doesn't
care about whether a passing test was a TODO test, or record the
reasons for why something was skipped. But TAP harnesses do record and
report this.

The idea is that we'll be able to set up smoke testing machines for
git, and they'll be able to report passing/failed/TODO passing/TODO
failing/skipped (why?) tests.

> The variable is not about skip_ALL either. =C2=A0In the majority of c=
ases, it
> is more like "finishing here, telling the user that we are doing so
> without running the remainder of the script", and in one case, it is =
more
> like "skipped one test, reporting after the fact".

Curiously enough, I initially called it "skip_all_remaining=3D<reason>"=
,
but thought it was too verbose. That's what it does now, anyway. Skips
all remaining tests.

> Among 63 assignments to $skip_all that are all over in t/*.sh scripts=
, the
> only ones that are not immediately followed by test_done are in
> lib-git-svn.sh (chooses one among 3 messages), lib-httpd.sh (sets a t=
rap
> before calling test_done), and t3600-rm (makes a mental note to repor=
t
> that one test was skipped long before all the tests run).
>
> I suspect that it might be much easier in the long run for test write=
rs if
> we made test_done take optional "parting words" parameter instead of =
using
> a global variable "$skip_all" and forcing them to carefully set it.

Having a magic string like you suggest is overloading the API a
bit. But my opinion differs from yours on this I suspect because I'm
trying to convey a semantic difference. I.e. the skip message isn't
just a custom "bye" message.

Rather than this:

    test_done 'skipping git svn tests, perl not available'

Which doesn't indicate that the "skipping" part is magic. Perhaps this
is better:

    test_done "bye bye now"
    test_done "skip_remaining" "can't test SVN here"

Or something. Anyway, personally I think that's overloading the API a
bit. I experimented with doing that before devising skip_all. And
decided to make test_done just work like Test::More's done_testing()
instead.

> Then we can lose special meaning to the global variable $skip_all,
> most of the scripts that currently assign to the variable do not
> need the assignments, and only the very few special cases can use
> $skip_all as their local convention to decide what optional "parting
> words" parameter to give to the test_done helper.

> The change would look something like this (I just did a few as a
> demonstration).
>
> What do you think?

That should work. Personally I don't really care what the API ends up
looking like (beyond the slight grumpiness associated with having to
amend existing code).

I just care that it's clear & concise. Which admittedly the current
skip_all=3D<reason> & test_done combo isn't a good example of.

Anyway. I suppose now is as good a time as any to share some of my
evil plans.

When I submitted the TAP series I really just did the bare minimum to
get things working. But there's a lot more that could be done.

=46or example, in the test case attached to my gettext patch I skip
tests on platforms that don't have the prerequisite locale files. But
there's no indication to the user that something is amiss.

I was planning to add support for skipping tests in the middle of the
test files, so you could do this:

    $ perl -MTest::More -E 'plan tests =3D> 4; pass "gettext stuff ok"
for 1..2; SKIP: { skip "Can not test without locale files", 2 }'
    1..4
    ok 1 - gettext stuff ok
    ok 2 - gettext stuff ok
    ok 3 # skip Can not test without locale files
    ok 4 # skip Can not test without locale files

And a TAP harness could subsequently report on how many tests were
skipped, and we might e.g. see that HP-UX is really unloved because
we're skipping 500/6000 tests or something.

This also allows for skipping tests in the middle of the file for some
reason:

    $ perl -MTest::More -E 'plan tests =3D> 6; pass "gettext stuff ok"
for 1..2; SKIP: { skip "Can not test without locale files", 2 } pass
"moo" for 1..2'
    1..6
    ok 1 - gettext stuff ok
    ok 2 - gettext stuff ok
    ok 3 # skip Can not test without locale files
    ok 4 # skip Can not test without locale files
    ok 5 - moo
    ok 6 - moo

You'll also notice that I planned the number of tests /before/ I
started running them. We don't do this now, but some tests can really
benefit from that (although I haven't spotted anything like that in
Git). At worst you'll get accurate test progress meters when running
prove.

</braindump>

> =C2=A0t/lib-git-svn.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 11 ++++-------
> =C2=A0t/t2007-checkout-symlink.sh | =C2=A0 =C2=A03 +--
> =C2=A0t/test-lib.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A05 +----
> =C2=A03 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index c3f6676..cfc0d5b 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -5,12 +5,10 @@ git_svn_id=3Dgit""-svn-id
>
> =C2=A0if test -n "$NO_SVN_TESTS"
> =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 skip_all=3D'skipping git svn tests, NO_SVN_TES=
TS defined'
> - =C2=A0 =C2=A0 =C2=A0 test_done
> + =C2=A0 =C2=A0 =C2=A0 test_done 'skipping git svn tests, NO_SVN_TEST=
S defined'
> =C2=A0fi
> =C2=A0if ! test_have_prereq PERL; then
> - =C2=A0 =C2=A0 =C2=A0 skip_all=3D'skipping git svn tests, perl not a=
vailable'
> - =C2=A0 =C2=A0 =C2=A0 test_done
> + =C2=A0 =C2=A0 =C2=A0 test_done 'skipping git svn tests, perl not av=
ailable'
> =C2=A0fi
>
> =C2=A0GIT_DIR=3D$PWD/.git
> @@ -21,8 +19,7 @@ PERL=3D${PERL:-perl}
> =C2=A0svn >/dev/null 2>&1
> =C2=A0if test $? -ne 1
> =C2=A0then
> - =C2=A0 =C2=A0skip_all=3D'skipping git svn tests, svn not found'
> - =C2=A0 =C2=A0test_done
> + =C2=A0 =C2=A0test_done 'skipping git svn tests, svn not found'
> =C2=A0fi
>
> =C2=A0svnrepo=3D$PWD/svnrepo
> @@ -46,7 +43,7 @@ then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0skip_all=3D'Pe=
rl SVN libraries not found or unusable'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> - =C2=A0 =C2=A0 =C2=A0 test_done
> + =C2=A0 =C2=A0 =C2=A0 test_done "$skip_all"
> =C2=A0fi
>
> =C2=A0rawsvnrepo=3D"$svnrepo"
> diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.s=
h
> index 05cc8fd..fd3d7be 100755
> --- a/t/t2007-checkout-symlink.sh
> +++ b/t/t2007-checkout-symlink.sh
> @@ -8,8 +8,7 @@ test_description=3D'git checkout to switch between br=
anches with symlink<->dir'
>
> =C2=A0if ! test_have_prereq SYMLINKS
> =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 skip_all=3D"symbolic links not supported - ski=
pping tests"
> - =C2=A0 =C2=A0 =C2=A0 test_done
> + =C2=A0 =C2=A0 =C2=A0 test_done "symbolic links not supported - skip=
ping tests"
> =C2=A0fi
>
> =C2=A0test_expect_success setup '
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ac496aa..2c4474d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -657,12 +657,9 @@ test_done () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$test_failure" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A00)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Maybe print SKIP=
 message
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ -z "$skip_all" ]=
 || skip_all=3D" # SKIP $skip_all"
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test $test_=
external_has_tap -eq 0; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0say_color pass "# passed all $msg"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 say "1..$test_count$skip_all"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 say "1..$test_count${1:+" # SKIP $1"}"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test -d "$remo=
ve_trash" &&
>
