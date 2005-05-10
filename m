From: Andreas Gal <gal@uci.edu>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 15:54:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505101552500.29765@sam.ics.uci.edu>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
 <1115739511.16187.432.camel@hades.cambridge.redhat.com>
 <17115.200.158.14.67.1115740220.squirrel@www.tendencies.com.br>
 <1115740844.16187.445.camel@hades.cambridge.redhat.com>
 <26021.200.158.14.67.1115741989.squirrel@www.tendencies.com.br>
 <20050510234501.79eea7a4.diegocg@gmail.com> <20050510224433.GC26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Diego Calleja <diegocg@gmail.com>, eduardo@tendencies.com.br,
	dwmw2@infradead.org, jon@blackcubes.dyndns.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 00:49:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdWp-0000mE-BM
	for gcvg-git@gmane.org; Wed, 11 May 2005 00:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVEJWzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEJWzw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 18:55:52 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:28323 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261808AbVEJWzp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 18:55:45 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j4AMsw48029815;
	Tue, 10 May 2005 15:54:58 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j4AMswER029811;
	Tue, 10 May 2005 15:54:58 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050510224433.GC26384@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Btw, I rewrote about 90% of git in python, just out of curiousity. 
Performance is pretty competitive, and I can optimize certain operations 
by keeping the index in memory temporarily. It also saves a lot of output 
parsing, simplifies error-handling (if the frontend is written in python 
too, which bit now is), and the best of all: its about 600 lines of python 
code. I am all for a Java implementation. After its done we will see 
whether it works and how well it works. We can still throw it away if it 
sucks. 

Andreas

On Wed, 11 May 2005, Petr Baudis wrote:

> Dear diary, on Tue, May 10, 2005 at 11:45:01PM CEST, I got a letter
> where Diego Calleja <diegocg@gmail.com> told me that...
> > Someone who is going to hack the kernel can very well install more things.
> > And anyway, git is "the linux SCM tool" so all distros will package it. Also,
> > people who hacks the linux kernel usually runs it, so "git is not ported
> > to win32" is not a big problem.
> 
> It's not like everything git is ever going to be used for is kernel and
> only the kernel.
> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
