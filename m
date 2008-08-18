From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fetch problem or was master on kernel.org reset?
Date: Mon, 18 Aug 2008 21:50:23 +0200
Message-ID: <20080818195023.GB3262@steel.home>
References: <20080818172615.GA6014@blimp.local> <7v3al2npt5.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 21:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVAlb-0004iK-C9
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 21:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760922AbYHRTuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 15:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763468AbYHRTum
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 15:50:42 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:15209 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762285AbYHRTuf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 15:50:35 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44hO88yw==
Received: from tigra.home (Fa968.f.strato-dslnet.de [195.4.169.104])
	by post.webmailer.de (mrclete mo43) (RZmta 16.47)
	with ESMTP id Q02f2dk7IIVxKN ; Mon, 18 Aug 2008 21:50:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D2E26277AE;
	Mon, 18 Aug 2008 21:50:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id AD81B56D2A; Mon, 18 Aug 2008 21:50:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3al2npt5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92731>

Junio C Hamano, Mon, Aug 18, 2008 20:25:26 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > The commit ea02eef096d4bfcbb83e76cfab0fcb42dbcad35e is the current
> > value of master (on kernel.org). But it definitely was
> > 2ebc02d32a4360da2cf69c2b5f5bfad0716d42b0 some time before (at 11:42)!
> 
> I suspect that one of the mirrors still had ea02ee (1.6.0) when you made
> the above observation, after 2ebc02 (Start 1.6.1) was pushed into.
> According to my push log, "1.6.0" was pushed on 14:04 and "Start 1.6.1" on
> 19:47 (both on 2008-08-17, US/Pacific).

Ach... Yes. The mirror in question is my own. I updated the repository
(which now refuses to update its local references) _arrround_ the
mirror (directly from kernel.org). Now the mirror is older then my
repository. Simple.

Evening well spent: I just learned that I am far from perfect an have
a lot room for improvement 8)
