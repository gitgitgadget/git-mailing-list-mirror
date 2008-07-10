From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: feature request: git-log should accept sth like
 v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 00:24:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807110022510.3279@eeepc-johanness>
References: <200807102057.15063.toralf.foerster@gmx.de> <7vk5ftpnek.fsf@gitster.siamese.dyndns.org> <m3d4lledbn.fsf@localhost.localdomain> <7v8ww9pkv8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4Zc-00069D-2P
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYGJWYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYGJWYL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:24:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:43923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751186AbYGJWYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:24:10 -0400
Received: (qmail invoked by alias); 10 Jul 2008 22:24:08 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp019) with SMTP; 11 Jul 2008 00:24:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TIUd1hwmTUQ+s+yAhdEGS/DqNnL4F8iGfpSjwb4
	gP1e4ReTeMXqOo
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v8ww9pkv8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88017>

Hi,

On Thu, 10 Jul 2008, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Besides, it would be nice to have some command (git-rev-parse 
> > perhaps?) which could take ambiguous commit-ish, and list all commit 
> > which matches it.
> 
> Have fun writing it and send in a patch.

Note that this really could be a patch, but not for rev-parse.  Patch 
revision.c instead to parse the argument into _all_ matching revisions.

The :/ notation I no longer like so much should give you a lot of 
inspiration.

Good luck,
Dscho
