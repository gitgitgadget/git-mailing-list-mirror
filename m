From: David Kastrup <dak@gnu.org>
Subject: Re: performance on repack
Date: Sun, 12 Aug 2007 00:09:12 +0200
Organization: Organization?!?
Message-ID: <85ps1tsozb.fsf@lola.goethe.zz>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 00:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJz9U-0005ug-1x
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 00:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762329AbXHKWJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762279AbXHKWJk
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 18:09:40 -0400
Received: from main.gmane.org ([80.91.229.2]:34172 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762216AbXHKWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 18:09:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJz9F-0002Q3-5K
	for git@vger.kernel.org; Sun, 12 Aug 2007 00:09:29 +0200
Received: from dslb-084-061-049-066.pools.arcor-ip.net ([84.61.49.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 00:09:29 +0200
Received: from dak by dslb-084-061-049-066.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 00:09:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-049-066.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:AfzcXur1One70rYjWPl/Cw/J45k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55641>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> If anyone is bored and looking for something to do, making the delta
> code in git repack multithreaded would help.

I severely doubt that.  It is like the "coding stuff in assembly
language will make it faster" myth.  The problem is that of manageable
complexity.  Making the stuff multithreaded or coded in assembly means
that it becomes inaccessible for a sound algorithmic redesign.

And anything that takes this long on today's machines has lots of room
for algorithmic improvement, usually resulting in a speedup from one
to several orders of magnitude.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
