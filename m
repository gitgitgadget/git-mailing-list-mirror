From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Virtual PATCH] Add an option to wrap a patch in <pre> in
 git-imap-send which ironically results in a cleaner patch from Thunderbird.
Date: Thu, 12 Feb 2009 20:19:54 -0800
Message-ID: <7viqnfezo5.fsf@gitster.siamese.dyndns.org>
References: <499446D0.90602@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 05:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXpYU-0004GS-VZ
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 05:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962AbZBMEUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 23:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758807AbZBMEUB
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 23:20:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758923AbZBMEUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 23:20:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ED71D2B04F;
	Thu, 12 Feb 2009 23:19:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C6E22B04E; Thu,
 12 Feb 2009 23:19:56 -0500 (EST)
In-Reply-To: <499446D0.90602@codeweavers.com> (Jeremy White's message of
 "Thu, 12 Feb 2009 09:57:04 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 935A4816-F985-11DD-89B7-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109705>

I do not think of a reason, other than to trigger the workaround you
mentioned in the documentation part of the patch, why any sane user would
want to send a patch as HTML.  This configuration variable sounds more
like "imap.forceThunderbirdToSendNonFlowedTextByExploitingItsBug" than
"imap.html", in other words.

What worries me the most is if there is any guarantee that this bug you
are exploiting to force it to send a patch in the common denominator
format _will not be fixed_ in future versions of Thunderbird.

I see your patch deals only with ampersand, less-than, greater-than and
dquot.  Do you know if this is enough, or would letters outside US-ASCII
need to be expressed in ampersand-hash "character reference" notation?
