From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Show committer ident in some cases
Date: Sun, 4 May 2008 23:30:44 -0400
Message-ID: <20080505033044.GB15498@sigill.intra.peff.net>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 05:31:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsrQK-00058i-Kn
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 05:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbYEEDao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 23:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYEEDao
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 23:30:44 -0400
Received: from peff.net ([208.65.91.99]:4603 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbYEEDao (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 23:30:44 -0400
Received: (qmail 23776 invoked by uid 111); 5 May 2008 03:30:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 May 2008 23:30:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 May 2008 23:30:44 -0400
Content-Disposition: inline
In-Reply-To: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81219>

On Fri, May 02, 2008 at 08:22:19PM +0200, Santi B=C3=A9jar wrote:

> The different strategies are.. Show the committer:
>=20
> 1) always
> 2) when user.warn =3D yes (defaulting to yes)
> 3) when it is automatic
>    a) always
>    b) and different from parent
>    c) and different from a list of valid committer idents
>    d) and when user.WarnAutomatic =3D yes (defaulting to yes)
>=20
> The first patch implements 3a
> The second patch implements 3d
>=20
> I prefer 3a.

I haven't kept up to date very well with this patch, but let me add a
(possibly belated) addendum to my earlier comments: I like 3a, and I
think it addresses the issues I brought up in earlier revisions.

-Peff
