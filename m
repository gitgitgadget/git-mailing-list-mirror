From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] push: change push to fail if short refname does not exist
Date: Tue, 30 Oct 2007 01:29:01 -0700
Message-ID: <7vwst5m2eq.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935812741-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImmTd-0001Yz-5L
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbXJ3I3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbXJ3I3S
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:29:18 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45557 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXJ3I3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:29:17 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 957F22EF;
	Tue, 30 Oct 2007 04:29:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 08DEE8F39D;
	Tue, 30 Oct 2007 04:29:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska <prohaska@zib.de> writes:

> Pushing a short refname used to create a new ref on on the
> remote side if it did not yet exist. If you specified the wrong
> branch accidentally it was created. A safety valve that pushes
> only existing branches may help to avoid errors.

On the other hand, if you specified a wrong branch that exists
on the remote end accidentally, it still was pushed.  Do we want
to have a new "--i-really-want-to-push" option to make it safer?

I do not think so.  Why should a new branch be treated any
differently?

Will drop 1/10 and 2/10 for now.
