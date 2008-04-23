From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 09:36:55 +0200
Message-ID: <200804230936.55539.barra_cuda@katamail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <200804222251.04559.barra_cuda@katamail.com> <7vd4ohwhcj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:36:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoZVt-0000IX-PD
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 09:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbYDWHer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Apr 2008 03:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbYDWHer
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 03:34:47 -0400
Received: from smtp.katamail.com ([62.149.157.154]:50090 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750856AbYDWHer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 03:34:47 -0400
Received: (qmail 9298 invoked by uid 89); 23 Apr 2008 07:31:35 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host15-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.15)
  by smtp1-pc with SMTP; 23 Apr 2008 07:31:33 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <7vd4ohwhcj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80194>

On Wednesday 23 April 2008, Junio C Hamano wrote:
> In the thread, addition of an extra hook to "gc --auto" wasdiscussed.=
 =C2=A0It
> was judged conditionally Ok as long as nobody assumes "gc --auto" is
> ultra-cheap. =C2=A0We used to have a "gc --auto" at the end of git-co=
mmit which
> violated that condition, but we do not have that anymore.
>=20
> The patch resurrects the behaviour that makes the extra hook possibly
> unacceptable again, dosn't it?

Yes. I thought there was an unwanted change in behavior in git-commit.
Sorry for the noise.
