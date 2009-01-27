From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] t3404 & t3411: undo copy&paste
Date: Tue, 27 Jan 2009 23:53:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272352110.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901271845380.3586@pacific.mpi-cbg.de> <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901272254450.14855@racer> <7veiyo1i5y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwpL-0001CA-8Y
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbZA0WxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbZA0WxN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:53:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:39455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750947AbZA0WxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:53:13 -0500
Received: (qmail invoked by alias); 27 Jan 2009 22:53:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 27 Jan 2009 23:53:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wQlw5YhmwRoMTUl0lFlkYEAp48kVK2qdHNsIUyt
	BL1u+LcYw0dIMU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7veiyo1i5y.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107415>

Hi,

On Tue, 27 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +		sed -n "${line}p" < "$1".tmp
> >> > +		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
> >> > +		sed -n "${line}s/^pick/$action/p" < "$1".tmp
> >
> > Probably.  It is for debugging, anyway.  As everything you only see with 
> > -v.
> 
> Exactly.  That is why I'd rather want to see what exact insn sequence is 
> being fed to the "rebase -i".  Because I'd be debugging my new test or 
> changes to "rebase -i", not debugging fake-editor's use of sed.

If you are really after seeing the constructed rebase script, then

			tail -n 1 "$1"

would make tons more sense, no?

Ciao,
Dscho
