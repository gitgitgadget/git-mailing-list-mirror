From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 13:43:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291343120.13507@racer.site.net>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 29 14:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1hW4-00066H-JZ
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 14:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbYE2MpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 08:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYE2MpI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 08:45:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:39937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751781AbYE2MpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 08:45:07 -0400
Received: (qmail invoked by alias); 29 May 2008 12:45:05 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 29 May 2008 14:45:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DCRFrJIZD9d3L92A80BSmNOz2hdNLGcnHNzdQJw
	TAZaUyTdLl1Pfo
X-X-Sender: gene099@racer.site.net
In-Reply-To: <E1K1eXH-00063c-Bt@fencepost.gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83193>

Hi,

On Thu, 29 May 2008, Paolo Bonzini wrote:

> @@ -233,6 +228,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
>  	if (*argv)
>  		pathspec = get_pathspec(prefix, argv);
>  
> +	assert (!(interactive && pathspec && *pathspec));

As pathspec is specified indirectly by the user, I think an assert() here 
is actively wrong.

Ciao,
Dscho
