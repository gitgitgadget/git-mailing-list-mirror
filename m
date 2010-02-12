From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: XML Parsing Error: junk after document element
Date: Fri, 12 Feb 2010 11:48:33 +0100
Message-ID: <201002121148.37761.jnareb@gmail.com>
References: <b713df2c1002102347g70cc212et21d507d44bb5aead@mail.gmail.com> <m3ocjw82ai.fsf@localhost.localdomain> <b713df2c1002112023k757a54faq933b9a9bdacc7d1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Siju George <sgeorge.ml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 11:48:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nft4y-00005z-N7
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 11:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab0BLKsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 05:48:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:41007 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab0BLKsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 05:48:50 -0500
Received: by fg-out-1718.google.com with SMTP id 22so11528fge.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3HP+TJ/quIrZGTKLGj3Rrhl3ni4sANnXVGDlf5ihUoE=;
        b=k0ie0GeAiFANhq5XQ2icKvnoTuTr9EY8JtsHb9x7l1qBJLzZ1zGcb+Pdxsh4KqT70n
         Uuqt3aUGbTTYORWPUzQQELb2+/DI1Qe7hm4BxvGnBV/N328v9mxKBiMcb21WuMcNxDjM
         k3N2HPMYEGupIh43CcNhD0rn3rjOZjk3ZqgsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rn4wxyLRidl9TQVxIFqtdOrRihW2RMyT4xgycTPUfE4cJM57VObHTaR8B+zTv6orTX
         hgGq1KLEvnunDCCa1YeCOBldaOB7SY4SKF/yu0/f3V0tp91Y3nzFSjP2jYf6kCgjrCwd
         HRvdTgoeQ33oBgfP6FpxqWJrFnld5MPjZf1GQ=
Received: by 10.87.47.3 with SMTP id z3mr2381394fgj.70.1265971729192;
        Fri, 12 Feb 2010 02:48:49 -0800 (PST)
Received: from ?192.168.1.13? (abvn168.neoplus.adsl.tpnet.pl [83.8.211.168])
        by mx.google.com with ESMTPS id l19sm764692fgb.5.2010.02.12.02.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 02:48:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b713df2c1002112023k757a54faq933b9a9bdacc7d1c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139680>

On Fri, Feb 12, 2010, Siju George wrote:
> On Thu, Feb 11, 2010 at 4:31 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
> >
> > Which version of gitweb?[1]
>=20
> gitweb-1.6.0.6  - all packages are from pkgsrc on DragonFly BSD
> v2.5.1.672.gf81ef-DEVELOPMENT #17: Tue Feb
>=20
> >=A0Which version of git?[2]
>=20
> scmgit-1.6.6.1

I don't think that difference in version numbers would be the problem.

Is this a version of git that gitweb (or to be more accurate web server=
)
sees?  Take a look at HTML source of page returned by gitweb, and at
the top there would be 'git core binaries version' in comment, and
'git/<version>' in the meta generator tag (this can be seen also in
"View Page Info" view, not only in "View Page Source").
=20
> > What web server?
> =20
>  apache-2.2.14nb1
>
> > Which version of CGI.pm is used by web server?[3]
> >
>=20
> $CGI::revision =3D '$Id: CGI.pm,v 1.263 2009/02/11 16:56:37 lstein Ex=
p $';
> $CGI::VERSION=3D'3.43';

This should not be a problem then.

> > Try to view source, or use different web browser that doesn't do
> > strict XML validation to find the source of this error.
> >
>=20
> I was using firefox 3.6-2.
> Trying with Konqueror Version 4.3.4 (KDE 4.3.4) Using KDE 4.3.4 (KDE
> 4.3.4) I dont get the error but it does not list my projectts. I get
> this message on the page.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> projects /
>=20
>=20
>  404 - No projects found
>=20
> OPMLTXT
> OK
> The requested URL /cgi-bin/gitweb.cgi was not found on this server.

You have two problems here.  First is that gitweb doesn't find your
projects because of problem with filesystem permissions.

Second is what it looks misconfigured web server.  The second part,
starting after [OPML][TXT] is not from gitweb, but from a web server.
It looks like you have either two web servers, or two parts of web
server configuration, or some worker of web server that didn't get
updated configuration, and it doesn't have permissions to access
gitweb.cgi or doesn't have configuration to know what to do with
the above URL.

What might help is, if you can, to restart your web server, something
like

  # apachectl restart           # as root

(I don't know what the proper command would be on DragonFlyBSD).

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>=20
> this page is shown when I take the URL
>=20
> http://172.16.3.27/cgi-bin/gitweb.cgi
>=20
> but I have the projectroot configure in gitweb.conf and there is a gi=
t
> project in that location.
>=20
> # cat /usr/pkg/etc/gitweb.conf | grep projectroot
> our $projectroot =3D "/Backup1/Data/git-repositories";
> # ls -l /Backup1/Data/git-repositories
> total 0
> drwxr-xr-x  1 root  wheel  0 Feb 11 10:40 systems-configuration
> # ls -l /Backup1/Data/git-repositories/systems-configuration/.git/
> total 0
> -rwxr-x---  1 root  wheel  393 Feb 11 11:03 COMMIT_EDITMSG
> -rwxr-x---  1 root  wheel   23 Feb 11 10:40 HEAD
> -rwxr-x---  1 root  wheel   92 Feb 11 10:40 config
> -rwxr-x---  1 root  wheel   73 Feb 11 10:40 description
> drwxr-x---  1 root  wheel    0 Feb 11 10:40 hooks
> -rwxr-x---  1 root  wheel  120 Feb 11 11:29 index
> drwxr-x---  1 root  wheel    0 Feb 11 10:40 info
> drwxr-x---  1 root  wheel    0 Feb 11 10:58 logs
> drwxr-x---  1 root  wheel    0 Feb 11 11:03 objects
> drwxr-x---  1 root  wheel    0 Feb 11 10:40 refs

Apache web server usually runs as apache:apache (user apache, group
apache); it most certainly *not* run as root, or is in wheel
(root-like) group.  So as you can see web server, and gitweb which
runs with the same uid and guid, doesn't have permissions to read
(access) your repositories.

You need to fix permissions, perhaps (as it seems to be your private
machine and private gitweb) by setting group to some common group
between you and web server and giving sticky group bit, or making
git repository world-readable: take a look at "shared repository"
thing: see description of core.sharedRepository config variable
(so that git wouldn't take world-readable permissions back).

BTW. what are you doing working as root?

> What could be the trouble?

=46ilesystem permissions on git repository, and some strange error in
web server configuration.  Unfortunately I haven't got a clue what
to do about the latter.

--=20
Jakub Narebski
Poland
