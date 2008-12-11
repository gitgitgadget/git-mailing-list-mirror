From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: malloc fails when dealing with huge files
Date: Thu, 11 Dec 2008 10:11:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812111009460.18321@eeepc-johanness>
References: <43c10b980812100742t3a65466yb9b7310bfedb2b18@mail.gmail.com> <alpine.LFD.2.00.0812101121401.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Blanton <jonathan.blanton@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 10:11:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAhZa-0001dr-Nk
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 10:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbYLKJJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 04:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbYLKJJt
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 04:09:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:60764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753924AbYLKJJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 04:09:47 -0500
Received: (qmail invoked by alias); 11 Dec 2008 09:09:46 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness) [130.60.5.218]
  by mail.gmx.net (mp033) with SMTP; 11 Dec 2008 10:09:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Pc69UAZKP88VNBqNnvd5RSSoJ/B1/E2VWVEw3pE
	rtj5B3UnCBj+Of
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.LFD.2.00.0812101121401.3340@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102790>

Hi,

On Wed, 10 Dec 2008, Linus Torvalds wrote:

> However, git performance with big files would never be wonderful, and 
> things like "git diff" would still end up reading not just the whole 
> file, but _both_versions_ at the same time. Marking the big files as 
> being no-diff might help, though.

Makes me wonder if we should not have a default cut-off, say, 10MB, at 
which files are automatically tagged with the no-diff attribute (unless 
overridden explicitely in .gitattributes)?

Ciao,
Dscho
