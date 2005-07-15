From: James Cloos <cloos+vger-git@jhcloos.com>
Subject: Re: cg update failing
Date: Fri, 15 Jul 2005 00:12:48 -0400
Message-ID: <m3eka04shr.fsf@lugabout.cloos.reno.nv.us>
References: <m3oe95qn64.fsf@lugabout.cloos.reno.nv.us>
	<1121365461.4729.0.camel@localhost.localdomain>
	<m3k6jtnod8.fsf@lugabout.cloos.reno.nv.us>
	<1121376069.4729.2.camel@localhost.localdomain>
	<m3d5plm50o.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darrin Thompson <darrint@progeny.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 06:13:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtHZp-0001yz-9w
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 06:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbVGOENR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 00:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbVGOENR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 00:13:17 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:35589 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S263199AbVGOENM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2005 00:13:12 -0400
Received: from lugabout.jhcloos.org (host-69-48-15-167.roc.choiceone.net [69.48.15.167])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP
	id AADC61D02F; Thu, 14 Jul 2005 23:13:02 -0500 (CDT)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id B5B251DE0AB; Fri, 15 Jul 2005 04:12:48 +0000 (GMT)
To: git@vger.kernel.org
In-Reply-To: <m3d5plm50o.fsf@lugabout.cloos.reno.nv.us> (James Cloos's message of "Thu, 14 Jul 2005 17:50:15 -0400")
X-Hashcash: 1:21:050715:git@vger.kernel.org::Z/55aNyPjnLMsq0j:0000000000000000000000000000000000000000001EM3
X-Hashcash: 1:21:050715:darrint@progeny.com::PHpDx2LYrfC8eMV4:0000000000000000000000000000000000000000004cMf
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Well, it wasn't as Ok as I first thought.  There were several .rej and
backup files as left behind by patch(1).  cg update HEAD says:  Branch
already fully merged but Makefile still says 2.6.12.

I'm cloning now to a remote uml and will try and rsync from there to
the laptop.  Perhaps *that* will get me a working repo.

[SIGH]

-JimC
