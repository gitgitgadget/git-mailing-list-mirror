From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Wrong time in git-log when using right/ timezone
Date: Wed, 18 Jul 2007 22:29:15 +0200
Message-ID: <20070718202915.GA29505@steel.home>
References: <20070718153614.GA28815@hartlich.com> <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Hartlich <wwsgj@hartlich.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 22:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBG9D-0001iD-UU
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 22:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbXGRU3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 16:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbXGRU3U
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 16:29:20 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:18890 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbXGRU3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 16:29:19 -0400
Received: from tigra.home (Fc837.f.strato-dslnet.de [195.4.200.55])
	by post.webmailer.de (fruni mo37) (RZmta 9.1)
	with ESMTP id 4047c4j6IJwbeg ; Wed, 18 Jul 2007 22:29:16 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B217E277BD;
	Wed, 18 Jul 2007 22:29:16 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D4AB1C164; Wed, 18 Jul 2007 22:29:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWotvlQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52896>

Linus Torvalds, Wed, Jul 18, 2007 19:01:31 +0200:
> I get:
> 
> 	commit 9dfdf14b3805e89aa2782458bda15b3dfae24c09
> 	Author: Junio C Hamano <gitster@pobox.com>
> 	Date:   Mon Jul 16 01:41:17 2007
> 
> for the CET case, but for right/Europe/Berlin I get:
> 
> 	commit 9dfdf14b3805e89aa2782458bda15b3dfae24c09
> 	Author: Junio C Hamano <gitster@pobox.com>
> 	Date:   Mon Jul 16 01:39:54 2007
> 
> ie apparently Berlin is in a timezone of its own that is roughly one 
> minute and 23 seconds away from CET.
> 
> What the *heck*?
> 

Maybe the "right/" timezones are just a little too right?

http://ecos.sourceware.org/ml/libc-alpha/2000-12/msg00068.html
