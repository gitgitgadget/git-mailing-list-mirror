From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 02 Aug 2007 00:09:03 +0200
Organization: At home
Message-ID: <f8r09t$qdg$1@sea.gmane.org>
References: <46AFCF3E.5010805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: users@cvs2svn.tigris.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 00:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMNl-0007wN-42
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbXHAWJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Aug 2007 18:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbXHAWJW
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:09:22 -0400
Received: from main.gmane.org ([80.91.229.2]:59611 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbXHAWJV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:09:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGMNa-0008N6-Kt
	for git@vger.kernel.org; Thu, 02 Aug 2007 00:09:18 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 00:09:18 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 00:09:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.subversion.cvs2svn.user,gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54484>

Michael Haggerty wrote:

> I am the maintainer of cvs2svn[1], which is a program for one-time
> conversions from CVS to Subversion. =A0cvs2svn is very robust against=
 the
> many peculiarities of CVS and can convert just about every CVS
> repository we have ever seen.
>=20
> I've been working on a cvs2svn output pass that writes the converted =
CVS
> repository directly into git rather than Subversion. =A0The code runs=
 now
> with at least one repository from our test suite of nasty CVS reposit=
ories.

Have you contacted Jon Smirl about his unpublished work on cvs2git,
cvs2svn based CVS to Git converter?

Quote from InterfacesFrontendsAndTools page on GIT wiki[1]:

  cvs2git is the unofficial name of Jon Smirl's modifications to cvs2sv=
n.
  These modifications allow cvs2svn to generate a data stream which is
  consumed by Shawn Pearce's git-fast-import (now included in git.git).
  git-fast-import converts its input stream directly into a Git .pack f=
ile,
  minimizing the amount of IO required on large imports.

  Jon Smirl stopped working on cvs2git[2] because first, Mozilla (which=
 was
  main target of his work) decided that to not to move to git, and seco=
nd
  because of troubles with cvs2svn architecture[*] (which it is based o=
n).
  Jon Smirl has posted his impressions on working on CVS importer in=20
  "Some tips for doing a CVS importer" thread[3].

References:
-----------
[1] http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-23858c2cd=
e0cef60443d8e73e6829a95f8e191ef
[2] http://msgid.gmane.org/9e4733910611190940y147992b8mbdfac5a51f42e0fe=
@mail.gmail.com
[3] http://marc.theaimsgroup.com/?t=3D116405956000001&r=3D1&w=3D2

=46ootnotes:
----------
[*] If I remember correctly authors of cvs2svn were talking about separ=
ating
the code dealing with disentangling CVS repository structure from the p=
art
translating it into Subversion repository (with its quirks), and the pa=
rt
generating Subversion repository.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
