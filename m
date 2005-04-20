From: Ralph Corderoy <ralph@inputplus.co.uk>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Wed, 20 Apr 2005 18:11:55 +0100
Message-ID: <200504201711.j3KHBtn22691@blake.inputplus.co.uk>
References: <1113951972.29444.42.camel@orca.madrabbit.org>
Cc: Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Wed Apr 20 19:10:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIi5-0002J6-Ue
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVDTROO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVDTROO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:14:14 -0400
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:47624 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261687AbVDTROK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 13:14:10 -0400
Received: from modem-2105.gazelle.dialup.pol.co.uk ([81.78.72.57] helo=blake.inputplus.co.uk)
	by cmailg3.svr.pol.co.uk with esmtp (Exim 4.41)
	id 1DOIlx-0004fa-SC; Wed, 20 Apr 2005 18:13:58 +0100
Received: from blake.inputplus.co.uk (ralph@localhost)
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id j3KHBtn22691;
	Wed, 20 Apr 2005 18:11:55 +0100
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: <1113951972.29444.42.camel@orca.madrabbit.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Hi Ray,

> Give me a case where assuming it's a replace will do the wrong thing,
> for C code, where it's a variable or function name.

How about two patches.

    1.  s/foo/bar/ throughout file because foo() has been decided upon
    as the name of a new globally visible forthcoming function but was
    already in use as a static function.

    2.  Add definition of new foo().

Patch 1 mustn't be a `darcs replace' despite it changing every occurence
of the C token foo into bar.

Cheers,


Ralph.

