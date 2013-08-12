From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Mon, 12 Aug 2013 10:11:25 +0200
Message-ID: <520898AD.8030406@googlemail.com>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com> <1376072305-15255-3-git-send-email-stefanbeller@googlemail.com> <20130809200101.GX14690@google.com> <7vr4e230g8.fsf@alter.siamese.dyndns.org> <7vd2pj1gto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigED7726B6907028DE1ED0934E"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 10:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8nDw-00043t-7L
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 10:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab3HLILX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 04:11:23 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:65425 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab3HLILU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 04:11:20 -0400
Received: by mail-we0-f173.google.com with SMTP id x55so5178244wes.4
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=8hZ5581X7hTvf8N9sf6AhzbnM20uvtIXJA89V0T7nZE=;
        b=RqrkhhIqnNapAST63Y5rzA4G9jIMMKtfocbYP3RiLEXsn5yESNDJN/yjV4C6Tz6Umt
         QZA36ymuUecznKIcm/zXkzpwlgCFnRrr7wvTbHuAfq8rQJ2oyaEwONfwZkRCVFDv1gn/
         xEt4xxgJppyqldvM8XFyJvxvfWGsmPgMxeBisiXXf/4SyHJTwiAAO0IyycdS50rYadC3
         fUXJYaJy24vB44beyvjKlG6HKelVzWePhsMXBmvsNQW+TZZObmasazlAPN2TI/VnBr38
         GtQpsAsQ2234H3xNuUmwG1lZFOzLUeJMkYLwQR9ZxbdO35ME9yEOLIDnuoMiZg+ScLx4
         WpuQ==
X-Received: by 10.194.122.168 with SMTP id lt8mr425468wjb.76.1376295078276;
        Mon, 12 Aug 2013 01:11:18 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id ee5sm14666099wib.3.2013.08.12.01.11.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 01:11:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <7vd2pj1gto.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232174>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED7726B6907028DE1ED0934E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2013 09:58 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> I'd suggest using the lavabit address unless we hear the preferred
>> address from her, as the lavabit address was used in 5bf46841
>> (git-gui: update Japanese translation, 2010-02-02), while the last
>> use of the bluebottle address was in 6762079a (Cloning from a repo
>> without "current branch", 2007-06-16).
>=20
> So with the above, and the four responses from long-lost friends,
> here is what I came up with.
>=20
> -- >8 --
> Subject: .mailmap: update long-lost friends with multiple defunct addre=
sses
>=20
> A handful of past contributors are recorded with multiple e-mail
> addresses, all of which are undeliberable.  With a lot of help from
> Jonathan, we located all of them except for one.  Update the found
> ones with their currently preferred address, and use the last known
> address to consolidate contributions by the lost person under a
> single entry.
>=20
> Helped-by: Stefan Beller <stefanbeller@googlemail.com>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  .mailmap | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index f7cc21e..7a5d0a6 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -18,6 +18,8 @@ Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff=
@gmail.com>
>  Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
>  Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
>  Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> +Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
> +Amos Waterland <apw@debian.org> <apw@us.ibm.com>
>  Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
>  Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
>  Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
> @@ -34,6 +36,8 @@ Dan Johnson <computerdruid@gmail.com>
>  Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
>  Dana L. How <danahow@gmail.com> Dana How
>  Daniel Barkalow <barkalow@iabervon.org>
> +Daniel Trstenjak <daniel.trstenjak@gmail.com> <daniel.trstenjak@online=
=2Ede>
> +Daniel Trstenjak <daniel.trstenjak@gmail.com> <trsten@science-computin=
g.de>
>  David Brown <git@davidb.org> <davidb@quicinc.com>
>  David D. Kilzer <ddkilzer@kilzer.net>
>  David K=C3=A5gedal <davidk@lysator.liu.se>
> @@ -68,11 +72,17 @@ J. Bruce Fields <bfields@citi.umich.edu> <bfields@p=
ig.linuxdev.us.dell.com>
>  J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>=

>  Jakub Nar=C4=99bski <jnareb@gmail.com>
>  James Y Knight <jknight@itasoftware.com> <foom@fuhm.net>
> +# The 2 following authors are probably the same person,
> +# but both emails bounce.

