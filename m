From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC/PATCH] git-shortlog: respect i18n.logOutputEncoding
	config setting
Date: Sun, 22 Mar 2009 12:34:38 +0100
Message-ID: <20090322113438.GK27459@genesis.frugalware.org>
References: <1235092358-6895-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 12:38:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlM0r-0007af-3P
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 12:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbZCVLeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 07:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbZCVLeq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 07:34:46 -0400
Received: from virgo.iok.hu ([212.40.97.103]:39996 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbZCVLep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 07:34:45 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4E5685811D
	for <git@vger.kernel.org>; Sun, 22 Mar 2009 12:34:38 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 44AC244783
	for <git@vger.kernel.org>; Sun, 22 Mar 2009 12:34:38 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 54C20153C002; Sun, 22 Mar 2009 12:34:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1235092358-6895-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114136>


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 20, 2009 at 02:12:38AM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
> As git-shortlog can be used as a filter as well, we do not really have
> the encoding info to do a reencode_string(), but in case
> i18n.logOutputEncoding is set, we can try to convert to the given value
> from utf-8.

Should I resend this patch without RFC in the subject?

I just hit this bug again today, then realised that I already posted a
patch for this problem. :-)

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknGIk4ACgkQe81tAgORUJZf9gCeOII8agSeKSO7JrMqzk1LPJKJ
YdUAn21K8bHrUL+aqdjuXpkd6jJXZvwA
=tOLV
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
