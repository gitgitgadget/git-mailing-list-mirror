From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] war on echo in scripts
Date: Fri, 9 Jul 2010 09:10:11 -0500
Message-ID: <20100709141011.GA1543@burratino>
References: <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
 <20100707094620.GC31048@genesis.frugalware.org>
 <7v7hl6stna.fsf@alter.siamese.dyndns.org>
 <20100708103552.GF31048@genesis.frugalware.org>
 <20100708171418.GA18229@burratino>
 <m2k4p58tum.fsf@igel.home>
 <20100709024633.GA13739@dert.cs.uchicago.edu>
 <AANLkTint6AfhwKdeizt-YVt4O6AZbLG9A5h6ipJyQyIQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 16:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXEII-0002iT-HA
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 16:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743Ab0GIOLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 10:11:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63381 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824Ab0GIOLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 10:11:03 -0400
Received: by iwn7 with SMTP id 7so2226736iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rBG8r1YZl9/hEjtC4v2hvmwRp3YJX1UYUMzGh20OKNY=;
        b=kdrCvQj0Yr29FigdDO34KAJRLoKnT4urxILXQYKkWK3o/G06Zj142ZQ6PBTkIioCkj
         jyclYgjDHXpXylMZqviJQKWb0ZtzAtQcU4Mwm+wHb7ckCWuYVJhddOdio5nlxVK6SzS1
         3u4YcFEcLx+HK1fNZdLbWgaBKpPA+/brr0vzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Cep66w+xH7kxsiQXhlnEfnypphLZ30IeHQPwq6A+1zEm4nrTsIHxU8j+g/0hJhyVO4
         kClj09FK31sUcPF3JTNDaK2T83N3pvTVaV6lEEunkGISJIxP4bK+bKDoMC+2WqnA2eij
         Zjy0rZjWNKy4t+OoobazWjukTPwRDsIqS4XoI=
Received: by 10.231.139.212 with SMTP id f20mr9137631ibu.166.1278684654707;
        Fri, 09 Jul 2010 07:10:54 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm4340711ibk.9.2010.07.09.07.10.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 07:10:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTint6AfhwKdeizt-YVt4O6AZbLG9A5h6ipJyQyIQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150669>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> (Via H.Merijn Brand): This fails on the old HP-UX 10.20 bourne shell:

Git commands require a Posix-style shell (with support for $() among
other things), which I suspect would rule out shells like the one
you=E2=80=99re talking about.  Still, portability is something to worry
about...

>     > cat xx.sh
>     #!/bin/sh
>=20
>     echo ()
>     {
>     perl -le'print "Done!"'
>     }
>=20
>     echo 1
>     echo Klaar
>     > sh xx.sh
>     xx.sh[3]: The operation is not allowed in a restricted shell.:
> echo is a shell builtin.
>     1
>     Klaar

That=E2=80=99s weird.  Where did =E2=80=9Crestricted shell=E2=80=9D com=
e into it?

Thanks for the example,
Jonathan
