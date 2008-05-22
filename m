From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH resend] perl/Makefile.PL: teach makefiles about possible
 old Error.pm files
Date: Thu, 22 May 2008 12:46:12 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221245240.30431@racer>
References: <20080517011614.GA11029@foursquare.net> <20080521222150.GA29696@foursquare.net> <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org> <20080521235647.GA21340@foursquare.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Thu May 22 13:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz9G9-0004Ai-L6
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 13:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759456AbYEVLqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 07:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759420AbYEVLqF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 07:46:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:44848 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759403AbYEVLqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 07:46:05 -0400
Received: (qmail invoked by alias); 22 May 2008 11:46:01 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp057) with SMTP; 22 May 2008 13:46:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+a/iwq7L+ayvS0qN1IQw4aXqgxczOMEeRcFREeP8
	qkzbWwMT0R74Am
X-X-Sender: gene099@racer
In-Reply-To: <20080521235647.GA21340@foursquare.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82615>

Hi,

On Wed, 21 May 2008, Chris Frey wrote:

> The problem as I see it, is that the decision about whether the existing 
> Error.pm "works as expected" is done at compile time.  And git will 
> break itself by repeated installs.

I do not see how it is _Git_ that breaks itself by repeated installs.  It 
detects that there is an Error.pm.  Fine.  You _remove_ it while 
installing Git.  Not fine.  Not Git's error.

Ciao,
Dscho
