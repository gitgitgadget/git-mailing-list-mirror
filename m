From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify that git-cherry-pick applies patches to HEAD
Date: Sun, 27 Jun 2010 12:46:12 -0700
Message-ID: <7viq54fed7.fsf@alter.siamese.dyndns.org>
References: <1277646745.13370.711.camel@zarniwoop.blob>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rspanton@zepler.net
X-From: git-owner@vger.kernel.org Sun Jun 27 21:46:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxo9-0007Mo-AU
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0F0TqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:46:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab0F0TqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:46:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8760BBFDB5;
	Sun, 27 Jun 2010 15:46:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UiBtn6wWCnxRPIS0ZLbZpI5zpnI=; b=aVwVfJ
	k6lAP1yvxnNIPV5Y6kAUENyheVIWNRArXT5b7babjxc0HYaxGBIvSBhhfdWg4by+
	xk+p1Xg69A/89L28cjUpKBYhHhLO3kBl0LFGprlnz9HnpGsKrZT/O7v6BBseZpis
	7X+j0mZfTBctMsfu06bt454wnKRm542LNEvYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bW+R0vHnUd1+GhnuPtKdDoD48Gx6tZKY
	2CkoxBixmijLx+WopvkSaSB6NjfcS2pMC61hYfAGexftiwazosrBW6FVnfR8gGY9
	hT2OU+yltwry2613bk32ctSpwobBrNA4ctWmNGYoxnfGNNrPX14Rm4dFJsLWjYib
	el5rMAOEhuc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A53BFDB1;
	Sun, 27 Jun 2010 15:46:17 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C5A1BFDB0; Sun, 27 Jun
 2010 15:46:14 -0400 (EDT)
In-Reply-To: <1277646745.13370.711.camel@zarniwoop.blob> (Robert Spanton's
 message of "Sun\, 27 Jun 2010 14\:52\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6D5281A-8224-11DF-9D67-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149806>

Robert Spanton <rspanton@zepler.net> writes:

> Change the description of cherry-pick to state that the given commits
> are applied to the current HEAD.  It was unclear exactly where
> cherry-pick ends up sticking the given commits.
>
> Signed-off-by: Robert Spanton <rspanton@zepler.net>

Almost all commit-creating commands work on nothing but the current HEAD,
and once a reader understands that repeating that "git commit" makes
commit on top of current HEAD, "git am" applies patches on top of current
HEAD, etc. will become excessively noisy, I am afraid.
