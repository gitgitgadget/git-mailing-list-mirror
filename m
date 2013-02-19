From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Feature idea : notes to track status of a commit,
 which remotes it is shared to
Date: Tue, 19 Feb 2013 05:30:42 -0500
Message-ID: <20130219103042.GA4565@odin.tremily.us>
References: <51234801.5050208@mildred.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=VS++wcV0S1rZb1Fb
Cc: git@vger.kernel.org
To: Mildred Ki'Lya <mildred-ml@mildred.fr>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kTx-0003Nv-VD
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597Ab3BSKa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:30:57 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:37846 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342Ab3BSKaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:30:55 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00GIGQJ6G160@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 04:30:43 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 3D9298ABB21; Tue,
 19 Feb 2013 05:30:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361269842; bh=C5QbiCB++urj//TSk8stTOAjHbpbGyCaAkWVX633X5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U3FcsIFGYoY0LHrGpMjlEVL5HsgHTK6qRWHuQqdmfzaXhznbjRtyJsZYSVnsPStWc
 vyvk76IOCMejl2Jg1Pxg0jZcZZ3926e5q04luOMmGdxOHtYQffqlvJz8Cn1pZZCJ6q
 hHCtMhylkQFEkBLcJndy9O2V0wUuZ/qDLaPNz3/c=
Content-disposition: inline
In-reply-to: <51234801.5050208@mildred.fr>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216597>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 10:38:09AM +0100, Mildred Ki'Lya wrote:
> Then, we could have all the history rewriting commands (such as
> rebase or pull --rebase) die when rewriting commits that are already
> published anywhere. We could make an exception for a --force/-f flag
> or configuration option, or commits published in another local
> repository owned by the same user.

You might want to look into extending the sample pre-rebase hook,
which prevents topic branches that are already merged to 'next' branch
=66rom getting rebased.  You'd just have to loop over all remote
references instead of only checking the local 'next' branch.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRI1RQAAoJEEUbTsx0l5OMUIEQAKnigu4dySS8X7DETavwYC9j
K4gnRFJ6hxYI1txmd+UGMKZgrnF1xBZ8T5Qx5nTSgdGiLBhw3TwfAvCfjBXw3FiZ
0lFT9dxG39zobMf8L16pn2TTJuXCsEC4+iULo3nZHEaZFTE48NFhsxb/TbewS3DE
uBRS6Wn6eU4twJOlBB2CwKcRZES+nlhM4Ol/tgCoUM7GgXzjTKEla5HkUL7pS8Hi
FJ9k9+vAns5smMTSl4YVHR0WY6t70gMe3wCo0oWzaheK7paNLVTzueQ21PiWmNaE
jEIDq0WSJdtfTrF3lioVsWkvfzzpmdpfCA0AafO7cRfC3F0uaRjuSRse6/X3pm3u
r+zokrrWXts/zfvIqta4Ld4dlTfXw9N3StQwwxtx/fwfCfw3+ym68qCghv4kQO+Q
SBpV2MxFyw7ljmELpOSbLxPUZaI/+0vSxMWttE3/HRCLBzBtLyGii5fpAdmlI68A
/Sti1FuuANOzcIAKD0iRaQPBM/QFFnVH34rpHWzSFcn+WgY8gkqyeLZgzSP+YaPA
4S+ugijxc1H884CsXBAygVMKOEl5q03P2Z7mhOA0BmNxMRggx0gkDvZbVrXEFWFL
8DHC+N6/0g9r+zdoFSU6BsZQk00HUO1wbM2Kqpjier4vESKL3GKo647Apu3AUscY
FY+Q0Gb7GUXkQeIwK77o
=Gbfg
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
