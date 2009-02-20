From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Thu, 19 Feb 2009 23:40:56 -0800
Message-ID: <7vzlghftdj.fsf@gitster.siamese.dyndns.org>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
 <20090220062543.GA27837@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 08:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQ1s-0008Qc-Im
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 08:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbZBTHlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 02:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbZBTHlF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 02:41:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZBTHlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 02:41:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 877392B85C;
	Fri, 20 Feb 2009 02:41:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C33002B856; Fri,
 20 Feb 2009 02:40:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D22147A6-FF21-11DD-AC0D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110808>

Jeff King <peff@peff.net> writes:

Thanks for a review.  Everything you said makes sense to me.

Also I noticed that [3/4] uses "diff -r -x" --- does it pretty much mean
we require GNU diff to pass the test?  Can this be made more portable?
