From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in  
 archive files)
Date: Wed, 5 Sep 2007 01:12:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709050111220.28586@racer.site>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
 <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site>
 <46DDE69C.1080908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Sep 05 06:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISm4E-00011F-HT
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 06:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbXIEEAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 00:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXIEEAb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 00:00:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:56756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750700AbXIEEAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 00:00:30 -0400
Received: (qmail invoked by alias); 05 Sep 2007 00:13:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 05 Sep 2007 02:13:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/F+E1iwTDFMMC09/nqI7ezxwWpG324++ZFZxOFoi
	QcsWq+TVEF9MtW
X-X-Sender: gene099@racer.site
In-Reply-To: <46DDE69C.1080908@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57666>

Hi,

On Wed, 5 Sep 2007, Ren? Scharfe wrote:

> Johannes Schindelin schrieb:
> 
> > On Tue, 4 Sep 2007, Andreas Ericsson wrote:
> > 
> >> Junio C Hamano wrote:
> >>> Ren? Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> >>>
> >>>> The attribute is useful for creating auto-updating specfiles.  It is 
> >>>> limited by the underlying function format_commit_message(), though. 
> >>>> E.g. currently there is no placeholder for git-describe like output, 
> >>>> and expanded specfiles can't contain NUL bytes.  That can be fixed 
> >>>> in format_commit_message() later and will then benefit users of 
> >>>> git-log, too.
> >>> Interesting. I however wonder if "specfile" is a good name for this 
> >>> attribute, although I admit I do not think of anything better offhand.
> >> "releasefile", perhaps?
> > 
> > Maybe we should not so much name it by purpose, but by function.  How 
> > about "substformat" for the attribute name, and replacing any 
> > $Format:blablub$ inside those files with something a la 
> > --pretty=format:blablub?
> 
> I like the $Format:...$ notation.  How about naming the attribute
> "template", as that's what a thus marked file is?

Unless somebody comes up with an even better name, yes (I like "template" 
better than "substformat" or "releasefile", but I still think that 
"template" is not descriptive enough).

Ciao,
Dscho
