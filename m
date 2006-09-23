From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-project-version
Date: Sun, 24 Sep 2006 01:51:53 +0200
Message-ID: <20060923235153.GH20017@pasky.or.cz>
References: <87bqr0tbo6.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 24 01:52:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRHIB-0006WZ-Oo
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 01:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWIWXvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 19:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWIWXvz
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 19:51:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5844 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750941AbWIWXvz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 19:51:55 -0400
Received: (qmail 25396 invoked by uid 2001); 24 Sep 2006 01:51:53 +0200
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
Content-Disposition: inline
In-Reply-To: <87bqr0tbo6.fsf@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27640>

Dear diary, on Fri, Aug 04, 2006 at 11:48:25PM CEST, I got a letter
where Santi B=E9jar <sbejar@gmail.com> said that...
> Introduce an easy way for projects to get its git version. This is
> something that other projects using git would like to do, and we don'=
t
> want them all reinventing the wheel.
>=20
> Signed-off-by: Santi B=E9jar <sbejar@gmail.com>

Perhaps it would be more useful to have a flag for git-describe to
describe not the (HEAD) commit but your working copy (thus HEAD + check
for the dirtyness).

--=20
				Petr "Pasky the Hater of Too Many
					Commands" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=3Dpack('H*',/((..)*)$/)
