From: Nicolas Pitre <nico@cam.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 21:33:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810312121000.13034@xanadu.home>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
 <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
 <7viqr873x7.fsf@gitster.siamese.dyndns.org>
 <20081031234115.GD14786@spearce.org>
 <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
 <20081101010011.GG14786@spearce.org>
 <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm>
 <20081101010824.GE29036@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@lang.hm, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:37:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw5QW-0007HK-6U
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYKABd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYKABd6
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:33:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31303 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYKABd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:33:57 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M007ROSCFGO40@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 21:33:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081101010824.GE29036@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99701>

On Sat, 1 Nov 2008, Pierre Habouzit wrote:

> See junio's example. It's rather easy to add hooks into the library to
> implement a feature outside of it. It's even possible to do it while
> preserving the ABI fully IMHO (by being a strict superset of it).
> 
> The patch would be so trivial, that I see no reason why they wouldn't
> provide it. Though the real implementation of the feature that would be
> delegated through it would be in their closed source stuff.

But at that point it's a matter of public perception.  It would clearly 
be against the spirit of the license even though the license itself 
couldn't prevent such tortuous practices.  Those people doing such 
things would clearly be identified as bad guys and get bad press, and 
libgit contributors could even attempt law suits based on the derived 
work angle.  That might be just enough to prevent such things to happen.

OTOH they would certainly come out clean if the license was BSD since 
the spirit of that license explicitly allows closing up the whole 
library and adding extra features.


Nicolas
