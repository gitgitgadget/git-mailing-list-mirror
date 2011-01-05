From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] Fixes bug: git-diff: class methods are not detected in hunk headers for Pascal
Date: Wed, 5 Jan 2011 15:31:48 +0100
Message-ID: <201101051531.49142.trast@student.ethz.ch>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <4510264083.20110105145302@mail.ru> <201101051523.55749.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?b?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Wed Jan 05 15:31:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaUP6-00036P-3F
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 15:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110Ab1AEObv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 09:31:51 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:49972 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab1AEObv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 09:31:51 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 5 Jan
 2011 15:31:41 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 5 Jan
 2011 15:31:49 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <201101051523.55749.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164565>

Thomas Rast wrote:
> =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=A8=D1=83=D0=BC=D0=BA=D0=
=B8=D0=BD wrote:
> > I did as you said I changed commit message (also included
> > "Acked-by:"). So should I re-submit patch to the maillist as a new =
one
> > or as an answer to this thread?
>=20
> It doesn't matter that much; most people resend as a reply to some
> email in the thread.  Just don't distribute the reroll all across the
> thread :-)

BTW speaking of series (and sorry for not pointing this out earlier):

Since these patches are not related to each other at all, it's better
if you treat them as separate, not as a series.  Making a series is
sort of an "all or nothing" hint, meaning that if something holds up
one patch in the series, Junio will treat the whole series as stalled,
etc.

So probably it's better if you resend the acked patch alone, to show
that it can stand on its own.  Then later repeat the same for the
other two patches when you have them ready.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
