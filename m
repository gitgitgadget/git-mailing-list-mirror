From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3 1/1] Makefile: make curl-config path configurable
Date: Mon, 5 Oct 2015 23:05:45 +0200
Message-ID: <20151005210545.GC386@cruxbox>
References: <1444077159-3268-1-git-send-email-repk@triplefau.lt>
 <20151005204909.GE11993@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCxG-0004MM-J7
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 23:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbbJEVFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2015 17:05:49 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38228 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbbJEVFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 17:05:48 -0400
Received: from mfilter34-d.gandi.net (mfilter34-d.gandi.net [217.70.178.165])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 642BFFB874;
	Mon,  5 Oct 2015 23:05:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter34-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter34-d.gandi.net (mfilter34-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id qpZaqdJkXntn; Mon,  5 Oct 2015 23:05:45 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7C540FB883;
	Mon,  5 Oct 2015 23:05:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151005204909.GE11993@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279096>

On Mon, Oct 05, 2015 at 01:49:09PM -0700, Jonathan Nieder wrote:
> Remi Pommarel wrote:
>=20
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>=20
> For what it's worth, with or without the tweaks below,
>=20
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

>=20
> [...]
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -39,6 +39,10 @@ all::
> >  # Define CURLDIR=3D/foo/bar if your curl header and library files =
are in
> >  # /foo/bar/include and /foo/bar/lib directories.
> >  #
> > +# Define CURL_CONFIG to curl's configuration program that gives in=
formations
> > +# about the library (ie curl's version, cflags, ...) . If not set =
it defaults
> > +# to 'curl-config'.
>=20
> Extra spaces, some wording tweaks:
>=20
> s/gives informations about the library/prints information about the l=
ibrary/
> s/(ie curl's version, cflags, .../) /(e.g., its version number)/
> s/If not set it defaults to/The default is/
>=20

Do I need to resend a v4 patch with these modifications ? I am not sure
about the correct workflow here.

--=20
R=C3=A9mi
