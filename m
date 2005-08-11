From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Wed, 10 Aug 2005 23:01:26 -0600
Message-ID: <E1E35C2-0004kt-VH@highlab.com>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com>
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 07:01:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E35AX-00043U-Hy
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 06:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVHKE71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 00:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVHKE71
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 00:59:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:28917 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932268AbVHKE7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 00:59:25 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20050811045924015004mb6te>; Thu, 11 Aug 2005 04:59:24 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1E35C2-0004kt-VH; Wed, 10 Aug 2005 23:01:26 -0600
To: Martin Langhoff <martin.langhoff@gmail.com>
In-reply-to: <46a038f90508102144358a4bcf@mail.gmail.com> 
Comments: In-reply-to Martin Langhoff <martin.langhoff@gmail.com>
   message dated "Thu, 11 Aug 2005 16:44:57 +1200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 8/11/05, Sebastian Kuzminsky <seb@highlab.com> wrote:
> > I agree completely - it's super bogus to rename the two central programs.
> > It makes Debian essentially incompatible with the rest of the world.
> 
> Well, I doubt this problem lies with Debian. GNU Interactive Tools is
> packaged for most (all?) distributions, and has been there for ages. A
> quick google search shows a page tracking a few of its distributed
> versions: http://linux.maruhn.com/sec/git.html
> 
> So it is fair to assume all distros are going to rename it, and wreak
> havoc with the calls to the binaries from cogito, qgit, etc. Perhaps
> it'd be better to rename the binaries within the git project. Better
> Junio at it than a bunch of package maintainers... It'll also nullify
> the risk of different packagers choosing different renaming
> strategies.

Yes, this would be best.  Linus was resistant to this idea, but maybe
Junio will be sympathetic?

I'll once again suggest "lit", for "Linu{x,s} Information Tracker",
meaning "filled with light", "on fire", and "drunk".


While we're at it, renaming cogito's "cg" to "cog" would fix another
filename conflict in Debian, and would give the right hand something to
do while the left hand seeks from c to g.  ;-)


-- 
Sebastian Kuzminsky
