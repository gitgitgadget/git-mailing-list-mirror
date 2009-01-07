From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Fix sourcing "test-lib.sh" using dash shell in "t3003-ls-files-narrow-match.sh"
Date: Wed, 7 Jan 2009 08:29:16 +0100
Message-ID: <200901070829.16752.chriscool@tuxfamily.org>
References: <20090105143002.8a369535.chriscool@tuxfamily.org> <7vzli4kftt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 08:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKSrs-0005JO-VU
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 08:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbZAGH2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 02:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbZAGH2c
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 02:28:32 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:38139 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbZAGH2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 02:28:31 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 37564D48101;
	Wed,  7 Jan 2009 08:28:23 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 0F14FD48129;
	Wed,  7 Jan 2009 08:28:21 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vzli4kftt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104767>

Le mardi 6 janvier 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > dash barfs, on my old Ubuntu box, when "test-lib.sh" is sourced
> > without "./".
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  t/t3003-ls-files-narrow-match.sh |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > 	This patch applies to "pu".
>
> Thanks; I hope you don't mind squashing this in to 'Introduce "sparse
> patterns"'.

No problem.

Thanks,
Christian.
