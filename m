From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] git rev-parse broken on Git for Windows
Date: Fri, 30 Jul 2010 10:26:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1007301022310.2983@bonsai2>
References: <4C526260.6000104@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Joshua Jensen <jjensen@workspacewhiz.com>,
	Giuseppe Scrivano <gscrivano@gnu.org>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 30 10:27:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oekvm-000597-OD
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab0G3I06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 04:26:58 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:40799 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755036Ab0G3I05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 04:26:57 -0400
Received: (qmail invoked by alias); 30 Jul 2010 08:26:55 -0000
Received: from pD9EB20EF.dip0.t-ipconnect.de (EHLO noname) [217.235.32.239]
  by mail.gmx.net (mp051) with SMTP; 30 Jul 2010 10:26:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cqX1SOrrcfX/pRT5x0LpvM5VBgGtW7bu9xXoS0y
	8nFLrtu7dlqmEh
X-X-Sender: gene099@bonsai2
In-Reply-To: <4C526260.6000104@workspacewhiz.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152224>

Hi,

On Thu, 29 Jul 2010, Joshua Jensen wrote:

>  9c7304e3e39ed397b3cc6566573333e2698a52b4 (print the usage string on stdout
> instead of stderr) and then 47e9cd28f8a404a0d6293935252ddca5fc243931
> (parseopt: wrap rev-parse --parseopt usage for eval consumption) break the
> following line from the manual and 'git subtree' on msysGit:
> 
> eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)

Both commits are from Junio's 'next' branch. I Cc:ed the authors of both 
commits.

> Running 'git revert' on both changelists causes the 'git rev-parse 
> --parseopt' to work again.
> 
> What was 9c7304e trying to solve?

Probably it tried to follow some GNU convention or some such. It does not 
say in the commit message, and neither in the code.

Thanks,
Johannes
