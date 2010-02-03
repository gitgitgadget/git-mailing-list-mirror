From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: Re: [gitolite] repo config for delegated projects
Date: Thu, 4 Feb 2010 00:47:34 +0200
Message-ID: <20100203224734.GI4808@reaktor.fi>
References: <20100203035718.GA30644@lapse.rw.madduck.net> <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com> <20100203202249.GA27125@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:55:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nco8S-0007GG-1v
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772Ab0BCWzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 17:55:42 -0500
Received: from mx.reaktor.fi ([82.203.205.80]:35501 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756956Ab0BCWzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 17:55:39 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 17:55:39 EST
Received: by mx.reaktor.fi (Postfix, from userid 1008)
	id 5B5F12460A; Thu,  4 Feb 2010 00:47:34 +0200 (EET)
Mail-Followup-To: Teemu Matilainen <teemu.matilainen@iki.fi>,
	git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
Content-Disposition: inline
In-Reply-To: <20100203202249.GA27125@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138914>

On Thu, 04 Feb 2010, martin f krafft wrote:

> src/gl-compile-conf:261 prohibits delegated repositories to make use
> of the functionality to configure config variables of the
> repositories:
> 
>   die "$WARN $fragment attempting to set repo configuration\n"
>     if $fragment ne 'master';
> 
> This is a bit unfortunate and makes me reconsider the use of
> delegations.
> 
> What is the reason for this restriction?

Well, the main reason probably is that I don't personally use delegation
and got tired of even thinking about the security concerns. =)

> Are there settings that are potentially compromising?

I think it depends on the setup and especially hooks.
Can't come up with any real problem, though.

> Would it be worth to consider making it configurable (e.g.
> ~/.gitolite.rc) whether to allow delegated repos to set config
> variables?

That's Sitaram's call. :)


-- 
	- Teemu