You seemed to be sure about Nanako Shiraishi for example,=20
but here you're uncertain, whether he is one person=20
or 2 persons having the same name?=20
I, as a really new contributor, tried a very conservative approach=20
as specially the mailmap is a sensitive field.
So in case you'd know he is one person with just different emails, maybe
we could write=20
+Jason McMullan <jason.mcmullan@timesys.com> <mcmullan@netapp.com>
as it doesn't matter which email comes first (both bounce anyway).


> +Jason McMullan <jason.mcmullan@timesys.com>
> +Jason McMullan <mcmullan@netapp.com>
>  Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
>  Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
>  Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
>  Jeff King <peff@peff.net> <peff@github.com>
>  Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
> +Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
> +Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
>  Jim Meyering <jim@meyering.net> <meyering@redhat.com>
>  Joachim Berdal Haga <cjhaga@fys.uio.no>
>  Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@=
gmx.de>
> @@ -144,7 +154,7 @@ Michele Ballabio <barra_cuda@katamail.com>
>  Miklos Vajna <vmiklos@frugalware.org> <vmiklos@suse.cz>
>  Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
>  Namhyung Kim <namhyung@gmail.com> <namhyung@kernel.org>
> -Nanako Shiraishi <nanako3@bluebottle.com>
> +Nanako Shiraishi <nanako3@lavabit.com> <nanako3@bluebottle.com>
>  Nanako Shiraishi <nanako3@lavabit.com>
>  Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
>  Nelson Elhage <nelhage@mit.edu> <nelhage@ksplice.com>
> @@ -177,6 +187,8 @@ Robert Fitzsimons <robfitz@273k.net>
>  Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
>  Robert Zeh <robert.a.zeh@gmail.com>
>  Robin Rosenberg <robin.rosenberg@dewire.com> <robin.rosenberg.lists@de=
wire.com>
> +Rutger Nijlunsing <rutger.nijlunsing@gmail.com> <rutger@nospam.com>
> +Rutger Nijlunsing <rutger.nijlunsing@gmail.com> <git@tux.tmfweb.nl>
>  Ryan Anderson <ryan@michonline.com> <rda@google.com>
>  Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
>  Sam Vilain <sam@vilain.net> <sam.vilain@catalyst.net.nz>
>=20

Ok, I've got more responses, which will follow in the next mail.


--------------enigED7726B6907028DE1ED0934E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSCJi0AAoJEJQCPTzLflhqayUP/2XMSxMPxHG+SqzGgFVXzfaF
jvkQRnNWlBbChXFKvAKrJt/2gHRYGXlbiIITv3+ptDCntd7lYBowEyWpznCghanF
UKG4Ehc9A4bKDKuADXi8oX29OXU2yG+mMo363UZLWJRkEFQymsdigENi3AakF6oO
gBQhgMUQkPcFnrfrLSoRuAGuu3fnKoNZ/0Ux1SUdJdoWPZ8VW5eI1cxVtbtenhSA
3ZZkfise+FMS8Zupq+mCauzfCT9TWThtXYihN0lChroOx3yHbYJ2IPazg91ZI1dZ
lPPKrp/sRc7siFm4t5PMz3o/ghKPVAocrmSjnXDXNakW8vO0MSbvvJPMhaS86Ifj
Xdu4FsUJ+kYqKiG+/LyVt3iSfTSUzHT0Ep6JXV5c0j6IwT7nKIpqbSG5uwPFNMzM
tsb3NQOwwlWs8ttI4orVGN0NN9JBzdsahEArj1s22vK36Gpp1MDvAPGlRscTaF9R
rcqtH29EFPgc8dMcrxqvND/KxinSRQ5JrbpdM6guSckbvUaBkWLH+NWcCLDGVYEf
ts19YUpbwRxeAdE85OJW4URmnCTL+myoQQRoorbM0tlVhNt7a8KjH2S8TubJPkkH
uBI5t33PWyFnYIWRKGSUFEhFmL0nLHnCKd/KzoLgfzbTuzz7RjqjQiIUR4aDcZuZ
6FrCD/qpmSkPpeCbVhLC
=o30k
-----END PGP SIGNATURE-----

--------------enigED7726B6907028DE1ED0934E--
