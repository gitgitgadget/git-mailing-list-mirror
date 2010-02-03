From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: extra headers in commit objects
Date: Wed, 03 Feb 2010 16:17:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002031612480.1681@xanadu.home>
References: <20100203174041.GC14799@spearce.org>
 <1265230702.7429.54.camel@ganieda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:17:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmbK-0006zQ-1c
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663Ab0BCVRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 16:17:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757345Ab0BCVRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 16:17:23 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXA00LKTB4Z9WA0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 16:17:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1265230702.7429.54.camel@ganieda>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138902>

On Wed, 3 Feb 2010, Jelmer Vernooij wrote:

> Since Dulwich would blow up when it encountered custom headers that
> might be set by other Git implements and since (as I understand) C git
> ignores unknown headers, I called this a bug fix. This change made it
> possible to deal with custom headers whenever they would appear *and*
> allowed users of the Dulwich API to set custom headers. 
> 
> (FWIW I haven't actually seen anybody setting custom headers)
> 
> If this is indeed a misunderstanding, I'll happily make this
> datastructure with custom headers read-only.

Please do so.

It is best to consider the Git note facility for the addition of such 
custom notations.  Notes can be attached to commits and changed at will 
while the commit objects themselves cannot (unless you rewrite history).


Nicolas
