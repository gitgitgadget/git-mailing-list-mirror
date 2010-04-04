From: Junio C Hamano <gitster@pobox.com>
Subject: Re: nd/setup
Date: Sun, 04 Apr 2010 14:42:48 -0700
Message-ID: <7vfx3a7v3b.fsf@alter.siamese.dyndns.org>
References: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
 <j2wfcaeb9bf1004020423nc5b7a73cq2278d41d1675dc8f@mail.gmail.com>
 <20100403050057.GA20525@progeny.tock>
 <j2mfcaeb9bf1004041141p28fba95dz5cb11918c172d32f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 23:43:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyXay-0002eY-KW
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 23:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab0DDVm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 17:42:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab0DDVm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 17:42:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C7E80A85C9;
	Sun,  4 Apr 2010 17:42:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cXWrdbl2wddmUqPTsQq8MPCDgVE=; b=skuRP7
	yKN1As95ieLp95E6VOHpUTkue0EwMMt+nYKCvzhSsgCGQ29FI7PRAj9twEB2M0vZ
	+sIEAMaZ4UhIzg+84BC/OoD+mPTt1U8XXcGPiuA4GAxb93K2m39KpiHXWip1eU99
	WQISLc3QeDZmHhLcFnhyxGU+Bm7oLYKWt11AU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KRBvfONqycG56k2+xsj8Y4Y2EphMOcLP
	wK4y0N598RDiyTvgtnNmRUBFM0xPT1lr1hCcbybnZ3Tf9tz4yOnpNd+cs0AuHe0m
	27H0f7QwWBgALz/ZTOTuaTPETjJbLVSQaF+B072dC6hZ3nDCV0rQv8+6Dy5TZNJU
	BMUAhjNOAmI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96C54A85C8;
	Sun,  4 Apr 2010 17:42:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA2BCA85C5; Sun,  4 Apr
 2010 17:42:49 -0400 (EDT)
In-Reply-To: <j2mfcaeb9bf1004041141p28fba95dz5cb11918c172d32f@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sun\, 4 Apr 2010 20\:41\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 063267C0-4033-11DF-93A6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143951>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I wanted to update nd/setup topic, but found nd/root-git was merged in
> between its two parts, which resulted in non-trivial conflicts in the
> end.

I am not quite sure what you want me to do.  Replacing these named commits
in place (meaning, the merge with nd/root-git to adjust the later parts
that depend on that fix is reproduced while rebuilding the topic) has some
silly conflicts, and rebuilding the whole series without the merge but
with the named commits replaced has different conflicts.

As the fix of nd/root-git is already in 'master', it might make more sense
to apply the whole series rebased to the newer codebase instead of keeping
the same fork point as the older series.  That also removes the worries
for you about having to send conflict resolutions, no?
