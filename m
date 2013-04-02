From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: [PATCH 1/3] Remove outdated/missleading/irrelevant
 entries from glossary-content.txt
Date: Tue, 02 Apr 2013 11:26:58 -0700
Message-ID: <7vy5d0dc0d.fsf@alter.siamese.dyndns.org>
References: <559824715.741522.1364923497242.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 20:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5vg-0005qH-RL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 20:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760986Ab3DBS1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 14:27:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab3DBS1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 14:27:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4E8121C9;
	Tue,  2 Apr 2013 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tknmgDcU/BOIhwuYeQwNtxKcY3E=; b=o/M+CZ
	MKY6aPJBgkGCwdlX6ZICEFmVyIA9U5URW/tJNvK5vzLGfNkHBJ9lmITYVV0qNohS
	bGnOznHRdQXxJJAnx4cjnErpBGDyDFkxeVeZR2d25BhRNVCNKEE98FEBDMSCSv+M
	BF+n5bKQ/bg/tyMXPr4wREMMWattNlwG+N1Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QYKwrXUnmcJqngBgIN/00ONREjGdOrCw
	MD3xPVQF9BkleL5MkQbjHwMdcxIfg9khDwTKD/Ml5iAbZaUIjn0Yq6cdC0GcnfnR
	v5UaPCqMVYiXxMk9ywKccO5EwQzINT0g762NxVUqakIHDK7BsUTZtcZa39Q0Terw
	0+eAUoBkomI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 122AA121C8;
	Tue,  2 Apr 2013 18:27:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FE36121C6; Tue,  2 Apr
 2013 18:27:00 +0000 (UTC)
In-Reply-To: <559824715.741522.1364923497242.JavaMail.ngmail@webmail15.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 2 Apr 2013 19:24:57 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8B51438-9BC2-11E2-9613-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219825>

Thomas Ackermann <th.acker@arcor.de> writes:

>> Even though I personally am slightly in favor of removal, I suspect
>> that is primarily because I already know what Git tag is, and it is
>> different from the type tag in the Lisp-speak.
>> 
> I assumed the cardinality of the set of Lisp users is so small that
> this addition will confuse more people than help somebody.
>
>> The text indeed has a room for improvement, but it probably makes
>> sense to have an entry for `directory` here, as folks who are used
>> to say "Folders" may not know what it is.
>> 
> I assumed the number of such people so low that it's not worth
> to keep this - to most people obvious - explanation.

For the above two (they are of the same theme) to help one audience,
I tend to be cautious and try not to say "I don't fall into the
target audience, and to me it is misleading/irrelevant, so let's
remove it".

>> Which one of outdated, misleading or irrelevant category does this
>> fall into?  It certainly is not outdated (diff --cc/-c is often a
>> way to view evil merges), the text defines what an evil merge is
>> precisely and I do not think it is misleading.  Is it irrelevant?
>> 
> I considered it "irrelevant" because it tries to define 
> "evil merge" which is - at least to my experience - not used
> as some kind of well known notion. But I might of course be wrong.

In a merge-heavy workflow, evil merges have to happen from time to
time, and it is a good concept to know about.

I however think the description is too literal and it does not lead
to the understanding of what it is used for.  I see a few questions
on the stackoverflow with unsatisfactory literal answers, too.
