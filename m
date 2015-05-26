From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 0/4] submodule config lookup API
Date: Tue, 26 May 2015 17:24:02 +0200
Message-ID: <20150526152402.GA31115@book.hvoigt.net>
References: <20150521170616.GA22979@book.hvoigt.net>
 <555E28E3.5020003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue May 26 17:24:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxGiK-0001s8-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 17:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbbEZPYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 11:24:16 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:47491 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbbEZPYO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 11:24:14 -0400
Received: from [188.108.15.115] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YxGi9-0005Xg-NO; Tue, 26 May 2015 17:24:09 +0200
Content-Disposition: inline
In-Reply-To: <555E28E3.5020003@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269946>

On Thu, May 21, 2015 at 08:50:11PM +0200, Ren=E9 Scharfe wrote:
> Am 21.05.2015 um 19:06 schrieb Heiko Voigt:
> >diff --git a/submodule-config.h b/submodule-config.h
> >index 9061e4e..58afc83 100644
> >--- a/submodule-config.h
> >+++ b/submodule-config.h
> >@@ -24,6 +24,6 @@ const struct submodule *submodule_from_name(const =
unsigned char *commit_sha1,
> >  		const char *name);
> >  const struct submodule *submodule_from_path(const unsigned char *c=
ommit_sha1,
> >  		const char *path);
> >-void submodule_free(void);
> >+void submodule_free();
>=20
> Why this change?  With void it matches the function's definition.

Sorry oversight on my side will remove it. Junio added those on his sid=
e
but it seems I forgot it in the header.

Cheers Heiko
