From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 08:55:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004070842580.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Vitaly <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 14:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzUmq-0002Gj-TA
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 14:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757911Ab0DGMzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 08:55:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60382 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab0DGMzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 08:55:10 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0I00DJ3BVXY760@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 08:55:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BBC1ED3.6020008@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144217>

On Wed, 7 Apr 2010, Vitaly wrote:

> Hmm, what does it mean - "makes no sense"? It works as it works - for several
> hours.

As I said, several hours for this operation makes no sense.  This should 
take minutes if no seconds.  *This* is what needs fixing.

> No, we work in a trusted environment. Our repository isn't open for external
> people.

I was asking that because that would have helped me (or any other Git 
developer) analyse the issue and provide a fix.

OK then.  What happens if you do the following on the server machine 
where the repository is stored:

	git repack -a -f -d

How long does this take?

How long does the "Resolving deltas" take when cloning this repacked 
repository? (don't wait more than 10 minutes for it).

If the "Resolving deltas" takes more than 10 minutes, could you capture 
a strace dump from that process during a minute or so and post it here?

Hmmm. Is this on Linux or Windows?


Nicolas
