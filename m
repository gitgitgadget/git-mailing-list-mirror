From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 14:15:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291413460.4631@eeepc-johanness>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
 <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com> <20080729082135.GB32312@artemis.madism.org> <20080729083755.GC32312@artemis.madism.org> <20080729085125.GJ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNo6U-0003AB-Cx
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbYG2MN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbYG2MN6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:13:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:47325 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755002AbYG2MN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 08:13:57 -0400
Received: (qmail invoked by alias); 29 Jul 2008 12:13:55 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp048) with SMTP; 29 Jul 2008 14:13:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZlPQBfhUZJAPN4r8jP2VmEprDUIAHLyt11YdAiV
	1NOQgC7MDuokJr
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080729085125.GJ32184@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90623>

Hi,

On Tue, 29 Jul 2008, Petr Baudis wrote:

> On Tue, Jul 29, 2008 at 10:37:55AM +0200, Pierre Habouzit wrote:
> 
> > 	path = "$path"
> > 	url = git://somewhere/
> > 	tracks = master
> 
> I do like this (well, I'd just name it "branch" instead of "tracks"). I 
> use submodules very "traditionally" just to bind external projects of 
> certain version to my project, but I have been already thinking about 
> implementing this merely as a hint for others to know what branch should 
> the other developers follow when updating the submodule to a newer 
> version.

As long as you only use it in "submodule status" to say what the relation 
of the current revision is with respect to the "tracks" branch...

But then, how does the relation to the currently _committed_ state get 
displayed?

Ciao,
Dscho
