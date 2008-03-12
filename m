From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Tue, 11 Mar 2008 22:37:09 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 03:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGqx-0006QP-AN
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbYCLChL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbYCLChL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:37:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39712 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYCLChK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:37:10 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXL00IZRJ9XRI70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Mar 2008 22:37:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vskywadum.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76914>

On Tue, 11 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If "--prune" is passed to gc, it still just calls "git prune".
> > Otherwise, "prune --expire 2.weeks.ago" is called, where the grace
> > period is overrideable by the config variable gc.pruneExpire.
> 
> "What it does."
> 
> > While adding a test to t5304-prune.sh (since it really tests the
> > implicit call to "prune"), the original test for "prune --expire"
> > is moved there from t1410-reflog.sh, where it did not belong.
> 
> "What the fallouts from this change were."
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Can we also have "why this is a good idea", "what problem this solves"?

FWIW, my agreeing with the "why this is a good idea" can be translated 
into:

Acked-by: Nicolas Pitre <nico@cam.org>


Nicolas
