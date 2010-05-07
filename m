From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-stash.txt: Add example "Using stash selectively"
Date: Fri, 07 May 2010 09:11:44 -0700
Message-ID: <7v8w7vhetb.fsf@alter.siamese.dyndns.org>
References: <1273045035-7292-1-git-send-email-jari.aalto@cante.net>
 <7v39y6jfmv.fsf@alter.siamese.dyndns.org>
 <7v39y6jfmv.fsf@alter.siamese.dyndns.org> <87pr194e3v.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri May 07 18:12:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQ9p-0001VJ-UK
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676Ab0EGQLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 12:11:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab0EGQLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 12:11:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DBABB1148;
	Fri,  7 May 2010 12:11:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVCF39c5B+YUqtTACqjZY2lb7/g=; b=jcXz52
	NIB0hzfCNibSoi/O48yaJ45ZL7tMgpwTNRUXWrVGghePNttrHSuEGX4Xylpzkmxh
	0g54cAmHs//lkQ1SgljDwCbfw1D+BukgF9SlZqGUVwkgMiBxWkVju1AITu6AJvB9
	DpyLWAITSiRZXf5MCjV9sMerXfpQSriY/LilQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uX7m/FO1e9niDq1ocSOA0FQAjQy7KRFk
	mE1EaFsrFLnL4GzednjRljyJthLa7En0JHjN4ZqZ+e6PLBjy9qtp0QOrLuuJuqMS
	c3zEE9b8pwRkIhqx4Df4xJi+naXrsilS+Q7tGTe5xfathQv5F4H7KksbHbfJ9bs1
	URawxAkV4dg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16E5BB1147;
	Fri,  7 May 2010 12:11:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D68B1142; Fri,  7 May
 2010 12:11:46 -0400 (EDT)
In-Reply-To: <87pr194e3v.fsf_-_@jondo.cante.net> (Jari Aalto's message of
 "Thu\, 06 May 2010 11\:40\:52 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E3A4BFE-59F3-11DF-9118-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146537>

Jari Aalto <jari.aalto@cante.net> writes:

>> While the above is not _wrong_ per-se, it was somewhat hard to understand
>> for me without a description on _why_ you might want to do this.  It
>> didn't help that "put only selected files" really meant "get rid of
>> selected _changes_ from the working tree and the index temporarily".
>
> This demonstrates the difference between the end-user and developer. The
> end-used think in term of tangible objects: "I have files, I need to
> stash some of them".

Not really.  You just demonstrated that you ignored "partial add".  It is
not so unusual for a user to need to express "I have a file, and I have
two kinds of changes to it.  The ones that I need now and the ones I need
to postpone".
