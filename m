From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] rebase [--onto O] A B: omit needless checkout
Date: Sat, 15 Mar 2008 23:21:41 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080315222140.GE24845@ins.uni-bonn.de>
References: <20080312191041.GF3198@ins.uni-bonn.de> <47D8D5B8.70809@viscovery.net> <20080315103954.GD14769@ins.uni-bonn.de> <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 23:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaell-0005rA-Gi
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 23:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYCOWVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 18:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYCOWVq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 18:21:46 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:50258 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbYCOWVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 18:21:45 -0400
Received: from localhost.localdomain (xdsl-87-78-71-236.netcologne.de [87.78.71.236])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 3C94D40000493;
	Sat, 15 Mar 2008 23:21:44 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1Jael3-0003C3-4D; Sat, 15 Mar 2008 23:21:41 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
Content-Disposition: inline
In-Reply-To: <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77342>

Hello Junio,

* Junio C Hamano wrote on Sat, Mar 15, 2008 at 09:42:11PM CET:
> This teaches "git rebase [--onto O] A B" to omit an unnecessary checkout
> of branch B before it goes on.

>  * Almost untested as I do not use this form very often.  Feedback would
>    be good.

Nice, and seems to do exactly what I meant.  Actually the more important
speedup gained from this change is that files that have changed in the
non-common history of A but not in that of B, preserve their old time
stamps, so the rebuild of my bugfix topic B after having built master
is really quick now.

Thanks!
Ralf
