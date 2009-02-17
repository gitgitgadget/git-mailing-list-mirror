From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] filter-branch -d: Export GIT_DIR earlier
Date: Wed, 18 Feb 2009 00:03:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902180002090.10279@pacific.mpi-cbg.de>
References: <20090217083146.GA7338@lars.home.noschinski.de> <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302> <20090217175959.GA3564@lars.home.noschinski.de> <20090217180540.GB3564@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:04:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYyy-0005Hm-7G
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbZBQXCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbZBQXCT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:02:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:59551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754363AbZBQXCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:02:18 -0500
Received: (qmail invoked by alias); 17 Feb 2009 23:02:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 18 Feb 2009 00:02:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19TpEQwN+xT7FAnOsEAq7Y6WbG8vaLp8SWgYASTX4
	nVwAvoBvfZpDaG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090217180540.GB3564@lars.home.noschinski.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110470>

Hi,

On Tue, 17 Feb 2009, Lars Noschinski wrote:

> The improved error handling catches a bug in filter-branch when using
> -d pointing to a path outside any git repository:
> 
> $ mkdir foo
> $ cd foo
> $ git init
> $ touch bar
> $ git add bar
> $ git commit -m bar
> $ git filter-branch -d /tmp/filter master
> fatal: Not a git repository (or any of the parent directories): .git
> 
> This error message comes from git for-each-ref in line 224. GIT_DIR is
> set correctly by git-sh-setup (to the foo.git repository), but not
> exported (yet).
> 
> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
> ---

Let me quickly add my ACK before Junio can apply the patch without it.  
(Even I had the impression that you wanted to trim down the commit 
message, but it really does not matter to me all that much.)

Ciao,
Dscho
