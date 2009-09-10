From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: Avoid modules deprecated in Python 2.6.
Date: Thu, 10 Sep 2009 11:22:37 -0700
Message-ID: <7v63bqd5hu.fsf@alter.siamese.dyndns.org>
References: <1252566158-13305-1-git-send-email-reillyeon@qotw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Reilly Grant <reillyeon@qotw.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MloIF-00056M-U7
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbZIJSWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbZIJSWm
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:22:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZIJSWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:22:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1D614B014;
	Thu, 10 Sep 2009 14:22:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9EKirmoNfq9XSCGg56OZcwTzRLU=; b=QCd4zS
	ByCA+/+L2guv//5zr3M14Q9zGKqrx/28EWOXQkb30JABUZnoVbnI4QVPyAdCvrxC
	/gCBOcOrhBESwy5h13nN8u2BUcAfPHgSJE6TB33OUdJrZFcTLzmuw4M4xNPODc1Z
	75RVVLmAInfyTOySNPGXKhi7cLb8PxBjjrHIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kTSjTV4d2UQcoQE+5pUjj+ylESILtIdD
	Dfp+jHCzUzMlVq0JcvMkGsTDuoFTAOgTzCpqQ4VdmbbP1BxJ1wRHKQeIzZVZzWGj
	7TtirrmBVUJ7u1MqklVqPHad3R/ZqanuVti5z2FaoAN67sqauF52HYw4ePVra2Qb
	uUnorADH7jE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 866A64B010;
	Thu, 10 Sep 2009 14:22:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B2164B00F; Thu, 10 Sep 2009
 14:22:38 -0400 (EDT)
In-Reply-To: <1252566158-13305-1-git-send-email-reillyeon@qotw.net> (Reilly
 Grant's message of "Thu\, 10 Sep 2009 00\:02\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EDD6BD96-9E36-11DE-AD6E-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128130>

Reilly Grant <reillyeon@qotw.net> writes:

> The popen2, sha and sets modules are deprecated in Python 2.6 (sha in
> Python 2.5).  Both popen2 and sha are not actually used in git-p4.
> Replace usage of sets.Set with the builtin set object.
>
> The built-in set object was added in Python 2.4 and is already used in
> other parts of this script, so this dependency is nothing new.

Thanks for a resend.  Will apply.
