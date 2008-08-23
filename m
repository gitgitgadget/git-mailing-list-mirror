From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 20:18:27 +0200
Message-ID: <20080823181827.GA15993@atjola.homenet>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org> <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org> <20080823164546.GX23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 20:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWxi4-0004vm-6H
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 20:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYHWSSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbYHWSSc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 14:18:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:54900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751567AbYHWSSb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 14:18:31 -0400
Received: (qmail invoked by alias); 23 Aug 2008 18:18:29 -0000
Received: from i577BB1D4.versanet.de (EHLO atjola.local) [87.123.177.212]
  by mail.gmx.net (mp001) with SMTP; 23 Aug 2008 20:18:29 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/WHtxEmMrWRu4yN7S1vqvGRSLH7WJ6Z3W+rajY8b
	x6AlyKs3zCxEfO
Content-Disposition: inline
In-Reply-To: <20080823164546.GX23334@one.firstfloor.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93470>

On 2008.08.23 18:45:46 +0200, Andi Kleen wrote:
> Then for linux-next it's reasonable to say that one shouldn't=20
> do development on top of it, but still if there is supposed
> to be a tester base for it it requires at least reasonable
> support in git for regular read-only download and right now that
> support is at best obscure and unobvious (to avoid stronger words)

So, how would you make it less obscure and unobvious then the current
method? The current method would be:

git fetch linux-next
git checkout linux-next/whatever

Which seems neither obscure nor unobvious to me...

Bj=F6rn
