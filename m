From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sun, 16 May 2010 09:36:51 +0400
Message-ID: <20100516053651.GB17200@dpotapov.dyndns.org>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
 <m3pr0wd880.fsf@localhost.localdomain>
 <AANLkTikgs3d1YagU5lRCkEM9uwWe9dmifbHvIjhsk_wF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 07:37:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODWXG-0006hP-11
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 07:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab0EPFg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 01:36:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60347 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0EPFg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 01:36:56 -0400
Received: by fxm6 with SMTP id 6so2714341fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8wRgSm6nndQ6pRo8FBFdAAmNHBPh7gbthuoVrJpbeU8=;
        b=X6kXeoaAarXEKN2GuSltojdoYN1I6zidI0D97bl+BiTwCslYzyqioZUDEjIxkZ20ro
         uPwTktsB77qIa+Kf0LHW7leGBtjulSQRO0pOqmP1hfL6417F/mFmBwnO2Dn9GiZlA2rD
         W9mozAs1XJie4ykZ6/TTQw34khpYoD4rPkbCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=stAdUxdfjiIHe+hb/omJkhwzhWNMrLbmpfNzUUcLvd+YrjjAZw0ZxHtczmkS5gOsBR
         P/gPNTRr2YjADBpi3FpjVQO3uWyG5lG49krba7xzuo3FSD2JJTPEJIez0b8Mu/SSyy/7
         VlqjO6kVkVlauPSaBbgwOM27CLnTgndabIalo=
Received: by 10.223.24.5 with SMTP id t5mr4119093fab.72.1273988214912;
        Sat, 15 May 2010 22:36:54 -0700 (PDT)
Received: from localhost (ppp85-140-167-233.pppoe.mtu-net.ru [85.140.167.233])
        by mx.google.com with ESMTPS id 7sm19220065far.6.2010.05.15.22.36.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 22:36:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikgs3d1YagU5lRCkEM9uwWe9dmifbHvIjhsk_wF@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147176>

On Sun, May 16, 2010 at 01:12:20AM +0000, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
>=20
>     GETTEXT=3D`which gettext 2> /dev/null`
>     if [ -z $GETTEXT ] ; then GETTEXT=3D'echo -n'; fi

'echo -n' is not portable, and it is not used in git for this reason.

Dmitry

> And then just:
>=20
>     - echo "We are not bisecting."
>     + $GETTEXT "We are not bisecting."

If gettext does not add the trailing newline to the message then it is
clearly not equivalent replacement.


Dmitry
