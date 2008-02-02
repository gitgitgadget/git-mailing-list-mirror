From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere
 (unify examples)
Date: Sat, 2 Feb 2008 02:37:44 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802020235480.7372@racer.site>
References: <3asc6spe.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 03:39:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL8HX-0004J8-LV
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 03:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbYBBCiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbYBBCiS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:38:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:36177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753836AbYBBCiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:38:17 -0500
Received: (qmail invoked by alias); 02 Feb 2008 02:38:15 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp051) with SMTP; 02 Feb 2008 03:38:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pOMUjonnpZMraut9Q83MU32yRc+QDW95MYy06iR
	O+dYg8+yl50MBu
X-X-Sender: gene099@racer.site
In-Reply-To: <3asc6spe.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72212>

Hi,

On Sat, 2 Feb 2008, Jari Aalto wrote:

> The examples in the documentation refer to multiple ~N commits. To Keep 
> the exampels unified with the same syntax, use ~N in all examples.

AFAIR it was already shot down.  Personally, I think it is not expecting 
too much of people to have the ambiguity between ~1 and ^1.  Even worse, 
if you hide the ^-syntax from new users, they will be puzzled how to 
access the different parents of merge commits.

Ciao,
Dscho
