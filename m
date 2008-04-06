From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 3/4] git log and git rev-list: Add --graph option
Date: Sun, 6 Apr 2008 15:51:32 -0700
Message-ID: <20080406225131.GD5822@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <1207507332-1866-2-git-send-email-adam@adamsimpkins.net> <1207507332-1866-3-git-send-email-adam@adamsimpkins.net> <200804070015.32783.tlikonen@iki.fi>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jidij-00069f-Gp
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 00:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbYDFWve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 18:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbYDFWve
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 18:51:34 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:56238 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbYDFWve (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 18:51:34 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 8968072D308;
	Sun,  6 Apr 2008 18:51:33 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 6688572BBF9;
	Sun,  6 Apr 2008 18:51:33 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 7B9AB14100BB; Sun,  6 Apr 2008 15:51:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804070015.32783.tlikonen@iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78939>

On Mon, Apr 07, 2008 at 12:15:32AM +0300, Teemu Likonen wrote:
> Adam Simpkins kirjoitti:
> 
> > The --graph option causes a text-based representation of the history
> > graph to be printed on the left-hand side of the output.
> 
> The '--graph' seems to work nicely with every '--pretty=' option 
> except 'email'.
> 
> $ git log --graph --pretty=email

Yep, I forgot to test that one.  Thanks for pointing it out.
It looks like it shouldn't be too hard to fix.  I'll try to fix it and
submit a patch later this evening.

-- 
Adam Simpkins
adam@adamsimpkins.net
