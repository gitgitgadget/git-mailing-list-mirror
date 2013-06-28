From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Thu, 27 Jun 2013 21:08:39 -0400
Message-ID: <20130628010839.GC11985@odin.tremily.us>
References: <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
 <20130627201032.GF9999@odin.tremily.us>
 <7vehbnqmhh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=L6iaP+gRLNZHKoI4
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 03:08:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsNB9-0006hE-AH
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 03:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab3F1BIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 21:08:42 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:51783 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3F1BIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 21:08:41 -0400
Received: from odin.tremily.us ([unknown] [72.68.89.85])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP200LL0WIGOP10@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 27 Jun 2013 20:08:41 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0C3DEA54811; Thu,
 27 Jun 2013 21:08:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372381720; bh=QqkNNkJERAqk712aFQm842/QEaC04d/t9thcQB62Krk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I6sjDE2n/qcmzly/5wkG/CqNlEyVibVvAO9Gx8JRQXQY5SAs8saXWCTfrbkGZcmh3
 pT0UbqlLq6Zl6LvDGYX7Q78EGwxvyT/3tDo8ALymPwM2CtZiKraxTV7NKMzCr6Kfxj
 Au+rCtwhI+RZ4sL8xPsKlgnvOw6qO3WDoY6doXYc=
Content-disposition: inline
In-reply-to: <7vehbnqmhh.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229169>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 02:20:42PM -0700, Junio C Hamano wrote:
> Your "accident user" could have just been on a 'maint' branch,
> [snip]

By the time I talk people into using a 'maint' branch, we'll probably
have already passed the 'accidental pull and push' stage ;).  This
will certainly reduce the risk in any case.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzOIWAAoJEKKfehoaNkbtbAYP/jQFd/R1waGXpg7wDpYNcus0
ddVOZJX7TTv8f8zAhL2wGNPOsyFZeyXu9aBWTmnTXczIC19OCUxLUD1gc/QFeQ4m
68mnE6v6eTfE1DYDUjlBSdFDctL5Mway7JFLdyK/kcVW8m9ZFDwL5TZA1c40S+ue
xw4Ul2tCtGIS80KgfcfYn/S7MH8nn/me1aC6G+rFPEPfProQpS3x3L0YgkJiH7k5
MjbDnxYHBkh/PPUsBgozt/96nmmycDtxG68LJig52B56XLq9aeOWGkIvEPZzKWti
OhwCGFn7w0JsDtK3+c7/igq+x11z33wKIgMpnddtJB1tzcGsNDdwI0j0bFLB0bsB
TVykE6EWDe8jP2TYAmNtDwtbYoz15bIsJhIxhT+SzNaPbdLLQZo5OW9dLyIacMXq
9/el6Ek9ofnw+c3xV6eK3Wqjk/Q66uoWSCgZp64OiwQBWVwKD4Kq2RqV2KJudUcC
jOu8KkKT4xeWt3fFHHau+QYMVZMmeGMViT9PA7kcz1w4k/LP3KYsqjuj17VQiR4Y
0Zbf/5xW9t+tn7zIb3ahVZOWeKEEP5e1pnhvS1BJdyw6SvQekWFPnCHJRs2Gw92p
EmLqq5oiluIOwkcu8SIkm4cyxHHh32rQletzVl8vZjX+0jH1JG3R171eGSYvp/3K
N90thXy67X8RHlCZ6NI5
=NVEM
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
