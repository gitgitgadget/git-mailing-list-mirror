From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 23:15:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804062315090.12583@eeepc-johanness>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062204580.12583@eeepc-johanness> <20080406220447.GB5822@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:16:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JidAP-00068M-5h
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 00:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613AbYDFWQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 18:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755566AbYDFWQC
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 18:16:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:40239 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754967AbYDFWQB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 18:16:01 -0400
Received: (qmail invoked by alias); 06 Apr 2008 22:15:59 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO eeepc-johanness.home) [86.165.92.90]
  by mail.gmx.net (mp002) with SMTP; 07 Apr 2008 00:15:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19y3pRiSmNyCtUVO4A0Dqfi7wM1HUMVV+bGrYqGxk
	BsBgT0X1AQkgyO
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080406220447.GB5822@adamsimpkins.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78936>

Hi,

On Sun, 6 Apr 2008, Adam Simpkins wrote:

> On Sun, Apr 06, 2008 at 10:06:24PM +0100, Johannes Schindelin wrote:
> > 
> > On Sun, 6 Apr 2008, Adam Simpkins wrote:
> > 
> > > +/* Defined in commit.h */
> > > +struct commit;
> > > +/* Defined in strbuf.h */
> > > +struct strbuf;
> > 
> > You do not need those.
> 
> I added them so that graph.h can be included without including any other 
> header files first.  They can be taken out if we assume that all users 
> of graph.h will include commit.h and strbuf.h first.

AFAICT you do not even need them then.  Using "struct strbuf *" without 
ever declaring struct strbuf before that is perfectly valid.

Ciao,
Dscho
