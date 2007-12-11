From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 07:03:55 -0800 (PST)
Message-ID: <m3myshs27c.fsf@roke.D-201>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
	<20071211142347.GA22879@diana.vm.bytemark.co.uk>
	<b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
	<m3r6hts2yk.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-14?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26fg-0000xs-FR
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbXLKPEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 10:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbXLKPEF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:04:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:35923 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbXLKPED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 10:04:03 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1302089nfb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=+M/OSrDmWz0tl+olYZv5b+GGW6SQsk7T+qCUbXCfMvY=;
        b=k4tRpCKB70j7xlv2t4k5ELu0UcIskSPmKdzhNKsXnhGTO+NAlU0sGcoMFiGtd+QmLckw/5W3hVEC7s0cSaWIivXdbx+IhfxJxiulcAMsFcZhBEpil2z01yaZcqcxEEulqZb5mFTojvYkYEUbuZCUfBeWs5LgWlKfKbo6biivd6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=ugywH6bhCFffHloDsyxVNj6VcSJN7s7ZLXzynAJYegXbRWd5HmiAAGqzPNc0vmFHZWhOcQ/+8b1UxwGO2FB+8lca0nHgaLuNgWKvTJSSmavbiWAeogeeJfEh2LXnMcrdz4bVKswu9IYYZ34/pckYqizc5fdNxe7WIe9fGTFLEwg=
Received: by 10.86.28.5 with SMTP id b5mr1491597fgb.1197385436274;
        Tue, 11 Dec 2007 07:03:56 -0800 (PST)
Received: from roke.D-201 ( [83.8.252.236])
        by mx.google.com with ESMTPS id 4sm158967fge.2007.12.11.07.03.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 07:03:55 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBBF3rpI010424;
	Tue, 11 Dec 2007 16:03:53 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBBF3qDg010421;
	Tue, 11 Dec 2007 16:03:52 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <m3r6hts2yk.fsf@roke.D-201>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67868>

Jakub Narebski <jnareb@gmail.com> writes:

> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>=20
> > On 11/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > > On 2007-12-10 11:40:41 +0000, Catalin Marinas wrote:
> > >
> > > > This release requires at least Python 2.4 and GIT 1.5.2.
> > >
> > > Yeah. So 0.14.1 (to be released very soon) should probably have t=
his
> > > fix. :-)
> >=20
> > Oops, I did some tests and forgot to revert it to 2.4. This would o=
nly
> > affect people using the source tarball. The rpm and deb packages
> > should be fine.
>=20
> Hmmm...
>=20
> $ rpm -Uhv --test stgit-0.14-1.noarch.rpm=20
> error: Failed dependencies:
>         python(abi) =3D 2.5 is needed by stgit-0.14-1.noarch
>=20
> Although I guess that it is something that rpmbuild sets (if not set)
> automatically during building.
>=20
> I'll just download SRPMS (which is available, just not linked from
> download area on homepage).

Ooops... I think I'd have to wait for 0.14.1

$ rpmbuild --rebuild --target=3Dnoarch stgit-0.14-1.src.rpm
[...]
Python version 2.5 or newer required. Found 2.4.3.final.0

--=20
Jakub Narebski
Poland
ShadeHawk on #git
