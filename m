From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 16:39:53 -0700
Message-ID: <20080819233953.GI24212@spearce.org>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com> <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com> <20080819185804.GA17943@coredump.intra.peff.net> <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com> <7v63pw3ick.fsf@gitster.siamese.dyndns.org> <d411cc4a0808191258i9037a84k267c09795dffb3b8@mail.gmail.com> <7vy72swpbt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:41:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVaor-0008RL-BQ
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 01:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYHSXjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 19:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYHSXjy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 19:39:54 -0400
Received: from george.spearce.org ([209.20.77.23]:34020 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYHSXjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 19:39:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1C5AE38375; Tue, 19 Aug 2008 23:39:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vy72swpbt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92937>

Junio C Hamano <gitster@pobox.com> wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
> 
> > I would be happy to add the name of the branch being updated and the remote
> > we're trying to push to.  Is there interest then, in the patch?
> 
> [...] so you are in a better position to come up with various use cases
> and the set of parameters the hook would need to do its validation job.

And please be careful with the term "parameters" here.

We not too long ago changed receive-pack to use stdin into a hook
so we don't have to worry about command line length limitations.
Once we start talking about something like push or fetch which can
operate on a huge batch of refs at one shot we really should avoid
the command line limits if we can.

-- 
Shawn.
