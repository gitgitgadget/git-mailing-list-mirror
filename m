From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: post-receive-email: about diff
Date: Fri, 22 Feb 2008 23:37:49 -0300
Message-ID: <20080223023749.GA5107@c3sl.ufpr.br>
References: <20080222191402.5f546aed@wizard.volgograd.ru> <20080223004308.GX31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Denis Shaposhnikov <dsh@wizard.volgograd.ru>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 03:38:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSkHt-0004nS-MT
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 03:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYBWCiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 21:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbYBWCiQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 21:38:16 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:56916 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbYBWCiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 21:38:16 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 92DFC700003DD;
	Fri, 22 Feb 2008 23:38:12 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <20080223004308.GX31441@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74788>

On Fri, Feb 22, 2008 at 07:14:02PM +0300, Denis Shaposhnikov <dsh@wizard.volgograd.ru> wrote:
> Does somebody has modifications for contrib/hooks/post-receive-email to
> send a diff together with a log message in a email?

Indeed I have =)
Check here[1] if might help you

This is the modified version I am using to send logs. It does not send diff
like patchs, all commits in one mail. 
And modified it to use last committer Name and email as From: , as I use
ssh_acl[2] to control repository acl instead of managing users and groups

Hope helped a little bit,

Ribas

[1]www.inf.ufpr.br/ribas/misc/post-receive-email
[2]http://www.inf.ufpr.br/ribas/ssh_acl.html
-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
