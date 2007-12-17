From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git with custom diff for commits
Date: Mon, 17 Dec 2007 23:11:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712172310090.9446@racer.site>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
 <Pine.LNX.4.64.0712172300510.9446@racer.site> <vpq1w9kaphg.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerald Gutierrez <ggmlfs@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4P8m-00087v-FW
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761016AbXLQXMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761485AbXLQXMP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:12:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:50679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761016AbXLQXMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:12:12 -0500
Received: (qmail invoked by alias); 17 Dec 2007 23:12:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 18 Dec 2007 00:12:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mzxcp5tomZxW4aGS6ipYHgZu1O+R3ZeVYWV88q9
	VhGo0VvMRMqGjY
X-X-Sender: gene099@racer.site
In-Reply-To: <vpq1w9kaphg.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68655>

Hi,

On Tue, 18 Dec 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 17 Dec 2007, Gerald Gutierrez wrote:
> >
> >> I've tried to set up an external diff script that runs diff -I "<<sql 
> >> timestamp comment>>" that effectively ignores the timestamp. While 
> >> this works with "git diff", it seems when git commits, it still sees 
> >> the differences.
> >> 
> >> How do I properly teach git to ignore these types of differences?
> >
> > You might be interested in reading Documentation/gitattributes.txt, 
> > look for "diff driver".
> 
> It will show an empty output for "git diff", but I doubt thit will 
> change anything at commit time. Probably the "filter" thing on the same 
> file (also "man gitattributes") can help though.

Ah, right.  I completely missed that you were talking about git-commit, 
not git-log on git commits.

Yes, setting up a "clean" filter that removes the timestamps is probably 
the reasonable thing to do here.

Sorry for the noise,
Dscho
