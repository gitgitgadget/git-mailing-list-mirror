From: Petr Baudis <pasky@suse.cz>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 14:11:24 +0200
Message-ID: <20080716121124.GM32184@machine.or.cz>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com> <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com> <487DD1C7.3070701@viscovery.net> <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com> <487DDCFC.9020007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nigel Magnay <nigel.magnay@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 14:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ5rv-00012X-93
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 14:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbYGPML2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 08:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbYGPML2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 08:11:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47070 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbYGPML2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 08:11:28 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D99161E4C025; Wed, 16 Jul 2008 14:11:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <487DDCFC.9020007@viscovery.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88673>

On Wed, Jul 16, 2008 at 01:35:24PM +0200, Johannes Sixt wrote:
> Ah, is this your actual scenario? Just to make sure we are talking about
> the same thing:
> 
> - You own superproject P.
> - $Maintainer owns submodule S.
> - You use S in P.
> - You make changes to S that you would like $Maintainer to include in the
> next release.
> x You use in P your changes to S while $Maintainer has not yet released a
> new version of S with your changes.
> - Finally your changes arrive via the new release of S.
> 
> That *is* the intended use-case for submodules. But you have to play the
> game by the rules:
> 
> - $Maintainer defines the official states of S.
> 
> - You must never commit an unofficial state of S in P.

I think the issue here is that $Maintainer = him (or Maintainers(P) =
Maintainers(S), in general); the workflow you described still works, but
is overly complicated and that is the original complaint.

				Petr "Pasky" Baudis
