From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Mon, 28 Apr 2008 11:33:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281132420.5399@eeepc-johanness>
References: <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org>
 <4814E097.7030407@gnu.org> <20080428012613.GB15121@sigill.intra.peff.net> <48155B7F.8020202@gnu.org> <20080428090948.GC16153@sigill.intra.peff.net> <20080428091150.GA16209@sigill.intra.peff.net> <48159688.2030202@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 12:34:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqQgp-0000um-K1
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 12:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbYD1Kdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 06:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbYD1Kdl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 06:33:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:39240 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756028AbYD1Kdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 06:33:41 -0400
Received: (qmail invoked by alias); 28 Apr 2008 10:33:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp024) with SMTP; 28 Apr 2008 12:33:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18t1757/iUtDwkgy1HNJx3KN9j4O6jnWH9hJuUEDV
	JzROXC4IP2DhQ8
X-X-Sender: user@eeepc-johanness
In-Reply-To: <48159688.2030202@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80524>

Hi,

On Mon, 28 Apr 2008, Paolo Bonzini wrote:

> I'm preparing a patch that has "git fetch" fetch from all remotes (same 
> as "git remote update" with no groups defined)

Funny, I would think that this functionality belongs into git-remote 
instead of git-fetch.  Especially since it would be possible to reuse the 
code you referred to...

Ciao,
Dscho
