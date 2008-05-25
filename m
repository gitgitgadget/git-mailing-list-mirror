From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 0/1] graph API: always print 'M' for merge commits
Date: Sat, 24 May 2008 23:49:51 -0700
Message-ID: <20080525064951.GA16981@adamsimpkins.net>
References: <20080524182530.GB2997@mithlond.arda.local> <1211662321-28846-1-git-send-email-adam@adamsimpkins.net> <7vabifkw9j.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 08:51:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0A4c-0005C5-A3
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 08:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbYEYGty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 02:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbYEYGtx
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 02:49:53 -0400
Received: from smtp152.sat.emailsrvr.com ([66.216.121.152]:49934 "EHLO
	smtp152.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYEYGtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 02:49:53 -0400
Received: from relay5.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id E16A1224EF4;
	Sun, 25 May 2008 02:49:52 -0400 (EDT)
Received: by relay5.relay.sat.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id C074C224AC4;
	Sun, 25 May 2008 02:49:52 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id DF3EC14100C8; Sat, 24 May 2008 23:49:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vabifkw9j.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82855>

On Sat, May 24, 2008 at 06:28:08PM -0700, Junio C Hamano wrote:
> Adam Simpkins <adam@adamsimpkins.net> writes:
> 
> > On Sat, May 24, 2008 at 09:25:30PM +0300, Teemu Likonen wrote:
> >> 
> >> I'd rather show merge commits always with M. They are still conceptually
> >> merges even if the current log view shows only one parent. This patch
> >> changes symbols * and M to be visual symbols, not logical symbols which
> >> I'd prefer.
> >> 
> >> For example user may be interested in finding certain merge but chooses
> >> to limit the output with a commit range. It helps if user can always
> >> trust the symbols * and M to have this conceptual difference.
> >
> > Okay.  Here's a simple patch to restore the behavior of always printing
> > 'M' for merge commits, even if less than 2 parents are shown in the
> > graph.
> 
> I have to wonder if that is really necessary.  A merge commit, unless you
> amend it, always starts with "Merge ...", and I think it is enough clue of
> what the particular commit did.  Besides, I think letter "M" in the
> pictorial part of the graph simply looks rather ugly.
> 
> I would even suggest not to use 'M' at all, whether its parents are
> interesting or not.

Either way is fine with me; it's just a cosmetic issue.
(We could even make it configurable, but that definitely seems like
overkill.)

-- 
Adam Simpkins
adam@adamsimpkins.net
