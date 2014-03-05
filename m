From: Lee Hopkins <leerhop@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Wed, 5 Mar 2014 09:02:48 -0500
Message-ID: <CAJHY66Fu-b8ugy7im=JtEQtYKFe5VVutMpCZGxYP0xCzeuzT_Q@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de>
	<530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net>
	<5310959D.709@gmail.com>
	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com>
	<CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
	<xmqqsiqzrwzr.fsf@gitster.dls.corp.google.com>
	<5315D3B9.6050602@gmail.com>
	<53163992.20701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:02:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLCPO-0005MF-Gv
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 15:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbaCEOCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 09:02:50 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:60778 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbaCEOCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 09:02:49 -0500
Received: by mail-qg0-f41.google.com with SMTP id i50so3022152qgf.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IIG2PoXakyWDrjIIA6Fyjwr7FUV/HzFDnqvPXNXjpXs=;
        b=BAR2DYtFcIZn5ny74d2ZUfVEG4Npo+1zkL89E9uVtY0Zro4/5ojCjp/EE//Vxq96Yd
         U1j+vs0lW6hWwOaZM5AbeD976h0rXGkDiZcAGmk738OcO03iQg61BheO3RyADa6loohA
         W73rpcdCOxCULIsR3lH73i2ki3dSRYrOZ1+WgHQyJS0ioSeyG2ybRkqUTVGlggPJVrBQ
         g43BHx8PV6nlLMghrcjYU5pISoBLUggaYGnSsZW8yiXSDm6su1R+HsRtr5CTeOSXXG71
         +H4I+QGM5nDNZC26rvN2HeEpYvpPi1gBqHaUKNJ0N8FQeXUdpAhFw50K37j7SEGjwHNA
         Fq7Q==
X-Received: by 10.224.60.71 with SMTP id o7mr6129961qah.38.1394028168644; Wed,
 05 Mar 2014 06:02:48 -0800 (PST)
Received: by 10.140.106.69 with HTTP; Wed, 5 Mar 2014 06:02:48 -0800 (PST)
In-Reply-To: <53163992.20701@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243436>

> Lee, could you improve your change in refs.c into a real patch, with a commit message?
> (And please have a look at the indentation with TABs)
>
> A test case could be good, if time allows I can make a suggestion.

I will remove the refs.ignorecase flag and work on a test care or two,
it will have to wait a few days tho.

> (and everything else could and should go into another patch:
>  If we ever want Linux to ignore the case in refs,
>  to ease the cross-platform development with Windows.
>  Or if we allow Windows/Mac OS to handle case insensitive refs (by always packing them)
>  to ease the co-working with e.g. Linux.
> )

I was actually planning on tying to add this to my changes if they
gained any traction. Why is another patch desirable?

> If the variable is not in 'core.' namespace, you should implement
> this check at the Porcelain level, allowing lower-level tools like
> update-ref as an escape hatch that let users bypass the restriction
> to be used to correct breakages; it would mean an unconditional "if
> !stricmp(), it is an error" in refs.c will not work well.
>
> I think it might be OK to have
>
>         core.allowCaseInsentitiveRefs = {yes|no|warn}
>
> which defaults to 'warn' (and 'yes' corresponds to 'allow', 'no'
> corresponds to 'error', in the previous suggestion), instead. If we
> wanted to prevent even lower-level tools like update-ref from
> bypassing the check, that is.

I also would not mind working on either of Junio's suggestions if one
is more desirable than what I already have.

-Lee
