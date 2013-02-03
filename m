From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Sun, 03 Feb 2013 18:38:18 -0500
Message-ID: <20130203233818.GB30520@odin.tremily.us>
References: <510EE661.8060600@iam.tj>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=tjCHc7DPkfUGtrlw
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter Collingbourne <peter@pcc.me.uk>
To: TJ <git@iam.tj>
X-From: git-owner@vger.kernel.org Mon Feb 04 00:39:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U299J-0002AU-9t
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 00:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab3BCXij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 18:38:39 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:13438 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab3BCXii (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 18:38:38 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MHO00L4N4BU1F40@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 03 Feb 2013 17:38:19 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 99E0B8679EB; Sun,
 03 Feb 2013 18:38:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1359934698; bh=CRCoANbVhpnNHUrOnef0cH8Ej6uNBrK1J5H2KP6g76o=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DqFUEDEEaFKKeNOf7HUpNg4hQHarIEKCrxENNp/aM3Fmu16TIQwC1qsrTTXm7F12a
 PkTjZwDeQyef5RIRtNqP3acvIVWVKnMxPCHPu7KrnQoLxGO8lFMgZmuo2RJ+O1K5Ee
 t2IoBIIz7pA2RzElNXaK1m9Yqdu3q854OKD4TaJs=
Content-disposition: inline
In-reply-to: <510EE661.8060600@iam.tj> <50EA7269.1080006@web.de>
 <20130107003603.GA25698@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215344>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2013 at 10:36:17PM +0000, TJ wrote:
> I've recently had need to re-arrange more than ten submodules within
> a project and discovered there is apparently no easy way to do it.

I ran into a similar problem last month, and wrote a similar script
[1] ;).  There are a few other related threads you might be interested
in:

On Sun, Jan 06, 2013 at 07:36:03PM -0500, W. Trevor King wrote:
> Today I had to move my first submodule, and I discovered that Git's
> support for this is pretty limited.  There have been a few patch
> series attempting to address this [1,2], but none of them seems to
> have pushed through into master (although I can't put my finger on a
> reason for why).  There are also some SO postings discussing this
> [3,4].  It would be nice if `git mv` worked out of the box on
> =E2=80=A6
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/88720
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/143250
> [4]: http://stackoverflow.com/questions/4323558/moving-submodules-with-git
> [3]: http://stackoverflow.com/questions/4604486/how-do-i-move-an-existing=
-git-submodule-within-a-git-repository

The long-term solution is probably Jens' branch:

On Mon, Jan 07, 2013 at 07:59:53AM +0100, Jens Lehmann wrote:
> I=C2=B4m currently working on teaching mv to move submodules and intend
> to send those patches to the list after finishing submodule deinit.
> Please see
>   https://github.com/jlehmann/git-submod-enhancements/commits/mv-submodul=
es
> for the current state of this series.

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.comp.version-control.git/212861

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRDvToAAoJEEUbTsx0l5OMkTAQAI5oCdwGrVayEVBP8D//iqxM
UaXF+k+qwO0iW5rbpk4sPzwYxVpJZbCFj//37vqRZXz6Qk4VwHdXmI0dAf/XMWwD
G1iZi9VvTzMwvO4f5HlKtZ5P4U9bFhQqHomU46UziulScib8gMjHC4XN6p0EMC9F
vqHkjbMkYhKjoSOhNiR/gDJ7a+ythTzPHrtg5KSBL9rePHfwrlLECpAe8VGhiCz3
ZG+6P0sS1g3pxIuST/yB3ZLi/zSNdgC9r0WgaEraSEPZpFglvCx+xQPNJAbm/+IR
2OtgRNy55A3cqXtaTqAv7LbGLMmNU3YbTZFfYqhgrZxnBwe8CH4yoajEPHUMaEpd
ZB3FCzNXLxqCgG8avZc1UEmII2AjOf7xy+hGPGKTbJ6fJDtf0GjJUseH/kTZo87r
zGcD6l1/w39WlhpH51G3dEOAu2YEWVknv6ygKbCaiMxYJXIgbdDYOxJ0MvcE0ggK
cb/Qh/MBJ7CAf0YX9aBiTBok4vQn322wzmw7iDKym1SRRfK4zl3L6VkCJokkIMw+
7SdH5+IZyOoS+BGnluKwNNvsCOjca1sNvcVcSuMhT/u/ABN2V8YGAaOJ3OWhgE7B
vAm6L/uRuZz3qMGwoEDs621BkrW5L9ptoyjBsCyh5otshJh1MGcu/SnxWCFuw0iE
kuhjn57QpWgo6hAT/o2D
=uxi1
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
