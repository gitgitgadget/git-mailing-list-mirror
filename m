From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] rebase -i squashes submodule changes into unrelated commit
Date: Tue, 27 Jan 2009 01:20:38 -0800
Message-ID: <7vd4e9yujd.fsf@gitster.siamese.dyndns.org>
References: <7vljsxyv58.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 10:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRk94-0008W7-HL
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 10:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbZA0JUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 04:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbZA0JUq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 04:20:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZA0JUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 04:20:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D26E1CF89;
	Tue, 27 Jan 2009 04:20:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9F74C1CF57; Tue,
 27 Jan 2009 04:20:39 -0500 (EST)
In-Reply-To: <7vljsxyv58.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Jan 2009 01:07:31 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C5077292-EC53-11DD-B200-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107323>

Junio C Hamano <gitster@pobox.com> writes:

> Attempting to rebase three-commit series (two regular changes, followed by
> one commit that changes what commit is bound for a submodule path) to
> squash the first two results in a failure; not just the first two commits
> squashed, but the change to the submodule is also included in the result.
>
> This failure causes the subsequent step to "pick" the change that actually
> changes the submodule to be applied, because there is no change left to be
> applied.

Sorry, an obvious typo is here: s/to be applied,/to fail,/;
