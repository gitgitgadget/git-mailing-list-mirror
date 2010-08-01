From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb not friendly to firefox revived
Date: Sun, 01 Aug 2010 13:26:16 -0700 (PDT)
Message-ID: <m3lj8qozan.fsf@localhost.localdomain>
References: <20100801195138.GA1980@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de,
	Stephen Boyd <bebarino@gmail.com>
To: =?iso-8859-15?q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun Aug 01 22:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Off77-0000Eb-Ge
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 22:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab0HAU0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 16:26:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57995 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab0HAU0S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 16:26:18 -0400
Received: by bwz1 with SMTP id 1so1174195bwz.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=9MJF3whIO5KwoR3R1IR5I0uNpngSly0P+r5wjdYeA+s=;
        b=MQeCYmTmZEq2gdHb1mKFYucv5ibkl/YU6JMDSb83/cmoJpC7PfJV1BFZEr7HWUbnmD
         YeC0M41/GWNVotrrIeJK4+PdMBvfup8q5WYIdGzeqAufPI21pK886DqwHAb5wnZ6dKnR
         FLIvCETPajeDIRw/Tg2s5J49Y8ulcLoFKGlTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=uZLqw7/PUPN7gd71WSer1JQMJqBYRSo1QFc2TT2G3JuACDLgW5hIp5i142iLJOnxFm
         MNYimLEMV4k6M0Ad4lRhWkFuTJlZS60RGm4/tGGms1D+eOpSKjHi9TpQ42Fnat4JEqI+
         WLj6vlvsFmriuaKwY8zmoruTmY3a3jOzgRel0=
Received: by 10.204.102.138 with SMTP id g10mr3475936bko.42.1280694376854;
        Sun, 01 Aug 2010 13:26:16 -0700 (PDT)
Received: from localhost.localdomain (abvf64.neoplus.adsl.tpnet.pl [83.8.203.64])
        by mx.google.com with ESMTPS id a9sm3484891bky.11.2010.08.01.13.26.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Aug 2010 13:26:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o71KQ42u003981;
	Sun, 1 Aug 2010 22:26:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o71KPrOV003974;
	Sun, 1 Aug 2010 22:25:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100801195138.GA1980@pengutronix.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152382>

Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:

> Hello,
>=20
> gitweb (at least) doesn't quote author names enough.
>=20
> Firefox barfs for me at looking at
>=20
> 	http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3Dv2=
=2E6.16.10
>=20
> with an error:
>=20
> 	XML Parsing Error: not well-formed Location:
> http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3Dv2.=
6.16.10
> Line Number 112, Column 81:
> <td class=3D"author"><a title=3D"Search for commits authored by YOSHI=
=46UJI Hideaki / ?$B5HF#1QL@?(B" class=3D"list" href=3D"/?p=3Dukl/linux=
-2.6.git;a=3Dsearch;h=3Dv2.6.16.10;s=3DYOSHIFUJI+Hideaki+/+%1B%24B5HF%2=
31QL@%1B(B;st=3Dauthor"><span title=3D"YOSHIFUJI Hideaki / ?$B5HF#1QL@?=
(B">YOSHIFUJI Hideaki...  </span></a></td><td><a class=3D"list subject"=
 title=3D"[PATCH] IPV6: XFRM: Fix decoding session with preceding exten=
sion header(s)." href=3D"/?p=3Dukl/linux-2.6.git;a=3Dcommit;h=3Dfa39df2=
ff7f6102f1f37d3cf1f68243534d56253">[PATCH] IPV6: XFRM: Fix decoding ses=
sion with preceding... </a></td>
> ---------------------------------------------------------------------=
-----------^
>=20
> This is with git 1.7.1 and Iceweasel (aka. Firefox) 3.5.10.
>=20
> Making
>=20
> 	title=3D>"Search for commits $performed by $author"
>=20
> in line 1694 of Debian's /usr/lib/cgi-bin/gitweb.cgi from the git 1.7=
=2E1
> package read
>=20
> 	title=3D>esc_html("Search for commits $performed by $author")
>=20
> this problem goes away.  (Still my browser barfs when clicking at the=
 name.)
>=20
> I'm not sure if this is the right way to fix this and I'm too tired n=
ow
> to do a complete patch, so I let this for someone else.

Actually gitweb leaves quoting of tag attributes to CGI module:

  return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
                                searchtext=3D>$author, searchtype=3D>$s=
earchtype),
                  -class =3D> "list",
                  -title =3D> "Search for commits $performed by $author=
"},
                 $displaytext);

I am worrying (perhaps unnecessary) that using esc_html would result
in double escaping.  But it looks like the problem is with Unicode,
so perhaps using

  	title =3D> to_utf8("Search for commits $performed by $author")

in place of

  	title=3D>esc_html("Search for commits $performed by $author")

would be a better fix?  Does this fix work for you?


Cc-ed Stephen Boyd, who is author of commit e133d65 (gitweb: linkify
author/committer names with search, 2009-10-15), introducing the code
you found this bug in.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
