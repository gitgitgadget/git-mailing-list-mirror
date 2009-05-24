From: Chani <chanika@gmail.com>
Subject: Re: partial checkouts
Date: Sat, 23 May 2009 17:26:09 -0700
Message-ID: <200905231726.10361.chanika@gmail.com>
References: <200905231401.11651.chanika@gmail.com> <200905240134.53387.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart21436433.U7GjHoQHCX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 24 02:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M81YP-0000BD-5f
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 02:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbZEXA06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 20:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbZEXA05
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 20:26:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:20946 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbZEXA04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 20:26:56 -0400
Received: by wf-out-1314.google.com with SMTP id 26so859549wfd.4
        for <git@vger.kernel.org>; Sat, 23 May 2009 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=LjkNqdlJsqsUC9+yTymrA1Gdib4BNSDRecYoIIW0rp0=;
        b=Z6w6Tda0R4LYERNYs9QwBFW6fYSZ5oG7kYOgdwVNmd6UkZIGFtYk6nNJgqy9JdYxuj
         dPtGN+aLf+NsQKZ3TJUafhADVHUuyEyTmOR/NhWA5BCiQT6TtzqKsLBfzgmRz2/d/Gf0
         2i782Eudokf8sAgUP9RkmtUDTZuIxLWMF3/vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=pjv97nHrmKrjSnd7w4EZT1lN40dwoUPxfOmh4t4CnzxAYp/6pONzTrAPW7RVMFx9C0
         58iyVWsWC7GWJjRQ6mj5GLQNY8H0ZV1GdX37Zy/LtI8oL9QqUwMjl1S18kucdss1Uk6r
         QS69a36Y2wvfXpw9HTe1vSewoRpnmH+4FVS04=
Received: by 10.143.2.20 with SMTP id e20mr2044885wfi.298.1243124816906;
        Sat, 23 May 2009 17:26:56 -0700 (PDT)
Received: from brain.localnet ([96.49.70.32])
        by mx.google.com with ESMTPS id 30sm5433515wfd.21.2009.05.23.17.26.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 17:26:56 -0700 (PDT)
User-Agent: KMail/1.11.90 (Linux/2.6.27-ARCH; KDE/4.2.87; i686; svn-970258; 2009-05-17)
In-Reply-To: <200905240134.53387.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119807>

--nextPart21436433.U7GjHoQHCX
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On May 23, 2009 16:34:53 Johan Herland wrote:
> On Saturday 23 May 2009, Chani wrote:
> > [...]
> >
> > right now all I've thought of is one ugly hack: have a server that chec=
ks
> > out all the kde git repos, pulls daily, copies all the doc/ folders into
> > a documentation folder, and offers that folder up on the interwebs so
> > that update_xml can rsync from it or download a tgz of it or something.
> > there appear to be lots of images in the documentation, so it's not a
> > small download - 200mb and growing. it still hasn't finished downloading
> > all the externals...
>
> Do you need the doc/ folders from _all_ kde git repos, or just from those
> repos that you have currently checked out? In the latter case, you could
> solve this by adding symlinks to all the doc/ folders inside the
> documentation/ folder, and then make sure the software that traverse the
> documentation/ folder recognize and skips symlinks. Of course, this won't
> work if the translations project need _all_ doc/ folders accessible, but
> not all the kde git repos.

nope, the translators may not have checked out *any* of them but the script=
=20
they want to run needs *all* the docs. :( however, I've been told they also=
=20
don't want to have to change their workflow in any way at all no matter how=
=20
small, so we may be stuck in svn-land anyways, because you can't make an sv=
n=20
external out of something that's not in svn, and having anything other than=
=20
svn externals would change their workflow :(

>
> > I'm kinda wondering if there'd be a way to use git-filter-branch to make
> > a repo that only tracks the doc/ folder for a module - but I've no idea
> > whether it'd have to be recreated from scratch every time someone chang=
es
> > something in the real repo's doc/
> >
> > can anyone think of a less ugly solution?
> > what are the chances of git supporting this kind of partial checkout
> > someday?
>
> Check out git-subtree. It can split out a subdirectory into its own repo,
> and re-integrate it back into the "parent" repo at a later date.
> git-subtree has been posted as a patch to this list a couple of times
> without much response, but it looks like an interesting alternative to
> submodules: http://alumnit.ca/~apenwarr/log/?m=3D200904#30
>
> If a lot of people find git-subtree useful, who knows, it might be includ=
ed
> in a future git version.

looks interesting. might have been a solution until I heard about this=20
requirement to not change workflow at all. :/

however, my friend told me about a project to make a git-svnserver that ser=
ves=20
git repos as svn repos, and *that* would allow the translators to stay wher=
e=20
they are without holding everyone else there too. know anything about that?=
=20

mm, google turns up an email from someone claiming they have a partial=20
implementation in python...

=2D-=20
This message brought to you by eevil bananas and the number 3.
www.chani3.com

--nextPart21436433.U7GjHoQHCX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoYlCIACgkQeGbAwpIS3GxrTgCfdv7PAG2RQw+Os5t4e/xFM6zB
gIQAniYyg8usepo7534cHX2vWivrUF2K
=sZF7
-----END PGP SIGNATURE-----

--nextPart21436433.U7GjHoQHCX--
