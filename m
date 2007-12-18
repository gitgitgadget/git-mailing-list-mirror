From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix segfault in diff-delta.c when FLEX_ARRAY is 1
Date: Tue, 18 Dec 2007 09:46:37 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712180941250.8467@xanadu.home>
References: <1197941997-11421-1-git-send-email-madcoder@debian.org>
 <20071218014455.GB14981@artemis.madism.org>
 <alpine.LFD.0.9999.0712172032090.21557@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712172146070.21557@woody.linux-foundation.org>
 <7vwsrc1idm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 15:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4dip-0002Ky-K9
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 15:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbXLROqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 09:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbXLROqi
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 09:46:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19169 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbXLROqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 09:46:38 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT900LTF2DPU370@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Dec 2007 09:46:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vwsrc1idm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68755>

On Tue, 18 Dec 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > But there's a few that aren't obviously allocations (this is a list done 
> > with grep and sparse, I didn't look at whether the values used are then 
> > all allocation-related):
> >
> >  - diff-delta.c:250        memsize = sizeof(*index)
> 
> I haven't studied this codepath.

Harmless overallocation.  Nothing to worry about.


Nicolas
