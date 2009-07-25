From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Option/Subcommand Processing Library?
Date: Sat, 25 Jul 2009 18:32:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907251830420.8306@pacific.mpi-cbg.de>
References: <231BD892-07B1-452C-A224-047829E21991@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Bergin <michaeljbergin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 18:33:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUkBA-0004MW-04
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 18:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbZGYQcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 12:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbZGYQcv
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 12:32:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:55421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751236AbZGYQcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 12:32:51 -0400
Received: (qmail invoked by alias); 25 Jul 2009 16:32:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 25 Jul 2009 18:32:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wRBZxuWywPB5VX0jMXAVW/WqCT7UxlHwZ1q0CEX
	7bh0Lvj5n500GE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <231BD892-07B1-452C-A224-047829E21991@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124020>

Hi,

On Sat, 25 Jul 2009, Michael Bergin wrote:

> Is there a library containing just the option and subcommand processing 
> code from git?  I saw a post about gitopt but can't find a project with 
> that name.

The "library" is contained in the files parse-options.[ch] in git.git.  I 
am unsure if you need strbuf.c, too, or not.

> If not is there any problem with me doing this?

Not if you abide by the license of git.git, which is GPLv2.

Ciao,
Dscho
