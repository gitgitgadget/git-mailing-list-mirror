From: thestar@fussycoder.id.au
Subject: Re: how to edit commit message in history
Date: Fri, 16 Jan 2009 15:31:56 +1100
Message-ID: <20090116153156.tfzar9idq8gwk0wg@webmail.fussycoder.id.au>
References: <20090116035714.GA6984@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 05:33:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNgOo-0006C3-AY
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 05:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbZAPEcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 23:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbZAPEcL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 23:32:11 -0500
Received: from cherry.cbr.hosting-server.com.au ([203.88.118.153]:36710 "EHLO
	cherry.cbr.hosting-server.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754589AbZAPEcK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 23:32:10 -0500
Received: (qmail 4306 invoked by uid 48); 16 Jan 2009 15:31:57 +1100
Received: from  ( [unknown]) by webmail.fussycoder.id.au (Horde MIME
	library) with HTTP; Fri, 16 Jan 2009 15:31:56 +1100
In-Reply-To: <20090116035714.GA6984@b2j>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105921>

You can't, that would default the whole point of git's sha1 hashes!

If you change a commit, you will change the sha1 hash of that commit, =20
and every subsequent commit. There is no way around it.

Quoting bill lam <cbill.lam@gmail.com>:

> I made some typos in commit messages, how to edit them without
> affecting everything else?
>
> Thanks in advance.
>
> --
> regards,
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> GPG key 1024D/4434BAB3 2008-08-24
> gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
> =E5=94=90=E8=A9=A9311 =E7=84=A1=E5=90=8D=E6=B0=8F  =E9=9B=9C=E8=A9=A9
>     =E7=9B=A1=E5=AF=92=E9=A3=9F=E9=9B=A8=E8=8D=89=E8=90=8B=E8=90=8B  =
=E8=91=97=E9=BA=A5=E8=8B=97=E9=A2=A8=E6=9F=B3=E6=98=A0=E5=A0=A4  =E7=AD=
=89=E6=98=AF=E6=9C=89=E5=AE=B6=E6=AD=B8=E6=9C=AA=E5=BE=97  =E6=9D=9C=E9=
=B5=91=E4=BC=91=E5=90=91=E8=80=B3=E9=82=8A=E5=95=BC
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
