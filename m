From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 12:37:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101237050.30769@pacific.mpi-cbg.de>
References: <87wsd48wam.fsf@iki.fi> <1231549039-5236-1-git-send-email-trast@student.ethz.ch> <gk8usj$slh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 12:38:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLcAs-0002hF-6y
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbZAJLhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbZAJLhP
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:37:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:45381 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753919AbZAJLhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:37:14 -0500
Received: (qmail invoked by alias); 10 Jan 2009 11:37:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 10 Jan 2009 12:37:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gaB44Z/ng7FF2E/iuPKrKWnVhSNwT12gnhWdSeR
	YG1tNA9DlDqixr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <gk8usj$slh$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105095>

Hi,

On Sat, 10 Jan 2009, Jakub Narebski wrote:

> Thomas Rast wrote:
> 
> > --color-words works (and always worked) by splitting words onto one
> > line each, and using the normal line-diff machinery to get a word
> > diff. 
> 
> Cannot we generalize diff machinery / use underlying LCS diff engine
> instead of going through line diff?

What do you think we're doing?  libxdiff is pretty hardcoded to newlines.  
That's why we're substituting non-word characters with newlines.

Ciao,
Dscho
