From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 15:47:25 -0700
Message-ID: <20080406224724.GC5822@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062135290.12583@eeepc-johanness>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jidel-0004vc-SE
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 00:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbYDFWr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYDFWr2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 18:47:28 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:55736 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYDFWr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 18:47:27 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 71FD072FFFB;
	Sun,  6 Apr 2008 18:47:26 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 4EBA172D303;
	Sun,  6 Apr 2008 18:47:26 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 45A5314100BB; Sun,  6 Apr 2008 15:47:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804062135290.12583@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78938>

On Sun, Apr 06, 2008 at 09:42:20PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 6 Apr 2008, Adam Simpkins wrote:
> 
> > I do like the fact that git-forest prints the names of the refs that 
> > point to each commit.  For the graphing API, we could perhaps add a "%r" 
> > specifier to --pretty=format to print the refs pointing to the commit.
> 
> Would "--decorate" help?

Yes, it does.  Unfortunately, it doesn't have any effect with
--pretty=format.


Actually, going back and testing this, it looks like I have a bug when
handling --graph together with --pretty=format.  There's a missing
newline after the user's format message and the next graph line.  I'll
try to fix this and submit a patch later this evening.

-- 
Adam Simpkins
adam@adamsimpkins.net
