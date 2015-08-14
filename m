From: =?UTF-8?B?SsO2cmc=?= Schaible <joerg.schaible@swisspost.com>
Subject: Re: git svn clone fails
Date: Fri, 14 Aug 2015 09:51:39 +0200
Organization: Swiss Post Solutions
Message-ID: <mqk6mb$qi8$1@ger.gmane.org>
References: <mpa8th$m80$1@ger.gmane.org> <mppsku$h97$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 09:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQ9mM-000780-17
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 09:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbbHNHvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2015 03:51:49 -0400
Received: from plane.gmane.org ([80.91.229.3]:35390 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbbHNHvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 03:51:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZQ9mE-00070n-GE
	for git@vger.kernel.org; Fri, 14 Aug 2015 09:51:46 +0200
Received: from 62.154.225.82 ([62.154.225.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 09:51:46 +0200
Received: from joerg.schaible by 62.154.225.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 09:51:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.154.225.82
User-Agent: KNode/4.14.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275896>

Is there really no other place for a bug report? This will simply vanis=
h in=20
the list's noise ...

J=C3=B6rg Schaible wrote:

> Hmmm. Is this the proper channel to report issues or should I go some=
where
> else?
>=20
> J=C3=B6rg Schaible wrote:
>=20
>> Hello guys,
>>=20
>> we have to turn some projects managed by Subversion into a GIT-based
>> solution. However the conversion unfortunately fails with an error:
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> [...]
>> Found branch parent: (refs/remotes/origin/tags/v_2.1.1)
>> 450fa2c84a8fc087a2a66e5fb3d6d22096671f81
>> Following parent with do_switch
>>         M       changes.xml
>>         M       pom.xml
>> couldn't truncate file at /usr/lib64/perl5/vendor_perl/5.20.2/Git.pm=
 line
>> 1325.
>> $ git --version
>> git version 2.5.0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>=20
>> Apart from the line number, the same error occurs also with GIT vers=
ion
>> 2.4.6 and 2.3.6 (latest stable version in Gentoo).
>>=20
>> The command to create the GIT repository was:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> $ git svn clone http://websvn/svn/essvn/standard/java-commons/lang -=
s
>> --no- metadata --preserve-empty-dirs -A ~/tmp/authors.txt commons-la=
ng
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>=20
>> Note, that the command succeeds even for 2.4.6 if we drop the --pres=
erve-
>> empty-dirs option - at the cost of some empty directories which are =
used
>> to trigger profiles for Maven; i.e. without those we cannot reproduc=
e
>> released versions.
>>=20
>> Cheers,
>> J=C3=B6rg
