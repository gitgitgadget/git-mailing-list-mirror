From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log filtering
Date: Thu, 8 Feb 2007 19:06:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
 <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
 <20070208061654.GA8813@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 19:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFDfJ-0007qX-IC
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 19:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbXBHSGb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 13:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbXBHSGb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 13:06:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:57975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752380AbXBHSGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 13:06:30 -0500
Received: (qmail invoked by alias); 08 Feb 2007 18:06:28 -0000
X-Provags-ID: V01U2FsdGVkX19IPY970ylIfUDOZbVU6Dae4JwqJxFjy/PTfIph1R
	JaXg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070208061654.GA8813@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39068>

Hi,

On Thu, 8 Feb 2007, Jeff King wrote:

> On Wed, Feb 07, 2007 at 01:53:18PM -0800, Linus Torvalds wrote:
> 
> > What's PCRE performance like? I'd hate to make "git grep" slower, and it 
> > would be stupid and confusing to use two different regex libraries..
> >
> > Maybe somebody could test - afaik, PCRE has a regex-compatible (from a API 
> > standpoint, not from a regex standpoint!) wrapper thing, and it might be 
> > interesting to hear if doing "git grep" is slower or faster..
> 
> The patch is delightfully simple (though a real patch would probably be
> conditional):
>
> [...]

May I register a complaint? This is yet _another_ dependency.

Ciao,
Dscho
