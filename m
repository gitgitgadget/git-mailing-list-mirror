From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 15:37:12 -0800
Message-ID: <7vwrywplxz.fsf@alter.siamese.dyndns.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 00:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc5pp-0000Ro-53
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 00:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab0BAXhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 18:37:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab0BAXha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 18:37:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55E1A96022;
	Mon,  1 Feb 2010 18:37:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WqWfqWhX+gmQ0BE/QtZoQjVzXNE=; b=TsMLFF
	J2MX89Xi1o6g/he3M9mMNr2K+4nl98b3J5UMMduTS5phXxOJkpN26tp982REekIz
	Qku/v2+wO8EZGXn/fgyKJStNLpqWAvEr5kwNVl7lscneHJsUlL6cxt90vkVl244J
	aVmNtZfVuPosKKRa/rMCgRegJanaChWl+4aYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h/TOPbithxjx1aDi4Z0t5JJ0XNDCE3WZ
	9ksLmnXBoearnw4bVrwqezNZJ/Z+eCwiFH28lkI01+Tw+rPRR56Y03Rtwp066+kr
	jvG840SQ7QVIQ5ElRIQ0YG8dQxGSLZe5FDyZdPYDx+5B5QOIKtAK2hC+Jwymet7b
	haNFZ79Bt5U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3596096021;
	Mon,  1 Feb 2010 18:37:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AD3F96020; Mon,  1 Feb
 2010 18:37:22 -0500 (EST)
In-Reply-To: <ron1-6F8B85.14520801022010@news.gmane.org> (Ron Garret's
 message of "Mon\, 01 Feb 2010 14\:52\:08 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1927CFA-0F8A-11DF-91F6-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138658>

Ron Garret <ron1@flownet.com> writes:

>> For my rather fresh eye it looks more like unnamed (anonymous?) branch
>> than a temporary one. Doesn't detached HEAD behave exactly like a
>> regular HEAD but pointing to the tip of an unnamed branch?
>
> I strongly concur with this.
>
> And as long as I'm weighing in, it would also help to prevent confusion 
> if it were made clear that this unnamed branch doesn't actually come 
> into existence unless and until you do a commit.

This shows that you are still thinking a branch is a line (or multiple
lines).  It is not.
