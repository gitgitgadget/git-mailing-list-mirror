From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: tracking submodules out of main directory.
Date: Thu, 4 Aug 2011 22:05:30 +0200
Message-ID: <20110804200529.GA35398@book.hvoigt.net>
References: <4E370107.3050002@web.de> <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de> <20110803062536.GB33203@book.hvoigt.net> <1312374382.3261.913.camel@Naugrim.eriador.com> <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de> <7vaabqb7vf.fsf@alter.siamese.dyndns.org> <4E39BDFF.3050804@web.de> <1312410562.3261.1030.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 22:05:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp4Ak-0004hq-31
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 22:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab1HDUFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 16:05:33 -0400
Received: from darksea.de ([83.133.111.250]:55745 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753621Ab1HDUFc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 16:05:32 -0400
Received: (qmail 1465 invoked from network); 4 Aug 2011 22:05:30 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 4 Aug 2011 22:05:30 +0200
Content-Disposition: inline
In-Reply-To: <1312410562.3261.1030.camel@Naugrim.eriador.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178766>

Hi,

On Thu, Aug 04, 2011 at 12:29:22AM +0200, henri GEIST wrote:
> Le mercredi 03 ao??t 2011 ?? 23:30 +0200, Jens Lehmann a ??crit :
> > Let me make this clear: this is not about changing how submodules are
> > committed in a superproject. It is not about having a loose collection of
> > projects, they stay tied together in a defined state by the superproject.
> > 
> 
> Yes but for me, from when I started this this topic, it was all about
> having a loose collection of project with dependency references between
> them. And get rid of the superproject.
> It is my first and only goal.

In that case maybe what you want is your own completely independent
implementation of a tool which manages a collection of submodules. I
doubt that tracking of submodules outside of the worktree will ever be
accepted inside core git. Some dependency scheme which makes use of the
current submodule implementation could be a feasible way but you can not
get rid of the superproject.

Your approach introduces many problems which you were not able to
present solutions for. So if you really want to work on this I suggest
you try to implement your solution outside of core git first. If you can
prove that you can solve all the immanent problems we can discuss
integrating it into git again.

> > Henri wanted it a bit upside down: any submodule could request a certain
> > version of another submodule somewhere else in the repo. And he wanted to
> > use gitlinks from one submodule to another for that, which I - hopefully -
> > convinced him was no good idea.
> > 
> 
> You just convince me that submodules are more than I need and to make a
> lighter independent version of submodules which will never been followed
> by git commands.

As described above this is probably the best way for you. Maybe you can
prove that such a tool works but git's submodules implementation can
currently not really assist you with your approach.

Cheers Heiko
