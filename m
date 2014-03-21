From: Matthias Beyer <mail@beyermatthias.de>
Subject: Re: File extension conflict when working with git and latex
Date: Fri, 21 Mar 2014 17:46:51 +0100
Message-ID: <20140321164651.GD2965@fu.192.168.200.1>
References: <20140321161324.GC2965@fu.192.168.200.1>
 <20140321163628.GA28121@ruderich.org>
Reply-To: Matthias Beyer <mail@beyermatthias.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Cc: git@vger.kernel.org
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 17:48:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2cd-0004d9-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 17:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760614AbaCUQsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 12:48:39 -0400
Received: from libra.uberspace.de ([95.143.172.171]:33536 "HELO
	libra.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754428AbaCUQsi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 12:48:38 -0400
Received: (qmail 8058 invoked from network); 21 Mar 2014 16:48:40 -0000
Received: from unknown (HELO localhost) (149.172.90.15)
  by libra.uberspace.de with SMTP; 21 Mar 2014 16:48:40 -0000
Content-Disposition: inline
In-Reply-To: <20140321163628.GA28121@ruderich.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244698>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21-03-2014 17:36:28, Simon Ruderich wrote:
> On Fri, Mar 21, 2014 at 05:13:24PM +0100, Matthias Beyer wrote:
> > Unfortunetely, we wrote our `make clean` task recursively. I think you
> > can imagine what went wrong: The clean-task corrupted the repository,
> > as it removed .idx files from within .git/.
> >
> > I lost work because of this ugly name collision.
>
> Hello Matthias,
>
> You can recreate the .idx files by running
>
>     git index-pack .git/objects/pack/pack-<hash>.pack
>
> for each pack file.

Hi Simon,

I think so. I executed:

    git fsck # reports N missing blobs, commits, trees and dangling stuff
    git index-pack ...
    git fsck # reports only dangling commits and blobs

I don't know if this means that the repository is fixed now?

--=20
Mit freundlichen Gr=FC=DFen,
Kind regards,
Matthias Beyer

Proudly sent with mutt.
Happily signed with gnupg.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLGz7AAoJEJi+S08gyg+UOIwQAIKw6u35w+v7UCn6SUqefZ47
E2ZvCH7snpeCZMzTUDzMu9+08IiTrCVqhSvTVEvlC4vSPVQYgx7hgvqjVn6kqevl
KooqOqzlEqQXmD4wscEdREz6s6w8LAWiopIu6yyedmFna+ncQgeRD1nnBhj+Crms
uvgpWdCeWgSIZ+wKqIeT1YUw9grzMJvF/fM8nsZ1HUD6jxog747EOBjU5t+Igoc5
f8GIEaxhudQk6VcROB3hZvv1iGxyVJBz3ZSABNcMaptVMzDB6fHH8m5h/c+N5FRv
wCsJY94MqLubLsiL7pnVqColnkUreSp6KhuwgG1q8HBv9mHUvK6h+ggqSF5FlqgG
KYoy9bEOp4reejPTdT/4QEwhXdcR88hhgE2JzoFPzb1j4HVLcZke/pAlk4ypJe6H
6YNNHv9d+ExjsEk+dU+xnFIOldyhfQPfME4GMwOKFP5IOrzqwNBEb/GMYF/O4ODE
aCXWN20ywujTIhtsGF4D9y5P5P0FcUBt9upl8VjwdkIdE/NV2GmYiqr6PgH2PUsN
kXYQCw1iBEkUx27zV0dO2OkCOT2T88UCqmYOguJYNO3Pi0MBYFG9tl7o1q+4zCGO
KeMiDzs7m2We3jycBjMEP/m+1vZyVFkvkj5R0iuxrKAXm30pLUG9jZGhZO8brsU+
jYH8EhPCLqYq68hauN3L
=V0FM
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
