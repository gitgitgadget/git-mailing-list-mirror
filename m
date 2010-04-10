From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Warn the users when more than 3 '-C' given.
Date: Sat, 10 Apr 2010 12:12:58 -0700
Message-ID: <7vochrw285.fsf@alter.siamese.dyndns.org>
References: <1270900308-20147-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	dirson@bertin.fr
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0g7L-00079G-9M
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab0DJTNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:13:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0DJTNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:13:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 186F2A9D0B;
	Sat, 10 Apr 2010 15:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uSKpQNBRKJckHHUOyT+xIMtgpXg=; b=LTXugG
	9QCK8WNcNDG08PE/rHmAHROEGLDyRWmpWO1oGCEaQMIbbBAbblqx3Smr6M3VpmE0
	u8kZD6OAB0NcMj1GKNR585yrvylEy3d88e/ndAsCq/5foU5rzDABlpT3sHIliXQj
	62foEItfkkQgFjAJBMvK1cK8bRz2HEDIXUPvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LgJ+Omr1069Modrnj71QMdTuUMu91RMw
	xddK5AGU2xm485C77OIVpMszwVJQNQ5bEclVFKTqJS0q1xn8xm4PMBs9iM8DEKMZ
	jNnmBP3YqvSAtxfGVjPMeKDcBUpOPTtc/A69nPrdHZ1ZFPri1mJ37GhXrRrIdWdr
	lHTh6iXiNgo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C99E9A9D03;
	Sat, 10 Apr 2010 15:13:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0175DA9CFF; Sat, 10 Apr
 2010 15:12:59 -0400 (EDT)
In-Reply-To: <1270900308-20147-1-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Sat\, 10 Apr 2010 19\:51\:48 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1788B24E-44D5-11DF-8D38-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144579>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Output a warning message to users when there are more than
> 3 '-C' options given. And ignore the numeric argument value
> provided by the additional '-C' options.

How were you bitten by the lack of this warning?  You gave four or five to
see how output would change, spent sleepless nights but couldn't figure
out what the differences between third and fourth levels are, and wasted
too much time?

IOW, what does this fix?

I personally do not see much value in this patch.  It would be just a
hindrance to remember to remove this hunk when somebody improves the
algorithm to add fourth level of detail to the inspection logic.
