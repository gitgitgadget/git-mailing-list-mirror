From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 15:04:48 -0700
Message-ID: <20080406220447.GB5822@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062204580.12583@eeepc-johanness>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiczZ-000332-Dm
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbYDFWEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755256AbYDFWEw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 18:04:52 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:52138 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbYDFWEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 18:04:52 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 0E10272D4E0;
	Sun,  6 Apr 2008 18:04:50 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id DA67172D340;
	Sun,  6 Apr 2008 18:04:49 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id B136714100BB; Sun,  6 Apr 2008 15:04:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804062204580.12583@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78935>

On Sun, Apr 06, 2008 at 10:06:24PM +0100, Johannes Schindelin wrote:
> 
> On Sun, 6 Apr 2008, Adam Simpkins wrote:
> 
> > +/* Defined in commit.h */
> > +struct commit;
> > +/* Defined in strbuf.h */
> > +struct strbuf;
> 
> You do not need those.

I added them so that graph.h can be included without including any
other header files first.  They can be taken out if we assume that all
users of graph.h will include commit.h and strbuf.h first.

> Apart from that, it looks very, very clean to me.  (Except maybe the 
> prefix ++ that could have been a postfix ++ in the line before, but that 
> is just me.)

Sorry, force of habit.  I tried to remember to use postfix in most
places, but I guess I forgot in that place.

I do most of my programming in C++, which allows crazy things like
defining prefix and postfix ++ and -- operators on classes.  When
using these on classes, the prefix operator is normally more efficient
than the postfix version, so I'm just in the habit of using prefix
increment everywhere.  This can easily be changed if postfix is
preferred for the git coding style.

-- 
Adam Simpkins
adam@adamsimpkins.net
