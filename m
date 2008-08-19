From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Tue, 19 Aug 2008 11:18:30 +0200
Message-ID: <20080819091830.GG11842@schiele.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org> <7vy72tkfu0.fsf@gitster.siamese.dyndns.org> <20080819072650.GE11842@schiele.dyndns.org> <7vpro5fnke.fsf@gitster.siamese.dyndns.org> <48AA8931.1030009@viscovery.net>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQFQLHPkFLmdEfVA"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 11:19:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVNNN-0000bf-At
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 11:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbYHSJSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 05:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYHSJSh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 05:18:37 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:56026 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYHSJSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 05:18:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so320035and.103
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=G6jYB33mQTKXKsEdBUIGVzEAEOTZd6HBjQi6McolB2I=;
        b=Zc4t65bz7drzmnPgvcc0fCXy2rv16p3kmN5661d9P1Jo6o49BU9RH/3Hndrs/vKqcE
         i1fc8GfWa9sdOQV9YSmGtu5zuPrQWZ6r0ZYB6vJ4t1XDqWYpCz13wjGpJ0hyAkY3bYDS
         j1XcqHFy366ac2EJMoTd/1EA0SYZbExvxKAcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=kikeyk+ALnqvybmTtY8im2K9yiTU9SG48RmHe0qoviy/3dRMZSv8V6FpnCbaeUqctY
         FEglcD4YKAs64J4F+N8VPHHQq8pUwCuHbdcMEOGZE4AV62Oy/Q5GD51JUDPG+0h11se/
         k4Ek0jK+crO9R7UUqDJouYKga4mhUNAVKg4TI=
Received: by 10.100.140.15 with SMTP id n15mr431522and.69.1219137515041;
        Tue, 19 Aug 2008 02:18:35 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.123.131])
        by mx.google.com with ESMTPS id 74sm18188wra.12.2008.08.19.02.18.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 02:18:33 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id CC9F816051; Tue, 19 Aug 2008 11:18:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48AA8931.1030009@viscovery.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92841>


--NQFQLHPkFLmdEfVA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2008 at 10:49:53AM +0200, Johannes Sixt wrote:
> Why not just revert 5b8e6f85f (shrink git-shell)? It was a nice try. If it
> had not proved as a maintainance burden, it would have had merits. But who
> these days cares whether git-shell takes 300K or 30K in the light of that
> it goes out of the way anyway by execing some other process at the first
> opportunity?

Sounds reasonable to me.  Doing this in a clean way would require more
restructuring in the code.  So far this change started a chain of changes
where each change tried to solve one issue and caused a more severe one.

Though it would not only be 5b8e6f85 to be reverted but also 78568448 that
tried to fix up problems that 5b8e6f85 caused.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--NQFQLHPkFLmdEfVA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIqo/mxcDFxyGNGNcRAph7AKDIwqUqcbKbv8vOQoYng9pGzJZ5DwCgjrWQ
4IXrPvNCD0QVN18+l8vrZoQ=
=cLOS
-----END PGP SIGNATURE-----

--NQFQLHPkFLmdEfVA--
