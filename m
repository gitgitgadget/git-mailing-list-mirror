From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 07:58:36 +0200
Message-ID: <85sl7jty43.fsf@lola.goethe.zz>
References: <858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
	<863azk78yp.fsf@lola.quinscape.zz>
	<FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
	<7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
	<7vir8f24o2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gernhardt <benji@silverinsanity.com>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 07:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBlVm-00015a-GI
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbXGTF6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbXGTF6n
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:58:43 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:48217 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752810AbXGTF6m (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 01:58:42 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id C66701A7B2A;
	Fri, 20 Jul 2007 07:58:38 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id B320C2DAB40;
	Fri, 20 Jul 2007 07:58:38 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-236.pools.arcor-ip.net [84.61.49.236])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 8A4AE34A6A9;
	Fri, 20 Jul 2007 07:58:38 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4A0571C3ACCF; Fri, 20 Jul 2007 07:58:37 +0200 (CEST)
In-Reply-To: <7vir8f24o2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 19 Jul 2007 19\:24\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3701/Fri Jul 20 02:52:18 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53059>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So the whole notion of "remembering" whether a directory was added 
>> explicitly as an empty directory or not is just not a sensible concept in 
>> git. 
>
> That is true if it is implemented as David suggested, to have a
> phony "." entry in the tree object itself.

Unix file systems contain a phony "." entry in the directory itself,
and have survived in spite of this.

> The object name of such a tree (when it contains blobs and trees
> underneath) will be different from a tree that contains the same set
> of blobs and trees.  It would destroy the fundamental concepts of
> git.

Like "." destroyed the fundamental concepts of Unix filesystems.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
