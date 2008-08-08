From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: commit-tree: remove 16 parents
 restriction
Date: Fri, 8 Aug 2008 12:38:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081238250.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218181975-12093-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 08 12:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRPJX-0004or-Bs
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbYHHKeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 06:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbYHHKeO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:34:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50999 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754098AbYHHKeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:34:13 -0400
Received: (qmail invoked by alias); 08 Aug 2008 10:34:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 08 Aug 2008 12:34:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/U60cKnknUU5N2e+vtYmA4RuP8Y4IVq3kmg0irTO
	eT2qNfz5efgfsX
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1218181975-12093-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91652>

Hi,

On Fri, 8 Aug 2008, Thomas Rast wrote:

> ef98c5ca lifted the 16 parents restriction in builtin-commit-tree.c,
> but forgot to update the documentation.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/git-commit-tree.txt |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
> index feec584..92ab3ab 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -16,12 +16,12 @@ This is usually not what an end user wants to run directly.  See
>  linkgit:git-commit[1] instead.
>  
>  Creates a new commit object based on the provided tree object and
> -emits the new commit object id on stdout. If no parent is given then
> -it is considered to be an initial tree.
> +emits the new commit object id on stdout.

Oops.

Ciao,
Dscho
