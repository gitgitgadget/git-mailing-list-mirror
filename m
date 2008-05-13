From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive
 description
Date: Tue, 13 May 2008 12:52:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805131251320.30431@racer>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue May 13 13:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvt3v-00057V-46
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 13:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbYEMLwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 07:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYEMLwF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 07:52:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:42718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751524AbYEMLwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 07:52:03 -0400
Received: (qmail invoked by alias); 13 May 2008 11:52:01 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp028) with SMTP; 13 May 2008 13:52:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eLGNf9ILelDVHh84xe2G7iXN3s0qxJTul9citjg
	9tqgsyC45rDZHv
X-X-Sender: gene099@racer
In-Reply-To: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82021>

Hi,

On Tue, 13 May 2008, Pieter de Bie wrote:

> The documentation for the --aggressive flag was misleading, hinting that 
> running git gc with --aggressive is a good thing. However, --aggressive 
> only really makes sense if you have a bad pack file, such as from 
> git-fast-import.

I disagree.  It makes sense to "git gc --aggressive" also after cloning 
from somebody who did not do so.

Ciao,
Dscho
