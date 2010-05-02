From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFD: tables in documentation
Date: Sun, 2 May 2010 12:53:54 -0500
Message-ID: <20100502175353.GA15521@progeny.tock>
References: <4BDC74F3.2020206@drmicha.warpmail.net>
 <20100502050622.GF14776@coredump.intra.peff.net>
 <4BDD7E96.2050603@drmicha.warpmail.net>
 <1272811394.24767.7.camel@dreddbeard>
 <1272811916.24767.16.camel@dreddbeard>
 <4BDD956F.5070800@drmicha.warpmail.net>
 <4BDD99F3.9000305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: wmpalmer@gmail.com, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 19:54:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8dMo-0007xR-2X
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 19:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758404Ab0EBRyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 13:54:00 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:53406 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab0EBRx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 13:53:58 -0400
Received: by iwn40 with SMTP id 40so2290543iwn.1
        for <git@vger.kernel.org>; Sun, 02 May 2010 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oJrkXZkS6hlnfq6i3bOez1ZOkIPQ3Vy4oMuv71p8qow=;
        b=XxTB73Mzp4M9Dao7yzV/QpdbhfMftqjBh7N0Pr4WxzOQDq09qGhX8I0NzG7RVWCvdo
         5oZJrdt/M5dnu6n3U2KJeXzqR5+rofRrZ9YYp6EIsCAKkuQB0dIKOnffR47AmVGl3X/D
         77sKgGVgBUbo0rYJo1BwsJ4O35gBA6HRf/OJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=G6oEqjipqlNJp8vBYPBH5Z4lVIq0DJuOZ7S+X0pL/VfuNgDSfK1liXhB3xCe9C3ORY
         84/LYlZeXbkVPK3Tp46GqrjJeimZinCkUMYBYyz9l8vOEUEBhY8EPRW9LNHH80NBKAhP
         3IOsPZ5KcgtuUwqY7KU+Trqjf6Z0GSMb/2RjM=
Received: by 10.231.149.71 with SMTP id s7mr3507501ibv.86.1272822837255;
        Sun, 02 May 2010 10:53:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3585972iwn.7.2010.05.02.10.53.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 10:53:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BDD99F3.9000305@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146192>

Hi Michael,

Michael J Gruber wrote:
> Michael J Gruber venit, vidit, dixit 02.05.2010 17:08:

>> Further experimentation (editing the xml) indicates that with my
>> toolchain, I can either shut off all borders (between cells as well =
as
>> outer) or none.
[...]
> For completeness, it results in this:
>=20
>      I                H         M               Result
>=20
>  0   nothing          nothing   nothing         (does not happen)
>=20
>  1   nothing          nothing   exists          use M
>=20
>  2   nothing          exists    nothing         remove path from inde=
x
>=20
>  3   nothing          exists    exists, H =3D=3DM   use M if "initial
>                                                 checkout", keep index
>      exists, H !=3D M             fail            otherwise
>=20
> [Same unealt rowspan issue, of course.]

=46or what it=E2=80=99s worth, except for the broken last row, I like t=
his and
find it readable.  It is too bad there is no way to make it more
compact so more rows can fit on a screen or page.

The ideal, to delimit the header without appearing busy, would be to
just have a thin horizontal rule separating the header from the
remaining rows[1].  Vertical rules are almost never a good idea.
Maybe frame=3D"topbot",grid=3D"none",options=3D"header" would be a good
approximation.

Jonathan

[1] Just my opinion.  I probably learned the aesthetic from Simon Fear.
http://www.tex.ac.uk/cgi-bin/texfaq2html?label=3Ddestable
