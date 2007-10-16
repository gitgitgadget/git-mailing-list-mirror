From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 04/25] Rework make_usage to print the usage message  immediately
Date: Wed, 17 Oct 2007 00:15:55 +0200
Message-ID: <20071016221555.GB31695@olympe.madism.org>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <20071016175650.GA9992@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhukK-0000RQ-S4
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966165AbXJPWSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 18:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966147AbXJPWSE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:18:04 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:52927 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966156AbXJPWSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 18:18:00 -0400
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 2F4331C12198
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 22:16:57 +0200 (CEST)
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 7CDE0322820;
	Wed, 17 Oct 2007 00:15:56 +0200 (CEST)
Received: from olympe.madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 304F9322825;
	Wed, 17 Oct 2007 00:15:56 +0200 (CEST)
Received: by olympe.madism.org (Postfix, from userid 1001)
	id 061015E565; Wed, 17 Oct 2007 00:15:56 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20071016175650.GA9992@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61267>

On Tue, Oct 16, 2007 at 05:56:50PM +0000, Alex Riesen wrote:
> Pierre Habouzit, Tue, Oct 16, 2007 10:39:37 +0200:
> > From: Alex Riesen <raa.lkml@gmail.com>
> >=20
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> >  parse-options.c |   48 ++++++++++++++++++++++---------------------=
-----
> >  1 files changed, 22 insertions(+), 26 deletions(-)
>=20
> Got it three times: you put git@kernel.org into To: and Cc:

  sorry, but it's not the reason, I sent it three time, there was a
problem with Shawn O. Pierce, it wasn't escaped properly and VGER ate
the mails because of that.

> Why stderr, BTW? For instance, the output from "git help" is on
> stdout. To be fair, I don't know why it is stdout there either.
  because it's what usage() does already ?
>=20

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
