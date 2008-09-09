From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge vs git commit
Date: Tue, 09 Sep 2008 10:34:42 -0700
Message-ID: <7vhc8p6x59.fsf@gitster.siamese.dyndns.org>
References: <20080909165236.GA8850@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd78E-0007dR-23
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 19:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbYIIRez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 13:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbYIIRez
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 13:34:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbYIIRez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 13:34:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 68D81799D5;
	Tue,  9 Sep 2008 13:34:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B620799CD; Tue,  9 Sep 2008 13:34:46 -0400 (EDT)
In-Reply-To: <20080909165236.GA8850@flint.arm.linux.org.uk> (Russell King's
 message of "Tue, 9 Sep 2008 17:52:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D3468F0-7E95-11DD-8BDF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95409>

Russell King <rmk@arm.linux.org.uk> writes:

> If there aren't any conflicts, you get a nice clean merge, resulting in:
> ...
> However, if you have a conflict that needs resolving, you fix it up as
> ...
> instead - an additional reference from commit 'K' back to commit 'A'
> which isn't present in the clean merge case.
>
> Is this intentional, or is it a bug?

I think some changes went into 1.6.0 around this area to (r)eject parents
that are redundant.  What happens when you use more recent git with the
same example?
