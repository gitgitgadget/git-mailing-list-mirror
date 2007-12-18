From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: git with custom diff for commits
Date: Tue, 18 Dec 2007 22:48:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712182246230.23902@racer.site>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com><Pine.LNX.4.64.0712172300510.9446@racer.site><vpq1w9kaphg.fsf@bauges.imag.fr><Pine.LNX.4.64.0712172310090.9446@racer.site><7vbq8o6gxw.fsf@gitster.siamese.dyndns.org><vpqk5ncz8fn.fsf@bauges.imag.fr><7vodco1him.fsf@gitster.siamese.dyndns.org><000001c841b5$89fcef00$762a14ac@na.acco.com><7vzlw7ybx7.fsf@gitster.siamese.dyndns.org><000101c841b7$5f1d1060$762a14ac@na.acco.com>
 <vpqsl1zfz8r.fsf@bauges.imag.fr> <000d01c841c5$386f7350$762a14ac@na.acco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Matthieu Moy' <Matthieu.Moy@imag.fr>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Gerald Gutierrez <ggmlfs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lFQ-0004MU-BJ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbXLRWsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbXLRWsY
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:48:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:32832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753867AbXLRWsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:48:23 -0500
Received: (qmail invoked by alias); 18 Dec 2007 22:48:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 18 Dec 2007 23:48:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18T6bATWF8TbXmJytCC4VB8Eq7gICnKhGvXTLtz9x
	ZTd718DW+5ObRn
X-X-Sender: gene099@racer.site
In-Reply-To: <000d01c841c5$386f7350$762a14ac@na.acco.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68839>

Hi,

On Tue, 18 Dec 2007, Gerald Gutierrez wrote:

[who said that?  (I know, but would you know in a few weeks?  Right.)]

> > What you seem to expect is to tell git "commit the changes except this 
> > portion", what you have to tell git is actually "commit the new state, 
> > but not if this portion is the only change". That sounds identical, 
> > but it's actually a bit different.
> 
> It's not what I'm saying.
> 
> Here's what the git-commit manpage on kernel.org says: "git-commit - 
> Record changes to the repository".

Yes.  Changes, as in "take this _file_ instead".  Not "edit this file, 
remove those lines, add these here, etc.".

So I think that you were saying exactly what Matthieu suggested.

Ciao,
Dscho
