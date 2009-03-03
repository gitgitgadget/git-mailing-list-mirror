From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: run post-checkout hook when checking out
Date: Mon, 02 Mar 2009 22:45:09 -0800
Message-ID: <7vsklvhzpm.fsf@gitster.siamese.dyndns.org>
References: <20273.1236033817@relay.known.net>
 <20090303042848.GC18136@coredump.intra.peff.net>
 <23978.1236056549@relay.known.net>
 <20090303053750.GA30201@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: layer <layer@known.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 07:46:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOOy-0001Im-Gy
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 07:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbZCCGpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 01:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZCCGpS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 01:45:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbZCCGpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 01:45:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1CB43EC3;
	Tue,  3 Mar 2009 01:45:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 366A63EC2; Tue, 
 3 Mar 2009 01:45:11 -0500 (EST)
In-Reply-To: <20090303053750.GA30201@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 3 Mar 2009 00:37:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D9E45DA2-07BE-11DE-8091-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112002>

Jeff King <peff@peff.net> writes:

> Junio, I'm not sure what you want to do with this. It is definitely a
> behavior change; we have never respected post-checkout hooks in shell
> git-clone.sh or in the builtin version. However, it seems like an
> omission rather than an intentional behavior, so I consider this a
> bugfix.

I do not mind queueing this to 'pu' and let people fight it out.  I hate
the local side hooks that have no reason to be there, and consider that
the existence of the "checkout hook" to be a bug to begin with, but I
really don't care that deeply anymore.
