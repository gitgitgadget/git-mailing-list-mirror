From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 17:09:57 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74482E50F03@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
 <20100506094212.GB9921@atjola.homenet>
 <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
 <4BE2BE2C.8050403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 06 17:10:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA2iN-0006C4-Qr
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 17:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab0EFPKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 11:10:05 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:32878 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab0EFPKC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 11:10:02 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o46F9wdM010653;
	Thu, 6 May 2010 17:09:58 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 6 May 2010 17:09:58 +0200
Thread-Topic: Any way to get complete diff up to a tag?
Thread-Index: AcrtHL6Jf6hukWUqTp2RAzy8Waz2MgADKepQ
In-Reply-To: <4BE2BE2C.8050403@viscovery.net>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146480>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Johannes Sixt
> Sent: den 6 maj 2010 15:04
> To: Peter Kjellerstedt
> Cc: Bj=F6rn Steinbrink; git@vger.kernel.org
> Subject: Re: Any way to get complete diff up to a tag?
>=20
> Am 5/6/2010 13:20, schrieb Peter Kjellerstedt:
> > Bj=F6rn Steinbrink
> >> git internally knows about the empty tree, so you can use:
> >> git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904 v1.7.1
> >>
> >> Bj=F6rn
> >
> > Thank you, that was useful. However, I need to be able to do this
> > for an arbitrary repository, and that SHA seems to be specific for
> > the git repository. How do I get the SHA for the empty tree in an
> > arbitrary repository?
>=20
> Aha, so you think Bj=F6rn et.al. were able to guess the SHA1 for your
> specific repository? ;)

No, not really, but I could not understand why it worked when I
tested it in my clone of git itself, but not in another git repository.

> No, the empty tree is the empty tree, and its name is as cited above,
> no matter where in the universe you are.
>=20
> -- Hannes

Well, I figured out my mistake. I had abbreviated the SHA1 since I
typed it in manually, and it worked fine in git's own repository,=20
but not in another repository. But when I used the full SHA1 it=20
worked in both. So I guess the empty dir SHA1 hardcoded in git just=20
happened to be the SHA1 for the empty dir in git's own repository...

Since the 4b825dc642cb6eb9a060e54bf8d69288fbee4904 SHA1 is somewhat
cumbersome to remember, wouldn't it be an idea to give it some kind=20
of alias or mnemonic? E.g., something like @~ (or some other mix of=20
odd characters which do not clash with all the other similar=20
constructs already used for references).

Anyway, thanks all for the help.
//Peter
