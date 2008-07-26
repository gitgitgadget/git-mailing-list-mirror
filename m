From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sat, 26 Jul 2008 17:35:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261732500.26810@eeepc-johanness>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness> <488B3A97.6000606@keyaccess.nl> <alpine.DEB.1.00.0807261709090.26810@eeepc-johanness> <488B409D.40709@keyaccess.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlnb-0001iU-3G
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbYGZPeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbYGZPeK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:34:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:53378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752244AbYGZPeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:34:09 -0400
Received: (qmail invoked by alias); 26 Jul 2008 15:34:06 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp021) with SMTP; 26 Jul 2008 17:34:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+T0iEhJfeTYpILxFk6qgBE8DM6YVunHTPLftpHe0
	W364JaqlG7OviH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <488B409D.40709@keyaccess.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90243>

Hi,

On Sat, 26 Jul 2008, Rene Herman wrote:

> Adding to the PATH is generally not disallowed by user level security. 
> Replacing the GIT binary generally is.

Prepending to the PATH is generally not disallowed either.  And that's 
just as good as replacing the Git binary.

This issue is totally independent of Git.  And it is totally bogus to 
think about the complicated issues when the "weakest link of the chain" is 
much easier to exploit.

Hth,
Dscho
