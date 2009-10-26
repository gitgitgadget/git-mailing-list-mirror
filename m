From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Mon, 26 Oct 2009 00:14:45 -0700
Message-ID: <7vzl7eocd6.fsf@alter.siamese.dyndns.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
 <20091025160213.GA8532@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Oct 26 08:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2JnB-0000lv-6H
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 08:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbZJZHOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 03:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZJZHOt
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 03:14:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbZJZHOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 03:14:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16F43859B1;
	Mon, 26 Oct 2009 03:14:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3mFiqWd5OpJaDSYLSxqBF0CFHRQ=; b=E87cfX7dBkiK/cZT6aGU4jz
	+S5DdGOwofGNg6PGhnxl4Htfvu8X+XtD/SCTRJ7xQgx2qsBsexFn9GD65sSrJnsI
	avuU3+d5wCLNwweUovfQtJtz574vKxOvZWbRDEhLPSl33dxS8huY3awxwwXds7kv
	k0CLcdEalhUh78i0OBNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IXr5JyBVzAj/ydojxnRHYsrQNEYqlD2FiEwsUrnMR+6xUb3IL
	CeY9c3VTZcnlMQWhQgnMFyim5NAYYUluRwfDD3yVP7k21SqyLC53ddnRxQE+3k9e
	5hCSE1dB9vUXnrgZg7mMTOIDkM4Dnr0V6DHa9O2cc6wUgecluf2PYTZsHk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF421859B0;
	Mon, 26 Oct 2009 03:14:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C77AB859AF; Mon, 26 Oct 2009
 03:14:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4069EB64-C1FF-11DE-98C6-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131243>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Oct 21, 2009 at 11:52:30PM -0700, Junio C Hamano wrote:
>
>> * ks/precompute-completion (2009-10-05) 1 commit.
>>   (merged to 'next' on 2009-10-14 at adf722a)
>>  + Speedup bash completion loading
>> 
>> Are people happy with this?
>
> I'm looking forward to this on Windows, where loading the completion script
> can take about 10 seconds.

Thanks.

Are you giving this comment after you actually tried it on Windows and
found it satisfactory, or is it just based on the general description of
"this should make it faster"?

I need to know, to sift acks/kudos based on facts that I can use to decide
when to release it to 'master', from wishful thinking that I shouldn't,
especially after seeing an obvious issue like the one reported by Stephen
Boyd a few days ago (http://mid.gname.com/4AE0190E.8020803@gmail.com/).
