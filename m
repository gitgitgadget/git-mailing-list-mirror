From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 1/6] Introduce sorted-array binary-search function.
Date: Thu, 30 Dec 2010 11:49:08 +0100
Message-ID: <20101230104908.GB3296@home.lan>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
 <1291848695-24601-2-git-send-email-ydirson@altern.org>
 <7vwrnhb6tm.fsf@alter.siamese.dyndns.org>
 <20101230004027.GB6639@home.lan>
 <AANLkTimkemRW1H7XvwbECWUHHWVpGnvKukn06DiQO9Ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 11:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYG4c-0003yP-N8
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 11:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab0L3KtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Dec 2010 05:49:18 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:53885 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab0L3KtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 05:49:16 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 63166D480EC;
	Thu, 30 Dec 2010 11:49:09 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PYG4C-00034o-70; Thu, 30 Dec 2010 11:49:08 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTimkemRW1H7XvwbECWUHHWVpGnvKukn06DiQO9Ce@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164353>

On Thu, Dec 30, 2010 at 02:06:28AM +0100, Erik Faye-Lund wrote:
> On Thu, Dec 30, 2010 at 1:40 AM, Yann Dirson <ydirson@free.fr> wrote:
> > On Fri, Dec 10, 2010 at 02:29:09PM -0800, Junio C Hamano wrote:
> >> In addition, these macros in this patch are almost unreadable, but=
 that
> >> probably is mostly a fault of C's macro, not yours.
> >
> > Yes. =A0When writing those I sorely missed the readability of C++
> > templates - yuck :)
>=20
> Unfortunately, it's something that ends up subtracting from the value
> of the change; a couple of duplicate functions is often easier to
> maintain than nasty macros.

Well, I don't find this one much less readable than, say, vcs-svn/trp.h

At least the declare_gen_* ones are quite readable.  Maybe making the
macro names shorter would help clarify the convenience wrappers ?
