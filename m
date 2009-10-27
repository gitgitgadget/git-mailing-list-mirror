From: Sebastian Schubert <schubert.seb@googlemail.com>
Subject: more fancy ignoring of files ('if' in .gitignore?)
Date: Tue, 27 Oct 2009 10:30:50 +0100
Message-ID: <200910271030.54571.schubert.seb@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart36963305.rXZfgZjfFy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 10:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2iOJ-00025N-9l
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 10:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbZJ0Jar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbZJ0Jaq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 05:30:46 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42614 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbZJ0Jaq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 05:30:46 -0400
Received: by fxm18 with SMTP id 18so12769235fxm.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=VXW7xlldCoFKE0aMI2E2dxqQXymdcNHWDAHIViDJ/xo=;
        b=IRVMxkd6uFRAHnt9E5dPf1vvX1978HGrW5IwUcXyQOeE0hD7FrXvx0T4NxEdDmaw11
         7SvffkWeVx04D5YFOUCg8cS7OKKZcQdhZhlodsF/5hE8d6i7aZkIG52/qbIqBh/XTl7O
         Ntj1fit0HJgZpmhzyDoymnh702pP+PkWFE8Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=OtogL4qaJz7mVeONFwutu4W0uzrOuHBcFWyATGAwjHvQkrvXi2cgqEMyLnHWx0eh+c
         tVO0hoCJ+qapHJzv+oaJc5PZEXcIy1ZCsag0cmeAtB3KrmZ17K3GwEONgPPqPMXa3CAT
         2UzGXPMp/jNTUpij3GFe2k1BPYuXG1bssSqXI=
Received: by 10.103.84.1 with SMTP id m1mr6656365mul.34.1256635849969;
        Tue, 27 Oct 2009 02:30:49 -0700 (PDT)
Received: from lt134.pik-potsdam.de (host16092.pik-potsdam.de [193.174.16.92])
        by mx.google.com with ESMTPS id b9sm2823760mug.9.2009.10.27.02.30.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 02:30:49 -0700 (PDT)
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131317>

--nextPart36963305.rXZfgZjfFy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I would like to ignore files if certain other files are present. In my=20
special case, I want to ignore foo.pdf and foo.eps if foo.fig is=20
present (both pdf and eps are generated on the fly but don't belong=20
into repository). In general, I do NOT want to ignore pdf or eps. There=20
are a lot of foos so I would like to have a general solution.

Is this possible?

Cheers
Sebastian

PS: Please CC my personal email address.

--nextPart36963305.rXZfgZjfFy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkrmvc4ACgkQSq29WkufMEZCBwCgj2krP218SbQUsYZCEKWOPFhj
nDwAoMQoC5IgozOTihviewq/LAlqhOhP
=QIgk
-----END PGP SIGNATURE-----

--nextPart36963305.rXZfgZjfFy--
