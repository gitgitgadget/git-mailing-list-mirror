From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in
 archive files)
Date: Tue, 4 Sep 2007 11:41:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041139140.28586@racer.site>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
 <46DCF0EF.9020604@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISVqj-0003Q8-Ge
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 12:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbXIDKla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 06:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbXIDKla
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 06:41:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:55032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751820AbXIDKl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 06:41:29 -0400
Received: (qmail invoked by alias); 04 Sep 2007 10:41:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 04 Sep 2007 12:41:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OVYEQYnfOPfCfMMLDGDOAciWSxUDSAcZ9D3V8zS
	XIpVrkf+vxr4TA
X-X-Sender: gene099@racer.site
In-Reply-To: <46DCF0EF.9020604@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57547>

Hi,

On Tue, 4 Sep 2007, Andreas Ericsson wrote:

> Junio C Hamano wrote:
> > Ren? Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> > 
> > > The attribute is useful for creating auto-updating specfiles.  It is 
> > > limited by the underlying function format_commit_message(), though. 
> > > E.g. currently there is no placeholder for git-describe like output, 
> > > and expanded specfiles can't contain NUL bytes.  That can be fixed 
> > > in format_commit_message() later and will then benefit users of 
> > > git-log, too.
> > 
> > Interesting. I however wonder if "specfile" is a good name for this 
> > attribute, although I admit I do not think of anything better offhand.
> 
> "releasefile", perhaps?

Maybe we should not so much name it by purpose, but by function.  How 
about "substformat" for the attribute name, and replacing any 
$Format:blablub$ inside those files with something a la 
--pretty=format:blablub?

Ciao,
Dscho
