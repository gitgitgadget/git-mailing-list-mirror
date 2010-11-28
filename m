From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] entry.c: remove "checkout-index" from error messages
Date: Sun, 28 Nov 2010 01:30:47 -0500
Message-ID: <20101128063046.GA2902@sigill.intra.peff.net>
References: <1290918998-15208-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 07:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMamo-0004dN-PA
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 07:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab0K1Gax convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 01:30:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48989 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab0K1Gaw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 01:30:52 -0500
Received: (qmail 26286 invoked by uid 111); 28 Nov 2010 06:30:50 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 28 Nov 2010 06:30:50 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Nov 2010 01:30:47 -0500
Content-Disposition: inline
In-Reply-To: <1290918998-15208-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162336>

On Sun, Nov 28, 2010 at 11:36:38AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Back then when entry.c was part of checkout-index (or checkout-cache
> at that time [1]). It makes sense to print the command name in error
> messages. Nowadays entry.c is in libgit and can be used by any
> commands, printing "git checkout-index: blah" does no more than
> confusion. The error messages without it still give enough informatio=
n.
>=20
> [1] 12dccc1 (Make fiel checkout function available to the git library=
 - 2005-06-05)
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I attempted to replace "git checkout-index" with the actual command =
name
>  when these functions are called, but I think it's better just removi=
ng
>  it...

Agreed. This came up recently in another thread[1], and I also tracked
it down to a simple cut-and-paste from the original checkout-index.

Acked-by: Jeff King <peff@peff.net>

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/160751
