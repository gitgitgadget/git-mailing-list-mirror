From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Wed, 18 Jul 2007 02:19:31 -0400
Message-ID: <20070718061931.GZ32566@spearce.org>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site> <Pine.LNX.4.64.0707172216420.14596@iabervon.org> <Pine.LNX.4.64.0707172302560.14596@iabervon.org> <20070718032907.GY32566@spearce.org> <7vy7he8cjl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 13:04:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB7Ke-0001Fq-Rm
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 13:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463AbXGRLEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 07:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756364AbXGRLEe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 07:04:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33237 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305AbXGRLEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 07:04:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IB2sm-0006EG-UA; Wed, 18 Jul 2007 02:19:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0DDEE20FBAE; Wed, 18 Jul 2007 02:19:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy7he8cjl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52850>

Junio C Hamano <gitster@pobox.com> wrote:
> It might not be actually so bad.  But I wonder if it would be
> more obvious if you do not show the whole "a-" lines but leave
> just a marker there.  That is (ugliness of "a@@" and "a-" that
> made me wash my eyes needs to be fixed, though -- but that is
> only the syntax):
> 
> a@@ -1598,43 +1635,6 a@@ apply_config
>   
>   ######################################################################
>   ##
> a-<<< Block a was originally here >>>
>   ## ui construction
>   
>   set ui_comm {}
> 
> You are coming up with a new output format that is only used
> when it is a straight move and nothing else, so by definition
> there is really no need to show both removal and addition.

Yea, this I like even better than what I posted.  Now we just need
a suck^H^H^H^Hprogrammer to implement a working prototype and see
how folks like more realistic diffs generated with it.  ;-)

-- 
Shawn.
