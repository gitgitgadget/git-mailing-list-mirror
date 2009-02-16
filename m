From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 10:17:01 +0000 (UTC)
Message-ID: <loom.20090216T101457-231@post.gmane.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm> <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 11:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0Yg-0007KR-FF
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbZBPKRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZBPKRK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:17:10 -0500
Received: from main.gmane.org ([80.91.229.2]:37512 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbZBPKRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:17:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LZ0XE-0006cC-T5
	for git@vger.kernel.org; Mon, 16 Feb 2009 10:17:09 +0000
Received: from host172-56-dynamic.10-87-r.retail.telecomitalia.it ([87.10.56.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:17:08 +0000
Received: from sergio.callegari by host172-56-dynamic.10-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:17:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.10.56.172 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.6) Gecko/2009020911 Ubuntu/8.10 (intrepid) Firefox/3.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110160>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Daniel Barkalow <barkalow <at> iabervon.org> writes:
> 
> > In fact, if you expect to be pushing to a non-bare repository, you
> > probably want to have HEAD contain the actual commit currently checked
> > out (instead of a reference to externally mutable storage), which you
> > can do with "git checkout refs/heads/master".
> 
> "git checkout master^0" is shorter 
> 
> For people who do not follow the git list regularly, a "HEAD contain the
> actual commit" is often called "detached".
> 


Could you have that done automatically?
Namely rather to denying push to a branch b where HEAD->b, when you get such
push you detach head?
