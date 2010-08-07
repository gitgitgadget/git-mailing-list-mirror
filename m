From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] test-lib: user-friendly alternatives to test [!] 
	[-d|-f]
Date: Sat, 7 Aug 2010 00:21:34 +0000
Message-ID: <AANLkTimiSJQPcZRZ06BamJPkd8PBkm7CaMcsKRSdEeP_@mail.gmail.com>
References: <1281027281-21055-2-git-send-email-Matthieu.Moy@imag.fr>
	<1281027831-22739-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100806225705.GA2534@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 02:21:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhXAc-00042u-4d
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 02:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0HGAVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 20:21:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57300 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab0HGAVf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 20:21:35 -0400
Received: by fxm14 with SMTP id 14so4179984fxm.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lZGR3O9lD+f2hG2bjciKHbPq8RYh0RsHH8JXZjWF6l0=;
        b=B+vFeJnmy4DGrR3/MgD5xJR/lDNhs4HfrLNeEx1u/somjJUIjfv3D8QlBQv4kJ9Izl
         uITFyzRrTJ0KCi/bl1sPMfYn21Hi4am5fmtHK3bnkNqiFqOBHxu3jKCOk7plEn2+yT3c
         YCqyzRHoyfcxFw95q18VUmd3zEVYBu+8fj/rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xkFz7vXbkNdIKh//hc9gPYTF9g1l0wQpcBwwPRgbC52cXrmmY+kz6VueXs1g7r+Jgz
         MvfGcxoSyH8cYEK5SQND/shDZa/lpi/WIwsgXv+vCdKJC4NYymnQbF+/jYWWfMuhJyl3
         7lSvEyJZ986Ma0x/wpL4CDvX0uikmuOKTEy+Y=
Received: by 10.223.105.132 with SMTP id t4mr13564676fao.75.1281140494303; 
	Fri, 06 Aug 2010 17:21:34 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Fri, 6 Aug 2010 17:21:34 -0700 (PDT)
In-Reply-To: <20100806225705.GA2534@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152832>

On Fri, Aug 6, 2010 at 22:57, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Matthieu Moy wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- test_file_exists <name> [<diagnosis>]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- test_dir_exists <name> [<diagnosis>]
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Check that <name> exists and is a f=
ile or directory,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printing a diagnostic if it does no=
t. =C2=A0The <diagnosis>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if present will be used to give som=
e added context to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the diagnostic.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- test_does_not_exist <name> [<diagnosis>]
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Check that <name> does not exist, p=
rinting a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diagnostic if it does. =C2=A0The <d=
iagnosis> will be
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printed on failure as added context=
 if present.
>
> I think the ..._must_exist names put the emphasis in the
> wrong place, and they look funny in "if" statements.

Personally I'd prefer something where I can just think in the "test"
bultin terms and still get debug info, something like (pseduocode)

    gittest() {
        test "$#" =3D 3 && { bool=3D'!'; shift; } || bool=3D
        test=3D$1; shift
        args=3D"$@"; shift
        case "$test" in
        -f)
            # Handle the common case of -f with a custom message
        ;;
        -d)
            # Same for -d
        ;;
        *)
            # Just pass a switch to test and say "test with the -X
switch", or something
esac
    }

    gittest ! -f ~/.gitconfig
    gittest -f ~/.gitconfig
    gittest -d /tmp
    gittest ! -d /tmp
    gittest -s /tmp

I'll never be able to fit more test_* functions in my brain, and I
wrote the docs :)

> Style nitpick: if statementss in the test-lib have tended to look lik=
e
>
> =C2=A0if [ foo ]
> =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bar
> =C2=A0fi
>
> so far. =C2=A0Here the whole function is a glorified "test -f", so I =
wonder
> if
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -f "$1" ] ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "file=
 $1 doesn't exist. $*"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0false
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> would not be clearer. =C2=A0I dunno.

This is the style we usually use:

    if ! test -f "$1"
    then
        echo >&2 "file $1 doesn't exist. $*"
        false
    fi

> I have often run into silent test failures of the sort your patch
> is designed to avoid. =C2=A0Thanks for tackling it.

Yeah, having more intra-test progress is definitely good. Right now I
just remove things from the tests in an ad-hoc fashion until they
start passing if they fail when I debug them.

I mentioned that we could emit these test progress reports as TAP in a
previous E-Mail. Here's how that could look like:

    $ perl -MTest::More=3Dno_plan -E '
        subtest "A git test" =3D> sub {
            pass("doing test -f file");
            pass("git commit ...");
            pass("test_tick...");
            done_testing();
        } for 1 .. 2
    '
        ok 1 - doing test -f file
        ok 2 - git commit ...
        ok 3 - test_tick...
        1..3
    ok 1 - A git test
        ok 1 - doing test -f file
        ok 2 - git commit ...
        ok 3 - test_tick...
        1..3
    ok 2 - A git test
    1..2

I.e. we could make these intra-test progress reports machine readable.

As the example shows the obvious next step would be to make other
utility functions like test_commit() emit a progress status as well.
