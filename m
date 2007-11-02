From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Introduce --dirty option to git-rebase, allowing you to start from a dirty state.
Date: Fri, 2 Nov 2007 01:08:30 -0400
Message-ID: <20071102050830.GA14735@spearce.org>
References: <1193952624-608-1-git-send-email-Simon.Sasburg@gmail.com> <1193952624-608-2-git-send-email-Simon.Sasburg@gmail.com> <7vmytx8upi.fsf@gitster.siamese.dyndns.org> <7vir4l8ug4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Sasburg <simon.sasburg@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 06:08:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inom3-0003Ux-7M
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 06:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbXKBFIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 01:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbXKBFIi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 01:08:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39842 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbXKBFIh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 01:08:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Inolj-0005E9-TA; Fri, 02 Nov 2007 01:08:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 760BF20FBAE; Fri,  2 Nov 2007 01:08:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vir4l8ug4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63062>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Doesn't this have the exact same problem with the one in 'next'
> > that uses "git-stash create", which Shawn said he was upset
> > about, and I said I will revert?
> 
> Sorry, --dirty is not the default, which changes everything.
> Forget what I said, sorry for the noise.

I'm happy with having --dirty, but AS AN OPTION.  Heck, I'd probably
use it sometimes, but only if it also reapplies the stash after
the rebase is complete.  But doing that stash/apply automatically
is really freaking annoying.

For the same reasons why I like git-checkout not defaulting to -m.
I want Git to stop by default if I'm about to possibly go into a
command that is going to cause conflicts, as I may not be ready to
deal with them right now.

-- 
Shawn.
