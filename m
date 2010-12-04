From: Evan Driscoll <driscoll@cs.wisc.edu>
Subject: Re: Splitting up a repository
Date: Sat, 04 Dec 2010 01:14:40 -0600
Message-ID: <4CF9EA60.7040402@cs.wisc.edu>
References: <4CF9D15D.7090001@cs.wisc.edu> <AANLkTikqnnOLN=asPUKK0zYxYK9VWXcZPBPtwMZ3z-cr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41EB9E20B8CA7777525AE414"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 08:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POmL6-0001dP-Oe
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 08:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab0LDHPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 02:15:08 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:37188 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304Ab0LDHPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 02:15:07 -0500
Received: from [192.168.0.2] (h216-165-158-75.mdtnwi.dsl.dynamic.tds.net [216.165.158.75])
	(authenticated bits=0)
	by sabe.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id oB47F5Jj019508
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 4 Dec 2010 01:15:05 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTikqnnOLN=asPUKK0zYxYK9VWXcZPBPtwMZ3z-cr@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162886>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41EB9E20B8CA7777525AE414
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/4/2010 1:09, Nguyen Thai Ngoc Duy wrote:
> On Sat, Dec 4, 2010 at 12:27 PM, Evan Driscoll <driscoll@cs.wisc.edu> w=
rote:
>> Say I have a repo where there are directories repo/foo, repo/bar,
>> repo/baz. 'foo', 'bar', and 'baz' are loosely related -- closely enoug=
h
>> that I put them together initially, but loosely enough that I now wish=
 I
>> could check out just 'repo/foo'. Since Git doesn't support partial
>> checkouts (a bit annoying!),
>=20
> Um.. it does support partial checkouts (check out man page of
> git-read-tree, sparse checkout section). But you must do a full clone
> (i.e. your repository will have bar and baz, even if you only checkout
> foo).

That's sort of spiffy, and I did not know about that. So again, thanks.

That said, I did a bit of reading around, and I'm not sure it does what
I need.
http://stackoverflow.com/questions/2336580/sparse-checkout-in-git-1-7-0
is basically what I want, and the answers seem to indicate it isn't
possible. (In other words, in my example, when I want a checkout of
repo/foo, the .git directory needs to be a sibling of foo's contents,
not a sibling of foo.)

Evan


--------------enig41EB9E20B8CA7777525AE414
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEVAwUBTPnqYAOzoR8eZTzgAQIgLgf/TqsIAnOD2yqbm6aCo/JJYMf4T2hzwzWe
dAqOOyxObGswGCdci5uvkbM41AzgKh8Kwzd6M8RmgFBszRAB4BmvNtl0L70am+xl
6O/wFcP1McKVk+5AtvzGmrGeYF5k69R471GoppIMz+PrSRDvIALttv712sE1IMrB
V8I+9AxyGHG0i/psDPzDY+4m026j/HKQMp96W1O5PtDWKAIDHQHCwmQpzgQda17C
81PYKa08PwrKC/YfUv2nKbcUKBrPfYZVL0IlR77m+l4z08WGWnHH3VxB4njQhkrA
1MT/NkV+3OclQ1urJN03X0f7zK5Mu9yfVn0HnGqLw9VP8C9hJ6r3Ng==
=Pd07
-----END PGP SIGNATURE-----

--------------enig41EB9E20B8CA7777525AE414--
