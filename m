From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH 0/4 v4] minor gitweb modifications
Date: Sun, 02 Jan 2011 17:27:21 +0100
Message-ID: <1293985641.15404.11.camel@kheops>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
	 <20110101104121.GA12734@burratino>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-AxR8CFD1UTDnL8G9szmT"
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 02 17:27:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZQmQ-0003Ad-Ja
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 17:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab1ABQ1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 11:27:31 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53517 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab1ABQ12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 11:27:28 -0500
Received: by wwa36 with SMTP id 36so13554726wwa.1
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 08:27:27 -0800 (PST)
Received: by 10.216.173.15 with SMTP id u15mr4203666wel.83.1293985645650;
        Sun, 02 Jan 2011 08:27:25 -0800 (PST)
Received: from [192.168.0.7] (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id m6sm9345099wej.10.2011.01.02.08.27.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 08:27:23 -0800 (PST)
In-Reply-To: <20110101104121.GA12734@burratino>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164419>


--=-AxR8CFD1UTDnL8G9szmT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2011-01-01 at 04:41 -0600, Jonathan Nieder wrote:
> (adding back cc: jakub)
>=20
> Hi,
>=20
> Sylvain Rabot wrote:
>=20
> >   gitweb: add extensions to highlight feature map
> >   gitweb: remove unnecessary test when closing file descriptor
>=20
> I like the above two.
>=20
> >   gitweb: add css class to remote url titles
>=20
> I had a question (why make the remote url table inconsistent with the
> older projects_list table) and suggested a more generic approach in
> reply to v2[1]:
>=20
> 	<table class=3D"projects_list">
> 	<tr id=3D"metadata_desc">
> 		<td class=3D"metadata_tag">description</td>
> 		<td>Unnamed repository; edit this file to name it for gitweb.</td>
> 	</tr>
> 	<tr id=3D"metadata_owner">
> 		<td class=3D"metadata_tag">owner</td>
> 		<td>UNKNOWN</td>
> 	</tr>
> 	...
>=20
> The idea was that the rows are already labelled for use by css, so to
> make this stylable all we need to do is use a class for the first
> column.  This way if some site operator wants the first column
> *always* be bold then that is easy to do.

So your idea is to use the same class for all this kind of tables' first
column ?

>=20
> Another approach with similar effect would be
>=20
> 	<dl class=3D"projects_list">
> 	<dt>description</dt>
> 	<dd id=3D"metadata_desc"
> 		>Unnamed repository; edit this file to name it for gitweb</dd>
> 	<dt>owner>
> 	<dd id=3D"metadata_owner"
> 		>UNKNOWN</dd>
> 	...
>=20
> but that does not degrade as well to browsers not supporting css.  Any
> thoughts on this?

I think table is fine, don't see the need to replace it by dd, dt, dl.

>=20
> >   gitweb: add vim modeline header which describes gitweb coding rule
>=20
> I don't like this one.  Isn't the tabstop whatever the reader wants it
> to be (e.g., 8)?  I don't like modelines as a way of documenting
> coding standards because
>=20
>  (1) they are not clear to humans and editors other than vim
>  (2) they require annotating each source file separately.
>=20
> See [1] for an alternative approach to configuring an editor to hack
> on git.
>=20
> Regards,
> Jonathan
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/109462/focus=
=3D109538


--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-AxR8CFD1UTDnL8G9szmT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJNIKdkAAoJECLlHVUnhaoWdBkIAK4GX5LeB9IrvsbLgrOFOjIg
sZTyc2HAxsXRIFW+FPfeW+nY051yZzn+O4c/0fvgHJbw5jA0e8h9TS7x0hhhwC0e
uhnLmr6MAsfxGiBCSJMpS7/kaHFEY3+7DkLZ3mXam3nj4V7A1xireZ6G+yEz5ZXr
U7ge+c7/ojA/76X76wuvJv4bksn20h3DyyXcHaOBdXoNHo69N5peXAO+v/c6Mq9+
0CDLkZ0mamZw+GoCaX681S51BgEQCN/pF34gzvCuL42gHwAxmiixDzkJoshaeF6w
qk0i0B8KCBkXNlFKCNT4NwAP3ILAx1tFOeUmhpjuj/PMosCQmb23gYNJBTi1t24=
=L2TI
-----END PGP SIGNATURE-----

--=-AxR8CFD1UTDnL8G9szmT--
