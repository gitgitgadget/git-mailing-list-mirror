From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: allowing aliases to override builtins to support default
 options
Date: Sat, 7 Mar 2009 03:37:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903070336200.10279@pacific.mpi-cbg.de>
References: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfmQ9-0007CO-P8
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 03:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbZCGCgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 21:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbZCGCgF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 21:36:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:33961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751147AbZCGCgC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 21:36:02 -0500
Received: (qmail invoked by alias); 07 Mar 2009 02:35:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 07 Mar 2009 03:35:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NV35d+tFND7cc3YPF1WHqNnG4eQArGrpgLnseU7
	zZHAP/iSkBugJP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112504>

Hi,

On Fri, 6 Mar 2009, Jay Soffian wrote:

> Currently git does not allow aliases to override builtins. I understand 
> the reasoning behind this, but I wonder if it's overly conservative.
> 
> Most shells support overriding commands with aliases, and I'm not sure 
> why git needs to be more conservative than the shell. (Although, I will 
> say, I hate when vendors alias rm to "rm -i", etc...)
> 
> It seems like this would be an elegant way to support default options.

What you dream about breaks a lot of scripts.

So while it might be nice for you, you would make life of others much, 
much, much harder.  Not nice at all.

Ciao,
Dscho
