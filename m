From: Evan Driscoll <driscoll@cs.wisc.edu>
Subject: Re: Feature suggestion: new 'git add -i' command to discard working
 copy changes
Date: Tue, 18 Dec 2012 16:10:34 -0600
Message-ID: <50D0E9DA.1020408@cs.wisc.edu>
References: <50D0DA19.5030606@cs.wisc.edu> <7vvcbzdoy9.fsf@alter.siamese.dyndns.org> <20121218215914.GB1806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig95BF9ED3351DDE5987F5CED8"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl5NS-0000xS-HE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 23:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab2LRWKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 17:10:45 -0500
Received: from sandstone.cs.wisc.edu ([128.105.6.39]:34827 "EHLO
	sandstone.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab2LRWKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 17:10:43 -0500
Received: from hank.cs.wisc.edu (hank.cs.wisc.edu [128.105.14.80])
	by sandstone.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id qBIMAdFA018311;
	Tue, 18 Dec 2012 16:10:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.11) Gecko/20121116 Thunderbird/10.0.11
In-Reply-To: <20121218215914.GB1806@sigill.intra.peff.net>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211792>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95BF9ED3351DDE5987F5CED8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/18/2012 03:59 PM, Jeff King wrote:
> I always assumed nobody really used the full "add -i", but maybe it is
> because I am such a command-line snob. Evan, are you after hunk
> selection (like choosing "patch" from the interactive UI), or full path=

> selection?

Mostly the latter.

I have two use cases of 'add -i'. The more common one is if I kind of
want -p but don't want to do it for every file. (I guess in part this is
my way of substituting for not knowing all the actions during -p as
well.) But I sometimes use it if I want to stage several but not all
files, as it's often faster for me to just choose the files I want from
the interactive add's list than it is for me to type each of the files
that I want (even with tab completion) -- I'm often working in a project
with unfortunately-deep paths.

What I want for my 'discard' action is more like the latter: I'd like a
fast way to choose a file(s) to discard without having to type the path(s=
).


Maybe I should just investigate tig or another front end; that might
satisfy my desire.

Evan


--------------enig95BF9ED3351DDE5987F5CED8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJQ0OnfAAoJEAOzoR8eZTzgK14H/1nktW1Mj44D28h8WFVzHD84
4d28BaqjbRm9l21FQdJOBB7Alwy8MffnjQ321/PYAI7nO3Lqh0TkH3C0lC1go66+
AevCx/2/Af503e8sCmzSUdJ8l9DEuT+oUW7l5DY+P6mhP87VJSwDs7jrzlaF9hOf
sQdd2IqerzJybr+CsM7bTas7nNVGY5J8C/jrbxmjGdKjTGD8a3xMgujL2V8i59C0
8Wb30W/JoGwPIbTK2u0cSbXu0XWI5irS84awt4yh+T8Pr0hv3zRQFeH1N/3btNJT
d6McGQqVuiSnKFMnAYuFS2vQgm/qOEqmYV/BXBiGBaPOZ/70Q5et08KCLdCfnbM=
=0J2R
-----END PGP SIGNATURE-----

--------------enig95BF9ED3351DDE5987F5CED8--
