From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Fri, 23 Feb 2007 19:38:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231935560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org>
 <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl>
 <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl>
 <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net> <455C618A.7080309@xs4all.nl>
 <ejkd6g$vog$1@sea.gmane.org> <4566E512.4010405@xs4all.nl>
 <Pine.LNX.4.63.0702230125270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcx9ywx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702231237500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vabz44tgh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 19:39:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKfJv-0000cb-7T
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 19:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXBWSit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 13:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbXBWSit
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 13:38:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:40390 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932583AbXBWSis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 13:38:48 -0500
Received: (qmail invoked by alias); 23 Feb 2007 18:38:47 -0000
X-Provags-ID: V01U2FsdGVkX1/lsT9qQtHlNUyO1bRiZYlyfYNRzp7tKh8DREzz//
	zAoA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vabz44tgh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40462>

Hi,

On Fri, 23 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > The supported placeholders are:
> >> >
> >> > 	'%H': commit hash
> >> >...
> >> > 	'%b': body
> >> 
> >> Hmmm.  Would we want to make them somehow interoperable with 
> >> git-for-each-ref format atoms?
> >
> > But those placeholders are so long! Not even GNU date supports such 
> > long placeholders... And I could not reuse interpolate.[ch] as is for 
> > that.
> 
> What I was hinting at was to fix (or extend) for-each-ref to accept 
> these short-and-sweet placeholders.

Ah, the other way round...

> >> Also, it _might_ be worthwhile to do something like "%+4b" which 
> >> means "indent each line of this field with 4 spaces", for a 
> >> multi-line field like "%b".
> >
> > Same goes here: interpolate.[ch] does not (yet) allow for that.
> 
> Nah, if you feel it is too much work, I trust your judgement (I
> do not recall details of how interpolate.c does its thing).  I
> do not think it's worth it.

Sure, it _would_ be nice to let interpolate call back, instead of having 
to fill a table with static strings (xstrdup()ing them, no less).

However, I want to go play Snooker tonight, so this is up-for-grabs.

Ciao,
Dscho
