From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/3] rr/fmt-merge-msg replacement
Date: Thu, 26 Aug 2010 09:58:44 -0700
Message-ID: <7v7hjdmhtn.fsf@alter.siamese.dyndns.org>
References: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
 <7vhbiiqv8p.fsf@alter.siamese.dyndns.org> <20100826051235.GA9407@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 18:59:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oofn3-0001AB-Sg
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 18:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab0HZQ64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 12:58:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0HZQ6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 12:58:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDAC3D05D0;
	Thu, 26 Aug 2010 12:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NRGNtxmOAF8hiHMgzUldk9Q16SI=; b=G1Kzzq
	2vUfPY7P3wtEK1pRpyr8Eof4S3sRFqLIAhHEvSVNntEWLSOauT0J72qV8S+Xm5Bu
	U1mHb9QTnzurgJi0i8Z2SlEPdkec3g58iLfFXnst/Qx7TU+7O/3esBXSP8jaZgmm
	O/ldx0pfxkayq2HzXJNHpJB0zGTehIE8rQ7qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r6bKyXaNRZWizuOHlOHcA4c3zWFFWn6h
	JO6V3JVJYfy3J+Cmdns1BbRmNCjPheg1vpJBHEG05ocs45ulzlOzcQuzmfFImc65
	HCXBnuObh9vVEKOX0Hy23KyGe/5A7iIYUmkGdRNvtQ8mune/GbUZLQ/llnzdY2Oj
	+v2SECONwkk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA66DD05CF;
	Thu, 26 Aug 2010 12:58:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2155D05CD; Thu, 26 Aug
 2010 12:58:46 -0400 (EDT)
In-Reply-To: <20100826051235.GA9407@kytes> (Ramkumar Ramachandra's message of
 "Thu\, 26 Aug 2010 10\:42\:38 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3349B7D8-B133-11DF-9055-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154545>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Just as a future reference, in a case like this that results in trivial
>> conflict, I'd prefer to see a patch that can be used independently from
>> other unrelated branches.
>
> Oh, okay. I think I realize why- if the dependent topics are ejected,
> you'll have more trouble taking this forward to `next` and `master`,
> right?

Not just "ejection".  In general topics mature at different rates, and
there is no point requiring the other unrelated topic to graduate first to
'master' before your topic does.

>> Maybe you'd want a new test or two in t6200?
>
> Good idea! It'll give me the chance to familiarize myself with
> test-lib.sh :)
