From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Userdiff patterns for C#
Date: Sun, 22 Aug 2010 00:23:06 -0700
Message-ID: <7v7hjj6rhh.fsf@alter.siamese.dyndns.org>
References: <20100811193739.GC8106@coredump.intra.peff.net>
 <1281978062-5772-1-git-send-email-gsvick@gmail.com>
 <20100816171408.GA15815@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 22 09:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On4xn-0004hz-Uk
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 09:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833Ab0HVHXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 03:23:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab0HVHXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 03:23:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D6DCD846;
	Sun, 22 Aug 2010 03:23:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TrZ++u+HykhZ7mfsWPbk4NXQK/c=; b=AWcMKW2stAmG4Z/ghAIv88q
	vGHL6tmUvA6UPdMwQX6EES+uVcvPa2LGkf9qogFdDInih9zzWuOvao4wJIxeP/2F
	3MaX5GkQ+nbve0ZZx2h9DK2J5Xcz8TiNzdf41NtV6IJgM5DkeZgX+Mx8ezlyRzHr
	jq1+hibukmnwmR+9XGko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=H9W9dyJD+E66yl6uNFbP2/Q1zckB05qQh3HYR4zA3I0vbffxB
	BfYOotJXkLV/T4NvxKFnTde+aIfK7E4a2ZRSMmvWnnh49r5FSjaZb5yTJFJK8+Q4
	BsCKTkha2nrEiHH6qMIQWKvQS+58WBmAjS3n5+XA+mr8a1Wi5Z1G/7Mtyc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D25CD840;
	Sun, 22 Aug 2010 03:23:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49591CD83F; Sun, 22 Aug
 2010 03:23:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1EFAD898-ADBE-11DF-96D0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154171>

Jeff King <peff@peff.net> writes:

> Thanks. I ran a few diffs on what little C# code I have, and it did seem
> to be an improvement. So:
>
> Acked-by: Jeff King <peff@peff.net>

Thanks, both.
