From: Evan Driscoll <driscoll@cs.wisc.edu>
Subject: Splitting up a repository
Date: Fri, 03 Dec 2010 23:27:57 -0600
Message-ID: <4CF9D15D.7090001@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCE8F4FB8777A1DDF8CDE4A8F"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 04 06:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POkfy-0004qx-CN
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 06:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134Ab0LDF2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 00:28:30 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:55802 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab0LDF23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 00:28:29 -0500
Received: from [192.168.0.2] (h216-165-158-75.mdtnwi.dsl.dynamic.tds.net [216.165.158.75])
	(authenticated bits=0)
	by sabe.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id oB45SS3o017916
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 3 Dec 2010 23:28:28 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162883>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE8F4FB8777A1DDF8CDE4A8F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Say I have a repo where there are directories repo/foo, repo/bar,
repo/baz. 'foo', 'bar', and 'baz' are loosely related -- closely enough
that I put them together initially, but loosely enough that I now wish I
could check out just 'repo/foo'. Since Git doesn't support partial
checkouts (a bit annoying!), I now have to split this repository into
separate ones. I'd of course like to keep history.

Is there a better way than making several (recursive) copies of the
repository, deleting all but one directory in each copy, then moving the
contents of that directory up a level? (And perhaps setting up a Git
superproject at the original location. I do know about that.)

I've probably spent more time typing up this email than it would take to
do, but I'm curious if there's some git magic or something that would be
better for some reason. :-)

Evan


--------------enigCE8F4FB8777A1DDF8CDE4A8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEVAwUBTPnRYwOzoR8eZTzgAQIW2wf/dJMI7/Hxq37klzjY/jqRBF9xBz3PDeuI
UB4rIOaWM5MWetW9c0HtSEMhBoKrJtTCv+ZtZvFTkVJ3yoP6rW87hdy9GcuYjitp
BYSzLw7c93dXfGol/Q239jb7ZLjhngG52fEUmktusM8JwKFB9e9NfDY1n393IaCH
E/zFSAD4RnHc3TIW0d3jCbh27M9mfVdJmOzyCyAtOI06lEXLQvsnNNKDXyGtAgsz
HaTUycOrZl8cSj27qIxcm5IEzC5EQ0CceuAoq0KS/87VJvWS5gAxbMY0J98p3sPm
WOxfzJpzBr2rpuokX4I19CJVD8dAaVVESQ6MnYqTxRrn5Lk6yRu8QQ==
=R10z
-----END PGP SIGNATURE-----

--------------enigCE8F4FB8777A1DDF8CDE4A8F--
