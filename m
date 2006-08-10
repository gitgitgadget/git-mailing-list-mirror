From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: repo-config needs a prefix.
Date: Thu, 10 Aug 2006 11:42:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101140040.13885@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44DAFE34.50701@codeweavers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 10 11:43:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB741-0000KP-4p
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 11:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWHJJmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 05:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWHJJmt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 05:42:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:36329 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751490AbWHJJmt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 05:42:49 -0400
Received: (qmail invoked by alias); 10 Aug 2006 09:42:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 10 Aug 2006 11:42:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Robert Shearman <rob@codeweavers.com>
In-Reply-To: <44DAFE34.50701@codeweavers.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25175>

Hi,

On Thu, 10 Aug 2006, Robert Shearman wrote:

> -               { "repo-config", cmd_repo_config },
> +               { "repo-config", cmd_repo_config, NEEDS_PREFIX },

Doesn't this prevent

$ git-ls-remote kernel

from being run anywhere, when the relevant information is in 
$HOME/.gitconfig?

I'd rather fix git-fetch to cd to the root of the repo, since it really 
does not make sense to expect git-fetch to fetch just one subdirectory.

Ciao,
Dscho
