From: Manish Gill <mgill25@outlook.com>
Subject: Re: Problem switching branches in submodule
Date: Fri, 27 Sep 2013 00:03:23 +0530
Message-ID: <BLU0-SMTP36066CF18FF63C9BD84AC48B8280@phx.gbl>
References: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl> <20130926180852.GF9464@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VpO5bcuEUc37ATTAGGNsURrEhRdfV0oB9"
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 20:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPGNi-0001vw-JY
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 20:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab3IZSdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 14:33:38 -0400
Received: from blu0-omc3-s25.blu0.hotmail.com ([65.55.116.100]:21543 "EHLO
	blu0-omc3-s25.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836Ab3IZSdg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Sep 2013 14:33:36 -0400
Received: from BLU0-SMTP360 ([65.55.116.73]) by blu0-omc3-s25.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 26 Sep 2013 11:33:36 -0700
X-TMN: [6NLyroLLZ+Jb7Z1482IaIgtO3gOj/wTO]
X-Originating-Email: [mgill25@outlook.com]
Received: from [192.168.1.106] ([120.56.147.88]) by BLU0-SMTP360.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 26 Sep 2013 11:33:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130926180852.GF9464@google.com>
X-Enigmail-Version: 1.5.2
X-OriginalArrivalTime: 26 Sep 2013 18:33:34.0663 (UTC) FILETIME=[E8857D70:01CEBAE6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235425>

--VpO5bcuEUc37ATTAGGNsURrEhRdfV0oB9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2013 11:38 PM, Jonathan Nieder wrote:
> (cc-ing Duy, who knows the setup code well)
> Manish Gill wrote:
>=20
>> I have a git repository with lots of submodules. In one particular
>> submodule, I'm having the following problem:
>>
>> If I try to switch branches at the top-level of that submodule, I succ=
eed.
>>
>> But, if I try to switch branches in any subsequen levels, I get the
>> following error:
>>
>>     fatal: internal error: work tree has already been set
>>     Current worktree: ../path/Mailman3/rest_project
>>     New worktree: ../path/Mailman3/rest_project/website/public_rest
>>
>> Here, Mailman3 is the primary repository and "rest_project" is a
>> submodule. I can do "git checkout" just fine
>> inside rest_project, but not after cd-ing into any other repos.
>>
>> My git version is 1.8.4
>>
>> Other commands, like git status, push/pull are working fine.
>=20
> Interesting.  Yeah, this shouldn't happen.
>=20
> What is the exact command you use to get the above output? =20

git checkout <branch_name>

Is your
> repository public (which would let us reproduce it) or can you
> reproduce it by creating a small artificial test repository

The repo isn't public, I'm afraid.

I should mention what *exactly* happened that led to this. I was trying
to publish my branch on Launchpad (using git-remote-bzr). At some point,
I had the genius idea to remote the extra stuff from the config file and
just try with the bzr:: remote as origin, and instead of doing it via
the console, I just replaced the config file.

Annnnyway, I just restored my backed up config file for that submodule
in the middle of writing this and seems like things seem to work now.

I dunno, this was most likely because of some configuration derp on my
part (the new config file didn't contain the branch information most
likely). So I guess problem solved!

Thanks for your help.



--VpO5bcuEUc37ATTAGGNsURrEhRdfV0oB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSRH35AAoJEDTnrae/jUU98YwH/1SKb62WAsB29Gwp4TO/wuXj
JfhSUOSUVX8YjaBgay3JN8I8HcoC+fiLr9ZePRmtOeb569ajiKaOwMqvKugIlZIQ
aFKeTKUsHyR2XoBLRKrEOt0DB9OL8uUWDPLVtQXKnDKw3HFJzVdaqFMqJdeo4r9I
0td/bTe26sQekhbG0FmuA41Nsx9r6U1bBTi5wf6XoWllTSGLvQlQCr4+uBLcsMTA
lBLB8EWCCTNn7osn5/t7f0S5S/I021RKpPmpmJE9Y+q57BTfrbmRSWfF5pnMHu29
uVdU0vheCxLXqXbNsQFOYuJDvKm7yJ2Mu7MTHxlc51qMwdzrBFJUtbIJU0YSf8o=
=2NHe
-----END PGP SIGNATURE-----

--VpO5bcuEUc37ATTAGGNsURrEhRdfV0oB9--
