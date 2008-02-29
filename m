From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Summer of Code 2008
Date: Fri, 29 Feb 2008 13:04:15 +0100
Message-ID: <200802291304.16026.jnareb@gmail.com>
References: <200802262356.28971.jnareb@gmail.com> <20080228063621.GR8410@spearce.org> <alpine.LSU.1.00.0802281021070.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 13:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV3zL-00081o-Ld
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 13:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbYB2MEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Feb 2008 07:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbYB2MEl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 07:04:41 -0500
Received: from ik-out-1112.google.com ([66.249.90.178]:29030 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbYB2MEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 07:04:39 -0500
Received: by ik-out-1112.google.com with SMTP id c28so2194145ika.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 04:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=nmcuKtJGIV8rm087x+BjPsUx8Gt9MXu1N6f3vYnTqRg=;
        b=lUbSfW7uvEY4CyqMDvJfmDGdgaCPZGZkmVNedDAXXHGj90QdzyO/SNsIk4qxsOcbzcF+zS6x0pmanWLxehBiL+fnFgB05GEsJl2kWWLvUhciOkJIFcVQxBwrgNHpPZvEr7QDn6mtEzb+E6gSQmR0+K+zFmCROk/XHmnaQ/4xeBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tqdR3Pc61qa3xB/487IBR0feKo6gwh7WlSGD/6aECwEJfGlvlbR0jMIIkOxlryjobAzLO5zjT2rumPPW80/e+VMbgOCQig9M4C5GpxwivnWpPd97gANXSa1Dq9LqRxI0aJDJxWsjuntGlHv+1vy7G/H0is8lInt+njokfk/ebn4=
Received: by 10.78.172.20 with SMTP id u20mr9816833hue.12.1204286677895;
        Fri, 29 Feb 2008 04:04:37 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.217.18])
        by mx.google.com with ESMTPS id f6sm4471807nfh.21.2008.02.29.04.04.29
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 04:04:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281021070.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75526>

On Thu, 28 Feb 2008, Johannes Schindelin wrote:
> Do go ahead! =A0I started the page
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0http://git.or.cz/gitwiki/SoC2008Ideas
>=20
> which is utterly incomplete. =A0I just took the ideas of 2007 that I =
am=20
> still interested in,

By the way, when looking at 2007 GSoC ideas one can see that some of=20
them got implemented already outside of GSoC, and are no longer valid;=20
well, perhaps as "improve <sth>" ideas.=20

Subproject/submodule support got implemented, Mozilla has decided to us=
e=20
Mecurial instead of Git (but there are other large-scale imports:=20
OpenOffice.org, GCC) and cvs2svn supports fast-import output which=20
means export to git, gitattributes support got much extended.

> and removed other people from the Mentor list, =20
> because I do not want to force them. =A0So please, if you are interes=
ted
> in mentoring one of the existing projects, just add yourself.
>=20
> And of course add all those cool projects you have in mind.

I have some interesting ideas for GSoC, but unfortunately none (with=20
perhaps single exception) that I could mentor. So I think I'd list them=
=20
here for now, and later I'd add it to SoC2008Ideas page.

Here they are.

=46irst, a few ideas which got partially implemented already, or are=20
implemented and need improvements. I don't know if current contributors=
=20
would want to be mentors, or would they want to submit their work under=
=20
GSoC as participants.

* Lazy clone / remote alternates

  The idea here is to be able to remotely access objects from a network
  based object server, as neededm rather than having them all local.

  Goal: A working lazy clone prototype implementation that could be
  considered for inclusion, in a nice series of commits (separate
  branch/fork)
  Language: C
  Suggested mentor: Jan Holesovsky, who submitted proof-of-concept
  patch for lazy clone

* Partial (subtree) checkout, or its generalization: sparse checkout

  The idea is to checkout for example only Documentation subdirectory,
  work on it, but commit full tree. Some workflows may be better suited
  to this type of usage than using submodules. Optionally should includ=
e
  partial clone (not needed objects not in repository).

  Goal: A working partial checkout prototype implementation, with
  technical documentation.
  Language: C
  Suggested mentors:=20
    gitzilla (sent proposal),=20
    Nguyen Thai Ngoc Duy (pclouds), proposed to implements it

* Gitweb caching

  Implementing very smart caching in gitweb, to avoid the thundering
  herd problem on kernel.org whenever a repository gets updated, or at
  least support for caching engines in the form of generating proper
  Last-Modified: and ETag: headers, and responding to If-Modified-Since=
:
  and If-None-Match: requests, cheaply.=20

  Perhaps becoming the gitweb maintainer could come of it, or at least
  the gitweb admin for kernel.org (sorely needed).

  Goal: At minimum, port kernel.org's caching to mainline (git's) gitwe=
b
  Language: Perl, HTML, perhaps JavaScript
  Suggested mentors:
    John 'Warthog9' Hawley (wrote caching for kernel.org's gitweb)
    Petr Baudis (repo.or.cz admin)
    Lars Hjemli (cgit author, git web interface in C, with caching)
    Jakub Narebski (gitweb contributor)

Then, a few ideas which were proposed for GSoC 2007, but never=20
implemented, and wasn't mentioned in this thread or on wiki for
GSoC 2008 yet

* Git / Subversion Interoperability

  The idea here is implement something in Git that speaks the Subversio=
n
  protocol on the wire, but uses Git as the backend storage. (This woul=
d
  be like the existing git-cvsserver.)

  There are two potential approaches:

   1. git-svnserver
   2. write a backend for Subversion

  Goal: To be able to access git repository, at minimum read-only, from
  a Subversion client, at least svn CLI.
  Language: Open for proposal.
  Suggested mentors:=20
    Eric Wong (git-svn author)
    Matthias Urlichs (git-svnimport author)
  Notes: I don't think we could pass it as Subversion SoC project, but
  I guess that we could ask for co-mentor for the Subversion protocol,
  or Subversion backend part of this task.

I'd send other ideas (including new ones, like translating svn:external=
s=20
into git submodules in git-svn; or making git mode for Emacs have all=20
features of tig, git-gui and gitk; or improving shallow clone support)
in a later post.

> Shawn, do we have to do the same again, as on this page?
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0http://git.or.cz/gitwiki/Soc2007Application

A few things changes for us: we have participated in GSoC 2007; we need=
=20
to find backup organization administrator (was: Martin Langhoff for=20
GSoC2007), list of mentors would change most probably.

As far as I've checked the application form for organizations didn't=20
change...
--=20
Jakub Narebski
Poland
