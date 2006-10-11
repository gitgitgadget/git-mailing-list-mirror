From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Wed, 11 Oct 2006 14:23:00 +0200
Message-ID: <200610111423.00656.jnareb@gmail.com>
References: <20061010025627.19317.70511.stgit@rover> <egfndo$lg6$1@sea.gmane.org> <20061010104149.GP20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 14:27:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXdA3-0004tI-UY
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 14:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWJKM0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Oct 2006 08:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWJKM0I
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 08:26:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:24991 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751238AbWJKM0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 08:26:07 -0400
Received: by ug-out-1314.google.com with SMTP id o38so92924ugd
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 05:26:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gCkuAyzduNWX8nSMnDcK/GPoifSlAya3uVIl5hg0US9UAWOnaThjhEc0gs4obS3H9cPDQdKxvis5/TRHb5xAOiYvm5+IfysVn2ZCW4bMX18xbstWi4h8FsCcGjJz+nt4NY74izvdevTOAC/CBeqwxXBAACZu9oQevJlqaZdXb20=
Received: by 10.67.119.13 with SMTP id w13mr928901ugm;
        Wed, 11 Oct 2006 05:26:05 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id l40sm655190ugc.2006.10.11.05.26.04;
        Wed, 11 Oct 2006 05:26:04 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061010104149.GP20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28712>

Petr "Pasky" Baudis wrote:
> Dear diary, on Tue, Oct 10, 2006 at 11:00:41AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
> > Petr Baudis wrote:
> >=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0print $_ while (<$fd>);
> >=20
> > Wouldn't it be better to do it in slurp mode, i.e.
> >=20
> >         {
> >                 local $/
> >                 print <$fd>;
> >         }
> >=20
> > instead?
>=20
> I personally prefer my version as it prevents allocation of big chunk=
s
> of memory, but I don't really care in this particular case.

Can any Perl expert tell us how Perl truly solve this? What is the best
way to dump whole [remaining] contents of file (from filehandle) to STD=
OUT?

> > Do you assume that README is HTML fragment? If not, you should esc_=
html it.
> > Besides, we have similar (if assumed to have one line only) file, n=
amely
> > description.
>=20
> I _do_ assume that README is HTML fragment (so that you can use links=
,
> non-proportional fonts, etc.), this is a difference to the descriptio=
n
> file.

Hmmm... perhaps better name would be description_long.html, or descript=
ion.html
Or at least README.html.

Description could be moved to the config file; your's project README co=
uldn't.

> > Besides, README for a project can be huge. Git README has 589 lines=
!
>=20
> This is not /README from the tree but README in the .git directory, s=
o
> it may not be the same. In the repo.or.cz admin interface, I limit
> README to 8kb.

Sorry. My mistake.
--=20
Jakub Narebski
Poland
