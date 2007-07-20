From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 07:55:45 +0200
Organization: Organization?!?
Message-ID: <85wswvty8u.fsf@lola.goethe.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com> <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org> <7vir8f24o2.fsf@assigned
 -by-dhcp.cox.net> <alpine.LFD.0.999.0707191930030.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 08:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBlXE-0001LS-C9
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 08:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbXGTGAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 02:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbXGTGAL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 02:00:11 -0400
Received: from main.gmane.org ([80.91.229.2]:38623 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbXGTGAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 02:00:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IBlX0-0001bl-RC
	for git@vger.kernel.org; Fri, 20 Jul 2007 08:00:02 +0200
Received: from dslb-084-061-049-236.pools.arcor-ip.net ([84.61.49.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 08:00:02 +0200
Received: from dak by dslb-084-061-049-236.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 08:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-049-236.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Bepz/mWPhjQdr3rMi2hP5WogeUs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53060>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 19 Jul 2007, Junio C Hamano wrote:
>> 
>> But you _could_ treat that "should-be-kept-even-when-empty"-ness
>> just like we treat executable bit on blobs, I think.
>
> True. Or you could make it a path attribute and/or a per-repository
> decision, so that while the data wouldn't necessarily be in the
> database itself, the user could specify the behaviour he wanted.

No, one can't.  Once can decide per repository whether one wants to
permit this kind of information in.  But if one does, the information
needs to there for _every_ tree.  And a "." entry is a natural and
intuitive way to do that.  "." has been used as a directory entry for
decades in Unix.

>> This will involve a lot of changes, so I would not recommend
>> anybody doing so, though.
>
> Agreed. The upside just isn't there.

It is a good thing that you did not design the Unix file systems.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
