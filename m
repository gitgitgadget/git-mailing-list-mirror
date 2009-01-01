From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: let a "false" Directory parameter (such as "0")
 be used correctly by the constructor"
Date: Thu, 01 Jan 2009 13:00:18 -0800
Message-ID: <7vwsdeivx9.fsf@gitster.siamese.dyndns.org>
References: <1230510300-7854-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 22:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUfs-0005a1-7F
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbZAAVA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbZAAVA1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:00:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZAAVA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:00:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 084291B8D1;
	Thu,  1 Jan 2009 16:00:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 042351B8D2; Thu, 
 1 Jan 2009 16:00:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3557E142-D847-11DD-806A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104322>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

> ---
>  perl/Git.pm |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Lacks sign-off and description but otherwise looks good.  Will queue to
'pu' to leave you a chance to re-send.

    commit b29b1ae7442cd7c1c78e38b7d980905944ec31e0
    Author: Philippe Bruhat (BooK) <book@cpan.org>
    Date:   Mon Dec 29 01:25:00 2008 +0100

        Git.pm: correctly handle directory name that evaluates to "false"

        The repository constructor mistakenly rewrote a Directory parameter that
        Perl happens to evaluate to false (e.g. "0") to ".".


Thanks.
