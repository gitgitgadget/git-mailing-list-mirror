From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Tue, 11 Mar 2008 19:13:53 -0700
Message-ID: <7vskywadum.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 03:14:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGUR-0001Je-It
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbYCLCOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYCLCOF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:14:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYCLCOC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:14:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 821553399;
	Tue, 11 Mar 2008 22:14:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DF6BE3398; Tue, 11 Mar 2008 22:13:56 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803112157560.3873@racer.site> (Johannes
 Schindelin's message of "Tue, 11 Mar 2008 21:58:20 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76908>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If "--prune" is passed to gc, it still just calls "git prune".
> Otherwise, "prune --expire 2.weeks.ago" is called, where the grace
> period is overrideable by the config variable gc.pruneExpire.

"What it does."

> While adding a test to t5304-prune.sh (since it really tests the
> implicit call to "prune"), the original test for "prune --expire"
> is moved there from t1410-reflog.sh, where it did not belong.

"What the fallouts from this change were."

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Can we also have "why this is a good idea", "what problem this solves"?
