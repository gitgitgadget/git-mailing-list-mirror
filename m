From: Eric Deplagne <Eric@Deplagne.name>
Subject: Re: Minor Bug in Renaming Branches
Date: Tue, 7 Jun 2016 09:40:51 +0200
Message-ID: <20160607074051.GT22583@mail.eric.deplagne.name>
References: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com> <54505ef2-7db6-8bc4-0ffb-0ac28c7d6046@web.de> <CAGZ79kb77m8ymDkJGMaWi8yOdSphpYifDPHQ=+nZMBhRi47i9w@mail.gmail.com> <575649DA.4080702@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r21wuLfwIlf/vvzy"
Cc: Stefan Beller <sbeller@google.com>,
	Samuel Lijin <samuel.lijin@formlabs.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 07 10:05:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAC0e-0006Og-JO
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 10:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbcFGIFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 04:05:07 -0400
Received: from goldorak5.eric.deplagne.name ([213.246.56.18]:33624 "EHLO
	exim4.goldorak5.eric.deplagne.name" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbcFGIFB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 04:05:01 -0400
X-Greylist: delayed 1445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2016 04:05:01 EDT
Received: from [192.168.0.4] (helo=mail.eric.deplagne.name)
	by exim4.goldorak5.eric.deplagne.name with esmtp (Exim 4.72)
	(envelope-from <Eric@Deplagne.name>)
	id 1bABd5-0007ZM-Na; Tue, 07 Jun 2016 09:40:51 +0200
Received: from deplagne by mail.eric.deplagne.name with local (Exim 4.69)
	(envelope-from <Eric@Deplagne.name>)
	id 1bABd5-0007ZH-L6; Tue, 07 Jun 2016 09:40:51 +0200
Content-Disposition: inline
In-Reply-To: <575649DA.4080702@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296613>


--r21wuLfwIlf/vvzy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Jun 2016 06:13:14 +0200, Torsten B=F6gershausen wrote:
> On 06/06/2016 09:35 PM, Stefan Beller wrote:
>> On Mon, Jun 6, 2016 at 12:17 PM, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>>
>>> A limitation is introduced by Mac OS and Windows:
>>> BRANCH/NAME and branch/name refer to the same object in the file
>>> system.
>>> As a workaround, you can pack the branch names:
>>> git pack-refs --all
>>
>> Once you packed a branch into the packed refs file, you can
>> create another loose branch of different capitalization,
>> which then 'hides' the packed ref?
>>
>> That sounds error prone to me, as a seemingly unrelated branch
>> changed its value:
>>
>>      git branch BRANCH 012345
>>      git pack-refs --all
>>      git branch branch BRANCH^
>>      git rev-parse BRANCH
>>      (I'd expect BRANCH^ as return)
>>
>> (I don't have a windows machine for testing here, so that
>> is pure speculation)
>>
> Yes, another reason not to use branch and BRANCH in the same repo.
> (You can test under Linux & vfat)

  Or to have git just refuse it altogether...

  But let me guess, it's against some sort of policy...

  There could be some hook out there, then ?

--=20
  Eric Deplagne

--r21wuLfwIlf/vvzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD4DBQFXVnqDej7DisjVpq4RAqxoAJ0eufoN3OXWKGiHrAPolS4SmOHGIwCWJHNl
jI/aVh12/NM8YZX5oEl4Ww==
=rwxP
-----END PGP SIGNATURE-----

--r21wuLfwIlf/vvzy--
