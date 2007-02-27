From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 15:04:56 +0100
Organization: At home
Message-ID: <es1dm2$kt6$2@sea.gmane.org>
References: <20070226121557.GA18114@coredump.intra.peff.net> <7virdnhpbt.fsf@assigned-by-dhcp.cox.net> <20070227105212.GA21757@coredump.intra.peff.net> <200702271131.57856.andyparkins@gmail.com> <20070227113938.GA5423@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 15:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM2vC-0005Xw-Cc
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 15:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbXB0ODK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 09:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbXB0ODK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 09:03:10 -0500
Received: from main.gmane.org ([80.91.229.2]:42280 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbXB0ODH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 09:03:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HM2ut-0003GV-TZ
	for git@vger.kernel.org; Tue, 27 Feb 2007 15:02:55 +0100
Received: from host-89-229-2-22.torun.mm.pl ([89.229.2.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 15:02:55 +0100
Received: from jnareb by host-89-229-2-22.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 15:02:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-2-22.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40735>

Jeff King wrote:

> On Tue, Feb 27, 2007 at 11:31:52AM +0000, Andy Parkins wrote:
> 
>>> there are dozens of repositories; I would now like to group them in the
>>> same repo for ease of clone/fetch.
>> 
>> It doesn't have fetch or clone support, but perhaps my poorman's submodule 
>> code will help you a bit, until real submodule support appears in git.
> 
> Thanks for the pointer, but it doesn't handle one of my pet peeves with
> many repositories: fetching 25 repositories takes a long time. I have a
> "look at every repository and see if anything needs fetched or pushed"
> script; it takes about 0.5-1.0 seconds per repository. Turning 25
> fetches into 1 makes it a lot nicer to use.
> 
> So of all the problems hoped to be solved by submodule support, I think
> your poor man's submodule support solves the ones I don't care about
> (tracking external repositories with merge resolution) but not the one I
> do (fetch/clone effort). :)

See http://git.or.cz/gitwiki/SubprojectSupport which mentions prototype
submodules/subprojects implementation by Martin Waitz, with having link
to submodule commit in the tree (so tree have links to trees, to blobs,
and to submodules/commits).

BTW. Andy, could you add note about your lightweight submodule support
to this page? TIA.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
