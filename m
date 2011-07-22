From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 15:40:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1107221530270.1762@xanadu.home>
References: <20110721202722.3765.qmail@science.horizon.com>
 <alpine.LFD.2.00.1107220907370.1762@xanadu.home>
 <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
 <201107222034.20510.jnareb@gmail.com>
 <alpine.DEB.2.02.1107221206370.11697@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Jul 22 21:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkLaJ-0005te-T3
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 21:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab1GVTkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 15:40:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13208 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab1GVTkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 15:40:22 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LOR003H42LMHVQ1@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Jul 2011 15:39:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.2.02.1107221206370.11697@asgard.lang.hm>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177661>

On Fri, 22 Jul 2011, david@lang.hm wrote:

> On Fri, 22 Jul 2011, Jakub Narebski wrote:
> 
> > That is IF unknown headers are copied verbatim during rebase.  For
> > "encoding" header this is a good thing, for "generation" it isn't.
> 
> commit headers are _not_ copied during rebase

Yes, this turns out to be true as I forgot that rebase is constructed on 
top of format-patch+am, and format-patch doesn't preserve the ancillary 
headers such as the existing "encoding" header, or the hypothetical 
"generation" header.


Nicolas
