From: Marcin Kasperski <Marcin.Kasperski@softax.pl>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 14:15:45 +0200
Organization: Softax
Message-ID: <1176984945.30690.30.camel@cauchy.softax.local>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417104520.GB4946@moonlight.home>
	 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	 <200704171818.28256.andyparkins@gmail.com>
	 <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	 <Pine.LNX.4.64.0704181130150.12094@racer.site>
	 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeVYH-0003S5-Ql
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993216AbXDSMPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993218AbXDSMPu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:15:50 -0400
Received: from bozon2.softax.com.pl ([83.238.10.48]:43843 "EHLO
	bozon2.softax.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993216AbXDSMPt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:15:49 -0400
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Apr 2007 08:15:49 EDT
Received: from bozon2.softax.pl (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 3BA72DC00B;
	Thu, 19 Apr 2007 14:15:48 +0200 (CEST)
Received: from 127.0.0.1 (127.0.0.1)
 by bozon2.softax.pl (F-Secure/fsigk_smtp/488/bozon2.softax.pl);
 Thu, 19 Apr 2007 14:15:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/488/bozon2.softax.pl)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 2FC58DC00A;
	Thu, 19 Apr 2007 14:15:48 +0200 (CEST)
Received: from bozon2.softax.com.pl ([127.0.0.1])
 by localhost (bozon2.softax.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04735-01; Thu, 19 Apr 2007 14:15:46 +0200 (CEST)
Received: from cauchy.softax.local (unknown [16.193.144.107])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 33E59DC007;
	Thu, 19 Apr 2007 14:15:46 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
X-Mailer: Evolution 2.6.3 
X-Virus-Scanned: amavisd-new at softax.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45004>


> Actually, at this stage, I really think cogito just *complicates* git 
> usage. 

Agreed.

> So I don't think it's even true that new people should be pointed at cg 
> any more.

Google points to git.or.cz ;-)

> But compare setting up a git repository with setting up a CVS repository.
> With git, it's literally "git init", and you're done. No need to worry 
> about CVSROOT issues etc. Everything is self-contained. CVS is *hard* to 
> get into, by comparison.

I am in no way advocating CVS, but to be fair in such comparison, one
should mention also effort of *publishing* git repository and making it
available to remote clients. Initialized and configured CVS (or
subversion, or perforce, or ...) repo is something ready to be used by
remote clients.

Getting correct ssh keys in correct places is - for instance -
noticeable problem for many people. Especially if they use clients
(like plink) which natively use alternative key save format. Etc...

> So people coming from CVS/SVN have a double shock: they are supposed to 
> learn things that they "know" are hard (because CVS/SVN made them so damn 
> hard - don't tell me that SVN branching is easy, because it is *not* easy. 

The way SVN implemented branching (and tagging!) simply killed the idea
of using this tool seriously. IMO. Let's leave it.

I agree that git introduces plenty of excellent concepts. What it needs
is better docs (also, clearly known **SINGLE** master doc, just sth like
subversion book), cleaned command line interface (I feel that there are
just too many lowlevel commands visible for beginning user, maybe at
least one could split them into git-* for mere mortals and gitadm-* for
repository hackers), portability, and finally GUI.

				Best regards
