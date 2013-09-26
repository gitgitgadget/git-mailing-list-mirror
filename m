From: Manish Gill <mgill25@outlook.com>
Subject: Re: Problem switching branches in submodule
Date: Fri, 27 Sep 2013 00:59:02 +0530
Message-ID: <BLU0-SMTP2754312DA341C7F3254F325B8280@phx.gbl>
References: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl> <20130926180852.GF9464@google.com> <BLU0-SMTP36066CF18FF63C9BD84AC48B8280@phx.gbl> <20130926184830.GG9464@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9S9pbpbK4I35LcuDtBIK9su8tQWWFs6dv"
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 21:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPHG1-0001YL-CI
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 21:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab3IZT3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 15:29:45 -0400
Received: from blu0-omc3-s31.blu0.hotmail.com ([65.55.116.106]:35630 "EHLO
	blu0-omc3-s31.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041Ab3IZT3o (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Sep 2013 15:29:44 -0400
Received: from BLU0-SMTP275 ([65.55.116.73]) by blu0-omc3-s31.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 26 Sep 2013 12:29:18 -0700
X-TMN: [SMf41bfubbRZa935AeqnB+jCtPls4EdN]
X-Originating-Email: [mgill25@outlook.com]
Received: from [192.168.1.106] ([120.56.147.88]) by BLU0-SMTP275.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 26 Sep 2013 12:29:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130926184830.GG9464@google.com>
X-Enigmail-Version: 1.5.2
X-OriginalArrivalTime: 26 Sep 2013 19:29:16.0486 (UTC) FILETIME=[B0673660:01CEBAEE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235428>

--9S9pbpbK4I35LcuDtBIK9su8tQWWFs6dv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2013 12:18 AM, Jonathan Nieder wrote:
> Manish Gill wrote:
>> Jonathan Nieder wrote:
>=20
>>> What is the exact command you use to get the above output?
>>
>> git checkout <branch_name>
>=20
> Is <branch_name> a normal branch, a remote-tracking branch, or a
> branch that doesn't exist yet?

Local branch that was supposed to track a remote branch.

>=20
> [...]
>> I should mention what *exactly* happened that led to this. I was tryin=
g
>> to publish my branch on Launchpad (using git-remote-bzr). At some poin=
t,
>> I had the genius idea to remote the extra stuff from the config file a=
nd
>> just try with the bzr:: remote as origin, and instead of doing it via
>> the console, I just replaced the config file.
>>
>> Annnnyway, I just restored my backed up config file for that submodule=

>> in the middle of writing this and seems like things seem to work now.
>=20
> If you happen to have a copy of the old config file or remember what it=

> said, that could be helpful (especially if you can still reproduce the
> problem in case we come up with a fix).

Config file which was NOT working:
http://bpaste.net/show/oaWG3TQarH3BrdjDj5be/

Working config restored from backup:
http://bpaste.net/show/nF3ap5fDEAwL9NyqdCmD/
>=20
> Did the config file have a [core] worktree setting or something similar=
?

Looks like the working one had it and the other didn't. Adding the
"worktree" setting seems to fix the problem. But shouldn't this work
uniformly in the repo? Removing the [core] worktree gives the same
error, but only in directories inside the repo. Checkout still works on
the top-level. Seems a bit strange I guess.
>=20
> Hmm,
> Jonathan
>=20



--9S9pbpbK4I35LcuDtBIK9su8tQWWFs6dv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSRIsFAAoJEDTnrae/jUU9xMwH/jqSrUea2LQZoWOFvpbM2mxR
TPVvcT+dfBame0/2D0sWbMpEO4of2P67YDxDV6n9czCx/YRngAPB42sDjBN0lXp0
Rd7bEKsJ4tuQdT8lBcO2VDxgd9XEja1Kbc/O3MLXPaUxHMbovbHDcTLHq3D0qU45
Zfac77quCNNAsG9DPzCecK3QTshyOE60FLlT1b5kGNp+lXwbW66cNZlke+StOuMD
zmzy5LeD/8W2M7wbce9+EIhGFSO4zl5cNmPMDzAUvgT+QshgG0HbEdMXOKBXl69C
EodM+1NL+ZvsCGWkATspl4d+2SpL77Q56p5vl2wa5JM+R1qes1pwr1o4W2k7WP0=
=xupE
-----END PGP SIGNATURE-----

--9S9pbpbK4I35LcuDtBIK9su8tQWWFs6dv--
