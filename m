From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Tue, 13 May 2008 23:46:38 +0200
Message-ID: <20080513214638.GA14930@cuci.nl>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com> <20080512234906.GX29038@spearce.org> <7vod7bw03a.fsf@gitster.siamese.dyndns.org> <20080513000925.GA29038@spearce.org> <48292243.3050307@gnu.org> <20080513092237.GA4413@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Tweed <david.tweed@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue May 13 23:47:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw2LT-0003wl-9M
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 23:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759575AbYEMVqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 17:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758611AbYEMVqk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 17:46:40 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43697 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759569AbYEMVqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 17:46:39 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 2513D5461; Tue, 13 May 2008 23:46:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080513092237.GA4413@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82046>

Teemu Likonen wrote:
>This way the "daily" gc would operate very fast (as it leaves .keep
>packs alone), and with gc --aggressive user could easily decide when to
>create new landmark .keep packs (and also prune possible dangling
>objects inside previous .keep packs). Normal user don't need to know the
>details. Just run gc occasionally and maybe gc --aggressive when better
>optimization is needed.

>How does this sound?

It sounds sound :-).
I like the simplicity.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
