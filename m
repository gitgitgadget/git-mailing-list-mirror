From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Keep rename/rename conflicts of intermediate merges while doing recursive merge
Date: Sat, 31 Mar 2007 14:06:58 +0200
Organization: At home
Message-ID: <eulimv$369$1@sea.gmane.org>
References: <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org> <20070331104947.GA4377@steel.home> <20070331114938.GB4377@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 14:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXcJc-0007Q3-Dr
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 14:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbXCaMD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 08:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbXCaMD4
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 08:03:56 -0400
Received: from main.gmane.org ([80.91.229.2]:52364 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990AbXCaMD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 08:03:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HXcJB-0004Nx-3z
	for git@vger.kernel.org; Sat, 31 Mar 2007 14:03:49 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 14:03:49 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 14:03:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43550>

Alex Riesen wrote:

> The result seem to be at least predictable. Still, doesn't it mean
> that once a rename/rename conflict is in it has to be resolved
> manually forever?

What about git-rerere2 idea (recording resolving of tree-level conflicts,
i.e. rename/rename and such)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
