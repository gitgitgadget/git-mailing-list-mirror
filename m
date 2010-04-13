From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Removing alternates -- but how?
Date: Tue, 13 Apr 2010 17:58:19 +0200
Message-ID: <20100413155819.GI19595@genesis.frugalware.org>
References: <20100413125704.GA29552@dirichlet.schwinge.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Cc: git@vger.kernel.org
To: Thomas Schwinge <thomas@schwinge.name>
X-From: git-owner@vger.kernel.org Tue Apr 13 17:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1iVR-0006LI-Vt
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 17:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338Ab0DMP6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 11:58:22 -0400
Received: from virgo.iok.hu ([212.40.97.103]:54934 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab0DMP6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 11:58:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C816958070;
	Tue, 13 Apr 2010 17:58:19 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8458C42F09;
	Tue, 13 Apr 2010 17:58:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 717D41240005; Tue, 13 Apr 2010 17:58:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100413125704.GA29552@dirichlet.schwinge.homeip.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144819>


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2010 at 02:57:04PM +0200, Thomas Schwinge <thomas@schwinge.name> wrote:
>     $ cat .git/objects/info/alternates
>     ../../../glibc/.git/objects
>     ../../../../O/work.new/.git/objects
>     $ git repack -a
>     Counting objects: 18670, done.
>     Compressing objects: 100% (7655/7655), done.
>     Writing objects: 100% (18670/18670), done.
>     Total 18670 (delta 10218), reused 18670 (delta 10218)
>     $ mv .git/objects/info/alternates{,.DEFUNCT}
>     $ git branch
>     error: refs/remotes/grubber/master does not point to a valid object!
>     error: refs/remotes/sourceware/cvs/fedora-2_3-branch does not point to a valid object!
>     error: refs/remotes/sourceware/cvs/fedora-2_5-branch does not point to a valid object!
>     [...]
>     error: refs/tags/cvs/sparc-980522-merge does not point to a valid object!
>     error: refs/tags/cvs/start does not point to a valid object!
>     error: refs/tags/master-2008-11-27 does not point to a valid object!
>     error: refs/tags/master-2009-02-10 does not point to a valid object!
>     error: refs/tags/master-2009-07-10 does not point to a valid object!
>     error: refs/top-bases/t/IOCTL_decode_argument does not point to a valid object!
>     error: refs/top-bases/t/IOCTL_types does not point to a valid object!
>     error: refs/top-bases/t/____longjmp_chk_cleanup_linux_x86_64 does not point to a valid object!
>     error: refs/top-bases/t/bits_posix_opt.h__POSIX_THREADS does not point to a valid object!
>     error: refs/top-bases/t/bits_pthreadtypes.h does not point to a valid object!
>       baseline
>       posix/regex_internal.c/MAX_undefined
>       t/IOCTL_decode_argument
>       t/IOCTL_types
>       t/____longjmp_chk
>       t/____longjmp_chk_cleanup_linux_x86_64
>       t/__rtld_lock_recursive_t
>     [...]
>       t/verify.h
>     * tschwinge/Roger_Whittaker

What git version are you using?

It seems to work for me:

$ mkdir s
$ cd s
$ git init
$ echo a > a
$ git add a
$ git commit -m i
$ cd ..
$ git clone -s s c
$ cd c
$ git repack -a
$ mv .git/objects/info/alternates .git/objects/info/alternates.orig
$ git branch
* master

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvElJsACgkQe81tAgORUJYWcQCeI3tFcwjgUaQMH8p9fFJGVSeC
L14AnjYSdkbu8wwAMp1NgX1CGOCxBLwy
=j9zN
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
