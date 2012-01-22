From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Checkout tag?
Date: Sun, 22 Jan 2012 18:33:52 +0100
Message-ID: <20120122173352.GA1068@jpl.local>
References: <1327226753653-7213023.post@n2.nabble.com>
 <20120122101116.GA31022@jpl.local>
 <1327227956026-7213061.post@n2.nabble.com>
 <20120122113115.GA31545@jpl.local>
 <20120122170800.GA29215@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>,
	Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 18:35:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp1Jo-0000jP-Fz
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 18:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab2AVRek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jan 2012 12:34:40 -0500
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:41505 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab2AVRej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 12:34:39 -0500
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 20544E9668
	for <git@vger.kernel.org>; Sun, 22 Jan 2012 18:33:53 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnhOAG9HHE9T46eEPGdsb2JhbABDiVCkUxkBAQEBNzKBcgEBBAEyASMjBQsLDgocEhQNCwEMChoTh3wCtyaLQ2MElRiLBIdM
X-IronPort-AV: E=Sophos;i="4.71,552,1320620400"; 
   d="scan'208";a="253279513"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb2.telenor.se with ESMTP; 22 Jan 2012 18:33:53 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 4934D42309; Sun, 22 Jan 2012 18:33:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120122170800.GA29215@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188968>

On Sunday, January 22, 2012 at 18:08 CET,
     Jonathan Nieder <jrnieder@gmail.com> wrote:

> Magnus B=E4ck wrote:
>=20
> > Looking at an up to date Git 1.7.9-rc2 man page, it still seems
> > slightly inconsistent with itself. The synopsis at the top says
> >
> >       git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]
> >
> > while the text in the DESCRIPTION section says
> >
> >       git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...
>=20
> Hmm, my copy says:
>=20
> 	SYNOPSIS
>=20
> 	git checkout [-q] [-f] [-m] [<branch>]
> 	git checkout [-q] [-f] [-m] [--detach] [<commit>]
> 	git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_=
point>]
> 	git checkout [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] [--] <paths>...
> 	git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]

Perhaps I wasn't clear -- I didn't mean that the synopsis *only* listed
the form in my original quote above.

> 	DESCRIPTION
>=20
> 	... overview ...
>=20
> 	git checkout [<branch>], git checkout -b|-B <new_branch> [<start poi=
nt>],
> 	git checkout [--detach] [<commit>]
>=20
> 		This form switches branches by updating the index, working
> 		tree, and HEAD...
>=20
> 	git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...
>=20
> 		When <paths> or --patch are given, git checkout does not
> 		switch branches. It updates the named paths...
>=20
> So in the synopsis it lists five forms, and in the description sectio=
n
> it lists two forms, the first of which has three variants.
>=20
> It's not immediately obvious to me which inconsistency you are
> pointing to as a source of confusion.  Could you elaborate,
> preferably with suggested wording for a fix?

I simply meant that

   git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]
   git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

aren't identical even though I assume they describe the exact same
scenario. The first command synopsis makes it clear that paths are
optional while the second indicates that at least one path must be
specified (unless "..." means "zero, one, or more occurences").
Also, "paths" !=3D "pathspec".

> If you can do so in the form of a patch, all the better. ;-)

Sure, but it won't be during the coming week. Not that the patch is
terribly difficult to prepare but because I need legal approval to
submit it, and it's not clear I'll have time to deal with all that
during my last week at work.

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
