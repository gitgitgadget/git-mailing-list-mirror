From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 02:04:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de>
References: <4A9EFFB1.9090501@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 02:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mizn9-0004su-OS
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 02:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbZICAC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 20:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbZICAC6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 20:02:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:36961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753828AbZICAC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 20:02:57 -0400
Received: (qmail invoked by alias); 03 Sep 2009 00:02:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 03 Sep 2009 02:02:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FbaF7uVAF9TSOdx+GxJIJIRWWqsGHavxdolh9Mf
	UwYM97brJ+jmrv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A9EFFB1.9090501@codeaurora.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127634>

Hi,

On Wed, 2 Sep 2009, Nasser Grainawi wrote:

> I'm looking to add 'git patch-id' to JGit and I could use a few 
> pointers. I'm not very familiar with the JGit code base or Java, so 
> please excuse any blatant oversights or unintelligent questions.
> 
> First off, is there a "hacking JGit" document anywhere? One of those 
> would be great right now.

There have been some mails with details about JGit from Shawn (IIRC) to 
this very list.

> So far I'm just trying to define the inputs and outputs. On Shawn's 
> suggestion I'm planning on making it part of the org.spearce.jgit.patch 
> package. C Git patch-id very generically has an input of a 'patch', so 
> I'm thinking this implementation should use the Patch object.

C Git patch-id takes a valid patch as input; I do not think that you want 
to use the Patch object.

FWIW a patch-id is nothing else than the SHA-1 of a diff where the "diff", 
"index", "@@" lines and all the whitespace was removed.

This is not really difficult in Java, however, it relies on a working diff 
implementation (and IIRC my implementation has not yet been integrated 
into JGit).

Ciao,
Dscho
