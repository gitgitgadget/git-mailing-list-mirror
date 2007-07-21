From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 05:54:10 +0200
Organization: Organization?!?
Message-ID: <85d4ymtnrx.fsf@lola.goethe.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org> <200707202302.57788.johan@herland.net> <alpine.LFD.0.999.0707201421110.27249@woody.linux-foundation.org> <Pine.LNX.4.64.0707202320300.16498@reaper.quantumfyre.co.uk> <alpine.LFD.0.999.0707201712150.27249@woody.linux-foundation.org> <85hcnytuq8.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 05:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC638-0007VW-Vz
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 05:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXGUDyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 23:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXGUDyX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 23:54:23 -0400
Received: from main.gmane.org ([80.91.229.2]:53923 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbXGUDyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 23:54:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IC62u-0001DK-JM
	for git@vger.kernel.org; Sat, 21 Jul 2007 05:54:20 +0200
Received: from dslb-084-061-013-246.pools.arcor-ip.net ([84.61.13.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 05:54:20 +0200
Received: from dak by dslb-084-061-013-246.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 05:54:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-013-246.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:mgj4426GPigIOlDrEyLqdQ2WGWk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53133>

David Kastrup <dak@gnu.org> writes:

> The only difference is that I am calling the file ".".  Which is in
> _all_ respects nothing more than a naming convention.
>
> However, this convention has distinct advantages over ".notignore":
>
> a) I don't have to depart as far from reality.  Whenever I try
> registering ".", I can rely on the work directory actually _having_
> "." as a _real_, not a pseudofile.  It will not actually be a
> _regular_ file as I'll tell git: that's a wart of my prototype
> implementation which will, no doubt, eventually be fixed by others
> _if_ the code does its job fine apart from being ugly to look at.

Update: well, I am still digging through the code, but this is all so
well factored that it might be perfectly feasible to have S_ISDIR
entries after all without too much of a hassle.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
