From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH next 2/2] Remove python 2.5'isms
Date: Thu, 10 Jun 2010 00:46:20 +0200
Message-ID: <AANLkTilCVoLJQaGroSFWx46KclPj_PBfNYH6-ghoY0N_@mail.gmail.com>
References: <nduJYSHPH3U3cC4hTqPaVi-iLDqB7pemU3zevJMNRmyDsRKmtq_gVu-G9W-She7bPSFG9LafRk0@cipher.nrlssc.navy.mil> 
	<nduJYSHPH3U3cC4hTqPaVieVkcHeedXMjA92T_KB9XTSNMZ0NeKHomHE5LPZ65BzOnHb--wYKXY@cipher.nrlssc.navy.mil> 
	<AANLkTikmdsJwy06WuRwpLEKzZE45VZcvPDDxnW1OCb8K@mail.gmail.com> 
	<201006100040.54375.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>,
	davvid@gmail.com, Brandon Casey <drafnel@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 00:54:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMU9u-0002aI-TV
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 00:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758583Ab0FIWxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 18:53:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45893 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758337Ab0FIWxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 18:53:54 -0400
Received: by yxl31 with SMTP id 31so1232708yxl.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=801Kzyw015miyoNLt9FdgcN358uuXq/ETXtfT7Tu210=;
        b=R7y+C1DZuJrVSIq+mwgDCFUHaQSCFBF2MXDX5HalCskp0IaCt18G4Z9y4g7G6aUFc2
         uN4A0YKfgvCTKFvJw6edgs9KQeylEDVES/k5YwijlLhe6pdzUAz9Zu/JrZmZTjmez3iU
         RqIVt1C/wRqx9xU44zDh2g7E+LwveTWKSe7oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gSwZsN7dvzN+GsB+z7DO7K6dBQTIiWrcMi5uDeoPvaWZW2gDUpWr7ZM+E7XhImou/j
         qvM+c2XfiwPl7+cnkH2cFYyNqIdi/IE9QTa1kA+36lAPtu7wNgFQEvsfHimE1ztdJAjU
         DgvYGV7gY4/hyAyO+QcRtjWZ7mVb3ZmlDlVIg=
Received: by 10.150.183.21 with SMTP id g21mr875623ybf.69.1276123600121; Wed, 
	09 Jun 2010 15:46:40 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Wed, 9 Jun 2010 15:46:20 -0700 (PDT)
In-Reply-To: <201006100040.54375.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148825>

Heya,

On Thu, Jun 10, 2010 at 00:40, Johan Herland <johan@herland.net> wrote:
> =C2=A0# hashlib is only available in python >=3D 2.5
> =C2=A0try:
> =C2=A0 =C2=A0 =C2=A0import hashlib
> =C2=A0 =C2=A0 =C2=A0_digest =3D hashlib.sha1
> =C2=A0except ImportError:
> =C2=A0 =C2=A0 =C2=A0import sha
> =C2=A0 =C2=A0 =C2=A0_digest =3D sha.sha
>
> so that we don't get the hideous DeprecationWarning.

This is exactly what I meant to suggest earlier, but I didn't know the
appropriate routine in python 2.4, thanks Johan.

--=20
Cheers,

Sverre Rabbelier
