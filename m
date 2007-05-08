From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to set git commit timestamp
Date: Tue, 08 May 2007 03:54:38 +0200
Organization: At home
Message-ID: <f1ol0d$tcd$1@sea.gmane.org>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de> <200705062151.40261.robin.rosenberg.lists@dewire.com> <20070508013833.GB11311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 03:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlErK-00058C-OG
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966847AbXEHBuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 21:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966837AbXEHBuV
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:50:21 -0400
Received: from main.gmane.org ([80.91.229.2]:39291 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966847AbXEHBuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:50:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HlEqC-0007JA-TH
	for git@vger.kernel.org; Tue, 08 May 2007 03:50:12 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 May 2007 03:50:12 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 May 2007 03:50:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46511>

Shawn O. Pearce wrote:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>> s=F6ndag 06 maj 2007 skrev Guido Ostkamp:

>>> I am writing a tool to convert from another SCM to git and need to =
replay=20
>>> all checkins. I know how to set the log message and the author, but=
 there=20
>>> appears to be no command option for the timestamp (Mercurial for ex=
ample,=20
>>> has a 'hg commit -d date <file>' syntax for this).
>>=20
>> If you are writing a converter then you should really use the plumbi=
ng=20
>> commands rather than porcelains like git-commit and in particular yo=
u should=20
>> look at git-fast-import for a  really fast methord of importing (and=
 packing)=20
>> objects.
>=20
> As the author of a few convert-to-git things, fast-import really
> is the easiest way to import stuff into git, even if it doesn't
> need to be "fast".  The input format is quite simple to create,
> and is documented pretty heavily in the git-fast-import manual page.
>=20
> There's also contrib/fast-import/import-tars.pl which handles
> decompressing and importing one or more tar files into a Git
> repository.  Works pretty well...

By the way, is there fast-import version of git-quiltimport?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
