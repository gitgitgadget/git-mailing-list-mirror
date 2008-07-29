From: Petr Baudis <pasky@suse.cz>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 10:51:26 +0200
Message-ID: <20080729085125.GJ32184@machine.or.cz>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com> <20080729082135.GB32312@artemis.madism.org> <20080729083755.GC32312@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkwW-0003J3-8B
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbYG2Iv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYG2Iv2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:51:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60419 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbYG2Iv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:51:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 12C46393B928; Tue, 29 Jul 2008 10:51:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080729083755.GC32312@artemis.madism.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90605>

On Tue, Jul 29, 2008 at 10:37:55AM +0200, Pierre Habouzit wrote:
> So okay, let's scratch this "automatic reference" thing, I see its
> limits now, so what about having a .gitmodule entry look like:
> 
>     [submodule "$path"]

This is not a "$path" but arbitrary string. Please keep that in mind.

> 	path = "$path"
> 	url = git://somewhere/
> 	tracks = master

I do like this (well, I'd just name it "branch" instead of "tracks").
I use submodules very "traditionally" just to bind external projects of
certain version to my project, but I have been already thinking about
implementing this merely as a hint for others to know what branch should
the other developers follow when updating the submodule to a newer
version.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
