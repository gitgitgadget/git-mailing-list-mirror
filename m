From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: provide a way to customize html headers
Date: Fri, 21 Oct 2011 21:14:33 +0200
Message-ID: <201110212114.34325.jnareb@gmail.com>
References: <201110170928.56075.lenaic@lhuard.fr.eu.org> <201110171357.00278.jnareb@gmail.com> <201110210046.34679.lenaic@lhuard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?L=C3=A9na=C3=AFc_Huard?= <lenaic@lhuard.fr.eu.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 21:14:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHKYL-0001S1-I3
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 21:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab1JUTOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 15:14:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57594 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab1JUTOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 15:14:43 -0400
Received: by eye27 with SMTP id 27so4157584eye.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=FZCSHzMtlD9heldTq2Ki/X8tjwp5P5NkswkVe0mWvMk=;
        b=jJJPiXI5zNWF43St7ofNGqLl7Uh373+XcafELkv1jeDSGZ+QbzbnRIL9/lWjgocyNk
         KarFe2GBO/86/tdBwUu3Wy1YNJt+roSBA0goH4GTxlJ8hOcdMFlBF2ljXMdzH28PUHX8
         OfvX+qHCXGnWof6iUluce+I44JyeUHD2oM/NQ=
Received: by 10.223.14.3 with SMTP id e3mr23785227faa.25.1319224482482;
        Fri, 21 Oct 2011 12:14:42 -0700 (PDT)
Received: from [192.168.1.13] (abwe57.neoplus.adsl.tpnet.pl. [83.8.228.57])
        by mx.google.com with ESMTPS id v17sm23695541fai.18.2011.10.21.12.14.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 12:14:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201110210046.34679.lenaic@lhuard.fr.eu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184079>

Dnia pi=C4=85tek 21. pa=C5=BAdziernika 2011 00:46, L=C3=A9na=C3=AFc Hua=
rd napisa=C5=82:
> Le lundi 17 octobre 2011, Jakub Narebski a =C3=A9crit :
>> On Mon, 17 Oct 2011, L=C3=A9na=C3=AFc Huard wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>> L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr.eu.org> writes:
[...]
>>>>> =C2=A0gitweb/INSTALL =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +++
>>>>=20
>>>> Nb. there is patch in flight adding gitweb.conf(5) and gitweb(1)
>>>> manpages...
>>>=20
>>> Ok. So, I=E2=80=99ll update them once a decision will be taken conc=
erning this
>>> $site_htmlheader.
>>=20
>> You might have to wait a bit till patches containing gitweb.conf(5)
>> manpage are merged in, and rebase your patch to add information abou=
t
>> new config variable not to gitweb/INSTALL, but to
>> Documentation/gitweb.conf.txt
>=20
> I added the documentation to Documentation/gitweb.conf.txt.
> But, as I noticed that gitweb/INSTALL still exists and still document=
s the
> old variables, I left the doc of the new one.
>=20
> =C2=A0Documentation/gitweb.conf.txt | =C2=A0 =C2=A05 +++++
> =C2=A0gitweb/INSTALL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A02 ++
> =C2=A0gitweb/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A02 ++
> =C2=A0gitweb/gitweb.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A07 +++++++
> =C2=A0t/gitweb-lib.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A01 +
> =C2=A05 files changed, 17 insertions(+), 0 deletions(-)

Well, gitweb/INSTALL documents _build_ time [make] variables, and that
didn't change with introduction of gitweb manpages.  Those are importan=
t
only during explanation.

It is only runtime _configuration_ that moved from gitweb/README (which
should be short description of project) to manpages for gitweb config.

--=20
Jakub Narebski
Poland
