From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fixes git-cherry algorithmic flaws
Date: Sun, 24 Sep 2006 02:00:51 +0200
Message-ID: <20060924000051.GI20017@pasky.or.cz>
References: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 02:01:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRHQW-0007jO-5K
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 02:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWIXAAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 20:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWIXAAw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 20:00:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32472 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751282AbWIXAAw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 20:00:52 -0400
Received: (qmail 26415 invoked by uid 2001); 24 Sep 2006 02:00:51 +0200
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27641>

Dear diary, on Mon, Aug 07, 2006 at 12:30:13PM CEST, I got a letter
where Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi> said that...
> Old algorithm:
>         - printed IDs of identical patches with minus (-) sign; they
> 	  should not be printed at all
>         - did not print anything from the changes in the upstream
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>

Ping? Is this patch bogus or was it just forgotten?

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=3Dpack('H*',/((..)*)$/)
