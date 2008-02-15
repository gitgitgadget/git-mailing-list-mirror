From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Fri, 15 Feb 2008 18:23:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802151823110.30505@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site> <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site> <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ5EV-00034f-37
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbYBOSXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbYBOSXs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:23:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:42391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752901AbYBOSXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 13:23:47 -0500
Received: (qmail invoked by alias); 15 Feb 2008 18:23:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 15 Feb 2008 19:23:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lOJ8lBFklNOqwMVpzUmkArhQaJpM/na78wgOJWi
	dzEukk6WnyAzbr
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73970>

Hi,

On Fri, 15 Feb 2008, Linus Torvalds wrote:

> In fact, in many ways, maybe we'd be better off counting (non-space) 
> bytes rather than lines. That gets the "complexity" argument mostly 
> right.

I don't like it.  It's not simple enough.  Let's stay with 3 lines, and if 
it turns out to be a bad choice, change it to two.

Ciao,
Dscho
