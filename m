From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 0/1] graph API: always print 'M' for merge commits
Date: Sun, 25 May 2008 09:29:27 +0300
Message-ID: <20080525062927.GA3174@mithlond.arda.local>
References: <20080524182530.GB2997@mithlond.arda.local> <1211662321-28846-1-git-send-email-adam@adamsimpkins.net> <7vabifkw9j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 08:30:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K09ko-0001ob-Kh
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 08:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbYEYG3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 02:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYEYG3c
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 02:29:32 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59769 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016AbYEYG3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 02:29:32 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 482C36810077020D; Sun, 25 May 2008 09:29:28 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K09jT-0000qJ-0X; Sun, 25 May 2008 09:29:27 +0300
Content-Disposition: inline
In-Reply-To: <7vabifkw9j.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82853>

Junio C Hamano wrote (2008-05-24 18:28 -0700):

> Adam Simpkins <adam@adamsimpkins.net> writes:
> 
> > Okay.  Here's a simple patch to restore the behavior of always
> > printing 'M' for merge commits, even if less than 2 parents are
> > shown in the graph.
> 
> I have to wonder if that is really necessary.  A merge commit, unless
> you amend it, always starts with "Merge ...", and I think it is enough
> clue of what the particular commit did.  Besides, I think letter "M"
> in the pictorial part of the graph simply looks rather ugly.
> 
> I would even suggest not to use 'M' at all, whether its parents are
> interesting or not.

I don't have strong opinions on this, although I prefer different
symbols for these conceptually different commits - in the current graph
view. But if in the future someone implements an option like
log.unicodegraph=true which displays the graph with nice Unicode chars,
then I think M's wouldn't quite fit there visually anymore.
