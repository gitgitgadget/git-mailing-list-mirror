From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 15:27:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810201525540.26244@xanadu.home>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
 <20081020191400.GA18743@fiberbit.xs4all.nl>
 <20081020192051.GA21770@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:44:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks0Qm-0005LU-DC
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 21:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYJTT1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbYJTT1c
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 15:27:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18754 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYJTT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 15:27:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K91006IGY1OONF0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 20 Oct 2008 15:27:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081020192051.GA21770@fiberbit.xs4all.nl>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98735>

On Mon, 20 Oct 2008, Marco Roeland wrote:

> Op maandag 20 oktober 2008 om 21:14 uur schreef Marco Roeland het volgende:
> 
> > This is on Debian 'sid' with an AMD64 architecture.
> > 
> > I've put the whole ".git" directory (warning: almost 35MB) for
> > investigation at:
> > 
> > http://www.xs4all.nl/~fiberbit/http://www.xs4all.nl/~fiberbit/git-next-8f0e41f3-bad-index.tgz
> 
> Gah, I can't even copy-and-paste:
> 
> http://www.xs4all.nl/~fiberbit/git-next-8f0e41f3-bad-index.tgz

Don't worry -- I figured it out and was able to reproduce the problem 
already.  Thanks a lot!

> This is on a quadcore. I recently experimented with "git config
> pack.threads 0" but as it didn't seem to speedup anything I removed
> it again. Just mention it on the infinitesimal chance it might be
> important.

It is not.  And the speedup should be noticeable when you repack, not 
when you fetch.


Nicolas
