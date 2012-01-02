From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git alias question
Date: Mon, 2 Jan 2012 00:57:44 -0500
Message-ID: <CAFLRbopp1ROfMqp3PVdUQ37_fdku2FtV-=pxuYk-YA-+_wgjPg@mail.gmail.com>
References: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
	<CAD0k6qTp9sKCb==Jh1vuLuZoxx99Kt2Z=VAbjYbGaUE7nbOxdQ@mail.gmail.com>
	<CAJDDKr5a8TB82h4ULWtamLOVu_4Fv+cGw1YfEL987gM3yM4TMg@mail.gmail.com>
	<CAFLRborAuoWKxOeHtPRujSYbQPk67RCxTiVBavtWDeh-Byfa2w@mail.gmail.com>
	<m3zke8e2vh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Dave Borowitz <dborowitz@google.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 02 06:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhauA-0002d5-1J
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 06:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937Ab2ABF5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jan 2012 00:57:46 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58689 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2ABF5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jan 2012 00:57:45 -0500
Received: by dajs34 with SMTP id s34so9765746daj.19
        for <git@vger.kernel.org>; Sun, 01 Jan 2012 21:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Q+wDVkhaQmiNuGEE1LY+n8tu0vls6x6dNRazy066n0=;
        b=fYm53gzekiVg+ELREhYtr1m1vtz+LZajB/MOv0s4/Te4uYpUkMaUIWqYocD1/cYsxE
         pHomG/or17pPBXiVNKTOcUicGLXo7m70/2s+EbTYhtBWtSiuI+qtrEnsuRcGerSyeyuV
         Ew5jU+mgVbdz6mN9UiKSD5SON9HvyFA2IHTH0=
Received: by 10.68.190.65 with SMTP id go1mr118413325pbc.7.1325483864655; Sun,
 01 Jan 2012 21:57:44 -0800 (PST)
Received: by 10.142.102.16 with HTTP; Sun, 1 Jan 2012 21:57:44 -0800 (PST)
In-Reply-To: <m3zke8e2vh.fsf@localhost.localdomain>
X-Google-Sender-Auth: 8KDlG7k6c7lupecjj30M_v2deCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187834>

Nice, works perfectly!  Didn't notice that was there, guess last time
I looked, I was using an older version.  I see it is in the git config
man page and all now.

Thanks,

Mike



On Sat, Dec 31, 2011 at 6:30 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> Michael Horowitz <michael.horowitz@ieee.org> writes:
>
> > The log operation does seem to make the most sense as the mechanism=
 to
> > search for the results. =A0Making it work with difftool would work.=
=2E.
> > Not sure if "--log" to difftool or some other options as suggested =
in
> > the other thread would be most consistent UI-wise as stated, but
> > either would work for me.
> >
> > On a separate note, some environment variable like GIT_PREFIX with =
the
> > CWD would make the alias functionality more flexible.
>
> 1f5d271 (setup: Provide GIT_PREFIX to built-ins, 2011-05-25) is
> present in v1.7.7; 7cf16a1 (handle_alias: provide GIT_PREFIX to
> !alias, 2011-04-27) is in 1.7.6
>
> --
> Jakub Narebski
