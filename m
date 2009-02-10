From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Tue, 10 Feb 2009 02:20:06 +0100
Message-ID: <200902100220.07304.jnareb@gmail.com>
References: <200902021948.54700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Theodore Tso <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 02:21:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWhJj-000306-If
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 02:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbZBJBUM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2009 20:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbZBJBUL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 20:20:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:42949 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbZBJBUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 20:20:09 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1196023fgg.17
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 17:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=y6zIiwftrdlZUdJKvbv/EAvDM+Z5IaE9SShB7IchCqo=;
        b=vVycAeI3pORpbZBtCmGx7xCnkt0JQVWrYknpM60KXFSwbmeazSQjx+d6WuzlK8QeSt
         LP4f43aIyUtOY2fBzmU+xQQ//gWetB2Nm3lGZa5Krp1E+JLI2Rg2RP5HvrmGc38Vpp2j
         enq5mDDqmyadHi+QIs5zqqQIKyrByo9IQ/rj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RcKO5gbdB0MXoPxM+Df3RJyR2ntv0ZfP+QAgOURUdCrCdvdUlyByCwWKXPccTw9kHC
         sWHjOcC2IbSGTOUmSdUQY6hZkdAZMj3Sd6vgX58RboEz2qStsNl2cZWbSVBOOr7Pb1TC
         9MxrFMMORRrX2DS+yMCVToVkgmS8iBcH57vc0=
Received: by 10.86.96.18 with SMTP id t18mr1004573fgb.17.1234228807562;
        Mon, 09 Feb 2009 17:20:07 -0800 (PST)
Received: from ?192.168.1.13? (abwr34.neoplus.adsl.tpnet.pl [83.8.241.34])
        by mx.google.com with ESMTPS id e20sm10798fga.56.2009.02.09.17.20.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Feb 2009 17:20:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200902021948.54700.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109171>

On Mon, 2 Feb 2009, Jakub Narebski wrote:

UVC =3D "Understanding Version-Control Systems" (draft),
http://www.catb.org/esr/writings/version-control/version-control.html

> UVC> =3D What, if anything, have we learned from history? =3D
> UVC>=20
> UVC> There's a folk saying that "It's not what you don't know that
> UVC> hurts you, it's what you think you know that ain't so." In
> UVC> examining the pattern of development of VCSes, it seems to me
> UVC> that the this sub-field of computer science has been less
> UVC> hampered than most by difficulties in finding appropriate
> UVC> techniques, but more hampered than most by wrong assumptions tha=
t
> UVC> hung on far longer than they should have.=20
> UVC>=20
> UVC> First wrong assumption: Conflict resolution by merging is
> UVC> intractably difficult, so we'll have to settle for locking. It
> UVC> took at least fifteen and arguably twenty years for VCS designer=
s
> UVC> to get shut of that one. But it's historical now.=20
> UVC>=20
> UVC> Second wrong assumption: Change history representation as a
> UVC> snapshot sequence is perfectly dual to the representation as
> UVC> change/add/delete/rename sequences.. This folk theorem is well
> UVC> expressed in the 2004 essay "On Arch and Subversion"[3]. It is
> UVC> appealing, widely held, and dead wrong.
> UVC>=20
> UVC> File renames break the apparent symmetry. The failure of
> UVC> snapshot-based models to correctly address this has caused
> UVC> endless design failures, subtle bugs, and user misery.=20
>=20
> It is not true. =A0Example of snapshot-based Git, which with its rena=
me
> detection deals very well in practice with file renames contradict
> this theory. =A0Bazaar which is supposedly snapshot-based, yet suppor=
t
> "container identities" ('file-ids') contradict this further.

Now after thinking about this a bit, I reckon that the second wrong
assumption is not the fact that snapshots sequences representation
are perfectly dual to changesets representation, because in practice
(as in: merge doesn't have exponential time in history size) they are.
It is not even assumption that renames are not important, or in other
words not dealing correctly with renames and copies.

No, second wrong assumption (if we want to phrase knowledge from
history of version control in this terms) is not realizing that it
is _merging_ that has to be easy.  Both to be able to do branching
(stable, development; feature branches), and for collaboration: the
distributed part of distributed version control systems (Linus'=20
"network of trust").  And intelligent, rename-aware merge strategy
is _necessary_ component for doing automated merge.  Necessary,
and very important, but only a _component_.

That is what Subversion, at least up to Subversion 1.5, got wrong.
It made branching (or facsimile / cheap imitation of branching)
easy, but it *didn't* made merging easy.  Even in SVN 1.5 it is not,
from what I understand, very easy.

Easy merging is extremely important for DVCS in OSS development, as
usually centralized VCS with need for commit rights simply do not
scale up to the sizes required by larger OSS projects, especially
those with diverse developers.


P.S. By the way, the hgbook contains quite good description of DVCS;
description of beginnings of Git can be found at GitHistory page on
Git Wiki; you can find history of adding features and changing design
and UI of Git in Junio C Hamano "Git Chronicles", presented at
GitTogether'08.
--=20
Jakub Narebski
Poland
