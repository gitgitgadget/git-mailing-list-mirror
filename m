From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 20:26:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142025420.10279@pacific.mpi-cbg.de>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>  <7vab8pweod.fsf@gitster.siamese.dyndns.org>  <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>  <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> 
 <94a0d4530902140415j4168d09dh8abac0d6eba0b8cf@mail.gmail.com>  <alpine.DEB.1.00.0902142003300.10279@pacific.mpi-cbg.de> <94a0d4530902141114s7352841cmf5c4259211a793e3@mail.gmail.com> <alpine.DEB.1.00.0902142022340.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:27:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQAl-0003S7-V6
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbZBNTZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZBNTZu
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:25:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:41651 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751841AbZBNTZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:25:49 -0500
Received: (qmail invoked by alias); 14 Feb 2009 19:25:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 14 Feb 2009 20:25:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KA9VxFmLKM1Up4DORO6739I2XD/iFNwQbLv59Mz
	Xy/gr+tUAsF4x1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0902142022340.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109901>

Hi,

On Sat, 14 Feb 2009, Johannes Schindelin wrote:

> On Sat, 14 Feb 2009, Felipe Contreras wrote:
> 
> > On Sat, Feb 14, 2009 at 9:11 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > Hi,
> > >
> > > On Sat, 14 Feb 2009, Felipe Contreras wrote:
> > >
> > >> 1) --list when no config file is given uses all the config files,
> > >> wouldn't it make sense to have a --repo option?
> > >
> > > The idea of --list is not "cat .git/config".  The idea is to help users or
> > > scripts to list the current settings (_including_ the global settings).
> > >
> > > You can force showing the repo-specific config with "git --file
> > > .git/config", though.
> > 
> > When you are on the root directory of the repo, and you don't have
> > GIT_DIR, or --git-dir.
> 
> When I wrote my response, I briefly considered if I had to be verbose, and 
> decided against it.
> 
> But this is what I should have written:
> 
> 	git --file $(git rev-parse --git-dir)/config --list

Okay, before anybody points out that I was not verbose enough -- again -- 
this is what I really should have written:

	git --file "$(git rev-parse --git-dir)"/config --list

Ciao,
Dscho
