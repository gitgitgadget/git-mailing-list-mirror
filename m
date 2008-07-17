From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git submodule update to use distributed
 repositories
Date: Thu, 17 Jul 2008 15:16:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807171513560.8986@racer>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>  <alpine.DEB.1.00.0807171311010.8986@racer>  <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>  <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com> 
 <alpine.DEB.1.00.0807171351380.8986@racer> <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:17:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUIL-0001aE-CT
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbYGQOQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756549AbYGQOQU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:16:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:38298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755772AbYGQOQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:16:19 -0400
Received: (qmail invoked by alias); 17 Jul 2008 14:16:18 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp048) with SMTP; 17 Jul 2008 16:16:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Jf6EoOWdJh/G/cwyzQcsH6aXvWaC72hxxLkq3fU
	HQWHWFtNEfmwjM
X-X-Sender: gene099@racer
In-Reply-To: <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88856>

Hi,

On Thu, 17 Jul 2008, Nigel Magnay wrote:

> Your attitude seems to be that the status-quo is in some way desirable; 
> "It's no wonder that this tool is awkward to use in your workflow.". 
> This workflow is really common, and there's actual, real people on this 
> list complaining about it. Don't we think it could be improved to be 
> non-awkward ?

I do not think that the status quo is the best possible.

But I think that the way you go makes things so confusing that those who 
use it apart from you will have problems.

For example, in your setup everybody would have to install _different_ 
remotes in every submodule.

And then some would ask themselves why the original origin was not good 
enough.

And others would specify "-o origin" all the time, thinking it was 
required.

There must be a better way to promote submodules to a usable state,
Dscho
