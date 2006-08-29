From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 14:16:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608291410290.9796@xanadu.home>
References: <20060829134233.GA21335@spearce.org> <ed1kn3$c3r$1@sea.gmane.org>
 <20060829162747.GA21729@spearce.org> <7v8xl7moo7.fsf@assigned-by-dhcp.cox.net>
 <20060829174448.GD21729@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 20:17:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI88f-00089W-6K
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 20:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWH2SQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 14:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWH2SQg
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 14:16:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62146 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750804AbWH2SQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 14:16:35 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4R00JJZURG04T1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 Aug 2006 14:16:29 -0400 (EDT)
In-reply-to: <20060829174448.GD21729@spearce.org>
X-X-Sender: nico@xanadu.home
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26211>

On Tue, 29 Aug 2006, Shawn Pearce wrote:

> So I'm probably going to wind up spending some time doing research
> and experimentation on pack storage.  I may just discover we're
> as good as we can get.  Or I may find that doing something else
> saves us only 5% at the cost of far too much complexity and thus
> isn't really worth doing.  Or I may get lucky and discover a way
> to improve on what we have.

I'm periodically looking for improvements on packing performances 
myself.

I look forward to being able to use your (and Jon's) fast-import work in 
order to play with (re)generation of big packs myself.


Nicolas
