From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: You don't exist, Go away! although user.name has been set
Date: Thu, 18 Sep 2008 13:47:35 +0200
Message-ID: <20080918114735.GA14176@gmx.de>
References: <20080916010529.GB22597@gmx.de> <48CF6277.4060807@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 13:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgI08-0005kD-3p
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 13:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYIRLrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 07:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbYIRLrj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 07:47:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:60523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752513AbYIRLrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 07:47:39 -0400
Received: (qmail invoked by alias); 18 Sep 2008 11:47:35 -0000
Received: from pD9E084EC.dip.t-dialin.net (EHLO nixos) [217.224.132.236]
  by mail.gmx.net (mp041) with SMTP; 18 Sep 2008 13:47:35 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+INiIE4i6INhhfUoDGOpPaca2hiUBQ4s9aJ0P9rZ
	Bw91hHzSE0at/y
Received: by nixos (sSMTP sendmail emulation); Thu, 18 Sep 2008 13:47:35 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <48CF6277.4060807@op5.se>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96194>

>  I can assure you that people are capable of fetching, pulling and
>  committing with git. I do it all day long at least.
> 
>  Can you post your ~/.gitconfig (and/or .git/config) file, please?
>  In conjunction, I also need to know the exact username you're using
>  on your system.

Hmm I think it only occurs if you git clone the repo before adding the
identity to your global config.

If you clone the repository after having added your identity everything
is fine..

/ksa > git fetch origin
fatal: You don't exist. Go away!

~/.gitconfig:
[user]
        name = sadflkj-sa
        email = info@dflkje.de

The repo config is unchanged  after cloning.
The HEAD pointer is invalid. But this shouldn't matter

Sincerly
Marc Weber
