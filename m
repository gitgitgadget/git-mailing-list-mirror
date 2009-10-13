From: bill lam <cbill.lam@gmail.com>
Subject: Re: quote in help code example
Date: Tue, 13 Oct 2009 22:06:23 +0800
Message-ID: <20091013140622.GA3927@debian.b2j>
References: <20091012102926.GA3937@debian.b2j>
 <20091012194016.GS23777@genesis.frugalware.org>
 <20091013021616.GA10554@debian.b2j>
 <20091013101916.GV23777@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 16:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxiBF-0007CK-9q
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 16:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759953AbZJMOIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 10:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759942AbZJMOIU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 10:08:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:15857 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759903AbZJMOIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 10:08:19 -0400
Received: by fg-out-1718.google.com with SMTP id 16so833610fgg.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=l6IxYgA/L2ZrLu0X7LkH7CDRJtEEmJEGoakok0cPA+g=;
        b=un+9VGTNS0Q3L8rjuT3/NYgC0m/y/gP1Ad8+RhkrPvHX+dHs0v+2pbD0cuxVgCuGrQ
         REByox/PVvGnfLERJfaV3F0JwSt/KBYe9FxyMB/ImaIaOfzluWyaFd/JVdG5r2pGiVqF
         EAMST+TmYFIGLpo9zbwA0ymrvsopuUxTKr0UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VQNHoILzgAglUuzIFAi6y5LLC+KVndn/oKeZmKtW8yZvio+OSGO1oMq6Om6dtfb5GB
         3P+1+UNwlXExI1C81KQ5a5crK0q0HU+RjT6e37JTzGbMOHGCqATilzNHds/paqD86n8r
         KWSqrhg2wXG/koxMj1pvMqTgvCjs6vfYVUtfI=
Received: by 10.86.249.30 with SMTP id w30mr6412371fgh.35.1255442791496;
        Tue, 13 Oct 2009 07:06:31 -0700 (PDT)
Received: from localhost (n219079103006.netvigator.com [219.79.103.6])
        by mx.google.com with ESMTPS id 4sm117331fgg.28.2009.10.13.07.06.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 07:06:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091013101916.GV23777@genesis.frugalware.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130163>

On Tue, 13 Oct 2009, Miklos Vajna wrote:
> On Tue, Oct 13, 2009 at 10:16:17AM +0800, bill lam <cbill.lam@gmail.c=
om> wrote:
> > > Just a guess: do you have docbook-xsl >=3D1.73.0 and you did not =
set
> > > ASCIIDOC_NO_ROFF?
> > >=20
> > > Try rebuilding the documentation using 'make ASCIIDOC_NO_ROFF=3DY=
esPlease'.
> >=20
> > I'm not familiar with how to twist git makefile.  By adding a line =
to ./Makefile
> >=20
> > # Platform specific tweaks
> > #
> >=20
> > # We choose to avoid "if .. else if .. else .. endif endif"
> > # because maintaining the nesting to match is a pain.  If
> > # we had "elif" things would have been much nicer...
> >=20
> > ASCIIDOC_NO_ROFF =3D YesPlease       # <--- this line added
> > ifeq ($(uname_S),Linux)
> >=20
> > However, the man page still display the same
>=20
> Don't edit the Makefile, just use the command 'make
> ASCIIDOC_NO_ROFF=3DYesPlease'. Also make sure to do a 'make clean' in=
 the
> Documentation dir to get the manpages rebuilt.

I run these commands=20

make ASCIIDOC_NO_ROFF=3DYesPlease prefix=3D/usr all doc info
sudo make ASCIIDOC_NO_ROFF=3DYesPlease prefix=3D/usr install install-do=
c install-html install-info

1. did I need to set ASCIIDOC_NO_ROFF in both lines?
2. now the .ft pair fixed but it still displayed incorrect quote.

 git filter-branch --tree-filter =B4rm filename=B4 HEAD

it should be 'rm filename' not =B4rm filename=B4

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
