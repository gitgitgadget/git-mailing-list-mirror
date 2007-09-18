From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Latest builtin-commit series
Date: Tue, 18 Sep 2007 23:24:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709182324230.28395@racer.site>
References: <1190129009.23692.24.camel@hinata.boston.redhat.com>
 <20070918213903.GA14488@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlVh-0003NG-FT
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXIRWZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXIRWZb
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:25:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:51509 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751399AbXIRWZa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:25:30 -0400
Received: (qmail invoked by alias); 18 Sep 2007 22:25:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 19 Sep 2007 00:25:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lxNENF5blhJPP8nd70w3u7lJlkoqB2botBmSn5g
	8bhnF+xqjWjunA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070918213903.GA14488@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58640>

Hi,

On Tue, 18 Sep 2007, Alex Riesen wrote:

> Kristian H?gsberg, Tue, Sep 18, 2007 17:23:29 +0200:
> >       * Set the test suite default editor to '/bin/true' instead of ':'.
> >         Since we're not exec'ing the editor from shell anymore, ':'
> >         won't work.  Maybe we should special case ':' in launch_editor
> >         or perhaps make launch_editor use system(3).  Not sure.
> 
> Special case "" (empty string)? MinGW may have problems with
> /bin/true, any future exotic ports notwithstanding (OS/2, anyone?).

No problem.  At least in msysGit.

Ciao,
Dscho
