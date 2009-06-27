From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/4] die_errno()
Date: Sat, 27 Jun 2009 11:38:40 -0700
Message-ID: <7vhby1iksv.fsf@alter.siamese.dyndns.org>
References: <cover.1244494646.git.trast@student.ethz.ch>
	<cover.1246115204.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKcnZ-0004aw-4W
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 20:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZF0Sii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 14:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbZF0Sii
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 14:38:38 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61374 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZF0Sii (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 14:38:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090627183841.LBCE20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 27 Jun 2009 14:38:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 96eg1c00C4aMwMQ046egyD; Sat, 27 Jun 2009 14:38:40 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=lntmRWy9di7j07wZvZYA:9
 a=U1v3_FRBvqIglxp9HhWOzeM317wA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122380>

Thomas Rast <trast@student.ethz.ch> writes:

> This just picks up Junio's %-doubling patch from pu, with the extra
> change I suggested in <200906121204.37752.trast@student.ethz.ch> to
> handle the border case where a lone % would end up at the end of the
> buffer.  The rest is the same as v3.

Thanks.  Will queue.
