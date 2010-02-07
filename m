From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround
 advice
Date: Sun, 07 Feb 2010 10:37:12 -0800
Message-ID: <7v8wb4gaef.fsf@alter.siamese.dyndns.org>
References: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sun Feb 07 19:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeC19-0006mO-Jc
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 19:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020Ab0BGShc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 13:37:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab0BGSh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 13:37:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8718E98765;
	Sun,  7 Feb 2010 13:37:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zntOV6yBxCncQhuWsdV5w8F3yOg=; b=KubOGD
	FUEgikNIdYvabb+06dXI3gjZNxfEnXBq1jitonTZHkDcyHEKp1ag77KJWmdf0C2s
	mp+6fqpw5HwZE7Xicfa6d1vY9nJI+JfRKoOmOGb0TWRtPQlcc08UudIbBHS/5zJ+
	yYolfV2haj0bmN1ROqShuHscRhDtvaMImyB4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W5EDL50WEyXmf2i0czmhA86bZ1UixsqP
	AC4S0ziZSOx+PrzdHxyNacRqXF5NqdwJnO+TgUientWKbXxIqyerf5I2DOD3/9UE
	uyBlxRhdwKJ5PASoMgohGPssuze75joli4pIerXh5zztYQOHjj8gAN2k10+XkUnE
	PbbH7Tx3RI4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BDD498764;
	Sun,  7 Feb 2010 13:37:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18E5F98763; Sun,  7 Feb
 2010 13:37:13 -0500 (EST)
In-Reply-To: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk> (Aaron
 Crane's message of "Sun\,  7 Feb 2010 15\:14\:02 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D39D55B4-1417-11DF-9E1F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139243>

Aaron Crane <git@aaroncrane.co.uk> writes:

> The suggested approach to dealing with Gmail's propensity for breaking
> patches doesn't seem to work.  Recommend an alternative technique which
> does.
>
> Signed-off-by: Aaron Crane <git@aaroncrane.co.uk>
> ---
> Thanks to Sverre Rabbelier, Jacob Helwig, David Aguilar, and Jay Soffian for
> their suggestions; the advice here comes from them.

Do you know _why_ it does not work?  For example, does it not work _at
all_ for you?  Or only certain things does not reliably work (iow, perhaps
you are seeing a bug in imap-send)?  We might want to find who wrote the
imap-send recommendation and ask their input.

What I am trying to get at is to see if the current imap-send suggestion
is fundamentally unworkable with gmail.  Perhaps they stopped supporting
imap.  Perhaps the procedure never worked.  I would be very happy to apply
your patch as is if that is the case.

But if the trouble you had is something fixable, I think removal of the
original text is unfriendly to people who have only imap reachability to
gmail---the description instead needs fixing.
