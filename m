From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Wed, 14 May 2008 08:42:45 +0300
Message-ID: <20080514054245.GA3147@mithlond.arda.local>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com> <20080512234906.GX29038@spearce.org> <7vod7bw03a.fsf@gitster.siamese.dyndns.org> <20080513000925.GA29038@spearce.org> <48292243.3050307@gnu.org> <20080513092237.GA4413@mithlond.arda.local> <20080513214638.GA14930@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Tweed <david.tweed@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu May 15 15:41:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwdeu-0001Ll-7Z
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 15:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbYEONhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 09:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbYEONhV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 09:37:21 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:40419 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750902AbYEONhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 09:37:20 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 482329DB00451619; Wed, 14 May 2008 08:42:53 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jw9lF-0000yH-M1; Wed, 14 May 2008 08:42:45 +0300
Content-Disposition: inline
In-Reply-To: <20080513214638.GA14930@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82205>

Stephen R. van den Berg wrote (2008-05-14 00:46 +0300):

> Teemu Likonen wrote:
> >This way the "daily" gc would operate very fast (as it leaves .keep
> >packs alone), and with gc --aggressive user could easily decide when to
> >create new landmark .keep packs (and also prune possible dangling
> >objects inside previous .keep packs). Normal user don't need to know the
> >details. Just run gc occasionally and maybe gc --aggressive when better
> >optimization is needed.
> 
> >How does this sound?
> 
> It sounds sound :-).
> I like the simplicity.

It turned out that gc --aggressive is not what I thought it was, i.e.
"pack aggressively and efficiently". So my suggestion implies the
semantics that --aggressive would do effective compressing.
