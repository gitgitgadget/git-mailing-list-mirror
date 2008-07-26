From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-reset: Let -q hush "locally modified" messages
Date: Sat, 26 Jul 2008 04:34:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260433250.11976@eeepc-johanness>
References: <1217018948-32475-1-git-send-email-s-beyer@gmx.net> <7vwsj9r722.fsf@gitster.siamese.dyndns.org> <20080725213853.GD13539@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 04:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMZc3-0008LN-VT
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 04:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbYGZCd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 22:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbYGZCd1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 22:33:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:43104 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752482AbYGZCd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 22:33:27 -0400
Received: (qmail invoked by alias); 26 Jul 2008 02:33:25 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp056) with SMTP; 26 Jul 2008 04:33:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eFOpGGL0eBMh3kIhI/1dvKxTMFDfRTHTExilHYB
	QmZsD8QW43bJ8C
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080725213853.GD13539@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90152>

Hi,

On Fri, 25 Jul 2008, Stephan Beyer wrote:

> Junio C Hamano wrote:
> > Stephan Beyer <s-beyer@gmx.net> writes:
> > 
> > > git reset -q makes reset more quiet, but "locally modified" messages 
> > > are still shown.  This patch makes them disappear, too.
> > 
> > Files being "locally modified" is not and error, so I think it is in 
> > line with the spirit of what -q is meant to do.
> > 
> > It is an interface change, though.
> 
> Yes, as "needs update" -> "locally modified" was.

But that is not about scripts.  Scripts have no business calling pure 
porcelain, so they still get "needs update" if done properly.

Hth,
Dscho
