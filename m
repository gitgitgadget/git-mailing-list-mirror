From: Nicolas Pitre <nico@cam.org>
Subject: Re: Further 'approxidate' improvements
Date: Sat, 22 Aug 2009 22:08:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908222204590.6044@xanadu.home>
References: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain>
 <alpine.LFD.2.01.0908221759420.3158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 23 04:11:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf2Ym-0003Ry-JM
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 04:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933428AbZHWCIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 22:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933426AbZHWCIj
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 22:08:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9925 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933425AbZHWCIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 22:08:38 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOT005FN4LTBKC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 22 Aug 2009 22:08:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908221759420.3158@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126829>

On Sat, 22 Aug 2009, Linus Torvalds wrote:

> So trying to date-parse nonsensical crud still gives odd results:
> 
> 	I ate six hot-dogs in June -> Sat Jun  6 18:09:26 2009
> 
> because it parses "six" and "June" and then puts it together as a date, 
> and then adds the current time (and year) and is happy.
> 
> But parsing random things amusingly is a _feature_. Misparsing something 
> that makes sense as a date is a bug.

Maybe that would be a good idea to write a test just for this, so known 
cases making sense aren't accidentally broken by eventual modifications 
to add more such cases.


Nicolas
