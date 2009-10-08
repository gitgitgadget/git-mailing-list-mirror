From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Fold long header lines to 78 chars
Date: Thu, 08 Oct 2009 09:27:04 -0700
Message-ID: <7vy6nlhmw7.fsf@alter.siamese.dyndns.org>
References: <1254759898.1799.449.camel@Joe-Laptop.home>
 <7vd44yo4uz.fsf@alter.siamese.dyndns.org>
 <1254979690.2056.103.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 18:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvvv9-0000vI-Bb
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 18:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbZJHQ14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 12:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbZJHQ1z
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 12:27:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbZJHQ1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 12:27:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9101E51E16;
	Thu,  8 Oct 2009 12:27:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BvH7mhPdJABJOsuw5K4WJEbQklw=; b=rXxRZ5U/2+OATioi9wx4lGB
	7xUv2cngsVMRIvQlGfqDOHOu9mwfbaaA97B6IE7gmEnYFKWnuMvVvqP80RE4ek3w
	T6KE8rtBXRi+qTgN7EuBg9Ypp5HU6AbD1wWMmkvo+gLTPb82Is7C87tnjWgE/Pkx
	yzhcLfypZmzup5UYTI2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=rMboaKdIcZ7uS5Ad9kWzpUq71ImouJqAxLVUQrjd3rOfv8Hk+
	O2A1HnY3LjuRp6MG14thncFqFfatazPv0pgQo4/J0Q+Q5i1jsSQgUr5peVYE+jB0
	At9ydDyzQ9PuqcEgN8nwG9OZ4K9bZn4lHBXWIxRrZttlm+TnlKQJwOFEx4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63ED951E15;
	Thu,  8 Oct 2009 12:27:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B87E751E14; Thu,  8 Oct
 2009 12:27:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D09585C-B427-11DE-9976-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129697>

Joe Perches <joe@perches.com> writes:

>> I do not think this hunk is correct.
>> Shouldn't we be rather repeating "RCPT TO: " for each recipient, as
>> RFC2821 4.1.1.3 says (this is an issue with the original code)?
>
> Looks like you're right.
>
> Want a new patch or will you fix both issues?
>
> I suggest using the same join as "To:" for "Cc:" and
> multiple single line "RCPT TO:"s.

Sure.  Please make it so.
