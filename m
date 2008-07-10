From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Thu, 10 Jul 2008 13:13:03 -0700
Message-ID: <7v4p6xpkfk.fsf@gitster.siamese.dyndns.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org>
 <alpine.DEB.1.00.0807101201210.3135@eeepc-johanness>
 <200807102126.37567.chriscool@tuxfamily.org>
 <7vd4llpkxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:14:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH2XV-0007R8-8g
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 22:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYGJUNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 16:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbYGJUNO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 16:13:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbYGJUNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 16:13:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BB7E62610B;
	Thu, 10 Jul 2008 16:13:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8698E26107; Thu, 10 Jul 2008 16:13:05 -0400 (EDT)
In-Reply-To: <7vd4llpkxq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 10 Jul 2008 13:02:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F7CEB9A-4EBC-11DD-8C70-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88005>

Junio C Hamano <gitster@pobox.com> writes:

> I have not looked at your implementation, but I do not think:

Sheesh.  "I *do* think"...

>  - The current one is not "fully reliable"; the user needs to know what
>    he is doing.  You might call it "prone to user errors".
>
>  - "Test this merge-base before going forward, please" will add typically
>    only one round of check (if you have more merge bases between good and
>    bad, you need to test all of them are good to be sure), so it is not
>    "slower nor more complex".

and I think it is a reasonable thing to do.
