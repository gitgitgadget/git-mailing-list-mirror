From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] lib-httpd.sh: print error.log on error
Date: Mon, 13 Jun 2016 13:08:33 -0400
Message-ID: <20160613170832.GA7283@sigill.intra.peff.net>
References: <20160613115608.GA5652@sigill.intra.peff.net>
 <20160613123509.22412-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 19:08:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCVLv-0006vb-O4
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 19:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933652AbcFMRIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 13:08:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:54121 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933027AbcFMRIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 13:08:36 -0400
Received: (qmail 30979 invoked by uid 102); 13 Jun 2016 17:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 13:08:35 -0400
Received: (qmail 18691 invoked by uid 107); 13 Jun 2016 17:08:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 13:08:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 13:08:33 -0400
Content-Disposition: inline
In-Reply-To: <20160613123509.22412-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297234>

On Mon, Jun 13, 2016 at 07:35:09PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Failure to bring up httpd for testing is not considered an error, so =
the
> trash directory, which contains this error.log file, is removed and w=
e
> don't know what made httpd fail to start. Improve the situation a bit=
,
> print error.log but only in verbose mode.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Looks good to me. Thanks.

-Peff
