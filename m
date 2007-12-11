From: Jeff King <peff@peff.net>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 07:25:39 -0500
Message-ID: <20071211122539.GA13945@sigill.intra.peff.net>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J24BY-0000jA-L7
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbXLKMZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXLKMZn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:25:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2198 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbXLKMZn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:25:43 -0500
Received: (qmail 13615 invoked by uid 111); 11 Dec 2007 12:25:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 11 Dec 2007 07:25:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 07:25:39 -0500
Content-Disposition: inline
In-Reply-To: <20071211115914.GJ30948@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67844>

On Tue, Dec 11, 2007 at 12:59:14PM +0100, Pierre Habouzit wrote:

> > Not exactly, as it does not give us email address.
> 
>   maybe it should be "fixed" so that it does, not to mention that other
> concerns ingo raised look legit to me.

Perhaps Junio is a time-traveller.

$ git show 4602c17d
commit 4602c17d8911e14d537f6f87db02faab6e3f5d69
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Dec 7 17:19:31 2007 -0800

    git-shortlog -e: show e-mail address as well

    This option shows the author's email address next to the name.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
