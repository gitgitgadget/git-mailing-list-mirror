From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found by the clang static analyzer
Date: Sun, 27 Sep 2009 10:21:17 +0200
Message-ID: <874oqokdc2.fsf@master.homenet>
References: <87ab0hepcn.fsf@master.homenet>
	<alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
	<871vltefdj.fsf@master.homenet>
	<fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
	<87ske9cya9.fsf@master.homenet>
	<20090926204604.GA2960@coredump.intra.peff.net>
	<alpine.LFD.2.00.0909262038470.4997@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:24:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrp3m-0006lt-Ob
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbZI0IV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 04:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbZI0IV2
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:21:28 -0400
Received: from averell.mail.tiscali.it ([213.205.33.55]:60120 "EHLO
	averell.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbZI0IVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 04:21:23 -0400
Received: from master.homenet (84.223.203.227) by averell.mail.tiscali.it (8.0.022)
        id 4AA780C80078157C; Sun, 27 Sep 2009 10:21:23 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1Mrp0P-0006f5-Bo; Sun, 27 Sep 2009 10:21:17 +0200
In-Reply-To: <alpine.LFD.2.00.0909262038470.4997@xanadu.home> (Nicolas Pitre's
	message of "Sat, 26 Sep 2009 20:41:35 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129200>

Nicolas Pitre <nico@fluxnic.net> writes:

> And the compiler (at least gcc) is indeed smart enough to realize that 
> nothing uses the result from the last statement, and does optimize away 
> the code associated to it already.  So this patch is unlikely to change 
> anything to the compiled result.

Right, and gcc can do many other amazing things.  But still it is used a
variable that is never accessed, removing it can make the code slightly
more readable.

Cheers,
Giuseppe
