From: Nicolas Pitre <nico@cam.org>
Subject: Re: GitTogether topics status (4th of October)
Date: Mon, 06 Oct 2008 23:46:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810062343000.3045@xanadu.home>
References: <200810041816.41026.chriscool@tuxfamily.org>
 <20081007031509.GA6031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Petr Baudis <pasky@suse.cz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 05:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn3YF-0003Yv-3L
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 05:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbYJGDqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 23:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbYJGDqt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 23:46:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55996 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbYJGDqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 23:46:47 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8C009P6NTTX9G0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Oct 2008 23:46:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081007031509.GA6031@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97663>

On Mon, 6 Oct 2008, Jeff King wrote:

>   2. What needs refactoring?
> 
>      I occasionally run up against parts of the code that just make my
>      eyes bleed everytime I touch them. I think we've made significant
>      progress in maintanability and bug-avoidance with things like the
>      strbuf library, refactoring of remote and transport handling, etc.
>      What areas might still benefit from such refactoring?

Tree object walking and commit object parsing. This is what's holding 
pack v4 performances back. But I think that Shawn will cover this 
already (I won't be there but I sent my thoughts about this to him).


Nicolas
