From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: add some script lint checks
Date: Mon, 12 Apr 2010 00:41:45 -0700
Message-ID: <7vochpm81y.fsf@alter.siamese.dyndns.org>
References: <20100412065234.GA12462@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 09:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1EHT-0001Ip-Mb
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 09:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab0DLHl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 03:41:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0DLHl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 03:41:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 360DCA9B34;
	Mon, 12 Apr 2010 03:41:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ag7Rh9vujqcrI7xyUF2OuqRNQBA=; b=KpA6bV
	jgkP1dF+Vz+410MUsYCkYnR5tLIDZ5TluLF87t0A3G4GBDmQHazrwgr7wXCt0X53
	aNaH9JDRGjmLyPhPky80LypXiBiVzwcfDf9upf2ly4UQNYQbRtqKKrJ1QhCXBcCa
	/fm4QIddr/lsKeLV2cQ6Ba6cRNpPni97E1BC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PmAj3FFq9bC+tRgYQ+K/9s64UB5UGGB+
	l/x9mrNzvpuy0ijeTtSc3aeyY3kGQxjAyJBQPrDcx9ZsmqhLBXrL+hPS9Z1B1UOE
	W1jPc+2MBV2AZV8v1NE6iWXjf8wmJoFPN4TmjfF23KfHch9fb+eUPIZQXBOFt53W
	PPHVJFr2n0k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D74A9B32;
	Mon, 12 Apr 2010 03:41:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29E3BA9B30; Mon, 12 Apr
 2010 03:41:47 -0400 (EDT)
In-Reply-To: <20100412065234.GA12462@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 12 Apr 2010 02\:52\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB737F2C-4606-11DF-AA63-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144709>

Jeff King <peff@peff.net> writes:

> As maintainer, Junio, you might want to run at
> least with TEST_LINT = test-lint-duplicate, since you can then catch
> duplicates introduced by merges and fix them up as part of the merge.

Thanks.  They are caught by pre-applypatch from 'todo' these days.  I
should also perhaps check for the executable bit there.
