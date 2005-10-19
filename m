From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag objects and cg-push/git-push don't play nice)
Date: Thu, 20 Oct 2005 01:52:08 +0200
Message-ID: <20051019235208.GR30889@pasky.or.cz>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com> <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org> <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com> <20051019223743.GQ30889@pasky.or.cz> <46a038f90510191623k4f1a7267m50d3bbbd6665a2a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 01:53:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESNjP-000324-GW
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 01:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbVJSXwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 19:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbVJSXwL
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 19:52:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24793 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751641AbVJSXwK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 19:52:10 -0400
Received: (qmail 16770 invoked by uid 2001); 20 Oct 2005 01:52:08 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510191623k4f1a7267m50d3bbbd6665a2a3@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10325>

Dear diary, on Thu, Oct 20, 2005 at 01:23:11AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> Actually, all the tagsrefs have only one line, but something is going
> weird around tagid=$(cat $tag) as $tag ends up containing many
> filenames. So I undid my initial change to "head -n1", and I'm trying
> to fix the loop.

Hmm, what bash version are you using? It's enclosed in

	for tag in *

and perhaps your bash misunderstood.

Anyway, this should've been quoted. I've fixed that in my tree, will
push out soon.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
