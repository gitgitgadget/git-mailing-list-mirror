From: bert hubert <ahu@ds9a.nl>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility
Date: Sat, 7 May 2005 12:03:48 +0200
Message-ID: <20050507100348.GA16461@outpost.ds9a.nl>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net> <20050507090543.GG23680@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 07 11:59:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUM56-0007fB-Et
	for gcvg-git@gmane.org; Sat, 07 May 2005 11:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVEGKFS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 06:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVEGKFS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 06:05:18 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:31704 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262940AbVEGKFP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2005 06:05:15 -0400
Received: by outpost.ds9a.nl (Postfix, from userid 1000)
	id BC14540E1; Sat,  7 May 2005 12:03:48 +0200 (CEST)
To: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050507090543.GG23680@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 07, 2005 at 11:05:43AM +0200, Thomas Glanzmann wrote:
> * Junio C Hamano <junkio@cox.net> [050507 10:54]:
> > A quick question.  Which construct in this bashism?
> > Not using backtick but saying $(command)?

You can nest $() which is valuable, unlike backtics.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
