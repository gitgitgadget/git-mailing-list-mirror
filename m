From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/11] Use "git merge" instead of "git pull ."
Date: Tue, 27 Aug 2013 13:46:13 -0700
Message-ID: <xmqqfvtuc162.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1685937666.34465.1377626298173.JavaMail.ngmail@webmail19.arcor-online.net>
	<xmqqob8jc5s6.fsf@gitster.dls.corp.google.com>
	<20130827194422.GW4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org,
	martinvonz@gmail.com, wking@tremily.us, philipoakley@iee.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 22:46:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEQ9e-0005zN-0v
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 22:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab3H0UqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 16:46:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922Ab3H0UqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 16:46:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 942093C273;
	Tue, 27 Aug 2013 20:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n829VjGqKHaZPVa1MI4WMrCXDp4=; b=Eg6tvy
	ZwPuUH2EMqwug+QY07lWJ7AfcMmWT7NBMp3pyfZDBsG/5y1UUS2P3aGW4bgYCuA0
	NM5UY+olZ3wO/jyyjpaJRpMM7RcBq/y1qMN3uy7kEhju+47AI3wT2FVKioXYHKbZ
	oJ0VvE1806AHvMVSWrUGvm/cCa2wWpW1F/ugs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GzTqlVN4FkYqLG1KcQRgwYTMz1g7Y/83
	Mqs3lhThliu2zvNkTFAVccBRPqOilpMqJL8IWg1mpN+wA0HTj+94nURrA33Xdskc
	UeTtqG/X//zhYwtV68qyfgQcqOlc/XA8ZcvD02b/XFArtpfIBNrNrXFDG6NP4AiH
	PkaZa6jx6v8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85CBB3C272;
	Tue, 27 Aug 2013 20:46:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 900E53C270;
	Tue, 27 Aug 2013 20:46:15 +0000 (UTC)
In-Reply-To: <20130827194422.GW4110@google.com> (Jonathan Nieder's message of
	"Tue, 27 Aug 2013 12:44:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B77A8B86-0F59-11E3-8567-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233159>

Jonathan Nieder <jrnieder@gmail.com> writes:

> On Tue, Aug 27, 2013 at 12:06:33PM -0700, Junio C Hamano wrote:
>> Thomas Ackermann <th.acker@arcor.de> writes:
>> 
>> > "git pull ." works, but "git merge" is the recommended
>> > way for new users to do things. (The old description
>> > also should have read "The former is actually *not* very
>> > commonly used".)
>> 
>> It does not matter that you are unaware other people use it often.
>> I'd suggest dropping the first hunk altogether.
>
> Eh, the claim "The former is actually very commonly used." is
> confusing on its own (even though it used to be true) and elaborating
> wouldn't help much with education, so the first hunk makes sense to
> me.  But maybe it should have been done in a separate patch. ;-)

Yeah, it may make sense to replace it with something like "... and
if you think about the fact that your local repository is not at all
special, it makes sense that you can pull from it just like you pull
from other places", without mentioning how common it is.  I do agree
that it is a separate topic.
