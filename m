From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 23:49:57 +0200
Message-ID: <20080728214957.GC3721@blimp.local>
References: <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org> <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:11:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNiQQ-0007v7-2l
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYG2GKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYG2GKI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:10:08 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:64418 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbYG2GKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:10:06 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf50O7
Received: from tigra.home (Fae3d.f.strato-dslnet.de [195.4.174.61])
	by post.webmailer.de (mrclete mo56) (RZmta 16.47)
	with ESMTP id 500a3ek6T25atG ; Tue, 29 Jul 2008 08:10:02 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 9D67F277C4;
	Tue, 29 Jul 2008 08:10:02 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id EBA1E36D15; Mon, 28 Jul 2008 23:49:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90589>

Linus Torvalds, Mon, Jul 28, 2008 18:09:32 +0200:
> It really is just Beagle that is (was? I can dream) a piece of 
> unbelievable crap.
> 
> Anybody who uses extended attributes as part of a indexing scheme is just 
> insane. Modifying the file you are indexing is not just fundamentally 
> wrong to begin with, but it will then also be incredibly inefficient to 
> read those entries one at a time.
> 
> And no other sane model would ever touch 'ctime'.

Beagle is not alone. Google Desktop Search was mentioned before.

> Oh, well. Making ctime configurable is not wrong per se. But if it's 
> Beagle that triggers this, the fix is sadly in the wrong place.

Never said it was a fix. Same as CRLF conversion is not a feature.
