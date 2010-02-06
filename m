From: Teemu Matilainen <teemu.matilainen@iki.fi>
Subject: Re: [gitolite] repo config for delegated projects
Date: Sat, 6 Feb 2010 20:21:33 +0200
Message-ID: <20100206182133.GL2530@reaktor.fi>
References: <20100203035718.GA30644@lapse.rw.madduck.net> <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com> <20100203202249.GA27125@lapse.rw.madduck.net> <20100204011842.GB497@atcmail.atc.tcs.com> <20100204040812.GC13411@lapse.rw.madduck.net> <2e24e5b91002051650k3c7cf14ev8752d36b5616e9a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 19:21:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdpHr-0008JF-1k
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 19:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab0BFSVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 13:21:38 -0500
Received: from mx.reaktor.fi ([82.203.205.80]:50191 "EHLO mx.reaktor.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617Ab0BFSVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 13:21:37 -0500
Received: by mx.reaktor.fi (Postfix, from userid 1008)
	id F274F25500; Sat,  6 Feb 2010 20:21:33 +0200 (EET)
Mail-Followup-To: Teemu Matilainen <teemu.matilainen@iki.fi>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2e24e5b91002051650k3c7cf14ev8752d36b5616e9a4@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139181>

On Sat, 06 Feb 2010, Sitaram Chamarty wrote:

> Now I just looked up hooks.showrev, and it's supposed to be any shell
> command.  Clearly this means anyone who can set that gitconfig option
> now has shell capability, and it's game over.

But of course you need to have a hook that runs the command.  And
setting hooks requires shell access.

Sorry for not thinking any problems with the config thing.  I personally
don't use the delegation and on the other hand all our gitolite
administrators anyway have shell access to the server...

> Regardless of how I look at it, I can't think of a cure for this short
> of either:
>   - putting all the allowed gitconfigs in the RC file, and not in the
> config (writing the RC file requires shell access, and we presume the
> "root of trust" person has enough smarts to know what to allow and
> what not to allow), and allowing repo admins to *refer* to them to use
> whichever they want

This sounds better solution for me.

>   - someone coming up with a list of gitconfig's that are "safe", and
> specific values for those that are unsafe (like saying "if you use
> showrev, you can only use this command  as the value", and forcing
> only those.

Might get too complicated.  Anyway the person setting the hook script
should know what it does and which configuration keys it uses and how.


-- 
	- Teemu
