From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow config file to specify Signed-off-by identity in
 format-patch.
Date: Sat, 5 Aug 2006 00:56:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608050055090.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <000001c6b809$2919a200$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 00:57:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98bE-0001Vf-Cg
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWHDW44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWHDW44
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:56:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:2029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422633AbWHDW4z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 18:56:55 -0400
Received: (qmail invoked by alias); 04 Aug 2006 22:56:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 05 Aug 2006 00:56:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
In-Reply-To: <000001c6b809$2919a200$c47eedc1@ramsay1.demon.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24862>



On Fri, 4 Aug 2006, Ramsay Jones wrote:

> Unlike git-commit, git-format-patch was not picking up and using the
> user.email config variable for the email part of the committer info.
> I was forced to use the GIT_COMMITTER_EMAIL environment variable to
> override the default <user@localhost.localdomain>. The fix was to
> simply move the call to setup_ident() to come before the git_config()
> call.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I _always_ use environment variables, since the $HOME/.gitconfig is a 
pretty recent addition. Therefore, I completely missed that one.

Ciao,
Dscho
