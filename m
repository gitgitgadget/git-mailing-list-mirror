From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff
 --cached'.
Date: Wed, 29 Oct 2008 02:02:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810290201400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 01:56:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuzMS-0004KT-BZ
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 01:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYJ2AzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 20:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbYJ2AzW
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 20:55:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:57409 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752704AbYJ2AzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 20:55:21 -0400
Received: (qmail invoked by alias); 29 Oct 2008 00:55:19 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 29 Oct 2008 01:55:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZiO9EAiQZkEvI7VnlBtH/+v2WclodcYVRVAzNHR
	KS6+kSrknbdR2V
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1225241048-99267-1-git-send-email-dsymonds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99340>

Hi,

On Tue, 28 Oct 2008, David Symonds wrote:

> diff --git a/.gitignore b/.gitignore
> index bbaf9de..9353d19 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -118,6 +118,7 @@ git-show
>  git-show-branch
>  git-show-index
>  git-show-ref
> +git-staged

Would it not be better to teach "git show --staged" to do that, and to add 
a command pair "git stage <file>" and "git unstage <file>" to do the 
obvious?

Ciao,
Dscho
