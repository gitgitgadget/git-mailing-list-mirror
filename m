From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] show-branch: use pager
Date: Thu, 13 Jun 2013 11:32:37 +0200
Message-ID: <vpq1u86pd8q.fsf@anie.imag.fr>
References: <20130613070118.GA23235@sigill.intra.peff.net>
	<1371110238-6910-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?iso-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 11:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un3th-0008Fi-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 11:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab3FMJcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 05:32:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59657 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134Ab3FMJco (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 05:32:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5D9WaBu009930
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 11:32:36 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Un3tV-0004Mi-Vy; Thu, 13 Jun 2013 11:32:38 +0200
In-Reply-To: <1371110238-6910-1-git-send-email-oystwa@gmail.com>
 (=?iso-8859-1?Q?=22=D8ystein?=
	Walle"'s message of "Thu, 13 Jun 2013 09:57:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 Jun 2013 11:32:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227709>

=D8ystein Walle <oystwa@gmail.com> writes:

> This is for consistency with other porcelain commands such as 'log'.

I don't think consistency with other porcelain is a sufficient argument=
=2E
Many commands purposely don't use the pager by default because they wil=
l
normally have a short output.

Users can already set "pager.show-branch" to get the behavior you
introduce in the patch. The question is more: will users prefer having
the pager by default for this particular command? I don't use
show-branch enough to answer by myself, but probably the answer is yes.

(This is not an objection, just to make sure you have all the elements)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
