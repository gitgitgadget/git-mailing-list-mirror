From: =?UTF-8?B?SsO2cmc=?= Schaible <joerg.schaible@swisspost.com>
Subject: Re: git svn clone fails
Date: Tue, 04 Aug 2015 10:20:46 +0200
Organization: Swiss Post Solutions
Message-ID: <mppsku$h97$1@ger.gmane.org>
References: <mpa8th$m80$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 10:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMXTH-0004zs-KS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 10:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbbHDIVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2015 04:21:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:51649 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318AbbHDIVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 04:21:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZMXT3-0004uc-FX
	for git@vger.kernel.org; Tue, 04 Aug 2015 10:21:01 +0200
Received: from 62.154.225.82 ([62.154.225.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 10:21:01 +0200
Received: from joerg.schaible by 62.154.225.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 10:21:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.154.225.82
User-Agent: KNode/4.14.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275241>

Hmmm. Is this the proper channel to report issues or should I go somewh=
ere=20
else?

J=C3=B6rg Schaible wrote:

> Hello guys,
>=20
> we have to turn some projects managed by Subversion into a GIT-based
> solution. However the conversion unfortunately fails with an error:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [...]
> Found branch parent: (refs/remotes/origin/tags/v_2.1.1)
> 450fa2c84a8fc087a2a66e5fb3d6d22096671f81
> Following parent with do_switch
>         M       changes.xml
>         M       pom.xml
> couldn't truncate file at /usr/lib64/perl5/vendor_perl/5.20.2/Git.pm =
line
> 1325.
> $ git --version
> git version 2.5.0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> Apart from the line number, the same error occurs also with GIT versi=
on
> 2.4.6 and 2.3.6 (latest stable version in Gentoo).
>=20
> The command to create the GIT repository was:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> $ git svn clone http://websvn/svn/essvn/standard/java-commons/lang -s
> --no- metadata --preserve-empty-dirs -A ~/tmp/authors.txt commons-lan=
g
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> Note, that the command succeeds even for 2.4.6 if we drop the --prese=
rve-
> empty-dirs option - at the cost of some empty directories which are u=
sed
> to trigger profiles for Maven; i.e. without those we cannot reproduce
> released versions.
>=20
> Cheers,
> J=C3=B6rg
