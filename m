From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Tue, 10 Oct 2006 12:41:49 +0200
Message-ID: <20061010104149.GP20017@pasky.or.cz>
References: <20061010025627.19317.70511.stgit@rover> <egfndo$lg6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 12:42:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXF3d-0002dW-JG
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 12:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWJJKlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 06:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWJJKlv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 06:41:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56469 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932617AbWJJKlu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 06:41:50 -0400
Received: (qmail 19887 invoked by uid 2001); 10 Oct 2006 12:41:49 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <egfndo$lg6$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28624>

Dear diary, on Tue, Oct 10, 2006 at 11:00:41AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
>=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0print $_ while (<$fd>);
>=20
> Wouldn't it be better to do it in slurp mode, i.e.
>=20
>         {
>                 local $/
>                 print <$fd>;
>         }
>=20
> instead?

I personally prefer my version as it prevents allocation of big chunks
of memory, but I don't really care in this particular case.

> Do you assume that README is HTML fragment? If not, you should esc_ht=
ml it.
> Besides, we have similar (if assumed to have one line only) file, nam=
ely
> description.

I _do_ assume that README is HTML fragment (so that you can use links,
non-proportional fonts, etc.), this is a difference to the description
file.

> Besides, README for a project can be huge. Git README has 589 lines!

This is not /README from the tree but README in the .git directory, so
it may not be the same. In the repo.or.cz admin interface, I limit
README to 8kb.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=3Dpack('H*',/((..)*)$/)
