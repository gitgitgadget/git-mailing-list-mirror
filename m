From: Marius Vollmer <marius.vollmer@gmail.com>
Subject: Re: What are branches?
Date: Tue, 21 Apr 2009 01:08:12 +0300
Message-ID: <87r5znashf.fsf@gmail.com>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
	<20090420113216.GC25059@dpotapov.dyndns.org>
	<49EC6596.8060208@drmicha.warpmail.net>
	<20090420132414.GD25059@dpotapov.dyndns.org>
	<49EC7E3B.9050909@drmicha.warpmail.net>
	<20090420184048.GF25059@dpotapov.dyndns.org>
	<7viqkzdoua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw2BF-0008BX-9E
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbZDTWkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 18:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757150AbZDTWj7
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 18:39:59 -0400
Received: from smtp6.welho.com ([213.243.153.40]:59214 "EHLO smtp6.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756484AbZDTWj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 18:39:59 -0400
X-Greylist: delayed 1905 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2009 18:39:59 EDT
Received: from zagadka.ping.de (cs178034.pp.htv.fi [213.243.178.34])
	by smtp6.welho.com (Postfix) with SMTP id E3AE75BC048
	for <git@vger.kernel.org>; Tue, 21 Apr 2009 01:08:12 +0300 (EEST)
Received: (qmail 25313 invoked by uid 1000); 21 Apr 2009 01:08:12 +0300
In-Reply-To: <7viqkzdoua.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 Apr 2009 13:58:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117045>

Junio C Hamano <gitster@pobox.com> writes:

> If we made it easy for Dscho to create the merge M to record my tree as
> the first parent, [...]

But it _is_ easy for Dscho to do that, isn't it?  He just needs to
remember to do the merge the other way around, checking out your branch
and merging his into it.

This doesn't change much, of course, since we still can't follow a
branch backwards in time reliably.  Would it make sense to record
additional information in a merge commit, such as the branch name for
each parent?  Then tools could automatically draw the history of the
current branch as a straight line, say.
