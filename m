From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Tue, 16 Dec 2008 00:45:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812160039180.30035@xanadu.home>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org>
 <49470D65.40808@gmx.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Dec 16 06:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCSmB-0002r2-V1
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 06:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbYLPFqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 00:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYLPFqF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 00:46:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42532 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYLPFqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 00:46:02 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBY00LVCG0KB3K0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Dec 2008 00:45:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <49470D65.40808@gmx.ch>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103249>

On Tue, 16 Dec 2008, Jean-Luc Herren wrote:

> jidanni@jidanni.org wrote:
> > JH> So maybe what you really want is an ETA display during the cloning
> > JH> process?  Sounds like a good idea to me.
> > 
> > ETA implies that git has an estimate of what is going to happen.
> 
> Aren't you implying this too from the beginning?  But reading
> Jeff's reply, there seems to be a reason why there isn't an ETA
> already.
> 
> However, since some repositories get cloned in the same way very
> often, there could be some cache that keeps these size information
> around for any subsequent identical clones.  The server could then
> send a hint about the expected amount of data at the beginning.

And then you'll end up being the unlucky bastard to be the first to 
clones the new latest revision of a repository, and ETA won't be 
available, and you'll complain about the fact that sometimes it is there 
and sometimes it is not.

The fact is, fundamentally, we don't know how many bytes to push when 
generating a pack to answer the clone request.  Sometimes we _could_ but 
not always.  It is therefore better to be consistent and let people know 
that there is simply no ETA.


Nicolas
