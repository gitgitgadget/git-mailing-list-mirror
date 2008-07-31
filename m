From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 22:58:13 -0700
Message-ID: <7vwsj23896.fsf@gitster.siamese.dyndns.org>
References: <20080730051059.GA4497@sigill.intra.peff.net>
 <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
 <20080731055024.GA17652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 07:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KORC8-00035Z-3s
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 07:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbYGaF6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 01:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbYGaF6X
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 01:58:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYGaF6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 01:58:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 448D24442B;
	Thu, 31 Jul 2008 01:58:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C4D0B44426; Thu, 31 Jul 2008 01:58:15 -0400 (EDT)
In-Reply-To: <20080731055024.GA17652@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 31 Jul 2008 01:50:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE07ACAE-5EC5-11DD-8DE9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90895>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 30, 2008 at 07:53:11PM +0200, Anders Melchiorsen wrote:
>
>> An empty commit message is now treated as a normal situation, not an error.
>
> As others have commented, I think the right way to say this is probably
> "it is not reported to the user as an error, but still exits with a
> non-zero exit status".
>
> And I think it looks better.
>
> But:
>
>>  			"# Please enter the commit message for your changes.\n"
>> +			"# To abort the commit, use an empty commit message.\n"
>>  			"# (Comment lines starting with '#' will ");
>
> I still prefer a shortened version of these three lines, as I mentioned
> earlier.

I tend to agree; please make it so ;-)
