From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Another way to provide help details. (was Re: [PATCH] Add help details to git help command.)
Date: Tue, 19 Apr 2005 19:32:38 +0200
Message-ID: <20050419173238.GJ12757@pasky.ji.cz>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <4263E782.6040608@mesatop.com> <200504181940.54453.elenstev@mesatop.com> <20050419015124.GW5554@pasky.ji.cz> <4265189E.6090801@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Cole <elenstev@mesatop.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:29:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwWW-0004yf-Qp
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDSRcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVDSRcl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:32:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58562 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261353AbVDSRcj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:32:39 -0400
Received: (qmail 2740 invoked by uid 2001); 19 Apr 2005 17:32:38 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4265189E.6090801@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 04:41:34PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> If Petr wants the top comment to be extracted by help then maybe a 
> bottom comment block could contain the more complete text?
> I *really* think that the user docs should live in the source for now 
> (hence I think that git man is better than going straight to man/docbook).

I'd stay with the top comment for now, and go for perldoc in the Perl
scripts. It's cool, nice, and you can export it to anything and it still
looks mostly cute.

> I wasn't sure whether to perlise the code or do a shell-lib - but 
> looking at the algorithms needed in things like git status I reckon the 
> shell will end up becoming a hackish mess of awk/sed/tr/sort/uniq/pipe 
> (ie perl) anyway.

I'm all for slow migration from sh to Perl so that we can add more cream
on the stuff. Shell was great for the first phase of rapid development
(where basically the most important thing was to be able to call the
core git easily, and just wrap it around) but now if you want to do the
fancier stuff (like git status, or even git log), it's getting more of a
nuisance.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
