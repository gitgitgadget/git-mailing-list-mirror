From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Newbie question regarding 3way merge order.
Date: Tue, 03 Feb 2009 08:21:24 +0100
Message-ID: <4987F074.9040506@viscovery.net>
References: <871vulda2r.fsf@gigli.quasi.internal>	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>	<7vskmyt127.fsf@gitster.siamese.dyndns.org>	<871vugc2c8.fsf@gigli.quasi.internal> <49871ADA.4080905@viscovery.net> <87wsc8aenx.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 08:22:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUFcY-00059f-G9
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 08:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbZBCHVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 02:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbZBCHVc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 02:21:32 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26011 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbZBCHVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 02:21:31 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUFb6-0002tp-Ln
	for git@vger.kernel.org; Tue, 03 Feb 2009 08:21:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP id 2C5046C4
	for <git@vger.kernel.org>; Tue,  3 Feb 2009 08:21:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <87wsc8aenx.fsf@gigli.quasi.internal>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108159>

Again: Don't set Mail-Followup-To and keep the Cc list if you want to
communicate efficiently on this list.

Raimund Berger schrieb:
> Are you sure you're not making assumptions about "obvious" manual
> resolutions? E.g. I can't quite see how A+B, which is
> 
>       g(a)----
>      /        \
>  f(a)          g(a)f(b) or f(a)f(b) ???
>      \        /
>       f(a)f(b)
> 
> would not be flagged as a conflict regarding f(a) vs. g(a).

My introductory sentence was probably not clear enough. I meant:

  mergebase	A	B	A+B
	f	g	f	g
	(	(	(	(
	a	a	a	a
	)	)	)	)
			f	f
			(	(
			b	b
			)	)

There is no conflict in A+B. But strctly speaking, this could be regarded
as an ambiguous merge since the change f->g could be applied to two
places. But if context is taken into consideration, then there is no
conflict in practice.

> And that's why I specifically "limited" my equality relation to
> automatic resolutions, to simplify the discussion and deal with kind of
> minimum requirements first. I didn't even mention that originally
> because I felt it was so obvious.

Yes, it was so obvious, that I thought my statement about "colums are
lines" and "saving vertical space" were obvious, too.

-- Hannes
