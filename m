From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git svn clone fails
Date: Fri, 14 Aug 2015 10:32:04 +0200
Message-ID: <55CDA784.7080809@web.de>
References: <mpa8th$m80$1@ger.gmane.org> <mppsku$h97$1@ger.gmane.org>
 <mqk6mb$qi8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?J=c3=b6rg_Schaible?= <joerg.schaible@swisspost.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 10:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQAPU-0003I1-Jz
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 10:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbbHNIcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2015 04:32:14 -0400
Received: from mout.web.de ([212.227.15.14]:62394 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285AbbHNIcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 04:32:12 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LpfFO-1Yugwh1EMI-00fOnB; Fri, 14 Aug 2015 10:32:09
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <mqk6mb$qi8$1@ger.gmane.org>
X-Provags-ID: V03:K0:m/AbJiHR+RncWVQNNL/5NMxHP3eFXRSNTWVBWPj+zbfyIMLhI5I
 Be5vgh1LswWYnQY47jx6br1WymiXlcilEgTAVuYxuUp/Tx1bQzqvIWX1JSYt7cF9KrWXe9F
 b6VCYMIIOk84ht+3LeKIBGTG8bo9VQjlXHeWWW9+hgQQUxI1d7MuSWqWVSsrmFwzyiAC8Xf
 7mfnAMUpQAn+qSOl78nGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yACqCdqQVOE=:WlMFb0Fs6JP3kJYlb42ZlM
 n09nBKTyO34I87M9fJna1PbXxKzlulun3r24aA3T0oOOLfhJ0T880E6J7Rpu3rCPjv1LVBA0W
 yx3FK0pKM9BdVCVo4h6JJBMnF4bP9NJhc5jhjeS8SMPRtzn8mJM4szyEs3HEwMw2LDV5Aqugb
 KqrABik7LyHIrhshzNwVkst/5hU8xyrRLSgxcM2cpcSFwaRbhsWUOC5m2NWGRXP8k/HA1VehJ
 uXX6sGfluIsauPs3JuERC5b5H9QanjF+wAuYaY9zijJkVvzdFulwcfiva/q08FhadqsStu5Ba
 ycmNqFnD6MVEE6x/CuyUMCZrXld5/HxT0j8KTZrlRS46ITqQoJXfEqG3bhmTLYisWZTFhUvcQ
 i0Bz6pIspJ11vqru1wzTCfbw1C2EYm0RsPWT1ZV2DaC2mMLKFRXmYkL4TU5k74l7QecHnj2Rx
 Lmr3K8CWayH9tsZAWP0P+04+XSVwdz9RCQCOb7Tnhnl+1GawCFH/+X30dvlgxcSPMj1TCjAbb
 JWdqbeKkcaUSBjKP52cWDNAevDk7A4M0AIBEaflGjrJJHMM9htQNXhw8kur6Fe3o8TWKWnchi
 FWNm0wgPyWpYZ0VM4cH9QD7Pu0j2E6OGJinQfJpPltuajw67naSqUWiajWQiU+eD1xnlbF9R3
 wKK3RKokYDzmQ1DyiNNzH2NyWIEaFRDtaIn4S6trtO2GChs2cN1NWxXrHPKzLUNRK0Y1hco9m
 mFMzPLsjK3nxs18vOWX3aR1xCdJGskLT+LP6Uw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275898>

On 2015-08-14 09.51, J=C3=B6rg Schaible wrote:
I can't reproduce it here:

 git svn clone http://websvn/svn/essvn/standard/java-commons/lang
Initialized empty Git repository in /home/xx/lang/.git/
RA layer request failed: OPTIONS of
'http://websvn/svn/essvn/standard/java-commons/lang': Could not resolve=
 hostname
`websvn': Host not found (http://websvn) at
/Users/xx/lib/perl5/site_perl/Git/SVN.pm line 143

In other words, is there a way to make this reproducible for others?
If not, how could the problem be tracked down and fixed
(from other people than you or somebody in your organization ?)



> Is there really no other place for a bug report? This will simply van=
ish in=20
> the list's noise ...
>=20
> J=C3=B6rg Schaible wrote:
>=20
>> Hmmm. Is this the proper channel to report issues or should I go som=
ewhere
>> else?
>>
>> J=C3=B6rg Schaible wrote:
>>
>>> Hello guys,
>>>
>>> we have to turn some projects managed by Subversion into a GIT-base=
d
>>> solution. However the conversion unfortunately fails with an error:
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> [...]
>>> Found branch parent: (refs/remotes/origin/tags/v_2.1.1)
>>> 450fa2c84a8fc087a2a66e5fb3d6d22096671f81
>>> Following parent with do_switch
>>>         M       changes.xml
>>>         M       pom.xml
>>> couldn't truncate file at /usr/lib64/perl5/vendor_perl/5.20.2/Git.p=
m line
>>> 1325.
>>> $ git --version
>>> git version 2.5.0
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Apart from the line number, the same error occurs also with GIT ver=
sion
>>> 2.4.6 and 2.3.6 (latest stable version in Gentoo).
>>>
>>> The command to create the GIT repository was:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> $ git svn clone http://websvn/svn/essvn/standard/java-commons/lang =
-s
>>> --no- metadata --preserve-empty-dirs -A ~/tmp/authors.txt commons-l=
ang
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Note, that the command succeeds even for 2.4.6 if we drop the --pre=
serve-
>>> empty-dirs option - at the cost of some empty directories which are=
 used
>>> to trigger profiles for Maven; i.e. without those we cannot reprodu=
ce
>>> released versions.
>>>
>>> Cheers,
>>> J=C3=B6rg
>=20
