From: AJ Rossini <blindglobe@gmail.com>
Subject: Re: git-svn on a strangely configured (pathwise) subversion repository
Date: Mon, 12 Feb 2007 19:47:52 +0100
Organization: BlindGlobe Networks
Message-ID: <200702121947.59154.blindglobe@gmail.com>
References: <200702121136.06382.blindglobe@gmail.com> <20070212183202.GB21413@localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart45056960.tAXFyqr5ab";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 20:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGgWX-0003Qx-GR
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 20:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbXBLTHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 14:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbXBLTHc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 14:07:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:33067 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964827AbXBLTHb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 14:07:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2379655nfa
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 11:07:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=IHeZkoNldjN7dwihEPBm28/Xu9B7MUs2GtKXHbrxIWMW+ZFkFJPy54ioqzUpAzOWAu5Pjt3Ns0QK0waitzdUlK4EfT8jBzg6RaieX4YQMnQgjg2H9nRLLd4Mq33IgtuKerthaqifm7EyOaiX+jN7p/IhLovD+Ft5YeQIpAm7KNU=
Received: by 10.49.29.3 with SMTP id g3mr4875990nfj.1171307248844;
        Mon, 12 Feb 2007 11:07:28 -0800 (PST)
Received: from servant.local ( [83.77.97.47])
        by mx.google.com with ESMTP id x1sm3873237nfb.2007.02.12.11.07.27;
        Mon, 12 Feb 2007 11:07:28 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070212183202.GB21413@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39424>

--nextPart45056960.tAXFyqr5ab
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 12 February 2007 19:32, Eric Wong wrote:
> AJ Rossini <blindglobe@gmail.com> wrote:
> > Greetings all -
> >
> > (paths and names changed, but basically correct)
> >
> > I'm trying to use git-svn as a svn client on a repository which is not
> > quite configured in a standard way...  i.e.
>
> Perfectly standard on some corporate networks, unfortunately :(
>
> > $ git svn fetch
> > RA layer request failed: PROPFIND request failed on '/path/to': PROPFIND
> > of '/path/to': 403 Forbidden (https://dummy-host-name.com)
> > at /usr/bin/git-svn line 2861
>
> <snip>
>
> > The problem seems to be that the Repository Root directory is not
> > readable, while the URL is (at least for me, using HTTPS).
> >
> > This is using
> > $ git --version
> > git version 1.4.4.4
>
> Known problem.  This is fixed in commit
> 747fa12cef73b6ca04fffaddaad7326cf546cdea
>
> > Here is what I'm considering:
> > #1 - upgrading to the 1.5.0 RC series
>
> Stop after #1 if you want a sure thing the current 1.5.0 RC series
> contains fixes for repositories with only partial read permissions.

Bingo!   Thanks, Eric!  Drop by for a beverage of your choice the next time=
=20
you pass through Basel, Switzerland....

> > #2 - trying Eric Wong's git-svn branch at
> > http://git.bogomips.org/git-svn.git
>
> Read access in your case *should* continue to work here.  More testing
> would be good.  This branch may not work well if your write access is
> not the same as as your read access; which is something I keep
> forgetting to fix...
=20
I'll try this in a dummy directory and try to report back in the hopefully=
=20
near future...

best,
=2Dtony

blindglobe@gmail.com
Muttenz, Switzerland.
"Commit early,commit often, and commit in a repository from which we can=20
easily
roll-back your mistakes" (AJR, 4Jan05).

--nextPart45056960.tAXFyqr5ab
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF0LZfeKAfgkUpPRARAk/WAJ9dQ3b+CrmGoPtVmhm5W94mI+RrjACfXK7s
GIsx0cKFgu+cBQsenF9uJAc=
=GA5z
-----END PGP SIGNATURE-----

--nextPart45056960.tAXFyqr5ab--
