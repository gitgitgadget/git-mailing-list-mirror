From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Wed, 05 Jul 2006 01:14:01 +0200
Organization: At home
Message-ID: <e8esnn$mb5$1@sea.gmane.org>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de> <44AAF49F.6090008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jul 05 01:14:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxu6H-0007Nh-A0
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 01:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWGDXOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 19:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWGDXOR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 19:14:17 -0400
Received: from main.gmane.org ([80.91.229.2]:29388 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932322AbWGDXOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 19:14:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fxu5s-0007Jp-JS
	for git@vger.kernel.org; Wed, 05 Jul 2006 01:14:12 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 01:14:12 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 01:14:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23329>

A Large Angry SCM wrote:

> It works[*] and it does what using the timestamp was trying to do. 
> Namely, work from "more recent" (or "closer") commits toward "older" (or 
> "farther") commits until you've gone past the point you care about.
> 
> It's a little late to be changing the structure of a commit and you'd 
> have to deal with some size/scale issues, but it's do-able. A better 
> idea may be to generate and keep the generation number on a per 
> repository basis, and you'd be able to work around changing grafts.

What about timestamp = MAX(now(), timestamps of parents) idea, which
doesn't need changing the structure of a commit?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
