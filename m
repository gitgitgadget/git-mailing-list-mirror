From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 07 May 2010 16:32:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005071630170.14468@xanadu.home>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
 <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
 <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071529050.14468@xanadu.home>
 <alpine.LFD.2.00.1005071235070.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 22:32:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUE5-0000Or-7r
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab0EGUch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:32:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45852 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0EGUcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 16:32:36 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L2200JE0H2B3X00@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 May 2010 16:32:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.1005071235070.901@i5.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146591>

On Fri, 7 May 2010, Linus Torvalds wrote:

> On Fri, 7 May 2010, Nicolas Pitre wrote:
> > 
> > Given that only a subset of gitconfig could make sense to have 
> > distributed, I think the file should be named .gitparams to make the 
> > distinction clear.
> 
> I went through the options listed in "man gitconfig", and quite frankly, I 
> didn't find any new ones. I didn't grep the source, and I'm sure they're 
> not all documented, but if it really is just two options, I doubt it's 
> worth it at all.

I don't dispute that.

I was merely pointing out that naming such a file .gitconfig is a bad 
idea if it doesn't duplicate the entire .git/config functionality.


Nicolas
