From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: Change default branch name (server side) while cloning a repository
Date: Fri, 27 Mar 2015 15:27:27 +0100
Message-ID: <551568CF.2050301@atlas-elektronik.com>
References: <1427459241861-7627964.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Garbageyard <varuag.chhabra@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:28:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbVEm-0007Q5-6Q
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 15:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbbC0O1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2015 10:27:42 -0400
Received: from mail96.atlas.de ([194.156.172.86]:27344 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbbC0O1l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 10:27:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 99BD410121;
	Fri, 27 Mar 2015 15:27:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UIHA4OfNvq3T; Fri, 27 Mar 2015 15:27:29 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 27 Mar 2015 15:27:28 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id A760D27169;
	Fri, 27 Mar 2015 15:27:28 +0100 (CET)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Fri, 27 Mar 2015
 15:27:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1427459241861-7627964.post@n2.nabble.com>
OpenPGP: id=922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266372>

Am 27.03.2015 um 13:27 schrieb Garbageyard:
> We use Gitolite for access control and i have admin access on Git ser=
ver. I
> wanted to make sure that whenever a new repository is created and is =
then
> cloned on any machine, the default branch should point to mainline. T=
o do
> this, when I run the repository creation script, i change the content=
 of
> file HEAD of a given repository to point to mainline i.e., default en=
try of
> =E2=80=9Cref: refs/heads/master=E2=80=9D in file HEAD is changed to =E2=
=80=9Cref:
> refs/heads/mainline=E2=80=9D.
>=20
> For example, if "work" is the repository name, then on Git server,
>=20
> [gitolite@gitserver  repositories]$ cd work.git/
>=20
> [gitolite@gitserver  work.git]$ cat HEAD
> ref: refs/heads/mainline
>=20
> If i now clone the repository on my local machine, then the default b=
ranch
> should be pointing to mainline and not master. However, the issue is =
that it
> still points to master. Am I /wrong/ in assuming that changing the en=
try in
> file HEAD for a given repository on Git server will change the defaul=
t
> branch while cloning? If I=E2=80=99m wrong, can anyone please tell me=
 how can I
> enforce this change on the /server/ side correctly?

Works for me with  "gitolite3 v3.6.2-24-g8e36230 on git 2.3.4".

Could it be that the repo was emtpy when you tried to clone it ?

Stefan
--=20
----------------------------------------------------------------
/dev/random says: Half of the people in the world are below average.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"=20
GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 2=
7AF
