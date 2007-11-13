From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Tue, 13 Nov 2007 20:33:20 +0100
Organization: At home
Message-ID: <fhcu5u$9dp$1@ger.gmane.org>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com> <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com> <Pine.LNX.4.64.0711121613570.4362@racer.site> <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com> <Pine.LNX.4.64.0711121635130.4362@racer.site> <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com> <20071113042017.GB9745@sigill.intra.peff.net> <9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com> <vpq3avah3r0.fsf@bauges.imag.fr> <7vy7d2rmb8.fsf@gitster.siamese.dyndns.org> <9e4733910711131127i15fb1e41g54752bc10bb28239@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 20:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1bp-0007tW-Og
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbXKMTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbXKMTjX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:39:23 -0500
Received: from main.gmane.org ([80.91.229.2]:38916 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbXKMTjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:39:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Is1Z4-00085R-OW
	for git@vger.kernel.org; Tue, 13 Nov 2007 19:36:50 +0000
Received: from abwy6.neoplus.adsl.tpnet.pl ([83.8.248.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 19:36:50 +0000
Received: from jnareb by abwy6.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 19:36:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwy6.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64838>

Jon Smirl wrote:

> Could we add an alternates entry on the server that would cause the
> client to first go fetch all objects the alternate has, then come back
> and fetch from the initial server with a normal fetch? It's like a URL
> redirect. You wouldn't fetch heads or tags from the alternate, just
> all of the objects.

objects/info/git-alternates, similar to objects/info/http-alternates?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
