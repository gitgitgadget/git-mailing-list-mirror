From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH] Pull gitweb If-Modified-Since handling out into its own
 function and use for snapshots.
Date: Mon, 19 Mar 2012 21:48:53 -0400
Message-ID: <20120320014853.GA21052@odin.tremily.us>
References: <7vmx7c86j8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=82I3+IH0IqGh5yIs
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 03:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9p8F-0001U6-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 03:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab2CTCtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 22:49:01 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:64560 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab2CTCtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 22:49:00 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2012 22:49:00 EDT
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M15004O4UDIQR60@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 19 Mar 2012 20:48:56 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 444CF42685B; Mon,
 19 Mar 2012 21:48:54 -0400 (EDT)
Content-disposition: inline
In-reply-to: <7vmx7c86j8.fsf@alter.siamese.dyndns.org>
 <20120315075407.GA18246@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193480>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 03:54:07AM -0400, W. Trevor King wrote:
> The current gitweb only generates Last-Modified and handles
> If-Modified-Since headers for the git_feed action.  This patch=E2=80=A6

On Mon, Mar 19, 2012 at 05:23:07PM -0700, Junio C Hamano wrote:
> What's cooking in git.git (Mar 2012, #07; Mon, 19)
> =E2=80=A6

My If-Modified-Since patch seems to have fallen through the cracks
here.  Is that because nobody is interested, or did I mess up
something in the submission?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPZ+IEAAoJEPe7CdOcrcTZke8H/2cT8II6aFCVFOC/6mui27an
8QbE69l2OJvdWMY0Vx9dCOSW+KSAjJz+1PNUTX+GnuCvq8n2swY4wEI6pl4lkYEj
YuP9t0gNOxYDiUuszzKr2sVLMbOKxxhglraggYRFXzvZ2FHebSelHEKq0fka4Ho4
/luHGZggTmDzrfR8jh/dkVsxWnoOScpUx3RVs8OfNgFyq8PONnSyVp3T2IilDi4n
exFK5IPl2LV0dabHHUYHmSp4AAP3CYls29yF4pS779Qd40D8dfwKIlHCyTjSG00X
VLEYsMNT96CMFmHME+aE6OBiW1wEJfnzsvQJxFSfqexJkRzBhcmGMi6FJR65UMk=
=rgcS
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
