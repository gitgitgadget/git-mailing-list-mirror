From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: support --root --cached combination
Date: Fri, 29 Oct 2010 11:40:51 -0400
Message-ID: <20101029154051.GA3022@sigill.intra.peff.net>
References: <1288346087-20263-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 17:40:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBr3r-0005lx-2y
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 17:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934084Ab0J2PkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 11:40:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53401 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752Ab0J2PkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 11:40:03 -0400
Received: (qmail 5999 invoked by uid 111); 29 Oct 2010 15:40:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 29 Oct 2010 15:40:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Oct 2010 11:40:51 -0400
Content-Disposition: inline
In-Reply-To: <1288346087-20263-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160333>

On Fri, Oct 29, 2010 at 04:54:47PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I have a ritual of doing "git dic" (short for diff --cached) before
>  committing and does not want to break it, even on new repos.
>=20
>  Looks like a good thing and no harm to the rest of the world.

Hmm. What's new is old, I suppose. You might want to read the comments
on my very similar patch here:

  http://thread.gmane.org/gmane.comp.version-control.git/95935/focus=3D=
96187

-Peff
