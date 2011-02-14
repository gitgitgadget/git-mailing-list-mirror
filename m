From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] fixes for ActiveState Perl
Date: Mon, 14 Feb 2011 16:26:51 +0100
Message-ID: <AANLkTinem19tDCdvrE2tK2bF2jojtYyh6-9WtepgdvAR@mail.gmail.com>
References: <4D5914C1.9050008@io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Mon Feb 14 16:26:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp0KI-0003i5-0u
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab1BNP0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 10:26:53 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61897 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab1BNP0w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:26:52 -0500
Received: by ewy5 with SMTP id 5so2295075ewy.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SEsWLYjueOk+Tlt5g/j5Hmox6E3J1b7nd+gPzDWP0Xg=;
        b=qUuPhZ8gZ8UTs2c4AalTOLyyoM/9Bt+bJKsWJgbyS6+miab/I2ctYw4Y+Ixpv0PAL3
         gMTZlrlBXbNuZ6nZ1Tzz+DrfK5+kuyQ2WOlxOvF3mS02TvmNYB58/PsRfSw1lf6F65lO
         8OiP+SFOAs98WQ5W1nhgYOMu8IerYjTO51qTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sqJCS1j2Y5xjv9us4/au2vPQwHFXZgp8eJcIa3lUd3SsTk8CBfOAFFpj9r/SoallYJ
         BRzcu9p0NMRYeApaqa+eMn+V5nJdCZYU5cgd3ezyDI2N+QF+k4NBsD70qxNbzkQsXMQ8
         ORA+PIsUbmQG1uEpjfT3rMZDTvlgblagZ/TR4=
Received: by 10.223.96.6 with SMTP id f6mr4681840fan.22.1297697211079; Mon, 14
 Feb 2011 07:26:51 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Mon, 14 Feb 2011 07:26:51 -0800 (PST)
In-Reply-To: <4D5914C1.9050008@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166727>

On Mon, Feb 14, 2011 at 12:40, Rafael Kitover <rkitover@io.com> wrote:

> =C2=A0 =C2=A0 =C2=A0 =C2=A0NO_MKSTEMPS =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SNPRINTF_RETURNS_BOGUS =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NO_SVN_TESTS =3D YesPlease
> - =C2=A0 =C2=A0 =C2=A0 NO_PERL_MAKEMAKER =3D YesPlease
> + =C2=A0 =C2=A0 =C2=A0 # NO_PERL_MAKEMAKER =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0RUNTIME_PREFIX =3D YesPlease

Aside from the comments Erik raised: If you're going to remove
something just remove it, don't comment it out.
