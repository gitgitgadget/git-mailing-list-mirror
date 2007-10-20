From: Jan Hudec <bulb@ucw.cz>
Subject: Re: gitk patch collection pull request
Date: Sat, 20 Oct 2007 17:32:16 +0200
Message-ID: <20071020153216.GD19521@efreet.light.src>
References: <20071019052823.GI14735@spearce.org> <18200.36704.936554.220173@cargo.ozlabs.ibm.com> <531A500E-667F-413C-BD20-D23DC817EB72@steelskies.com> <18201.60047.898077.579869@cargo.ozlabs.ibm.com> <B3349B61-995B-42D0-B777-CEA618943848@steelskies.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 17:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjGJd-0004gR-SQ
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 17:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbXJTPc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 11:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbXJTPc2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 11:32:28 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47056 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755972AbXJTPc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 11:32:27 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0F3D15729A;
	Sat, 20 Oct 2007 17:32:26 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id XDwTBbg6eHKE; Sat, 20 Oct 2007 17:32:23 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5C21E5729B;
	Sat, 20 Oct 2007 17:32:22 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IjGJE-0002JE-Ap; Sat, 20 Oct 2007 17:32:16 +0200
Content-Disposition: inline
In-Reply-To: <B3349B61-995B-42D0-B777-CEA618943848@steelskies.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61841>


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20, 2007 at 14:00:20 +0100, Jonathan del Strother wrote:
>
> On 20 Oct 2007, at 12:46, Paul Mackerras wrote:
>
>> Jonathan del Strother writes:
>>
>>> In my defense, most of that file is space indented, and the places
>>
>> Only the lines that are indented 1 level start with spaces.  Any line
>> that is indented 2 or more levels should start with a tab.
>
>>> It seems to have the whole 'tabs for code
>>> indentation, with space for alignment' rule back-to-front.
>>
>> I don't recall signing up to that rule. :)  I use 4-column indentation
>> and 8-column tabs, and my editor (emacs) handles it all automatically
>> for me.
>
>
> Ugh...  I don't usually get involved in tab/space wars, but I'm curious..=
=2E=20
> why on earth would you choose this style?

Because that's default behaviour of both emacs and vi when you set
indentation different from tabstop. Actually most of GNU software, whether =
it
uses the GNU standard indent of 2, or more, uses tabs for any indents
over 8. Probably even most unix software uses this.

Actually, even if the indent is 8, function arguments are often aligned und=
er
the open parenthesis and a tabs + spaces combination is normally used for
that as well (because, again, that's what most editors will by default do!).

> With space indentation you can make sure that everyone sees the indentati=
on=20
> as it was intended.  With tab indentation, you save space, add semantic=
=20
> meaning, and let people control how wide they want their indents to appea=
r.=20
>  This approach seems to take the worst parts of each and combine them. =
=20
> What's the benefit?

Tab stops are every 8 characters. No more, no less. Ever. This makes the te=
xt
with whatever formating you want the shortest.

> I appreciate I'm not going to convert you - this is an honest question.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGh+ARel1vVwhjGURAj2gAKDsCAg8v6yBKP948n8QL1l+nruIlQCg3yoH
z/5eeyylAhhr9qyiftB/Hks=
=j46i
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
