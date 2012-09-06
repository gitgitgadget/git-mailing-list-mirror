From: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] fetch: align new ref summary printout in UTF-8 locales
Date: Thu, 6 Sep 2012 18:21:18 +0200
Message-ID: <B268CEF3-88A6-49B0-8AE7-7C06EDAE7CEF@web.de>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com> <1346755175-31468-1-git-send-email-pclouds@gmail.com> <504796A5.4070700@gmail.com> <5047A602.1020802@web.de> <CACsJy8D3VyFk+0PTeeXTN-Js9x7p+a+2vW+trry8-6q+9=m2xg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:22:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9eq7-00035L-Cm
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 18:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758782Ab2IFQVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 12:21:43 -0400
Received: from mout.web.de ([212.227.17.12]:53069 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915Ab2IFQVm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 12:21:42 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LopMx-1Tlkfz0M15-00fxco; Thu, 06 Sep 2012 18:21:21
 +0200
In-Reply-To: <CACsJy8D3VyFk+0PTeeXTN-Js9x7p+a+2vW+trry8-6q+9=m2xg@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:8QSY34sT556jnEbsRjs1iorrCVwU9ntqdQTiVkNKlAb
 Trj/mUp7LPdQ0qjCjQo0xMSXcnD7YjdQ0k58I3uu3KwqyCRigU
 7+sPzlYFVdayU+8sPhDU8+YocriBJpzLFuKGzGyB7IYoZfgKNc
 X5p+lvQMdRMuQIMGEN2S+ImIpKzVnhOU3owqrEF/lR/QGJJHgn
 kCRsPXXVXe0KS/u6kx6xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204900>


Am 06.09.2012 um 17:36 schrieb Nguyen Thai Ngoc Duy:

> On Thu, Sep 6, 2012 at 2:20 AM, Torsten B=F6gershausen <tboegi@web.de=
> wrote:
>>> Will that work for non-ASCII encodings?
>>> For ISO-8859-x we can say strlen() =3D=3D strwidth(),
>>> but for other encodings using multibytes that doesn't work, does it=
?
>=20
> BTW if you are interested in supporting non-utf8 output, you may want
> to look at 1452bd6 (branch -v: align even when branch names are in
> UTF-8 - 2012-08-26), which assumes branches are in utf-8. So you have
> to convert them to output charset before printing.
> --=20
> Duy

Thanks,
I try to re-phrase my question:

Do installations still exist which use e.g. BIG5 or any other
multi byte encoding which is not UTF-8?

Do we want to support other encodings than ASCII or UTF-8?
(Because then the screen width needs to be calculate different, I think=
)

/Torsten
