From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v4 0/3] Isolate If-Modified-Since handling in gitweb
Date: Tue, 27 Mar 2012 15:49:33 -0400
Message-ID: <20120327194933.GA32529@odin.tremily.us>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <201203221346.35295.jnareb@gmail.com> <20120326110943.GA2951@odin.tremily.us>
 <201203272124.23145.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=cWoXeonUoKmBZSoM
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCcPT-0007eR-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 21:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab2C0Ttq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 15:49:46 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:64662 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400Ab2C0Ttp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 15:49:45 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1K00HVF72MXN20@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Mar 2012 14:49:34 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id E0EDA43A503; Tue,
 27 Mar 2012 15:49:33 -0400 (EDT)
Content-disposition: inline
In-reply-to: <201203272124.23145.jnareb@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194079>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2012 at 08:24:22PM +0100, Jakub Narebski wrote:
> BTW. we are in feature freeze currently, before release of v1.7.10.

I'm not in a big hurry or anything, just trying to save some
bandwidth=E2=80=A6

> Though I am not sure how lack of "Status:" header is different from
> incorrect "Status:" header for 'grep "Status: 304" gitweb.headers'...

It's not for the 304 tests.  I thought it would be a good idea to grep
for a 200 status before looking for Last-Modified times, to ensure you
actually get to the successful response stage.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPchnKAAoJEPe7CdOcrcTZeJsH/jAOEnPXj47xvZ7MGXmlUFEC
q2QGfhHm2TWy6/NGQ8irMscP0ReOHbZRXLz4e6W1MEXyMfpq4u16EKa5Fu8Q/4ru
XykkTcczg5TDzx9ru6AB8SmlbGWsEm/HXKd0gJtFESFIdKD3XYzgS87qN9AoIAFQ
RFrJKfzOQF3C6ccEBIDFEyC5JnXMStC2JKQ8oGTZpEPmHihYbqYznM1ruJtZFYOJ
4sLsMPXaNgNxjPMhhBKo2xrdQ9IGLaWW+vUvRWbaxkERledwvxxoVBRxT4CTSj+t
xMHYhmUk78msp/wyY12m8Z3s6K+P96WLAtI2IcVjc8CX5xOOaQacABygrOXLOKA=
=eAFk
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
