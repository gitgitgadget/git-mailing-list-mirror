From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: git with custom diff for commits
Date: Tue, 18 Dec 2007 21:27:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712182124410.23902@racer.site>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com><Pine.LNX.4.64.0712172300510.9446@racer.site><vpq1w9kaphg.fsf@bauges.imag.fr><Pine.LNX.4.64.0712172310090.9446@racer.site><7vbq8o6gxw.fsf@gitster.siamese.dyndns.org><vpqk5ncz8fn.fsf@bauges.imag.fr><7vodco1him.fsf@gitster.siamese.dyndns.org><000001c841b5$89fcef00$762a14ac@na.acco.com>
 <7vzlw7ybx7.fsf@gitster.siamese.dyndns.org> <000101c841b7$5f1d1060$762a14ac@na.acco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Matthieu Moy' <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Gerald Gutierrez <ggmlfs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:29:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jzo-0005YN-4q
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbXLRV1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbXLRV1Y
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:27:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:41518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753246AbXLRV1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:27:23 -0500
Received: (qmail invoked by alias); 18 Dec 2007 21:27:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 18 Dec 2007 22:27:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IOiUILOMIGv8hpJUIdhgUma0CBfy0lwPILLY4Hq
	Af4IB1ahNegLZk
X-X-Sender: gene099@racer.site
In-Reply-To: <000101c841b7$5f1d1060$762a14ac@na.acco.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68818>

Hi,

On Tue, 18 Dec 2007, Gerald Gutierrez wrote:

> Yes, but wouldn't it be slick to actually teach git's internal diff to 
> do things like GNU diff can, like the ignore option -I, case 
> insensitivity, etc. I thought that's what the external diff capability 
> is for, but it is not so.

I disagree.  Your statement is misleading when you say you want the 
internal diff to do things like GNU diff can.

What you want to do _in fact_ is not only modify the diff _output_, but 
the commit _input_.

And I am not so keen on such filters.  If I do not want to commit,  I do 
not change it to begin with.  Yes, your mysqldump is a special case here.  
But it is special anyway, as it is not source code.

Ciao,
Dscho
