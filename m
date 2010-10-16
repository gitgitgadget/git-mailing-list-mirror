From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Why is "git tag --contains" so slow?
Date: Sat, 16 Oct 2010 16:32:26 +0200
Message-ID: <20101016143226.GA20515@localhost>
References: <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123923.GC21146@sigill.intra.peff.net>
 <20101014185945.GA14634@burratino>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Cc: Jeff King <peff@peff.net>, tytso@mit.edu,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 16:38:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P77uJ-0000SB-Ac
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 16:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab0JPOik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 10:38:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55551 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab0JPOij (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 10:38:39 -0400
Received: by bwz15 with SMTP id 15so1749570bwz.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8IkW+xjNK4W22vcpJT5y7kLE++cXORiOHKmuxX6keTg=;
        b=XYVy2LsxR6wDWAyXt6qb57hztoiAQCDjdKTgD0/aRrdgc5uZZAAun6oQN8dYPxCc1l
         N1yS+373DXZ/wIRl508YNzPgj30mHz1C2+cQaUEaGreg/xPicMWkbiIkRHSPnRwZXf2o
         ImfuJRZKvl/WtQ/3Yg58cB+0B0wd3eQG9kHi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Bb3jHqmRYNN1Jl6WtrJUFALJjmYWI4EaQE/7PY1ZiLz1cvDHM2w8GVkM/bQ7bDYU78
         If60CLe9b7WwLxS6mEJ+oDJLI3RZO/IVIF3P8zDWFymihyJlGRMaqG7FNndtDrN8nSp8
         56QzEaVJ20/U8MvW9Jgs/CwEiDtyAiZ+JxzIw=
Received: by 10.204.57.3 with SMTP id a3mr2038948bkh.164.1287239525233;
        Sat, 16 Oct 2010 07:32:05 -0700 (PDT)
Received: from darc.lan (p549A2EC8.dip.t-dialin.net [84.154.46.200])
        by mx.google.com with ESMTPS id 4sm11589477bki.13.2010.10.16.07.32.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 07:32:04 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P77oA-00071o-Hz; Sat, 16 Oct 2010 16:32:26 +0200
Content-Disposition: inline
In-Reply-To: <20101014185945.GA14634@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159164>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 14, 2010 at 01:59:45PM -0500, Jonathan Nieder wrote:
>=20
> project # skewed        maximum skew    notes
> ------- --------        ------------    -----
> gtk+    13              13 hrs          worst example seems to be tz rela=
ted

It really is kind of fun.

wine                    1       14 days
mesa                    4930    150 days

xf86-video-ati          13      ~2.5 hrs
xf86-video-intel        26      8 hrs
xf86-video-nouveau      12       10 hrs

fluxbox                 0       0
metacity                0       0
openbox                 8       4 hrs

giggle                  2       21 min
glibc                   2       931 days

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMubd6AAoJELKdZexG8uqMR7UH/RIJK6RLHwbgJV80TbmkGgel
a5pXVhRDEFJKuPRqPUm7+WuhyR6W02VY8zwJWrbavE6lMDwcFY0XxYIcpcd6B4Yp
gNJw/vD4pljX7xTGwpDRue6ucu1sWmo0xrLrkF+DfFvI1fvCB7F0Nd01JGnHW/nX
nQJ+qfa/QmgHPl0c1DuJJQD2rEMc8WQgjCgPjry5RmwchESesgMHuCCJNGXZcVL3
LFG/pRGhOotbPVn6q6Z019xe1kV2yuJ+NuvlQTSK3W649afNrSI1LBf16sL6JtDO
DvAhFqCREvV57G/4fLFlMl9W44no1LihByLYy1s1X/alsmA57DDSTkBvSqg+ybA=
=rOiB
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
