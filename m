From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] use cache for function names in hunk headers
Date: Mon, 20 Sep 2010 19:36:05 +0200
Message-ID: <20100920173605.GA13057@localhost>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
 <1284890369-4136-4-git-send-email-drizzd@aon.at>
 <AANLkTikArADX8XviB99VtkkmKmVbs9jHPHw9PNSmiOc3@mail.gmail.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 19:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxkH6-00040E-Tr
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 19:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab0ITRf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 13:35:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53569 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab0ITRfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 13:35:25 -0400
Received: by bwz11 with SMTP id 11so4439432bwz.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Z9vnGNoE7MNLKuZui+gK+ZUWHNglp0KE/5ljhLpRn24=;
        b=WUAj3GJhJoSInYIM8Ydz18+fwBPcEvL2iRtNUiuuA/82brnl4AJmhSl1e3aMVyP3/0
         C1ssw21kraRkEsoF1nONChntMkwsI+CHASo46HXDfvKFe1q+MhJc1GjTgkZB39f0+OtX
         aUxce+xq1d+Cgq55X+OUlEZlyXaXfBtRJv7eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=jfmlnOBzU3+nAFS49yHRijuswWGB3rdWQ5XZtfZmbHgWer45q9cTm+3549kc6WIKGr
         g031g51yk8iMt3bYPqe6GSUybPD5MJRLi28wxCeTJuqetVF9krnyY0uTXCTyl03U8SoG
         h9MhY4jr7g1SweXi2GcOE8KtI5MOn9gXQY448=
Received: by 10.204.112.84 with SMTP id v20mr6713925bkp.213.1285004124194;
        Mon, 20 Sep 2010 10:35:24 -0700 (PDT)
Received: from darc.lan (p549A4F70.dip.t-dialin.net [84.154.79.112])
        by mx.google.com with ESMTPS id f18sm6733603bkf.15.2010.09.20.10.35.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 10:35:23 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OxkHd-0003QK-Sy; Mon, 20 Sep 2010 19:36:05 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikArADX8XviB99VtkkmKmVbs9jHPHw9PNSmiOc3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156641>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2010 at 10:24:52PM +0200, Sverre Rabbelier wrote:
>=20
> On Sun, Sep 19, 2010 at 11:59, Clemens Buchacher <drizzd@aon.at> wrote:
> > 2.78user 0.01system 0:02.82elapsed 99%CPU
> > 0.05user 0.01system 0:00.06elapsed 96%CPU
>=20
> Very nice. It would improve the commit message if you could explain
> what exactly it is this optimizes though, saving the reader from
> having to read through t3419 to find out.

Ok.

The test creates a file with 50000 lines and a one-line change
every 10 lines, i.e., about 5000 hunks. Since none of the lines
matches a function definition, previous to this optimization, the
file was searched 5000 times.

Clemens

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMl5uFAAoJELKdZexG8uqMONcH/0bJy83PlEDOVVxw7qRHeshz
mcsIicqsyplBR76/V4fF4mQRtZ7JZfHCQqW3qb/ZDO3/39YGHrI2BjqrwUVUQt8f
4N08WhNTNjUGovhwk4scgheY/7iHR6qQK5Sls8XakQAU4dUXtncRPYbYRK100w8F
I32RumC1gasUVeLlmh2sgEIDKk/BwcMtY26h9HW5vFvGT3r5dQwUJeKg9micWh4M
sDPSCve506v/fE9IyCmOhQ/5HeSgcF0u9tNFTM8YSbiOQ8r3AdgydlncwOpHAzLC
KbZda0CB00hbg9VtmZJzv6l2ICrdehkoz0wz9pI039+k8401LZXB2t2Jp0vYwQM=
=2wcg
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
