From: Jan Hudec <bulb@ucw.cz>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:36:54 +0100
Message-ID: <20071126203654.GF25784@efreet.light.src>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <20071126192703.GB25784@efreet.light.src> <FF804F69-3EEC-4FED-AE92-18C4F5B3645F@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Cc: David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwkhr-0004Kp-R3
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbXKZUhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbXKZUhG
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:37:06 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:59207 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbXKZUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:37:04 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6316057425;
	Mon, 26 Nov 2007 21:37:02 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id dYehk42-B+BW; Mon, 26 Nov 2007 21:36:59 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id EF752574FB;
	Mon, 26 Nov 2007 21:36:57 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IwkhK-0006yi-Hx; Mon, 26 Nov 2007 21:36:54 +0100
Content-Disposition: inline
In-Reply-To: <FF804F69-3EEC-4FED-AE92-18C4F5B3645F@lrde.epita.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66115>


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 21:11:41 +0100, Benoit Sigoure wrote:
> On Nov 26, 2007, at 8:27 PM, Jan Hudec wrote:
>
>> On Mon, Nov 26, 2007 at 18:11:43 +0100, David Kastrup wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>>> If you would write git from scratch now, from the beginning, without
>>>> concerns for backwards compatibility, what would you change, or what
>>>> would you want to have changed?
>>>
>>> Get rid of plumbing at the command line level.  It is confusing to
>>
>> No, please. It's extremely useful. It should be a bit more hidden, but=
=20
>> it's
>> a big advantage of git that the plumbing is available.
>>
>>> users, and command line arguments, exec calls and I/O streams are not
>>> efficient and reasonably typed mechanisms for the kind of operations
>>> done in plumbing.  Instead using a good extensible portable scripting
>>> language (I consider Lua quite suitable in that regard, but it is
>>> conceivable that something with a native list type supporting easy
>>> sorts, merges and selections could be more efficient) and implementing
>>> plumbing in that or in C would have been preferable for creating the
>>> porcelain.
>>
>> POSIX shell is really the best extensible portable scripting language
>> available for the job. Because the whipuptitude is the most important
>> property and shell is simply best at one-liners. And since you use it
>> for regular work (running editor, compiler, git porcelain), it is the
>> obvious choice for whiping up a short function.
>
> Perl seems pretty portable.  If we had a decent, complete libgit, it woul=
d=20
> be easy to create bindings for various languages and script Git in other=
=20
> languages than Shell script.

Perl might be good for the lower level stuff (and is indeed used for that in
git a lot), but most useful tools on top of git gather few bigish bits
(contents of whole files and such) and pass them to some application. And
this is what shell is really good at.

So yes, more direct interfaces for various languages would certainly be goo=
d,
but it would never be a full replacement for the process interface. It is
most generic and for many hacks the easiest thing to use.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHSy5mRel1vVwhjGURAiK4AJ92U3/lodTZCUmaaW4AJcyFPm6QrwCfY3jh
Yy9P0gKWK+G0kY5kBXl+lu0=
=3fry
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
