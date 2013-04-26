From: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: [PATCH] t9501: Do not use export X=Y
Date: Fri, 26 Apr 2013 15:14:41 -0300
Message-ID: <20130426181441.GF13306@sdfg.com.ar>
References: <201304252049.00811.tboegi@web.de>
 <7va9om2v9z.fsf@alter.siamese.dyndns.org>
 <517A4723.7050309@web.de>
 <7v38udz1da.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 20:38:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnX2-0005kG-JY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab3DZSiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 14:38:00 -0400
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:33386 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab3DZSh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:37:59 -0400
X-Greylist: delayed 1405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2013 14:37:59 EDT
Received: from [201.255.255.46] (helo=sdfg.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.76)
	(envelope-from <rodrigo@sdfg.com.ar>)
	id 1UVnAD-0007Fx-G9; Fri, 26 Apr 2013 15:14:30 -0300
Content-Disposition: inline
In-Reply-To: <7v38udz1da.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222550>

On Fri, Apr 26, 2013 at 09:46:09AM -0700, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
> > On 2013-04-25 22.46, Junio C Hamano wrote:
> >> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
> >>=20
> >>> Spilt lines like export X=3DY into 2 lines:
> >>> X=3DY
> >>> export X
> >
> > Side questions:
> > Which shells of which OS/distribution do not understand export X=3D=
Y?
>=20
> I have not met one for quite some time myself. cf.

It seems Solaris /bin/sh doesn't like it. I don't have a Solaris to tes=
t it, but
this recent commit of gzip does this change because of Solaris:

http://article.gmane.org/gmane.comp.gnu.gzip.bugs/795





Thanks a lot,
Rodrigo
