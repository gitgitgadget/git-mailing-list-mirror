From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Allow cherry-picking root commits
Date: Sun, 6 Jul 2008 13:35:48 +0200
Message-ID: <20080706113548.GC6731@leksak.fem-net>
References: <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net> <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness> <20080704015326.GI6677@leksak.fem-net> <alpine.DEB.1.00.0807041617320.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 13:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFSXy-0003KI-BT
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 13:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbYGFLfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 07:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYGFLfx
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 07:35:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:54379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752630AbYGFLfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 07:35:52 -0400
Received: (qmail invoked by alias); 06 Jul 2008 11:35:50 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp023) with SMTP; 06 Jul 2008 13:35:50 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19F45IAbWVFnw6caRo7X9lplkYj7wILqNywie384Z
	dwn03SkVona52I
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KFSWy-0006kX-Sv; Sun, 06 Jul 2008 13:35:48 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807041617320.9925@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87520>

On Fri, Jul 04, Johannes Schindelin wrote:
> +	if (!commit->parents) {
> +		if (action == REVERT)
> +			die ("Cannot revert a root commit");

I btw wondered why _reverting_ a root commit should not work.
Then I tried to quickly add this feature and saw what's the point:
merge-recursive wants a remote -- this
> +	argv[i++] = next_sha1;
to be set :)
So the change is not as trivial as I thought.
And yes, there may even be no use case for reverting root commits.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
